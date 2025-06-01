import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

void main() async {
  // desktop용 FFI 초기화
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  try {
    print('🔍 데이터베이스 상태 확인 시작...');

    // 데이터베이스 경로 확인
    final databasesPath = await getDatabasesPath();
    final dbPath = join(databasesPath, 'parking_finder.db');

    print('📍 데이터베이스 경로: $dbPath');

    final dbFile = File(dbPath);
    if (!await dbFile.exists()) {
      print('❌ 데이터베이스 파일이 존재하지 않습니다!');
      return;
    }

    final db = await openDatabase(dbPath);

    // 1. 전체 레코드 수 확인
    final totalResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM regions',
    );
    final totalCount = totalResult.first['count'] as int;
    print('📊 전체 지역 레코드 수: $totalCount개');

    if (totalCount == 0) {
      print('❌ 지역 데이터가 비어있습니다!');
      await db.close();
      return;
    }

    // 2. 시도별 개수 확인
    print('\n🏛️ 시도별 레코드 수:');
    final provinceResult = await db.rawQuery('''
      SELECT province, COUNT(*) as count 
      FROM regions 
      GROUP BY province 
      ORDER BY count DESC
    ''');

    for (final row in provinceResult) {
      print('  ${row['province']}: ${row['count']}개');
    }

    // 3. 서울 지역 확인
    print('\n🏙️ 서울특별시 시군구 (처음 10개):');
    final seoulResult = await db.query(
      'regions',
      where: 'province = ?',
      whereArgs: ['서울특별시'],
      limit: 10,
    );

    for (final row in seoulResult) {
      print('  ${row['sigungu_name']} (코드: ${row['sigungu_code']})');
    }

    // 4. 읍면동 데이터 확인 (bjdongs 테이블이 있는지 확인)
    try {
      final bjdongResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM bjdongs',
      );
      final bjdongCount = bjdongResult.first['count'] as int;
      print('\n🏘️ 읍면동 레코드 수: $bjdongCount개');

      if (bjdongCount > 0) {
        print('\n📍 서울 종로구 읍면동 (처음 5개):');
        final jongnoResult = await db.query(
          'bjdongs',
          where: 'sigungu_code = ?',
          whereArgs: ['11110'], // 종로구 코드
          limit: 5,
        );

        for (final row in jongnoResult) {
          print('  ${row['bjdong_name']}');
        }
      }
    } catch (e) {
      print('⚠️ bjdongs 테이블이 존재하지 않거나 오류: $e');
    }

    await db.close();
    print('\n✅ 데이터베이스 상태 확인 완료');
  } catch (e) {
    print('❌ 데이터베이스 확인 실패: $e');
  }
}
