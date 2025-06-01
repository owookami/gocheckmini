import 'dart:io';
import 'package:path/path.dart' as path;

void main() async {
  print('🔍 sigungu.txt 데이터 확인 스크립트');
  print('=====================================');

  // sigungu.txt 파일 경로 확인
  final scriptDir = Directory.fromUri(Platform.script).parent;
  final sigunguFile = File(
    path.join(scriptDir.path, '..', '..', 'scripts', 'sigungu.txt'),
  );

  if (!await sigunguFile.exists()) {
    print('❌ sigungu.txt 파일을 찾을 수 없습니다: ${sigunguFile.path}');
    return;
  }

  print('✅ sigungu.txt 파일 발견: ${sigunguFile.path}');

  // 파일 읽기
  final lines = await sigunguFile.readAsLines();
  print('📄 총 라인 수: ${lines.length}');

  // 헤더 확인
  if (lines.isNotEmpty) {
    print('📝 헤더: ${lines[0]}');
  }

  // 데이터 라인 파싱
  final dataLines = <Map<String, dynamic>>[];
  final errors = <String>[];

  for (int i = 1; i < lines.length; i++) {
    // 첫 번째 줄은 헤더
    final line = lines[i].trim();
    if (line.isEmpty) continue;

    final parts = line.split(' ');
    if (parts.length >= 4) {
      try {
        final unifiedCode = int.parse(parts[0]);
        final sigunguCode = parts[1];
        final sigunguName = parts[2];
        final isAutonomous = parts[3] == '해당';

        dataLines.add({
          'unified_code': unifiedCode,
          'sigungu_code': sigunguCode,
          'sigungu_name': sigunguName,
          'is_autonomous_district': isAutonomous ? 1 : 0,
        });
      } catch (e) {
        errors.add('라인 $i 파싱 오류: $line - $e');
      }
    } else {
      errors.add('라인 $i 형식 오류: $line (부족한 필드)');
    }
  }

  print('✅ 성공적으로 파싱된 데이터: ${dataLines.length}개');
  print('❌ 파싱 오류: ${errors.length}개');

  if (errors.isNotEmpty) {
    print('\n⚠️ 파싱 오류 목록:');
    for (final error in errors.take(10)) {
      // 최대 10개만 표시
      print('  - $error');
    }
    if (errors.length > 10) {
      print('  ... 그리고 ${errors.length - 10}개 더');
    }
  }

  // 데이터 샘플 출력
  print('\n📊 데이터 샘플 (처음 10개):');
  for (final data in dataLines.take(10)) {
    print(
      '  - ${data['sigungu_name']} (${data['sigungu_code']}) - 자치구: ${data['is_autonomous_district'] == 1 ? '예' : '아니오'}',
    );
  }

  // 통계 출력
  final seoulCount =
      dataLines
          .where((d) => d['sigungu_name'].toString().startsWith('서울특별시'))
          .length;
  final busanCount =
      dataLines
          .where((d) => d['sigungu_name'].toString().startsWith('부산광역시'))
          .length;
  final gyeonggiCount =
      dataLines
          .where((d) => d['sigungu_name'].toString().startsWith('경기도'))
          .length;
  final autonomousCount =
      dataLines.where((d) => d['is_autonomous_district'] == 1).length;

  print('\n📈 지역별 통계:');
  print('  - 서울특별시: ${seoulCount}개');
  print('  - 부산광역시: ${busanCount}개');
  print('  - 경기도: ${gyeonggiCount}개');
  print('  - 자치구 지역: ${autonomousCount}개');
  print('  - 일반 지역: ${dataLines.length - autonomousCount}개');

  // SQL 삽입 문 생성 (샘플)
  print('\n💾 SQL 삽입 문 생성 (처음 5개):');
  for (final data in dataLines.take(5)) {
    print(
      'INSERT INTO regions (unified_code, sigungu_code, sigungu_name, is_autonomous_district) VALUES (${data['unified_code']}, \'${data['sigungu_code']}\', \'${data['sigungu_name']}\', ${data['is_autonomous_district']});',
    );
  }

  print('\n✅ sigungu.txt 데이터 확인 완료!');
  print('✅ 총 ${dataLines.length}개의 유효한 지역 데이터를 확인했습니다.');
}
