import '../lib/core/database/database_helper.dart';
import '../lib/features/parking/data/repositories/region_repository.dart';
import '../lib/core/api/legal_district_api_service.dart';

Future<void> main() async {
  try {
    print('🚀 데이터베이스 마이그레이션 시작');

    final databaseHelper = DatabaseHelper();
    final regionRepository = RegionRepository(databaseHelper);

    // 강제 마이그레이션 실행
    await regionRepository.forceMigration();

    // 결과 확인
    final dbInfo = await regionRepository.getDatabaseInfo();
    print('\n📊 마이그레이션 결과:');
    print('  - 총 지역 수: ${dbInfo['regions_count']}개');
    print('  - 시도 수: ${dbInfo['provinces_count']}개');
    print('  - 시도 목록: ${dbInfo['provinces']}');

    print('\n✅ 마이그레이션 완료!');

    await regionRepository.close();
  } catch (e, stackTrace) {
    print('❌ 마이그레이션 실패: $e');
    print('스택 트레이스: $stackTrace');
  }
}
