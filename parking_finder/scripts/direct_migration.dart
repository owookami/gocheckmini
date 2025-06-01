import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

Future<void> main() async {
  // SQLite FFI 초기화
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  try {
    print('🚀 직접 데이터베이스 마이그레이션 시작');

    // DatabaseHelper에서 사용하는 이름과 동일하게 설정
    final dbPath = join('parking_finder.db');

    // 기존 파일 삭제
    final dbFile = File(dbPath);
    if (await dbFile.exists()) {
      await dbFile.delete();
      print('🗑️ 기존 데이터베이스 파일 삭제');
    }

    // 디렉토리 생성 확인
    final dbDir = Directory(dirname(dbPath));
    if (!await dbDir.exists()) {
      await dbDir.create(recursive: true);
      print('📁 데이터베이스 디렉토리 생성');
    }

    // 새 데이터베이스 생성
    final db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE regions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          unified_code INTEGER NOT NULL,
          sigungu_code TEXT NOT NULL,
          sigungu_name TEXT NOT NULL,
          is_autonomous_district INTEGER NOT NULL DEFAULT 0,
          province TEXT NOT NULL,
          city TEXT NOT NULL DEFAULT '',
          created_at TEXT,
          updated_at TEXT
        )
      ''');
      },
    );

    print('✅ 데이터베이스 파일 생성 완료');

    // sigungu.txt 파일 읽기
    final file = File('assets/data/sigungu.txt');
    if (!await file.exists()) {
      print('❌ sigungu.txt 파일이 존재하지 않습니다');
      return;
    }

    final content = await file.readAsString();
    final lines = content.split('\n');
    print('📄 총 ${lines.length}줄 읽음');

    // 데이터 파싱 및 삽입
    print('🔄 데이터 파싱 및 삽입 중...');
    int insertedCount = 0;
    final batch = db.batch();

    for (int i = 1; i < lines.length; i++) {
      final line = lines[i].trim();
      if (line.isEmpty) continue;

      try {
        final parts = line.split(' ');
        if (parts.length >= 4) {
          final unifiedCode = int.parse(parts[0]);
          final sigunguCode = parts[1];

          // 시군구명을 올바르게 파싱 (세 번째 컬럼부터 마지막-1까지가 이름)
          final sigunguNameParts = parts.sublist(2, parts.length - 1);
          final fullSigunguName = sigunguNameParts.join(' ');
          final isAutonomousString = parts.last;

          // 시도와 구 정보 파싱
          final regionInfo = parseRegionInfo(fullSigunguName);

          final data = {
            'unified_code': unifiedCode,
            'sigungu_code': sigunguCode,
            'sigungu_name': regionInfo['display_name'] ?? fullSigunguName,
            'is_autonomous_district': isAutonomousString == '해당' ? 1 : 0,
            'province': regionInfo['province'] ?? '',
            'city': regionInfo['city'] ?? '',
            'created_at': DateTime.now().toIso8601String(),
            'updated_at': DateTime.now().toIso8601String(),
          };

          batch.insert('regions', data);
          insertedCount++;
        }
      } catch (e) {
        print('⚠️ 라인 파싱 오류 ($i): $line - $e');
        continue;
      }
    }

    // 배치 실행
    await batch.commit(noResult: true);
    print('✅ 데이터 삽입 완료: ${insertedCount}개');

    // 결과 검증
    print('\n📊 마이그레이션 결과 검증:');
    final countResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM regions',
    );
    final totalCount = countResult.first['count'] as int;
    print('  - 총 지역 수: $totalCount');

    // 서울특별시 데이터 확인
    print('\n🏙️ 서울특별시 데이터 확인 (처음 5개):');
    final seoulData = await db.query(
      'regions',
      where: 'province = ?',
      whereArgs: ['서울특별시'],
      limit: 5,
    );

    for (final row in seoulData) {
      print(
        '  - 코드: ${row['sigungu_code']}, 이름: ${row['sigungu_name']}, 시도: ${row['province']}',
      );
    }

    await db.close();
    print('\n🎉 직접 마이그레이션 완료!');
  } catch (e, stackTrace) {
    print('❌ 마이그레이션 실패: $e');
    print('스택 트레이스: $stackTrace');
  }
}

/// 지역명에서 시도, 시, 구/군 정보 파싱
Map<String, String?> parseRegionInfo(String fullName) {
  String? province;
  String? city;
  String? displayName;

  // 광역시/특별시/특별자치시/특별자치도 패턴 매칭
  if (fullName.startsWith('서울특별시')) {
    province = '서울특별시';
    if (fullName.length > '서울특별시'.length) {
      // "서울특별시 종로구" -> "종로구"
      displayName = fullName.substring('서울특별시'.length + 1).trim();
    } else {
      displayName = '서울특별시';
    }
  } else if (fullName.startsWith('부산광역시')) {
    province = '부산광역시';
    if (fullName.length > '부산광역시'.length) {
      displayName = fullName.substring('부산광역시'.length + 1).trim();
    } else {
      displayName = '부산광역시';
    }
  } else if (fullName.startsWith('대구광역시')) {
    province = '대구광역시';
    if (fullName.length > '대구광역시'.length) {
      displayName = fullName.substring('대구광역시'.length + 1).trim();
    } else {
      displayName = '대구광역시';
    }
  } else if (fullName.startsWith('인천광역시')) {
    province = '인천광역시';
    if (fullName.length > '인천광역시'.length) {
      displayName = fullName.substring('인천광역시'.length + 1).trim();
    } else {
      displayName = '인천광역시';
    }
  } else if (fullName.startsWith('광주광역시')) {
    province = '광주광역시';
    if (fullName.length > '광주광역시'.length) {
      displayName = fullName.substring('광주광역시'.length + 1).trim();
    } else {
      displayName = '광주광역시';
    }
  } else if (fullName.startsWith('대전광역시')) {
    province = '대전광역시';
    if (fullName.length > '대전광역시'.length) {
      displayName = fullName.substring('대전광역시'.length + 1).trim();
    } else {
      displayName = '대전광역시';
    }
  } else if (fullName.startsWith('울산광역시')) {
    province = '울산광역시';
    if (fullName.length > '울산광역시'.length) {
      displayName = fullName.substring('울산광역시'.length + 1).trim();
    } else {
      displayName = '울산광역시';
    }
  } else if (fullName.startsWith('세종특별자치시')) {
    province = '세종특별자치시';
    displayName = '세종특별자치시';
  } else if (fullName.startsWith('경기도')) {
    province = '경기도';
    if (fullName.length > '경기도'.length) {
      displayName = fullName.substring('경기도'.length + 1).trim();
      city = displayName;
    } else {
      displayName = '경기도';
    }
  } else if (fullName.startsWith('충청북도')) {
    province = '충청북도';
    if (fullName.length > '충청북도'.length) {
      displayName = fullName.substring('충청북도'.length + 1).trim();
      city = displayName;
    } else {
      displayName = '충청북도';
    }
  } else if (fullName.startsWith('충청남도')) {
    province = '충청남도';
    if (fullName.length > '충청남도'.length) {
      displayName = fullName.substring('충청남도'.length + 1).trim();
      city = displayName;
    } else {
      displayName = '충청남도';
    }
  } else if (fullName.startsWith('전북특별자치도')) {
    province = '전북특별자치도';
    if (fullName.length > '전북특별자치도'.length) {
      displayName = fullName.substring('전북특별자치도'.length + 1).trim();
      city = displayName;
    } else {
      displayName = '전북특별자치도';
    }
  } else if (fullName.startsWith('전라북도')) {
    province = '전라북도';
    if (fullName.length > '전라북도'.length) {
      displayName = fullName.substring('전라북도'.length + 1).trim();
      city = displayName;
    } else {
      displayName = '전라북도';
    }
  } else if (fullName.startsWith('전라남도')) {
    province = '전라남도';
    if (fullName.length > '전라남도'.length) {
      displayName = fullName.substring('전라남도'.length + 1).trim();
      city = displayName;
    } else {
      displayName = '전라남도';
    }
  } else if (fullName.startsWith('경상북도')) {
    province = '경상북도';
    if (fullName.length > '경상북도'.length) {
      displayName = fullName.substring('경상북도'.length + 1).trim();
      city = displayName;
    } else {
      displayName = '경상북도';
    }
  } else if (fullName.startsWith('경상남도')) {
    province = '경상남도';
    if (fullName.length > '경상남도'.length) {
      displayName = fullName.substring('경상남도'.length + 1).trim();
      city = displayName;
    } else {
      displayName = '경상남도';
    }
  } else if (fullName.startsWith('강원특별자치도')) {
    province = '강원특별자치도';
    if (fullName.length > '강원특별자치도'.length) {
      displayName = fullName.substring('강원특별자치도'.length + 1).trim();
      city = displayName;
    } else {
      displayName = '강원특별자치도';
    }
  } else if (fullName.startsWith('강원도')) {
    province = '강원도';
    if (fullName.length > '강원도'.length) {
      displayName = fullName.substring('강원도'.length + 1).trim();
      city = displayName;
    } else {
      displayName = '강원도';
    }
  } else if (fullName.startsWith('제주특별자치도')) {
    province = '제주특별자치도';
    if (fullName.length > '제주특별자치도'.length) {
      displayName = fullName.substring('제주특별자치도'.length + 1).trim();
      city = displayName;
    } else {
      displayName = '제주특별자치도';
    }
  } else {
    // 기타 지역이나 최상위 지역
    if (fullName == '국토교통부') {
      province = '기타';
      displayName = '국토교통부';
    } else {
      province = '기타';
      displayName = fullName;
    }
  }

  return {'province': province, 'city': city, 'display_name': displayName};
}
