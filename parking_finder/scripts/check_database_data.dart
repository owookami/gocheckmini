import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import '../lib/core/database/database_helper.dart';
import '../lib/core/database/database_schema.dart';

void main() async {
  print('🔍 sigungu 데이터베이스 확인 스크립트 시작');

  // FFI 초기화
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  try {
    // 데이터베이스 헬퍼 생성 (실제 데이터베이스 파일 사용)
    final dbHelper = DatabaseHelper();

    print('📂 데이터베이스 경로: ${await dbHelper.databasePath}');

    // 데이터베이스 초기화
    final db = await dbHelper.database;
    print('✅ 데이터베이스 연결 성공');

    // 1. 테이블 존재 확인
    print('\n📋 테이블 존재 확인:');
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table'",
    );

    for (final table in tables) {
      print('  - ${table['name']}');
    }

    // 2. regions 테이블 데이터 개수 확인
    print('\n📊 regions 테이블 데이터 개수:');
    final countResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseSchema.regionsTable}',
    );
    final totalCount = countResult.first['count'] as int;
    print('  총 지역 수: $totalCount');

    if (totalCount == 0) {
      print('❌ regions 테이블이 비어있습니다!');
      await dbHelper.close();
      return;
    }

    // 3. 몇 가지 샘플 데이터 확인
    print('\n📍 샘플 지역 데이터:');
    final sampleData = await db.rawQuery(
      'SELECT * FROM ${DatabaseSchema.regionsTable} LIMIT 5',
    );

    for (final row in sampleData) {
      print(
        '  - ${row['sigungu_code']}: ${row['sigungu_name']} (${row['province']})',
      );
    }

    // 4. 도별 통계
    print('\n🏙️ 도별 지역 통계:');
    final provinceStats = await db.rawQuery('''
      SELECT province, COUNT(*) as count 
      FROM ${DatabaseSchema.regionsTable} 
      WHERE province IS NOT NULL
      GROUP BY province 
      ORDER BY count DESC
    ''');

    for (final stat in provinceStats) {
      print('  - ${stat['province']}: ${stat['count']}개');
    }

    // 5. 특정 지역 검색 테스트
    print('\n🔍 특정 지역 검색 테스트:');

    // 서울특별시 종로구 확인
    final seoul = await db.rawQuery(
      'SELECT * FROM ${DatabaseSchema.regionsTable} WHERE sigungu_code = ?',
      ['11110'],
    );

    if (seoul.isNotEmpty) {
      print('  ✅ 서울특별시 종로구: ${seoul.first['sigungu_name']}');
    } else {
      print('  ❌ 서울특별시 종로구를 찾을 수 없습니다.');
    }

    // 부산광역시 중구 확인
    final busan = await db.rawQuery(
      'SELECT * FROM ${DatabaseSchema.regionsTable} WHERE sigungu_code = ?',
      ['26110'],
    );

    if (busan.isNotEmpty) {
      print('  ✅ 부산광역시 중구: ${busan.first['sigungu_name']}');
    } else {
      print('  ❌ 부산광역시 중구를 찾을 수 없습니다.');
    }

    // 6. 자치구 여부 통계
    print('\n🏛️ 자치구 통계:');
    final autonomousStats = await db.rawQuery('''
      SELECT is_autonomous_district, COUNT(*) as count 
      FROM ${DatabaseSchema.regionsTable} 
      GROUP BY is_autonomous_district
    ''');

    for (final stat in autonomousStats) {
      final isAutonomous = stat['is_autonomous_district'] == 1;
      final type = isAutonomous ? '자치구' : '일반 시군구';
      print('  - $type: ${stat['count']}개');
    }

    await dbHelper.close();
    print('\n✅ 데이터베이스 확인 완료!');
  } catch (e, stackTrace) {
    print('❌ 오류 발생: $e');
    print('스택 트레이스: $stackTrace');
    exit(1);
  }
}
