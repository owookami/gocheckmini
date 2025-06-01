import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as path;
import '../lib/core/api/standard_region_api_service.dart';
import '../lib/core/database/database_schema.dart';

/// 공공데이터 API에서 법정동코드 데이터를 가져와 SQLite에 저장
Future<void> main() async {
  print('🚀 공공데이터 API 법정동코드 마이그레이션 시작\n');

  try {
    // 1. 환경변수 로드
    await dotenv.load(fileName: '.env');
    print('✅ 환경변수 로드 완료');

    // 2. SQLite FFI 초기화
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    print('✅ SQLite FFI 초기화 완료');

    // 3. 데이터베이스 파일 경로 설정
    final dbPath = path.join('assets', 'data', 'parking_finder.db');
    final dbFile = File(dbPath);

    // 기존 데이터베이스 파일 삭제 (새로 생성)
    if (await dbFile.exists()) {
      await dbFile.delete();
      print('🗑️ 기존 데이터베이스 파일 삭제');
    }

    // 디렉토리 생성
    await Directory(path.dirname(dbPath)).create(recursive: true);
    print('📁 데이터베이스 디렉토리 생성 완료');

    // 4. 데이터베이스 생성
    final database = await openDatabase(
      dbPath,
      version: DatabaseSchema.currentVersion,
      onCreate: (db, version) async {
        print('🏗️ 데이터베이스 테이블 생성 중...');

        // 테이블 생성
        for (final createTableQuery in DatabaseSchema.createTableQueries) {
          await db.execute(createTableQuery);
        }

        // 인덱스 생성
        for (final indexQuery in DatabaseSchema.createIndexQueries) {
          final query = indexQuery.trim();
          if (query.isNotEmpty) {
            await db.execute(query);
          }
        }

        print('✅ 데이터베이스 스키마 생성 완료');
      },
    );

    // 5. API 서비스 초기화 및 데이터 가져오기
    final apiService = StandardRegionApiService();

    print('\n🌐 공공데이터 API 연결 테스트...');
    final isConnected = await apiService.testConnection();
    if (!isConnected) {
      throw Exception('API 연결 실패');
    }
    print('✅ API 연결 성공');

    print('\n📡 전국 법정동코드 데이터 수집 중...');
    final allData = await apiService.getAllPagesData();
    print('✅ 데이터 수집 완료: ${allData.length}개');

    if (allData.isEmpty) {
      throw Exception('수집된 데이터가 없습니다.');
    }

    // 6. 데이터 변환 및 저장
    print('\n💾 데이터베이스 저장 중...');
    await _saveToDatabase(database, allData);

    // 7. 결과 확인
    await _printStatistics(database);

    // 8. 자원 정리
    await database.close();
    apiService.dispose();

    print('\n🎉 마이그레이션 완료!');
  } catch (e, stackTrace) {
    print('❌ 마이그레이션 실패: $e');
    print('📋 상세 오류:\n$stackTrace');
    exit(1);
  }
}

/// 데이터베이스에 법정동코드 데이터 저장
Future<void> _saveToDatabase(
  Database database,
  List<Map<String, dynamic>> apiData,
) async {
  Batch batch = database.batch();
  int insertCount = 0;
  final now = DateTime.now().toIso8601String();

  for (final item in apiData) {
    try {
      // API 응답 데이터 파싱
      final regionCd = item['region_cd']?.toString() ?? '';
      final locataddNm = item['locatadd_nm']?.toString() ?? '';

      if (regionCd.isEmpty || locataddNm.isEmpty) {
        continue; // 필수 데이터가 없으면 스킵
      }

      // 법정동코드로부터 레벨과 상위 코드 추출
      final levelInfo = _extractLevelInfo(regionCd, locataddNm);

      // 데이터베이스 삽입
      batch.insert(DatabaseSchema.legalDistrictsTable, {
        'region_cd': regionCd,
        'sido_cd': levelInfo['sido_cd'],
        'sgg_cd': levelInfo['sgg_cd'],
        'umd_cd': levelInfo['umd_cd'],
        'ri_cd': levelInfo['ri_cd'],
        'locatadd_nm': locataddNm,
        'sido_nm': levelInfo['sido_nm'],
        'sgg_nm': levelInfo['sgg_nm'],
        'umd_nm': levelInfo['umd_nm'],
        'ri_nm': levelInfo['ri_nm'],
        'mountain_yn': item['mountain_yn']?.toString() ?? 'N',
        'land_type_cd': item['land_type_cd']?.toString(),
        'land_type_nm': item['land_type_nm']?.toString(),
        'admin_yn': item['admin_yn']?.toString() ?? 'Y',
        'is_active': 1,
        'level_type': levelInfo['level_type'],
        'parent_region_cd': levelInfo['parent_region_cd'],
        'created_at': now,
        'updated_at': now,
      });

      insertCount++;

      // 배치 크기 제한
      if (insertCount % 1000 == 0) {
        await batch.commit(noResult: true);
        batch = database.batch();
        print('📊 진행률: $insertCount/${apiData.length}');
      }
    } catch (e) {
      print('⚠️ 데이터 처리 오류 (스킵): ${item.toString().substring(0, 100)}... - $e');
      continue;
    }
  }

  // 마지막 배치 커밋
  if (insertCount % 1000 != 0) {
    await batch.commit(noResult: true);
  }

  print('✅ 총 $insertCount개 데이터 저장 완료');
}

/// 법정동코드로부터 레벨 정보 추출
Map<String, dynamic> _extractLevelInfo(String regionCd, String locataddNm) {
  final result = <String, dynamic>{
    'sido_cd': null,
    'sgg_cd': null,
    'umd_cd': null,
    'ri_cd': null,
    'sido_nm': null,
    'sgg_nm': null,
    'umd_nm': null,
    'ri_nm': null,
    'level_type': DatabaseSchema.levelRi, // 기본값: 최하위 레벨
    'parent_region_cd': null,
  };

  if (regionCd.length >= 2) {
    result['sido_cd'] = regionCd.substring(0, 2);
  }

  if (regionCd.length >= 5) {
    result['sgg_cd'] = regionCd.substring(0, 5);
  }

  if (regionCd.length >= 8) {
    result['umd_cd'] = regionCd.substring(0, 8);
  }

  if (regionCd.length >= 10) {
    result['ri_cd'] = regionCd.substring(0, 10);
  }

  // 주소명으로부터 각 레벨 이름 추출
  final addressParts = locataddNm.split(' ');
  if (addressParts.isNotEmpty) {
    result['sido_nm'] = addressParts[0];

    if (addressParts.length > 1) {
      result['sgg_nm'] = addressParts[1];
    }

    if (addressParts.length > 2) {
      result['umd_nm'] = addressParts[2];
    }

    if (addressParts.length > 3) {
      result['ri_nm'] = addressParts[3];
    }
  }

  // 레벨 타입 결정
  if (regionCd.length == 2 || regionCd.endsWith('00000000')) {
    result['level_type'] = DatabaseSchema.levelSido;
  } else if (regionCd.length == 5 || regionCd.endsWith('00000')) {
    result['level_type'] = DatabaseSchema.levelSigungu;
    result['parent_region_cd'] = result['sido_cd'];
  } else if (regionCd.length == 8 || regionCd.endsWith('00')) {
    result['level_type'] = DatabaseSchema.levelUmd;
    result['parent_region_cd'] = result['sgg_cd'];
  } else {
    result['level_type'] = DatabaseSchema.levelRi;
    result['parent_region_cd'] = result['umd_cd'];
  }

  return result;
}

/// 데이터베이스 통계 출력
Future<void> _printStatistics(Database database) async {
  print('\n📊 저장된 데이터 통계:');

  // 레벨별 통계
  for (int level = 1; level <= 4; level++) {
    final result = await database.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseSchema.legalDistrictsTable} WHERE level_type = ?',
      [level],
    );
    final count = result.isNotEmpty ? (result.first['count'] as int?) ?? 0 : 0;

    final levelName = DatabaseSchema.levelNames[level] ?? '알 수 없음';
    print('  - $levelName: $count개');
  }

  // 시도별 통계 (상위 5개)
  final sidoStats = await database.rawQuery('''
    SELECT sido_nm, COUNT(*) as count 
    FROM ${DatabaseSchema.legalDistrictsTable} 
    WHERE sido_nm IS NOT NULL 
    GROUP BY sido_nm 
    ORDER BY count DESC 
    LIMIT 5
  ''');

  print('\n📍 주요 시도별 데이터 수:');
  for (final row in sidoStats) {
    print('  - ${row['sido_nm']}: ${row['count']}개');
  }

  // 전체 통계
  final totalResult = await database.rawQuery(
    'SELECT COUNT(*) as count FROM ${DatabaseSchema.legalDistrictsTable}',
  );
  final totalCount =
      totalResult.isNotEmpty ? (totalResult.first['count'] as int?) ?? 0 : 0;

  print('\n🔢 총 데이터 수: $totalCount개');
}
