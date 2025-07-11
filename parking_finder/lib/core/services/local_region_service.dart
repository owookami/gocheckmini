import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../../features/parking/data/models/standard_region_model.dart';

/// 로컬 assets 파일 기반 지역 데이터 서비스
/// 웹 환경에서 CORS 문제 없이 지역 정보를 제공합니다.
class LocalRegionService {
  static final LocalRegionService _instance = LocalRegionService._internal();
  factory LocalRegionService() => _instance;
  LocalRegionService._internal();

  final Logger _logger = Logger();
  
  List<RegionData>? _cachedRegionData;
  
  /// sigungu.txt 파일에서 지역 데이터 로드
  Future<List<RegionData>> _loadRegionData() async {
    if (_cachedRegionData != null) {
      return _cachedRegionData!;
    }

    try {
      _logger.i('📍 로컬 지역 데이터 로드 시작');
      if (kIsWeb) print('📍 [WEB] 로컬 지역 데이터 로드 시작');
      
      final String content = await rootBundle.loadString('assets/data/sigungu.txt');
      final List<String> lines = content.split('\n');
      
      final List<RegionData> regionData = [];
      
      for (String line in lines) {
        line = line.trim();
        if (line.isEmpty || line.startsWith('통합분류코드')) continue;
        
        final parts = line.split(' ');
        if (parts.length >= 3) {
          final code = parts[1].trim();
          final name = parts.sublist(2).join(' ').trim();
          
          if (code.isNotEmpty && name.isNotEmpty && name != '미해당') {
            regionData.add(RegionData(
              code: code,
              name: name,
            ));
          }
        }
      }
      
      _cachedRegionData = regionData;
      _logger.i('✅ 로컬 지역 데이터 로드 완료: ${regionData.length}개');
      if (kIsWeb) print('✅ [WEB] 로컬 지역 데이터 로드 완료: ${regionData.length}개');
      
      return regionData;
    } catch (e) {
      _logger.e('❌ 로컬 지역 데이터 로드 실패: $e');
      if (kIsWeb) print('❌ [WEB] 로컬 지역 데이터 로드 실패: $e');
      return [];
    }
  }

  /// 시도 목록 조회
  Future<List<StandardRegion>> getSidoList() async {
    final regionData = await _loadRegionData();
    
    _logger.i('🔍 시도 목록 조회 시작: 총 ${regionData.length}개 지역 데이터');
    if (kIsWeb) print('🔍 [WEB] 시도 목록 조회 시작: 총 ${regionData.length}개 지역 데이터');
    
    // 시도는 코드가 5자리이고 끝 3자리가 '000'인 것들
    final sidoList = regionData
        .where((region) {
          final isCorrectLength = region.code.length == 5;
          final endsWith000 = region.code.endsWith('000');
          _logger.d('🔍 시도 체크: ${region.name} (${region.code}) - 길이:$isCorrectLength, 000끝:$endsWith000');
          return isCorrectLength && endsWith000;
        })
        .map((region) => StandardRegion(
          regionCd: region.code,
          sidoCd: region.code.substring(0, 2),
          sggCd: '000',
          umdCd: '000',
          locataddNm: region.name,
        ))
        .toList();
    
    // 서울을 맨 앞으로, 나머지는 가나다순 정렬
    sidoList.sort((a, b) {
      if (a.locataddNm?.contains('서울') == true) return -1;
      if (b.locataddNm?.contains('서울') == true) return 1;
      return (a.locataddNm ?? '').compareTo(b.locataddNm ?? '');
    });
    
    _logger.i('📍 시도 목록 조회 완료: ${sidoList.length}개');
    
    // 결과 로깅
    for (final sido in sidoList.take(3)) {
      _logger.d('📋 시도 결과: ${sido.locataddNm} (코드: ${sido.regionCd}, 시도코드: ${sido.sidoCd})');
    }
    
    return sidoList.cast<StandardRegion>();
  }

  /// 시군구 목록 조회
  Future<List<StandardRegion>> getSigunguList(String sidoCode) async {
    final regionData = await _loadRegionData();
    
    _logger.i('🔍 시군구 조회 시작: sidoCode=$sidoCode');
    if (kIsWeb) print('🔍 [WEB] 시군구 조회 시작: sidoCode=$sidoCode');
    
    // 시도코드를 2자리로 변환 (11000 -> 11)
    final sidoPrefix = sidoCode.length >= 2 ? sidoCode.substring(0, 2) : sidoCode;
    
    // 해당 시도의 시군구들 찾기
    final sigunguList = regionData
        .where((region) {
          final isCorrectLength = region.code.length == 5;
          final startsWithSido = region.code.startsWith(sidoPrefix);
          final notEndsWith000 = !region.code.endsWith('000');
          final isDistrict = region.name.contains('구') || region.name.contains('군');
          final notMainCity = !region.name.contains('특별시') && !region.name.contains('광역시');
          
          _logger.d('🔍 지역 체크: ${region.name} (${region.code}) - 길이:$isCorrectLength, 시도:$startsWithSido, 비000:$notEndsWith000, 구군:$isDistrict, 비시도:$notMainCity');
          
          return isCorrectLength && startsWithSido && notEndsWith000 && isDistrict && notMainCity;
        })
        .map((region) => StandardRegion(
          regionCd: region.code,
          sidoCd: sidoPrefix + '000',  // 표준 시도 코드 형식
          sggCd: region.code.substring(2), // 뒤 3자리를 시군구 코드로
          umdCd: '000',
          locataddNm: region.name,
        ))
        .toList();
    
    // 가나다순 정렬
    sigunguList.sort((a, b) => (a.locataddNm ?? '').compareTo(b.locataddNm ?? ''));
    
    _logger.i('📍 시군구 목록 조회 완료: ${sigunguList.length}개 (시도코드: $sidoCode)');
    if (kIsWeb) print('📍 [WEB] 시군구 목록 조회 완료: ${sigunguList.length}개 (시도코드: $sidoCode)');
    
    // 결과 로깅
    for (final region in sigunguList.take(3)) {
      _logger.d('📋 결과 예시: ${region.locataddNm} (${region.regionCd})');
    }
    
    return sigunguList.cast<StandardRegion>();
  }

  /// 읍면동 목록 조회 (시범적으로 일부 구역만 제공)
  Future<List<StandardRegion>> getUmdList(String sidoCode, String sggCode) async {
    // 로컬 데이터에는 상세한 읍면동 정보가 제한적이므로
    // 기본적인 구역들만 제공
    final commonUmds = [
      '전체', '시내', '구도심', '신도시', '산업단지', '주거지역', '상업지역'
    ];

    final umdList = commonUmds.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final name = entry.value;
      
      return StandardRegion(
        regionCd: '${sggCode}${index.toString().padLeft(3, "0")}',
        sidoCd: sidoCode,
        sggCd: sggCode,
        umdCd: index.toString().padLeft(3, "0"),
        locataddNm: name,
      );
    }).toList();

    _logger.i('📍 읍면동 목록 조회 완료: ${umdList.length}개 (기본 구역)');
    return umdList.cast<StandardRegion>();
  }
}

/// 지역 데이터 모델
class RegionData {
  final String code;
  final String name;

  RegionData({
    required this.code,
    required this.name,
  });

  @override
  String toString() => 'RegionData(code: $code, name: $name)';
}