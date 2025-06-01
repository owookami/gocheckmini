import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

Future<void> main() async {
  // SQLite FFI 초기화
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  try {
    // 데이터베이스 파일 경로
    final dbPath = join('assets', 'data', 'parking_finder.db');
    print('데이터베이스 경로: $dbPath');

    // 파일 존재 확인
    final dbFile = File(dbPath);
    if (!await dbFile.exists()) {
      print('❌ 데이터베이스 파일이 존재하지 않습니다: $dbPath');
      return;
    }

    // 데이터베이스 열기
    final db = await openDatabase(dbPath);
    print('✅ 데이터베이스 연결 성공');

    // 전체 레코드 수 확인
    final countResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM regions',
    );
    final totalCount = countResult.first['count'] as int;
    print('\n📊 총 지역 수: $totalCount개');

    // 서울특별시 데이터 확인
    print('\n🏙️ 서울특별시 데이터 (처음 10개):');
    final seoulData = await db.query(
      'regions',
      where: 'province = ?',
      whereArgs: ['서울특별시'],
      limit: 10,
    );

    for (final row in seoulData) {
      print(
        '  - ID: ${row['id']}, 코드: ${row['sigungu_code']}, '
        '이름: ${row['sigungu_name']}, 시도: ${row['province']}, '
        '시: ${row['city']}, 구: ${row['district']}',
      );
    }

    // 시도별 개수
    print('\n📍 시도별 개수:');
    final provinceCount = await db.rawQuery('''
      SELECT province, COUNT(*) as count 
      FROM regions 
      GROUP BY province 
      ORDER BY count DESC
    ''');

    for (final row in provinceCount) {
      print('  - ${row['province']}: ${row['count']}개');
    }

    await db.close();
  } catch (e) {
    print('❌ 오류 발생: $e');
  }
}
