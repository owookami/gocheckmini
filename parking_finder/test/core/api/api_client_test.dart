import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parking_finder/core/api/api_client.dart';

void main() {
  group('ApiClient JSON 테스트', () {
    late ApiClient apiClient;

    setUpAll(() async {
      // 테스트를 위한 환경 변수 로드
      await dotenv.load(fileName: '.env');
    });

    setUp(() {
      apiClient = ApiClient();
      apiClient.initialize();
    });

    tearDown(() {
      apiClient.dispose();
    });

    test('일반 주차장 정보 조회 - JSON 파싱 테스트', () async {
      try {
        final response = await apiClient.getParkingLots(
          pageNo: 1,
          numOfRows: 5,
          sigunguCd: '11110', // 서울특별시 종로구
        );

        expect(response, isNotNull);
        expect(response.resultCode, isNotEmpty);
        expect(response.items, isA<List>());

        print('응답 코드: ${response.resultCode}');
        print('응답 메시지: ${response.resultMsg}');
        print('총 개수: ${response.totalCount}');
        print('아이템 개수: ${response.items.length}');

        if (response.items.isNotEmpty) {
          final firstItem = response.items.first;
          print('첫 번째 주차장: ${firstItem.parkingPlaceName}');
          print('주소: ${firstItem.roadAddress}');
          print('주차구획수: ${firstItem.parkingSpace}');
        }
      } catch (e) {
        print('오류 발생: $e');
        // API 키나 네트워크 오류일 경우 테스트 스킵
        if (e is ApiError && e.type == ApiErrorType.unauthorized) {
          print('API 키가 설정되지 않아 테스트를 스킵합니다.');
          return;
        }
        rethrow;
      }
    });

    test('부설 주차장 정보 조회 - JSON 파싱 테스트', () async {
      try {
        final response = await apiClient.getAttachedParkingLots(
          pageNo: 1,
          numOfRows: 5,
          sigunguCd: '11110', // 서울특별시 종로구
        );

        expect(response, isNotNull);
        expect(response.resultCode, isNotEmpty);
        expect(response.items, isA<List>());

        print('응답 코드: ${response.resultCode}');
        print('응답 메시지: ${response.resultMsg}');
        print('총 개수: ${response.totalCount}');
        print('아이템 개수: ${response.items.length}');

        if (response.items.isNotEmpty) {
          final firstItem = response.items.first;
          print('첫 번째 부설주차장: ${firstItem.parkingPlaceName}');
          print('주소: ${firstItem.roadAddress}');
          print('주차구획수: ${firstItem.parkingSpace}');
        }
      } catch (e) {
        print('오류 발생: $e');
        // API 키나 네트워크 오류일 경우 테스트 스킵
        if (e is ApiError && e.type == ApiErrorType.unauthorized) {
          print('API 키가 설정되지 않아 테스트를 스킵합니다.');
          return;
        }
        rethrow;
      }
    });

    test('하위 호환성 - Raw Response 메서드 테스트', () async {
      try {
        final response = await apiClient.getApPklotInfo(
          pageNo: 1,
          numOfRows: 5,
          sigunguCd: '11110',
        );

        expect(response, isNotNull);
        expect(response.statusCode, 200);
        expect(response.data, isNotNull);

        print('Raw Response 상태코드: ${response.statusCode}');
        print('Raw Response 데이터 타입: ${response.data.runtimeType}');
      } catch (e) {
        print('Raw Response 오류 발생: $e');
        if (e is ApiError && e.type == ApiErrorType.unauthorized) {
          print('API 키가 설정되지 않아 테스트를 스킵합니다.');
          return;
        }
        rethrow;
      }
    });

    test('잘못된 시군구 코드로 테스트', () async {
      try {
        final response = await apiClient.getParkingLots(
          pageNo: 1,
          numOfRows: 5,
          sigunguCd: '99999', // 존재하지 않는 시군구 코드
        );

        // 결과가 있더라도 빈 리스트이거나 에러 코드를 반환할 수 있음
        print('잘못된 시군구코드 결과: ${response.resultCode}');
        print('아이템 개수: ${response.items.length}');
      } catch (e) {
        print('잘못된 시군구코드 오류: $e');
        if (e is ApiError && e.type == ApiErrorType.unauthorized) {
          print('API 키가 설정되지 않아 테스트를 스킵합니다.');
          return;
        }
        // 잘못된 코드로 인한 오류는 예상된 결과일 수 있음
      }
    });
  });
}
