import 'dart:io';

/// 지역명에서 시도, 시, 구/군 정보 파싱
Map<String, String?> parseRegionInfo(String fullName) {
  String? province;
  String? city;
  String? displayName;

  // 광역시/특별시/특별자치시/특별자치도 패턴 매칭
  if (fullName.startsWith('서울특별시')) {
    province = '서울특별시';
    if (fullName.length > '서울특별시'.length) {
      // "서울특별시 종로구" -> "종로구"
      displayName = fullName.substring('서울특별시'.length + 1).trim();
    } else {
      displayName = '서울특별시';
    }
  } else {
    displayName = fullName;
    province = fullName;
  }

  return {'province': province, 'city': city, 'display_name': displayName};
}

Future<void> main() async {
  try {
    // sigungu.txt 파일 읽기
    final file = File('assets/data/sigungu.txt');
    final content = await file.readAsString();
    final lines = content.split('\n');

    print('서울특별시 파싱 테스트:');

    for (int i = 1; i < lines.length && i <= 10; i++) {
      final line = lines[i].trim();
      if (line.isEmpty || !line.contains('서울특별시')) continue;

      final parts = line.split(' ');
      if (parts.length >= 4) {
        final unifiedCode = parts[0];
        final sigunguCode = parts[1];

        // 시군구명을 올바르게 파싱 (세 번째 컬럼부터 마지막-1까지가 이름)
        final sigunguNameParts = parts.sublist(2, parts.length - 1);
        final fullSigunguName = sigunguNameParts.join(' ');
        final isAutonomousString = parts.last;

        print('원본 라인: $line');
        print('  - 파트 분할: $parts');
        print('  - 풀네임: "$fullSigunguName"');

        final regionInfo = parseRegionInfo(fullSigunguName);
        print('  - 파싱 결과: $regionInfo');
        print('---');
      }
    }
  } catch (e) {
    print('오류: $e');
  }
}
