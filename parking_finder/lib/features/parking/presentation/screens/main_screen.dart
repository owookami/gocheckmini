import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/standard_region_model.dart';
import '../../data/models/parking_model.dart';
import '../../data/services/standard_region_service.dart';
import '../../data/services/parking_search_service.dart';
import '../../../../core/utils/web_utils.dart';
import 'parking_search_result_screen.dart';
import 'favorites_screen.dart';

/// 주차장 찾기 메인 화면
/// 계층적 지역 선택 (시도 > 시군구 > 읍면동) 제공
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final Logger _logger = Logger();
  final StandardRegionService _regionService = StandardRegionService();
  final ParkingSearchService _parkingService = ParkingSearchService();

  // 검색 상태
  bool isSearching = false;

  // 지역 선택 상태
  List<StandardRegion> sidoList = [];
  List<StandardRegion> sigunguList = [];
  List<StandardRegion> umdList = [];

  StandardRegion? selectedSido;
  StandardRegion? selectedSigungu;
  StandardRegion? selectedUmd;

  // 로딩 상태
  bool isLoadingSido = false;
  bool isLoadingSigungu = false;
  bool isLoadingUmd = false;

  // 검색 타입
  ParkingSearchType selectedSearchType = ParkingSearchType.structure;

  String? errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadSidoList();
    });
  }

  /// 시도 목록 로드
  Future<void> _loadSidoList() async {
    setState(() {
      isLoadingSido = true;
      errorMessage = null;
    });

    try {
      _logger.i('📍 시도 목록 로드 시작');
      final list = await _regionService.getSidoList();

      if (mounted) {
        setState(() {
          // 한글 자음 순으로 정렬
          list.sort((a, b) => (a.displayName).compareTo(b.displayName));
          sidoList = list;
          isLoadingSido = false;
        });

        if (list.isEmpty) {
          setState(() {
            errorMessage = '시도 목록을 불러올 수 없습니다.\nAPI 응답이 비어있거나 형식이 올바르지 않습니다.';
          });
        } else {
          _logger.i('✅ 시도 ${list.length}개 로드 완료');
        }
      }
    } catch (e) {
      _logger.e('❌ 시도 목록 로드 실패: $e');
      if (mounted) {
        setState(() {
          isLoadingSido = false;
          errorMessage = '시도 목록 로드 실패:\n$e';
        });
      }
    }
  }

  /// 시군구 목록 로드
  Future<void> _loadSigunguList(String sidoCode) async {
    setState(() {
      isLoadingSigungu = true;
      sigunguList = [];
      selectedSigungu = null;
      umdList = [];
      selectedUmd = null;
    });

    try {
      _logger.i('🏢 시군구 목록 로드 시작: $sidoCode');
      final regions = await _regionService.getSigunguList(sidoCode);

      setState(() {
        // 한글 자음 순으로 정렬
        regions.sort((a, b) => (a.displayName).compareTo(b.displayName));
        sigunguList = regions;
        isLoadingSigungu = false;
      });

      _logger.i('✅ 시군구 ${regions.length}개 로드 완료');
    } catch (e) {
      _logger.e('❌ 시군구 목록 로드 실패: $e');
      setState(() {
        isLoadingSigungu = false;
      });
      _showErrorSnackBar('시군구 목록을 불러오는데 실패했습니다.');
    }
  }

  /// 읍면동 목록 로드
  Future<void> _loadUmdList(String sidoCode, String sggCode) async {
    setState(() {
      isLoadingUmd = true;
      umdList = [];
      selectedUmd = null;
    });

    try {
      _logger.i('🏘️ 읍면동 목록 로드 시작: $sidoCode-$sggCode');
      final regions = await _regionService.getUmdList(sidoCode, sggCode);

      setState(() {
        // 한글 자음 순으로 정렬
        regions.sort((a, b) => (a.displayName).compareTo(b.displayName));
        umdList = regions;
        isLoadingUmd = false;
      });

      _logger.i('✅ 읍면동 ${regions.length}개 로드 완료');
    } catch (e) {
      _logger.e('❌ 읍면동 목록 로드 실패: $e');
      setState(() {
        isLoadingUmd = false;
      });
      _showErrorSnackBar('읍면동 목록을 불러오는데 실패했습니다.');
    }
  }

  /// 검색 실행
  Future<void> _performSearch() async {
    // 최소 하나의 지역 선택 확인
    if (selectedSido == null) {
      setState(() {
        errorMessage = '시도를 선택해주세요.';
      });
      return;
    }

    if (selectedSigungu == null) {
      setState(() {
        errorMessage = '시군구를 선택해주세요.';
      });
      return;
    }

    if (selectedUmd == null) {
      setState(() {
        errorMessage = '읍면동을 선택해주세요.';
      });
      return;
    }

    setState(() {
      isSearching = true;
      errorMessage = null;
    });

    try {
      // 지역 코드 생성 - 새로운 변환 로직 적용
      String sigunguCode;
      String bjdongCode;

      if (selectedSigungu != null) {
        // sigunguCd 변환: 11000500 → 11500 (앞2자리 + 끝3자리)
        final originalSigunguCode =
            selectedSido!.apiRegionCode + selectedSigungu!.sggCd!;
        if (originalSigunguCode.length >= 5) {
          sigunguCode =
              originalSigunguCode.substring(0, 2) +
              originalSigunguCode.substring(originalSigunguCode.length - 3);
        } else {
          sigunguCode = originalSigunguCode;
        }
      } else {
        sigunguCode = selectedSido!.apiRegionCode;
      }

      if (selectedUmd != null) {
        // bjdongCd 변환: 103 → 10300 (뒤에 00 붙여서 5자리)
        final originalBjdongCode = selectedUmd!.bjdongCode!;
        bjdongCode = originalBjdongCode.padRight(5, '0');
      } else {
        bjdongCode = '000';
      }

      _logger.i('🔍 주차장 검색 실행');
      _logger.d(
        '📍 지역: ${selectedSido!.locataddNm} > ${selectedSigungu?.locataddNm ?? ''} > ${selectedUmd?.locataddNm ?? ''}',
      );
      _logger.d(
        '🔢 원본 지역코드: ${selectedSido!.apiRegionCode}${selectedSigungu?.sggCd ?? ''}, 변환된 sigunguCode: $sigunguCode',
      );
      _logger.d(
        '🔢 원본 법정동코드: ${selectedUmd?.bjdongCode ?? ''}, 변환된 bjdongCode: $bjdongCode',
      );

      // 실제 검색 수행
      final parkingLots = await _parkingService.searchParking(
        searchType: selectedSearchType,
        sigunguCode: sigunguCode,
        bjdongCode: bjdongCode,
      );

      _logger.i('✅ 검색 완료: ${parkingLots.length}개 결과');

      // 검색 결과 화면으로 이동
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder:
                (context) => ParkingSearchResultScreen(
                  parkingLots: parkingLots,
                  searchLocation: _buildLocationString(),
                  searchType: selectedSearchType,
                ),
          ),
        );
      }
    } catch (e) {
      _logger.e('❌ 검색 실행 실패: $e');
      setState(() {
        errorMessage = '검색 실행 중 오류가 발생했습니다:\n$e';
      });
    } finally {
      setState(() {
        isSearching = false;
      });
    }
  }

  /// 위치 문자열 생성
  String _buildLocationString() {
    final parts = <String>[];
    if (selectedSido != null) parts.add(selectedSido!.locataddNm ?? '');
    if (selectedSigungu != null) parts.add(selectedSigungu!.locataddNm ?? '');
    if (selectedUmd != null) parts.add(selectedUmd!.locataddNm ?? '');
    return parts.where((part) => part.isNotEmpty).join(' > ');
  }

  /// 에러 스낵바 표시
  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          '주차장 찾기',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.star),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const FavoritesScreen(),
                ),
              );
            },
            tooltip: '즐겨찾기',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 환경 정보 배너
            _buildEnvironmentInfoBanner(),
            const SizedBox(height: 16),
            
            // 검색 타입 선택
            _buildSearchTypeSection(),
            const SizedBox(height: 20),

            // 지역 선택
            _buildRegionSelectionSection(),
            const SizedBox(height: 24),

            // 에러 메시지 표시
            if (errorMessage != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.red.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red.shade600,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '오류 발생',
                          style: TextStyle(
                            color: Colors.red.shade600,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      errorMessage!,
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          errorMessage = null;
                        });
                        _loadSidoList();
                      },
                      icon: const Icon(Icons.refresh, size: 16),
                      label: const Text('다시 시도'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade600,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(0, 32),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

            // 검색 버튼
            _buildSearchButton(),

            const SizedBox(height: 16),

            // 구조 분석 버튼
            _buildStructureAnalysisButton(),
          ],
        ),
      ),
    );
  }

  /// 환경 정보 배너
  Widget _buildEnvironmentInfoBanner() {
    if (!WebUtils.isWebEnvironment) {
      return const SizedBox.shrink(); // 모바일에서는 표시하지 않음
    }
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue.shade600,
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '웹 버전 정보',
                  style: TextStyle(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  WebUtils.getEnvironmentMessage(),
                  style: TextStyle(
                    color: Colors.blue.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 검색 타입 선택 섹션
  Widget _buildSearchTypeSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.search, color: Colors.blue[600]),
                const SizedBox(width: 8),
                const Text(
                  '검색 타입',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...ParkingSearchType.values.map((type) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color:
                          selectedSearchType == type
                              ? Colors.blue
                              : Colors.grey[300]!,
                      width: selectedSearchType == type ? 2 : 1,
                    ),
                    color:
                        selectedSearchType == type
                            ? Colors.blue[50]
                            : Colors.white,
                  ),
                  child: RadioListTile<ParkingSearchType>(
                    title: Text(
                      type.displayName,
                      style: TextStyle(
                        fontWeight:
                            selectedSearchType == type
                                ? FontWeight.bold
                                : FontWeight.normal,
                        color:
                            selectedSearchType == type
                                ? Colors.blue[700]
                                : Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      type.description,
                      style: TextStyle(
                        color:
                            selectedSearchType == type
                                ? Colors.blue[600]
                                : Colors.grey[600],
                      ),
                    ),
                    value: type,
                    groupValue: selectedSearchType,
                    activeColor: Colors.blue[600],
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedSearchType = value;
                        });
                      }
                    },
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// 지역 선택 섹션
  Widget _buildRegionSelectionSection() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.blue[600]),
                const SizedBox(width: 8),
                const Text(
                  '지역 선택',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // 시도 선택
            _buildRegionDropdown(
              label: '시도 *',
              hint: isLoadingSido ? '시도 목록을 불러오는 중...' : '시도를 선택하세요',
              items: sidoList,
              selectedItem: selectedSido,
              isLoading: isLoadingSido,
              onChanged: (region) {
                setState(() {
                  selectedSido = region;
                });
                if (region?.sidoCd != null) {
                  _loadSigunguList(region!.sidoCd!);
                }
              },
              itemLabel: (region) => region.displayName,
            ),
            const SizedBox(height: 16),

            // 시군구 선택
            _buildRegionDropdown(
              label: '시군구 *',
              hint: '시군구를 선택하세요',
              items: sigunguList,
              selectedItem: selectedSigungu,
              isLoading: isLoadingSigungu,
              enabled: selectedSido != null && !isLoadingSigungu,
              onChanged: (region) {
                setState(() {
                  selectedSigungu = region;
                });
                if (region?.sggCd != null && selectedSido?.sidoCd != null) {
                  _loadUmdList(selectedSido!.sidoCd!, region!.sggCd!);
                }
              },
              itemLabel: (region) => region.displayName,
            ),
            const SizedBox(height: 16),

            // 읍면동 선택
            _buildRegionDropdown(
              label: '읍면동 *',
              hint: '읍면동을 선택하세요',
              items: umdList,
              selectedItem: selectedUmd,
              isLoading: isLoadingUmd,
              enabled: selectedSigungu != null && !isLoadingUmd,
              onChanged: (region) {
                setState(() {
                  selectedUmd = region;
                });
              },
              itemLabel: (region) => region.displayName,
            ),
          ],
        ),
      ),
    );
  }

  /// 지역 드롭다운 위젯
  Widget _buildRegionDropdown({
    required String label,
    required String hint,
    required List<StandardRegion> items,
    required StandardRegion? selectedItem,
    required void Function(StandardRegion?) onChanged,
    required String Function(StandardRegion) itemLabel,
    bool enabled = true,
    bool isLoading = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: DropdownButtonFormField<StandardRegion>(
            value: selectedItem,
            onChanged: enabled && !isLoading ? onChanged : null,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              hintText: enabled ? hint : '상위 지역을 먼저 선택하세요',
              hintStyle: TextStyle(color: Colors.grey[500]),
            ),
            items:
                items.map((item) {
                  return DropdownMenuItem<StandardRegion>(
                    value: item,
                    child: Text(
                      itemLabel(item),
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
            icon:
                isLoading
                    ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                    : const Icon(Icons.arrow_drop_down),
          ),
        ),
      ],
    );
  }

  /// 검색 버튼
  Widget _buildSearchButton() {
    final canSearch =
        selectedSido != null && selectedSigungu != null && selectedUmd != null;

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: canSearch && !isSearching ? _performSearch : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[600],
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child:
            isSearching
                ? const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      '검색 중...',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
                : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.search, size: 24),
                    const SizedBox(width: 12),
                    Text(
                      '주차장 검색${canSearch ? '' : ' (모든 지역을 선택하세요)'}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  /// 구조 분석 버튼
  Widget _buildStructureAnalysisButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {
          context.push('/structure-analysis');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[600],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.analytics, size: 24),
            SizedBox(width: 12),
            Text(
              '건축물 구조 분석',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
