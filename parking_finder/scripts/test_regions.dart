import '../lib/core/database/database_helper.dart';
import '../lib/features/parking/data/repositories/region_repository.dart';

Future<void> main() async {
  try {
    print('🧪 RegionRepository 테스트 시작');

    final databaseHelper = DatabaseHelper();
    final regionRepository = RegionRepository(databaseHelper);

    // 1. 시도 목록 확인
    print('\n📍 시도 목록:');
    final provinces = await regionRepository.getProvinces();
    for (final province in provinces) {
      print('  - $province');
    }

    // 2. 서울특별시 시군구 목록 확인
    print('\n🏙️ 서울특별시 시군구 목록:');
    final seoulSigungus = await regionRepository.getSigungus('서울특별시');
    print('서울특별시 총 구 수: ${seoulSigungus.length}개');

    for (int i = 0; i < seoulSigungus.length && i < 10; i++) {
      final sigungu = seoulSigungus[i];
      print('  [$i] ${sigungu.sigunguName} (코드: ${sigungu.sigunguCode})');
    }

    // 3. 부산광역시 시군구 목록 확인
    print('\n🌊 부산광역시 시군구 목록:');
    final busanSigungus = await regionRepository.getSigungus('부산광역시');
    print('부산광역시 총 구 수: ${busanSigungus.length}개');

    for (int i = 0; i < busanSigungus.length && i < 5; i++) {
      final sigungu = busanSigungus[i];
      print('  [$i] ${sigungu.sigunguName} (코드: ${sigungu.sigunguCode})');
    }

    // 4. 경기도 시군구 목록 확인
    print('\n🏞️ 경기도 시군구 목록:');
    final gyeonggiSigungus = await regionRepository.getSigungus('경기도');
    print('경기도 총 시군 수: ${gyeonggiSigungus.length}개');

    for (int i = 0; i < gyeonggiSigungus.length && i < 5; i++) {
      final sigungu = gyeonggiSigungus[i];
      print('  [$i] ${sigungu.sigunguName} (코드: ${sigungu.sigunguCode})');
    }

    print('\n✅ 테스트 완료!');

    await regionRepository.close();
  } catch (e, stackTrace) {
    print('❌ 테스트 실패: $e');
    print('스택 트레이스: $stackTrace');
  }
}
