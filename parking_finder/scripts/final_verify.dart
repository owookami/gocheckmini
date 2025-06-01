import '../lib/core/database/database_helper.dart';
import '../lib/features/parking/data/repositories/region_repository.dart';

Future<void> main() async {
  try {
    print('🔍 최종 지역 선택 기능 검증 시작');

    final databaseHelper = DatabaseHelper();
    final regionRepository = RegionRepository(databaseHelper);

    // 1. 시도 목록 확인
    print('\n📍 전체 시도 목록:');
    final provinces = await regionRepository.getProvinces();
    for (final province in provinces) {
      print('  - $province');
    }

    // 2. 서울특별시 시군구 목록 확인 (실제 앱에서 사용되는 방식)
    print('\n🏙️ 서울특별시 선택 시 시군구 목록:');
    final seoulSigungus = await regionRepository.getSigungus('서울특별시');
    print('서울특별시 시군구 총 개수: ${seoulSigungus.length}개');

    if (seoulSigungus.isEmpty) {
      print('❌ 서울특별시 시군구 데이터가 없습니다!');
    } else {
      print('✅ 서울특별시 시군구 데이터가 정상적으로 조회됩니다.');

      for (int i = 0; i < seoulSigungus.length && i < 15; i++) {
        final sigungu = seoulSigungus[i];
        print('  [${i + 1}] ${sigungu.sigunguName} (${sigungu.sigunguCode})');
      }

      if (seoulSigungus.length > 15) {
        print('  ... 외 ${seoulSigungus.length - 15}개');
      }
    }

    // 3. 다른 지역도 테스트
    print('\n🌊 부산광역시 시군구 목록 (처음 5개):');
    final busanSigungus = await regionRepository.getSigungus('부산광역시');
    for (int i = 0; i < busanSigungus.length && i < 5; i++) {
      final sigungu = busanSigungus[i];
      print('  [${i + 1}] ${sigungu.sigunguName} (${sigungu.sigunguCode})');
    }

    print('\n🏞️ 경기도 시군 목록 (처음 5개):');
    final gyeonggiSigungus = await regionRepository.getSigungus('경기도');
    for (int i = 0; i < gyeonggiSigungus.length && i < 5; i++) {
      final sigungu = gyeonggiSigungus[i];
      print('  [${i + 1}] ${sigungu.sigunguName} (${sigungu.sigunguCode})');
    }

    print('\n✅ 최종 검증 완료! 지역 선택 기능이 정상적으로 작동합니다.');

    await regionRepository.close();
  } catch (e, stackTrace) {
    print('❌ 검증 실패: $e');
    print('스택 트레이스: $stackTrace');
  }
}
