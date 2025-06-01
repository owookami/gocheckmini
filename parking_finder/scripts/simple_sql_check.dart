import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as path;

Future<void> main() async {
  // macOS에서 FFI 설정
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  try {
    print('🔍 SQLite 데이터베이스 직접 확인');

    // FFI 데이터베이스 경로 사용
    final dbPath = path.join(
      '.dart_tool',
      'sqflite_common_ffi',
      'databases',
      'lib',
      'core',
      'database',
      'parking_app.db',
    );
    print('데이터베이스 경로: $dbPath');

    if (!File(dbPath).existsSync()) {
      print('❌ 데이터베이스 파일이 존재하지 않습니다!');
      return;
    }

    final db = await openDatabase(dbPath);

    // 1. 전체 지역 수 확인
    final totalCount = await db.rawQuery(
      'SELECT COUNT(*) as count FROM regions',
    );
    print('📊 전체 지역 수: ${totalCount.first['count']}개');

    // 2. 서울특별시 시군구 데이터 확인
    print('\n🏙️ 서울특별시 시군구 데이터:');
    final seoulData = await db.rawQuery(
      'SELECT sigungu_code, sigungu_name, province FROM regions WHERE province = ? ORDER BY sigungu_code',
      ['서울특별시'],
    );

    print('서울특별시 총 지역 수: ${seoulData.length}개');

    for (int i = 0; i < seoulData.length && i < 15; i++) {
      final row = seoulData[i];
      print('  [${i + 1}] ${row['sigungu_name']} (코드: ${row['sigungu_code']})');
    }

    if (seoulData.length > 15) {
      print('  ... 외 ${seoulData.length - 15}개');
    }

    // 3. 서울특별시 중에서 "서울특별시"라는 이름을 가진 것들 확인
    print('\n⚠️ 이상한 데이터 확인 (이름이 "서울특별시"인 것들):');
    final duplicateData = await db.rawQuery(
      'SELECT sigungu_code, sigungu_name, province FROM regions WHERE province = ? AND sigungu_name = ? ORDER BY sigungu_code',
      ['서울특별시', '서울특별시'],
    );

    print('이름이 "서울특별시"인 데이터 수: ${duplicateData.length}개');
    for (final row in duplicateData) {
      print(
        '  - 코드: ${row['sigungu_code']}, 이름: "${row['sigungu_name']}", 시도: "${row['province']}"',
      );
    }

    // 4. 부산광역시 샘플 확인
    print('\n🌊 부산광역시 시군구 데이터 (처음 5개):');
    final busanData = await db.rawQuery(
      'SELECT sigungu_code, sigungu_name FROM regions WHERE province = ? ORDER BY sigungu_code LIMIT 5',
      ['부산광역시'],
    );

    for (int i = 0; i < busanData.length; i++) {
      final row = busanData[i];
      print('  [${i + 1}] ${row['sigungu_name']} (${row['sigungu_code']})');
    }

    await db.close();
    print('\n✅ 직접 SQL 확인 완료!');
  } catch (e, stackTrace) {
    print('❌ 오류 발생: $e');
    print('스택 트레이스: $stackTrace');
  }
}
