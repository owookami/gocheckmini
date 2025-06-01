import 'dart:io';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../core/database/database_helper.dart';
import '../../../../core/database/database_schema.dart';
import '../../../../core/api/legal_district_api_service.dart';
import '../models/region_model.dart';

/// 지역 정보를 관리하는 Repository
class RegionRepository {
  final DatabaseHelper _databaseHelper;
  final LegalDistrictApiService _apiService;
  final Logger _logger = Logger();

  RegionRepository(this._databaseHelper)
    : _apiService = LegalDistrictApiService();

  /// 데이터베이스 초기화 상태 확인
  Future<bool> isInitialized() async {
    try {
      final db = await _databaseHelper.database;
      final result = await db.query(DatabaseSchema.regionsTable, limit: 1);
      return result.isNotEmpty;
    } catch (e) {
      _logger.e('초기화 상태 확인 실패', error: e);
      return false;
    }
  }

  /// 강제 초기화 실행 (assets의 데이터베이스 파일을 복사)
  Future<void> forceInitialize() async {
    try {
      _logger.i('🔄 지역 데이터 강제 초기화 시작...');

      // assets에서 데이터베이스 파일 복사
      await _copyDatabaseFromAssets();

      _logger.i('✅ 지역 데이터 강제 초기화 완료');
    } catch (e, stackTrace) {
      _logger.e('❌ 강제 초기화 실패', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  /// assets의 데이터베이스 파일을 앱 내부 저장소로 복사
  Future<void> _copyDatabaseFromAssets() async {
    try {
      final databasesPath = await getDatabasesPath();
      final path = join(databasesPath, 'parking_finder.db');

      // 기존 데이터베이스가 있으면 삭제
      final existingFile = File(path);
      if (await existingFile.exists()) {
        await existingFile.delete();
        _logger.d('🗑️ 기존 데이터베이스 파일 삭제');
      }

      // assets에서 데이터베이스 파일 로드
      final assetData = await rootBundle.load('assets/data/parking_finder.db');
      final bytes = assetData.buffer.asUint8List();

      // 앱 내부 저장소에 파일 생성
      await File(path).writeAsBytes(bytes);
      _logger.i('✅ 데이터베이스 파일 복사 완료: $path');

      // 복사된 데이터베이스의 데이터 확인
      final db = await _databaseHelper.database;
      final count = await db.rawQuery('SELECT COUNT(*) as count FROM regions');
      final totalCount = count.first['count'] as int;
      _logger.i('📊 복사된 데이터베이스 레코드 수: $totalCount개');
    } catch (e) {
      _logger.e('❌ 데이터베이스 파일 복사 실패: $e');
      // assets에 파일이 없으면 기존 방식으로 폴백
      await _fallbackToTextFileInitialization();
    }
  }

  /// 기존 텍스트 파일 방식으로 폴백 초기화
  Future<void> _fallbackToTextFileInitialization() async {
    _logger.w('⚠️ 데이터베이스 파일이 없어 텍스트 파일로 폴백합니다');

    try {
      // sigungu.txt 파일에서 데이터 읽기
      final assetData = await rootBundle.loadString('assets/data/sigungu.txt');
      final lines = assetData.split('\n');

      final db = await _databaseHelper.database;

      await db.transaction((txn) async {
        // 외래 키 제약 조건 임시 비활성화
        await txn.execute('PRAGMA foreign_keys = OFF');

        // 테이블 삭제 순서를 올바르게 처리 (자식 테이블부터)
        await txn.delete('bjdongs');
        await txn.delete('regions');

        // 외래 키 제약 조건 다시 활성화
        await txn.execute('PRAGMA foreign_keys = ON');

        int id = 1;
        for (int i = 0; i < lines.length; i++) {
          final line = lines[i].trim();

          // 헤더나 빈 줄 건너뛰기
          if (line.isEmpty ||
              line.startsWith('통합분류코드') ||
              line.contains('국토교통부')) {
            continue;
          }

          try {
            // 공백으로 구분된 데이터 파싱
            final parts = line.split(RegExp(r'\\s+'));

            if (parts.length >= 4) {
              final unifiedCode = int.tryParse(parts[0]) ?? 0;
              final sigunguCode = parts[1];

              // 이 부분이 문제였습니다. 시군구명 전체를 파싱해야 합니다
              final sigunguNameParts = parts.sublist(2, parts.length - 1);
              final fullSigunguName = sigunguNameParts.join(' ');
              final autonomousDistrict = parts.last;

              // 지역 정보 파싱
              final regionInfo = _parseRegionInfo(fullSigunguName);

              await txn.insert('regions', {
                'id': id++,
                'unified_code': unifiedCode,
                'sigungu_code': sigunguCode,
                'sigungu_name': regionInfo['display_name'] ?? fullSigunguName,
                'is_autonomous_district': autonomousDistrict == '해당' ? 1 : 0,
                'province': regionInfo['province'] ?? '',
                'city': regionInfo['city'] ?? '',
                'created_at': DateTime.now().toIso8601String(),
                'updated_at': DateTime.now().toIso8601String(),
              });
            }
          } catch (e) {
            _logger.w('라인 파싱 실패 (${i + 1}번째 줄): $line - $e');
          }
        }
      });

      _logger.i('✅ 텍스트 파일로부터 데이터 초기화 완료');
    } catch (e) {
      _logger.e('❌ 텍스트 파일 초기화도 실패: $e');
      rethrow;
    }
  }

  /// 지역명에서 시도, 시, 구/군 정보 파싱
  Map<String, String?> _parseRegionInfo(String fullName) {
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
    } else if (fullName.startsWith('부산광역시')) {
      province = '부산광역시';
      if (fullName.length > '부산광역시'.length) {
        displayName = fullName.substring('부산광역시'.length + 1).trim();
      } else {
        displayName = '부산광역시';
      }
    } else if (fullName.startsWith('대구광역시')) {
      province = '대구광역시';
      if (fullName.length > '대구광역시'.length) {
        displayName = fullName.substring('대구광역시'.length + 1).trim();
      } else {
        displayName = '대구광역시';
      }
    } else if (fullName.startsWith('인천광역시')) {
      province = '인천광역시';
      if (fullName.length > '인천광역시'.length) {
        displayName = fullName.substring('인천광역시'.length + 1).trim();
      } else {
        displayName = '인천광역시';
      }
    } else if (fullName.startsWith('광주광역시')) {
      province = '광주광역시';
      if (fullName.length > '광주광역시'.length) {
        displayName = fullName.substring('광주광역시'.length + 1).trim();
      } else {
        displayName = '광주광역시';
      }
    } else if (fullName.startsWith('대전광역시')) {
      province = '대전광역시';
      if (fullName.length > '대전광역시'.length) {
        displayName = fullName.substring('대전광역시'.length + 1).trim();
      } else {
        displayName = '대전광역시';
      }
    } else if (fullName.startsWith('울산광역시')) {
      province = '울산광역시';
      if (fullName.length > '울산광역시'.length) {
        displayName = fullName.substring('울산광역시'.length + 1).trim();
      } else {
        displayName = '울산광역시';
      }
    } else if (fullName.startsWith('세종특별자치시')) {
      province = '세종특별자치시';
      displayName = '세종특별자치시';
    } else if (fullName.startsWith('경기도')) {
      province = '경기도';
      if (fullName.length > '경기도'.length) {
        displayName = fullName.substring('경기도'.length + 1).trim();
        city = displayName;
      } else {
        displayName = '경기도';
      }
    } else if (fullName.startsWith('충청북도')) {
      province = '충청북도';
      if (fullName.length > '충청북도'.length) {
        displayName = fullName.substring('충청북도'.length + 1).trim();
        city = displayName;
      } else {
        displayName = '충청북도';
      }
    } else if (fullName.startsWith('충청남도')) {
      province = '충청남도';
      if (fullName.length > '충청남도'.length) {
        displayName = fullName.substring('충청남도'.length + 1).trim();
        city = displayName;
      } else {
        displayName = '충청남도';
      }
    } else if (fullName.startsWith('전북특별자치도')) {
      province = '전북특별자치도';
      if (fullName.length > '전북특별자치도'.length) {
        displayName = fullName.substring('전북특별자치도'.length + 1).trim();
        city = displayName;
      } else {
        displayName = '전북특별자치도';
      }
    } else if (fullName.startsWith('전라북도')) {
      province = '전라북도';
      if (fullName.length > '전라북도'.length) {
        displayName = fullName.substring('전라북도'.length + 1).trim();
        city = displayName;
      } else {
        displayName = '전라북도';
      }
    } else if (fullName.startsWith('전라남도')) {
      province = '전라남도';
      if (fullName.length > '전라남도'.length) {
        displayName = fullName.substring('전라남도'.length + 1).trim();
        city = displayName;
      } else {
        displayName = '전라남도';
      }
    } else if (fullName.startsWith('경상북도')) {
      province = '경상북도';
      if (fullName.length > '경상북도'.length) {
        displayName = fullName.substring('경상북도'.length + 1).trim();
        city = displayName;
      } else {
        displayName = '경상북도';
      }
    } else if (fullName.startsWith('경상남도')) {
      province = '경상남도';
      if (fullName.length > '경상남도'.length) {
        displayName = fullName.substring('경상남도'.length + 1).trim();
        city = displayName;
      } else {
        displayName = '경상남도';
      }
    } else if (fullName.startsWith('강원특별자치도')) {
      province = '강원특별자치도';
      if (fullName.length > '강원특별자치도'.length) {
        displayName = fullName.substring('강원특별자치도'.length + 1).trim();
        city = displayName;
      } else {
        displayName = '강원특별자치도';
      }
    } else if (fullName.startsWith('강원도')) {
      province = '강원도';
      if (fullName.length > '강원도'.length) {
        displayName = fullName.substring('강원도'.length + 1).trim();
        city = displayName;
      } else {
        displayName = '강원도';
      }
    } else if (fullName.startsWith('제주특별자치도')) {
      province = '제주특별자치도';
      if (fullName.length > '제주특별자치도'.length) {
        displayName = fullName.substring('제주특별자치도'.length + 1).trim();
        city = displayName;
      } else {
        displayName = '제주특별자치도';
      }
    } else {
      // 기타 지역이나 최상위 지역
      if (fullName == '국토교통부') {
        province = '기타';
        displayName = '국토교통부';
      } else {
        province = '기타';
        displayName = fullName;
      }
    }

    return {'province': province, 'city': city, 'display_name': displayName};
  }

  /// 시도 목록 가져오기
  Future<List<String>> getProvinces() async {
    try {
      final db = await _databaseHelper.database;
      final result = await db.query(
        DatabaseSchema.regionsTable,
        columns: ['DISTINCT province'],
        orderBy: 'province ASC',
      );

      return result.map((row) => row['province'] as String).toList();
    } catch (e) {
      _logger.e('시도 목록 조회 실패', error: e);
      return [];
    }
  }

  /// 선택된 시도의 시군구 목록 가져오기
  Future<List<RegionModel>> getSigungus(String province) async {
    try {
      final db = await _databaseHelper.database;
      final result = await db.query(
        DatabaseSchema.regionsTable,
        where: 'province = ? AND sigungu_name != ?',
        whereArgs: [province, province],
        orderBy: 'sigungu_name ASC',
      );

      return result.map((row) => RegionModel.fromJson(row)).toList();
    } catch (e) {
      _logger.e('시군구 목록 조회 실패: $province', error: e);
      return [];
    }
  }

  /// 선택된 시군구의 읍면동 목록 가져오기 (간소화된 실제 데이터)
  Future<List<String>> getBjdongs(String sigunguCode) async {
    try {
      // 주요 시군구별 읍면동 데이터 (대표적인 지역만)
      final bjdongs = _getSimplifiedBjdongs(sigunguCode);
      return bjdongs;
    } catch (e) {
      _logger.e('읍면동 목록 조회 실패: $sigunguCode', error: e);
      return [];
    }
  }

  /// 간소화된 읍면동 목록 반환
  List<String> _getSimplifiedBjdongs(String sigunguCode) {
    // 서울특별시 주요 구
    if (sigunguCode.startsWith('11')) {
      switch (sigunguCode) {
        case '11110': // 종로구
          return [
            '청운효자동',
            '사직동',
            '삼청동',
            '부암동',
            '종로1·2·3·4가동',
            '종로5·6가동',
            '이화동',
            '혜화동',
            '창신1동',
            '창신2동',
            '창신3동',
          ];
        case '11140': // 중구
          return [
            '소공동',
            '회현동',
            '명동',
            '필동',
            '장충동',
            '광희동',
            '을지로동',
            '신당동',
            '다산동',
            '약수동',
            '청구동',
          ];
        case '11170': // 용산구
          return [
            '용산2가동',
            '남영동',
            '청파동',
            '원효로1동',
            '원효로2동',
            '효창동',
            '용문동',
            '한강로동',
            '이촌1동',
            '이촌2동',
            '한남동',
            '서빙고동',
            '보광동',
          ];
        case '11200': // 성동구
          return [
            '왕십리도선동',
            '마장동',
            '사근동',
            '행당1동',
            '행당2동',
            '응봉동',
            '금호1가동',
            '금호2·3가동',
            '금호4가동',
            '옥수동',
            '성수1가1동',
            '성수1가2동',
            '성수2가1동',
            '성수2가3동',
          ];
        case '11215': // 광진구
          return [
            '화양동',
            '군자동',
            '중곡1동',
            '중곡2동',
            '중곡3동',
            '중곡4동',
            '능동',
            '구의1동',
            '구의2동',
            '구의3동',
            '광장동',
            '자양1동',
            '자양2동',
            '자양3동',
            '자양4동',
          ];
        case '11230': // 동대문구
          return [
            '용신동',
            '제기동',
            '전농1동',
            '전농2동',
            '답십리1동',
            '답십리2동',
            '장안1동',
            '장안2동',
            '청량리동',
            '회기동',
            '휘경1동',
            '휘경2동',
          ];
        case '11260': // 중랑구
          return [
            '면목본동',
            '면목2동',
            '면목3·8동',
            '면목4동',
            '면목5동',
            '면목7동',
            '상봉1동',
            '상봉2동',
            '중화1동',
            '중화2동',
            '묵1동',
            '묵2동',
            '망우본동',
            '망우3동',
            '신내1동',
            '신내2동',
          ];
        case '11290': // 성북구
          return [
            '성북동',
            '삼선동',
            '동선동',
            '돈암1동',
            '돈암2동',
            '안암동',
            '보문동',
            '정릉1동',
            '정릉2동',
            '정릉3동',
            '정릉4동',
            '길음1동',
            '길음2동',
            '종암동',
            '월곡1동',
            '월곡2동',
            '장위1동',
            '장위2동',
            '장위3동',
            '석관동',
          ];
        case '11305': // 강북구
          return [
            '삼양동',
            '미아동',
            '송중동',
            '송천동',
            '삼각산동',
            '번1동',
            '번2동',
            '번3동',
            '수유1동',
            '수유2동',
            '수유3동',
            '우이동',
            '인수동',
          ];
        case '11320': // 도봉구
          return [
            '쌍문1동',
            '쌍문2동',
            '쌍문3동',
            '쌍문4동',
            '방학1동',
            '방학2동',
            '방학3동',
            '창1동',
            '창2동',
            '창3동',
            '창4동',
            '창5동',
            '도봉1동',
            '도봉2동',
          ];
        case '11350': // 노원구
          return [
            '월계1동',
            '월계2동',
            '월계3동',
            '공릉1동',
            '공릉2동',
            '하계1동',
            '하계2동',
            '중계본동',
            '중계1동',
            '중계2·3동',
            '중계4동',
            '상계1동',
            '상계2동',
            '상계3·4동',
            '상계5동',
            '상계6·7동',
            '상계8동',
            '상계9동',
            '상계10동',
          ];
        case '11380': // 은평구
          return [
            '녹번동',
            '불광1동',
            '불광2동',
            '갈현1동',
            '갈현2동',
            '구산동',
            '대조동',
            '응암1동',
            '응암2동',
            '응암3동',
            '역촌동',
            '신사1동',
            '신사2동',
            '증산동',
            '수색동',
            '진관동',
          ];
        case '11410': // 서대문구
          return [
            '충현동',
            '천연동',
            '북아현동',
            '신촌동',
            '연희동',
            '홍제1동',
            '홍제2동',
            '홍제3동',
            '홍은1동',
            '홍은2동',
            '남가좌1동',
            '남가좌2동',
            '북가좌1동',
            '북가좌2동',
          ];
        case '11440': // 마포구
          return [
            '공덕동',
            '아현동',
            '도화동',
            '용강동',
            '대흥동',
            '염리동',
            '신수동',
            '서강동',
            '서교동',
            '홍대동',
            '합정동',
            '망원1동',
            '망원2동',
            '연남동',
            '성산1동',
            '성산2동',
            '상암동',
          ];
        default:
          return ['동지역']; // 기본값
      }
    }
    // 부산광역시 주요 구군
    else if (sigunguCode.startsWith('26')) {
      switch (sigunguCode) {
        case '26110': // 중구
          return [
            '중앙동',
            '동광동',
            '대청동',
            '보수동',
            '부평동',
            '광복동',
            '남포동',
            '영주1동',
            '영주2동',
          ];
        case '26140': // 서구
          return [
            '동대신1동',
            '동대신2동',
            '동대신3동',
            '서대신1동',
            '서대신2동',
            '서대신3동',
            '서대신4동',
            '부민동',
            '아미동',
            '초장동',
            '충무동',
            '남부민1동',
            '남부민2동',
          ];
        case '26170': // 동구
          return [
            '초량1동',
            '초량2동',
            '초량3동',
            '초량6동',
            '수정1동',
            '수정2동',
            '수정4동',
            '수정5동',
            '좌천1동',
            '좌천4동',
            '범일1동',
            '범일2동',
            '범일5동',
          ];
        case '26200': // 영도구
          return [
            '동삼1동',
            '동삼2동',
            '동삼3동',
            '신선동',
            '영선1동',
            '영선2동',
            '봉래1동',
            '봉래2동',
            '청학1동',
            '청학2동',
            '남항동',
          ];
        default:
          return ['동지역'];
      }
    }
    // 인천광역시 주요 구군
    else if (sigunguCode.startsWith('28')) {
      switch (sigunguCode) {
        case '28110': // 중구
          return [
            '신흥동',
            '도원동',
            '유동',
            '신포동',
            '송월동',
            '율목동',
            '해안동',
            '중산동',
            '내동',
            '경동',
            '답동',
            '연안동',
            '덕교동',
            '북성동',
            '송학동',
            '운서동',
            '운남동',
            '을왕동',
            '용유동',
            '무의동',
          ];
        case '28140': // 동구
          return [
            '만석동',
            '화평동',
            '송현1동',
            '송현2동',
            '송현3동',
            '화수1동',
            '화수2동',
            '대화동',
            '금창동',
            '금곡동',
            '박문동',
            '동인천동',
            '창영동',
            '도화동',
            '양곡동',
          ];
        case '28177': // 미추홀구
          return [
            '숭의1·3동',
            '숭의4동',
            '도화1동',
            '도화2·3동',
            '주안1동',
            '주안2동',
            '주안3동',
            '주안4동',
            '주안5동',
            '주안6동',
            '주안7동',
            '주안8동',
            '관교동',
            '문학동',
            '학익1동',
            '학익2동',
          ];
        default:
          return ['동지역'];
      }
    }
    // 대구광역시 주요 구군
    else if (sigunguCode.startsWith('27')) {
      switch (sigunguCode) {
        case '27110': // 중구
          return [
            '동인동',
            '삼덕동',
            '성내1동',
            '성내2동',
            '성내3동',
            '대신동',
            '남산1동',
            '남산2동',
            '남산3동',
            '남산4동',
            '봉산동',
          ];
        case '27140': // 동구
          return [
            '신암1동',
            '신암2동',
            '신암3동',
            '신암4동',
            '신암5동',
            '신천1동',
            '신천2동',
            '신천3동',
            '신천4동',
            '효목1동',
            '효목2동',
            '도평동',
            '불로봉무동',
            '지저동',
            '동촌동',
          ];
        case '27170': // 서구
          return [
            '내당1동',
            '내당2동',
            '내당3동',
            '내당4동',
            '비산1동',
            '비산2동',
            '비산3동',
            '비산4동',
            '비산5동',
            '비산6동',
            '비산7동',
            '평리1동',
            '평리2동',
            '평리3동',
            '평리4동',
            '평리5동',
            '평리6동',
            '상중이동',
          ];
        default:
          return ['동지역'];
      }
    }
    // 광주광역시 주요 구
    else if (sigunguCode.startsWith('29')) {
      switch (sigunguCode) {
        case '29110': // 동구
          return [
            '충장동',
            '동명동',
            '산수1동',
            '산수2동',
            '지산1동',
            '지산2동',
            '계림동',
            '용산동',
            '학동',
            '용연동',
            '소태동',
            '황금동',
            '남동',
            '지원1동',
            '지원2동',
            '월남동',
            '불로동',
          ];
        case '29140': // 서구
          return [
            '양동',
            '농성1동',
            '농성2동',
            '농성3동',
            '금호1동',
            '금호2동',
            '유덕동',
            '치평동',
            '상무1동',
            '상무2동',
            '화정1동',
            '화정2동',
            '화정3동',
            '화정4동',
            '마재동',
            '백운동',
            '풍암동',
            '금부동',
            '세하동',
          ];
        case '29155': // 남구
          return [
            '양림동',
            '방림1동',
            '방림2동',
            '봉선1동',
            '봉선2동',
            '사직동',
            '노대동',
            '대촌동',
            '백운1동',
            '백운2동',
            '주월1동',
            '주월2동',
            '효덕동',
            '행암동',
            '진월동',
            '임암동',
            '도금동',
            '압촌동',
            '송하동',
            '지석동',
            '승촌동',
          ];
        default:
          return ['동지역'];
      }
    }
    // 대전광역시 주요 구
    else if (sigunguCode.startsWith('30')) {
      switch (sigunguCode) {
        case '30110': // 동구
          return [
            '효동',
            '판암1동',
            '판암2동',
            '용운동',
            '성남동',
            '홍도동',
            '대별동',
            '산내동',
            '용전동',
            '중앙동',
            '신인동',
            '삼성동',
            '대청동',
          ];
        case '30140': // 중구
          return [
            '은행선화동',
            '목동',
            '중촌동',
            '대흥동',
            '문창동',
            '석교동',
            '대사동',
            '부사동',
            '용두동',
            '오류동',
            '타원동',
            '유천1동',
            '유천2동',
            '문화1동',
            '문화2동',
            '산성동',
          ];
        case '30170': // 서구
          return [
            '복수동',
            '도마1동',
            '도마2동',
            '만년동',
            '둔산1동',
            '둔산2동',
            '둔산3동',
            '괴정동',
            '갈마1동',
            '갈마2동',
            '월평1동',
            '월평2동',
            '월평3동',
            '가수원동',
            '내동',
            '변동',
            '용문동',
            '가장동',
            '정림동',
            '기성동',
            '매노동',
            '관저1동',
            '관저2동',
            '탄방동',
            '학하동',
            '장안동',
          ];
        default:
          return ['동지역'];
      }
    }
    // 울산광역시 주요 구군
    else if (sigunguCode.startsWith('31')) {
      switch (sigunguCode) {
        case '31110': // 중구
          return [
            '성안동',
            '유곡동',
            '학성동',
            '반구동',
            '태화동',
            '약사동',
            '성남동',
            '복산동',
            '남외동',
            '교동',
            '우정동',
            '다운동',
            '서동',
            '강동',
            '옥교동',
          ];
        case '31140': // 남구
          return [
            '신정1동',
            '신정2동',
            '신정3동',
            '신정4동',
            '신정5동',
            '달동',
            '삼산동',
            '야음장생포동',
            '무거동',
            '삼호동',
            '수암동',
            '두왕동',
            '선암동',
          ];
        case '31170': // 동구
          return [
            '일산동',
            '화정동',
            '대송동',
            '동부동',
            '전하1동',
            '전하2동',
            '서부동',
            '미포동',
            '방어동',
            '남목1동',
            '남목2동',
            '남목3동',
            '남목4동',
          ];
        default:
          return ['동지역'];
      }
    }
    // 세종특별자치시
    else if (sigunguCode.startsWith('36')) {
      return [
        '한솔동',
        '도담동',
        '어진동',
        '종촌동',
        '고운동',
        '보람동',
        '새롬동',
        '다정동',
        '소담동',
        '대평동',
        '연서면',
        '전의면',
        '전동면',
        '조치원읍',
        '연기면',
        '부강면',
        '금남면',
        '장군면',
        '연동면',
      ];
    }
    // 경기도 주요 시군
    else if (sigunguCode.startsWith('41')) {
      switch (sigunguCode) {
        case '41111': // 수원시 장안구
          return [
            '파장동',
            '율천동',
            '정자1동',
            '정자2동',
            '정자3동',
            '영화동',
            '송죽동',
            '조원1동',
            '조원2동',
            '연무동',
          ];
        case '41113': // 수원시 영통구
          return [
            '매탄1동',
            '매탄2동',
            '매탄3동',
            '매탄4동',
            '원천동',
            '영통1동',
            '영통2동',
            '태장동',
            '광교동',
            '하동',
          ];
        case '41131': // 성남시 수정구
          return [
            '태평1동',
            '태평2동',
            '태평3동',
            '태평4동',
            '수진1동',
            '수진2동',
            '신흥1동',
            '신흥2동',
            '신흥3동',
            '단대동',
            '복정동',
          ];
        case '41135': // 성남시 분당구
          return [
            '분당동',
            '수내1동',
            '수내2동',
            '수내3동',
            '정자1동',
            '정자2동',
            '정자3동',
            '구미1동',
            '구미2동',
            '백현동',
            '운중동',
            '금곡동',
            '서현1동',
            '서현2동',
            '이매1동',
            '이매2동',
            '야탑1동',
            '야탑2동',
            '야탑3동',
            '판교동',
          ];
        case '41150': // 안양시 만안구
          return [
            '안양1동',
            '안양2동',
            '안양3동',
            '안양4동',
            '안양5동',
            '안양6동',
            '안양7동',
            '안양8동',
            '안양9동',
            '석수1동',
            '석수2동',
            '석수3동',
            '박달1동',
            '박달2동',
          ];
        case '41173': // 부천시
          return [
            '원미1동',
            '원미2동',
            '역곡1동',
            '역곡2동',
            '소사동',
            '송내1동',
            '송내2동',
            '중1동',
            '중2동',
            '중3동',
            '상1동',
            '상2동',
            '상3동',
            '상동',
            '춘의동',
            '신중동',
            '심곡본동',
            '심곡1동',
            '심곡2동',
            '원종1동',
            '원종2동',
            '대장동',
            '고강본동',
            '고강1동',
            '오정동',
          ];
        default:
          return ['동지역'];
      }
    }

    // 그 외 지역은 기본값 반환
    return ['읍면동 정보 없음'];
  }

  /// 지역 검색
  Future<List<RegionModel>> searchRegions(String query) async {
    try {
      final db = await _databaseHelper.database;
      final result = await db.query(
        DatabaseSchema.regionsTable,
        where: 'sigungu_name LIKE ? OR province LIKE ?',
        whereArgs: ['%$query%', '%$query%'],
        orderBy: 'province ASC, sigungu_name ASC',
      );

      return result.map((row) => RegionModel.fromJson(row)).toList();
    } catch (e) {
      _logger.e('지역 검색 실패: $query', error: e);
      return [];
    }
  }

  /// 지역 개수 확인
  Future<int> getRegionCount() async {
    try {
      final db = await _databaseHelper.database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${DatabaseSchema.regionsTable}',
      );
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      _logger.e('지역 개수 조회 실패', error: e);
      return 0;
    }
  }

  /// 시군구 코드로 지역 정보 가져오기
  Future<RegionModel?> getRegionBySigunguCode(String sigunguCode) async {
    try {
      final db = await _databaseHelper.database;
      final result = await db.query(
        DatabaseSchema.regionsTable,
        where: 'sigungu_code = ?',
        whereArgs: [sigunguCode],
        limit: 1,
      );

      if (result.isNotEmpty) {
        return RegionModel.fromJson(result.first);
      }
      return null;
    } catch (e) {
      _logger.e('지역 정보 조회 실패: $sigunguCode', error: e);
      return null;
    }
  }

  /// 데이터베이스 정보 조회
  Future<Map<String, dynamic>> getDatabaseInfo() async {
    try {
      final count = await getRegionCount();
      final provinces = await getProvinces();

      return {
        'regions_count': count,
        'provinces_count': provinces.length,
        'provinces': provinces,
        'is_initialized': count > 0,
        'last_updated': DateTime.now().toIso8601String(),
      };
    } catch (e) {
      _logger.e('❌ 데이터베이스 정보 조회 실패: $e');
      return {
        'regions_count': 0,
        'provinces_count': 0,
        'provinces': <String>[],
        'is_initialized': false,
        'error': e.toString(),
      };
    }
  }

  /// 데이터베이스 연결 해제
  Future<void> close() async {
    await _databaseHelper.close();
  }

  /// 강제로 데이터베이스 마이그레이션 실행
  Future<void> forceMigration() async {
    try {
      print('🚀 강제 데이터베이스 마이그레이션 시작');

      final db = await _databaseHelper.database;

      // 1. 기존 데이터 삭제
      print('🗑️ 기존 지역 데이터 삭제 중...');
      await db.delete(DatabaseSchema.regionsTable);
      print('✅ 기존 데이터 삭제 완료');

      // 2. assets에서 sigungu.txt 파일 읽기
      print('📖 sigungu.txt 파일 읽기 중...');
      final data = await rootBundle.loadString('assets/data/sigungu.txt');
      final lines = data.split('\n');
      print('📄 총 ${lines.length}줄 읽음');

      // 3. 데이터 파싱 및 삽입
      print('🔄 데이터 파싱 및 삽입 중...');
      int insertedCount = 0;
      final batch = db.batch();

      for (int i = 1; i < lines.length; i++) {
        // 첫 줄은 헤더이므로 스킵
        final line = lines[i].trim();
        if (line.isEmpty) continue;

        try {
          final parts = line.split(' ');
          if (parts.length >= 4) {
            final unifiedCode = int.parse(parts[0]);
            final sigunguCode = parts[1];

            // 시군구명을 올바르게 파싱 (세 번째 컬럼부터 마지막-1까지가 이름)
            final sigunguNameParts = parts.sublist(2, parts.length - 1);
            final fullSigunguName = sigunguNameParts.join(' ');
            final isAutonomousString = parts.last;

            // 지역 정보 파싱
            final regionInfo = _parseRegionInfo(fullSigunguName);

            final data = {
              'unified_code': unifiedCode,
              'sigungu_code': sigunguCode,
              'sigungu_name': regionInfo['display_name'] ?? fullSigunguName,
              'is_autonomous_district': isAutonomousString == '해당' ? 1 : 0,
              'province': regionInfo['province'] ?? '',
              'city': regionInfo['city'] ?? '',
              'created_at': DateTime.now().toIso8601String(),
              'updated_at': DateTime.now().toIso8601String(),
            };

            batch.insert(
              DatabaseSchema.regionsTable,
              data,
              conflictAlgorithm: ConflictAlgorithm.replace,
            );

            insertedCount++;
          }
        } catch (e) {
          print('⚠️ 라인 파싱 오류 ($i): $line - $e');
          continue;
        }
      }

      // 배치 실행
      await batch.commit(noResult: true);
      print('✅ 데이터 삽입 완료: ${insertedCount}개');

      // 4. 결과 검증
      print('\n📊 마이그레이션 결과 검증:');
      final countResult = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${DatabaseSchema.regionsTable}',
      );
      final totalCount = countResult.first['count'] as int;
      print('  - 총 지역 수: $totalCount');

      print('\n🎉 강제 마이그레이션 완료!');
    } catch (e, stackTrace) {
      print('❌ 마이그레이션 실패: $e');
      print('스택 트레이스: $stackTrace');
      rethrow;
    }
  }
}
