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

    // 데이터베이스 열기
    final db = await openDatabase(dbPath);
    print('✅ 데이터베이스 연결 성공');

    // 전체 레코드 수 확인
    final countResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM regions',
    );
    final totalCount = countResult.first['count'] as int;
    print('📊 총 지역 수: $totalCount개');

    // 서울특별시 데이터 직접 확인
    print('\n🏙️ 서울특별시 관련 데이터 (전체):');
    final seoulData = await db.query(
      'regions',
      where: 'province = ?',
      whereArgs: ['서울특별시'],
    );

    print('서울특별시 총 개수: ${seoulData.length}');
    for (int i = 0; i < seoulData.length && i < 10; i++) {
      final row = seoulData[i];
      print(
        '  [$i] 코드: ${row['sigungu_code']}, 이름: "${row['sigungu_name']}", 시도: "${row['province']}", 시: "${row['city']}"',
      );
    }

    // 실제 구 이름들이 들어있는지 확인
    print('\n🔍 구 이름 포함된 데이터 확인:');
    final guData = await db.query(
      'regions',
      where: 'sigungu_name LIKE ?',
      whereArgs: ['%구'],
      limit: 10,
    );

    for (final row in guData) {
      print(
        '  - 코드: ${row['sigungu_code']}, 이름: "${row['sigungu_name']}", 시도: "${row['province']}"',
      );
    }

    await db.close();
  } catch (e, stackTrace) {
    print('❌ 오류: $e');
    print('스택 트레이스: $stackTrace');
  }
}
