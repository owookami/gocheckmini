import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as path;

void main() async {
  print('🔍 SQLite 데이터베이스 직접 확인');

  // 데이터베이스 경로 설정
  final dbPath = path.join(
    '.dart_tool',
    'sqflite_common_ffi',
    'databases',
    'lib/core/database/parking_app.db',
  );

  print('데이터베이스 경로: $dbPath');

  // 파일 존재 확인
  final dbFile = File(dbPath);
  if (!dbFile.existsSync()) {
    print('❌ 데이터베이스 파일이 존재하지 않습니다!');
    print('💡 앱을 먼저 실행하여 데이터베이스를 초기화해주세요.');
    return;
  }

  // SQLite FFI 초기화
  sqfliteFfiInit();
  final databaseFactory = databaseFactoryFfi;

  try {
    // 데이터베이스 열기
    final db = await databaseFactory.openDatabase(dbPath);
    print('✅ 데이터베이스 연결 성공');

    // 테이블 목록 확인
    print('\n📋 테이블 목록:');
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' ORDER BY name",
    );

    for (final table in tables) {
      final tableName = table['name'] as String;
      if (tableName.startsWith('sqlite_')) continue;

      // 테이블 행 수 확인
      final countResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $tableName',
      );
      final count = countResult.first['count'] as int;
      print('  - $tableName: $count개 행');
    }

    // 법정동 테이블 상세 확인
    if (tables.any((t) => t['name'] == 'bjdongs')) {
      print('\n🏘️ 법정동 테이블 상세:');

      // 시도별 법정동 수 확인
      final sidoStats = await db.rawQuery('''
        SELECT SUBSTR(sigungu_code, 1, 2) as sido_code, COUNT(*) as count 
        FROM bjdongs 
        GROUP BY SUBSTR(sigungu_code, 1, 2) 
        ORDER BY sido_code
      ''');

      print('  시도별 법정동 수:');
      for (final stat in sidoStats) {
        final sidoCode = stat['sido_code'] as String;
        final count = stat['count'] as int;
        final sidoName = _getSidoName(sidoCode);
        print('    $sidoCode($sidoName): $count개');
      }

      // 서울시 샘플 데이터 확인
      print('\n  서울시 샘플 법정동 (상위 5개):');
      final seoulSample = await db.rawQuery('''
        SELECT sigungu_code, bjdong_name, bjdong_code 
        FROM bjdongs 
        WHERE sigungu_code LIKE '11%' 
        LIMIT 5
      ''');

      for (final row in seoulSample) {
        print(
          '    ${row['sigungu_code']} - ${row['bjdong_name']} (${row['bjdong_code']})',
        );
      }
    }

    await db.close();
    print('\n✅ 데이터베이스 확인 완료');
  } catch (e) {
    print('❌ 데이터베이스 확인 실패: $e');
  }
}

String _getSidoName(String sidoCode) {
  switch (sidoCode) {
    case '11':
      return '서울특별시';
    case '26':
      return '부산광역시';
    case '27':
      return '대구광역시';
    case '28':
      return '인천광역시';
    case '29':
      return '광주광역시';
    case '30':
      return '대전광역시';
    case '31':
      return '울산광역시';
    case '36':
      return '세종특별자치시';
    case '41':
      return '경기도';
    case '42':
      return '강원도';
    case '43':
      return '충청북도';
    case '44':
      return '충청남도';
    case '45':
      return '전라북도';
    case '46':
      return '전라남도';
    case '47':
      return '경상북도';
    case '48':
      return '경상남도';
    case '50':
      return '제주특별자치도';
    default:
      return '알 수 없음';
  }
}
