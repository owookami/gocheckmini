import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../lib/features/parking/data/services/standard_region_service.dart';
import '../lib/features/parking/data/models/standard_region_model.dart';

void main() async {
  print('🔍 행정안전부 표준 지역 코드 API 테스트 (JSON 파싱)');

  // .env 파일 로드
  try {
    await dotenv.load(fileName: '.env');
    print('✅ .env 파일 로드 성공');
  } catch (e) {
    print('⚠️ .env 파일 로드 실패: $e');
  }

  // 간단한 JSON 파싱 테스트
  print('\n🧪 JSON 파싱 테스트');
  final testJson = {
    "region_cd": "1100000000",
    "sido_cd": "11",
    "sgg_cd": "000",
    "umd_cd": "000",
    "ri_cd": "00",
    "locatjumin_cd": "1100000000",
    "locatjijuk_cd": "1100000000",
    "locatadd_nm": "서울특별시",
    "locat_order": 11,
    "locat_rm": "",
    "locathigh_cd": "0000000000",
    "locallow_nm": "서울특별시",
    "adpt_de": "20000101",
  };

  try {
    final region = StandardRegion.fromJson(testJson);
    print('✅ JSON 파싱 성공: ${region.locataddNm}');
    print('  - 시도코드: ${region.sidoCd}');
    print('  - 타입: ${region.type}');
  } catch (e) {
    print('❌ JSON 파싱 실패: $e');
    return;
  }

  final service = StandardRegionService();

  try {
    print('\n1️⃣ 시도 목록 조회');
    final sidoList = await service.getSidoList();
    print('✅ 조회된 시도: ${sidoList.length}개');

    for (final sido in sidoList.take(3)) {
      print('  - ${sido.sidoCd}: ${sido.locataddNm}');
    }

    if (sidoList.isNotEmpty) {
      final seoul = sidoList.where((sido) => sido.sidoCd == '11').firstOrNull;

      if (seoul != null) {
        print('\n2️⃣ ${seoul.locataddNm} 시군구 목록 조회');
        final sigunguList = await service.getSigunguList(seoul.sidoCd!);
        print('✅ 조회된 시군구: ${sigunguList.length}개');

        for (final sigungu in sigunguList.take(3)) {
          print('  - ${sigungu.sggCd}: ${sigungu.locataddNm}');
        }

        if (sigunguList.isNotEmpty) {
          final firstSigungu = sigunguList.first;

          print('\n3️⃣ ${firstSigungu.locataddNm} 읍면동 목록 조회');
          final umdList = await service.getUmdList(
            seoul.sidoCd!,
            firstSigungu.sggCd!,
          );
          print('✅ 조회된 읍면동: ${umdList.length}개');

          for (final umd in umdList.take(3)) {
            print('  - ${umd.umdCd}: ${umd.locataddNm}');
            final apiCode = '${umd.sidoCd}${umd.sggCd}';
            print('    -> 주차장 API 시군구코드: $apiCode');
            print('    -> 주차장 API 법정동코드: ${umd.umdCd}');
          }
        }
      } else {
        print('⚠️ 서울시를 찾을 수 없습니다. 첫 번째 시도로 테스트합니다.');
        final firstSido = sidoList.first;

        print('\n2️⃣ ${firstSido.locataddNm} 시군구 목록 조회');
        final sigunguList = await service.getSigunguList(firstSido.sidoCd!);
        print('✅ 조회된 시군구: ${sigunguList.length}개');
      }
    }

    print('\n🎯 성공적으로 API 테스트를 완료했습니다!');
  } catch (e) {
    print('❌ API 테스트 실패: $e');
    print('스택 트레이스: ${StackTrace.current}');
  }
}
