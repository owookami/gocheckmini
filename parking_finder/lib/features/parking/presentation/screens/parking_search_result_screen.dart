import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../data/models/parking_lot_model.dart';
import '../../data/services/parking_search_service.dart';
import '../../data/services/favorites_service.dart';
import 'naver_map_screen.dart';
import 'google_map_screen.dart';
import 'google_street_view_screen.dart';
import '../widgets/map_selection_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingSearchResultScreen extends StatefulWidget {
  final List<ParkingLotModel> parkingLots;
  final String searchLocation;
  final ParkingSearchType searchType;

  const ParkingSearchResultScreen({
    Key? key,
    required this.parkingLots,
    required this.searchLocation,
    required this.searchType,
  }) : super(key: key);

  @override
  State<ParkingSearchResultScreen> createState() =>
      _ParkingSearchResultScreenState();
}

class _ParkingSearchResultScreenState extends State<ParkingSearchResultScreen> {
  final FavoritesService _favoritesService = FavoritesService.instance;
  Set<String> _favoriteIds = <String>{};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  /// 즐겨찾기 목록 로드
  Future<void> _loadFavorites() async {
    final favoriteIds = await _favoritesService.getFavoriteIds();
    if (mounted) {
      setState(() {
        _favoriteIds = favoriteIds;
      });
    }
  }

  /// 즐겨찾기 토글
  Future<void> _toggleFavorite(ParkingLotModel parkingLot) async {
    final success = await _favoritesService.toggleFavorite(parkingLot);
    if (success && mounted) {
      await _loadFavorites(); // 즐겨찾기 상태 새로고침

      final isFavorite = await _favoritesService.isFavorite(parkingLot);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isFavorite ? '즐겨찾기에 추가되었습니다' : '즐겨찾기에서 제거되었습니다'),
          backgroundColor: isFavorite ? Colors.green : Colors.orange,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  /// 주차장 고유 ID 생성 (FavoritesService와 동일한 로직)
  String _generateParkingId(ParkingLotModel parkingLot) {
    final name = parkingLot.name ?? '';
    final address = parkingLot.address ?? '';
    final lat = parkingLot.latitude?.toStringAsFixed(6) ?? '';
    final lng = parkingLot.longitude?.toStringAsFixed(6) ?? '';

    return '$name|$address|$lat|$lng'.hashCode.toString();
  }

  @override
  Widget build(BuildContext context) {
    final totalCount = widget.parkingLots.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.searchType.displayName} 검색 결과'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:
          totalCount == 0
              ? _buildEmptyState(context)
              : _buildResultsList(context),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              '검색 자료가 없습니다',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.searchLocation}에서\n${widget.searchType.displayName} 정보를 찾을 수 없습니다.\n\n다른 지역을 선택하거나 검색 조건을 변경해보세요.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _showSearchTips(context),
              icon: const Icon(Icons.lightbulb_outline),
              label: const Text('검색 팁 보기'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultsList(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              ),
            ),
          ),
          child: Row(
            children: [
              Icon(
                widget.searchType == ParkingSearchType.general
                    ? Icons.local_parking
                    : Icons.apartment,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${_getCleanSearchLocation()} · ${widget.parkingLots.length}개 발견',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: widget.parkingLots.length,
            itemBuilder: (context, index) {
              final item = widget.parkingLots[index];
              final parkingId = _generateParkingId(item);
              final isFavorite = _favoriteIds.contains(parkingId);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor:
                        isFavorite
                            ? Colors
                                .amber // 즐겨찾기된 항목은 황금색
                            : Theme.of(context).colorScheme.secondary,
                    child:
                        isFavorite
                            ? const Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 20,
                            )
                            : Text(
                              '${index + 1}',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                  ),
                  title: Text(
                    _getItemTitle(item),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        _getItemAddress(item),
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _getItemInfo(item),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  onTap: () => _navigateToMap(context, item),
                  onLongPress: () => _toggleFavorite(item),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getItemTitle(ParkingLotModel item) {
    return item.name ?? '이름 없음';
  }

  String _getItemAddress(ParkingLotModel item) {
    return item.address ?? '주소 정보 없음';
  }

  String _getItemInfo(ParkingLotModel item) {
    final totalCapacity =
        (item.totalCapacity ?? 0) > 0 ? '${item.totalCapacity}대' : '정보없음';
    final availableSpots =
        (item.availableSpots ?? 0) > 0 ? '${item.availableSpots}대' : '정보없음';

    if (widget.searchType == ParkingSearchType.structure) {
      // 공작물관리대장의 경우 공작물 코드명과 면적 표시
      final facilityInfo = item.facilityInfo ?? '공작물 정보 없음';
      final areaValue = item.area;
      final area = (areaValue != null && areaValue > 0)
              ? '면적: ${areaValue.toStringAsFixed(1)}㎡'
              : '면적: 정보없음';
      return '$facilityInfo · $area';
    } else if (widget.searchType == ParkingSearchType.general) {
      return '주차면수: $totalCapacity';
    } else {
      return '총 주차면수: $totalCapacity · 이용가능: $availableSpots';
    }
  }

  void _showDetailDialog(BuildContext context, ParkingLotModel item) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(item.name ?? '주차장 정보'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (item.address != null) ...[
                    const Text(
                      '주소:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(item.address ?? ''),
                    const SizedBox(height: 12),
                  ],
                  if (widget.searchType == ParkingSearchType.structure) ...[
                    // 공작물관리대장 특화 정보
                    if (item.facilityInfo != null) ...[
                      const Text(
                        '공작물 정보:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(item.facilityInfo ?? ''),
                      const SizedBox(height: 8),
                    ],
                    ...() {
                      final areaValue = item.area;
                      if (areaValue != null && areaValue > 0) {
                        return [
                          const Text(
                            '면적:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('${areaValue.toStringAsFixed(1)}㎡'),
                          const SizedBox(height: 8),
                        ];
                      }
                      return <Widget>[];
                    }(),
                    const Text(
                      '구분:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(item.type.displayName),
                    const SizedBox(height: 8),
                  ] else ...[
                    // 일반/부설 주차장 정보
                    if ((item.totalCapacity ?? 0) > 0) ...[
                      const Text(
                        '총 주차면수:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${item.totalCapacity}대'),
                      const SizedBox(height: 8),
                    ],
                    if ((item.availableSpots ?? 0) > 0) ...[
                      const Text(
                        '이용가능:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('${item.availableSpots}대'),
                      const SizedBox(height: 8),
                    ],
                    if (item.operatingHoursStart != null ||
                        item.operatingHoursEnd != null) ...[
                      const Text(
                        '운영시간:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${item.operatingHoursStart ?? ''} ~ ${item.operatingHoursEnd ?? ''}',
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (item.feeInfo != null) ...[
                      const Text(
                        '요금정보:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(item.feeInfo ?? ''),
                      const SizedBox(height: 8),
                    ],
                    if (item.phoneNumber != null) ...[
                      const Text(
                        '연락처:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(item.phoneNumber ?? ''),
                      const SizedBox(height: 8),
                    ],
                  ],
                  if (item.managementAgency != null) ...[
                    const Text(
                      '관리기관:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(item.managementAgency ?? ''),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('닫기'),
              ),
            ],
          ),
    );
  }

  void _showSearchTips(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('🔍 효과적인 검색 방법'),
            content: const Text(
              '• 인근 시군구로 검색 범위를 확장해보세요\n'
              '• 일반 주차장과 부설 주차장을 번갈아 검색해보세요\n'
              '• 도심 지역은 부설 주차장이 더 많을 수 있습니다\n'
              '• 외곽 지역은 일반 주차장이 더 많을 수 있습니다\n'
              '• 데이터가 없는 지역일 수 있으니 주변 지역도 확인해보세요\n\n'
              '💡 팁: 검색이 안 되면 상위 지역(시도)부터 다시 선택해보세요!',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('확인'),
              ),
            ],
          ),
    );
  }

  /// 지도 화면으로 이동
  Future<void> _navigateToMap(
    BuildContext context,
    ParkingLotModel parkingLot,
  ) async {
    // 바로 스트리트 뷰로 이동
    await _openStreetViewDirect(context, parkingLot);
  }

  /// 스트리트 뷰 직접 열기
  Future<void> _openStreetViewDirect(
    BuildContext context,
    ParkingLotModel parkingLot,
  ) async {
    // 로딩 다이얼로그 표시
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (context) => const Center(
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: Color(0xFF4285F4)),
                    SizedBox(height: 16),
                    Text('좌표를 검색하는 중...'),
                  ],
                ),
              ),
            ),
          ),
    );

    try {
      LatLng? location;

      // 이미 좌표가 있는 경우
      if (parkingLot.latitude != null && parkingLot.longitude != null) {
        final lat = parkingLot.latitude;
        final lng = parkingLot.longitude;
        if (lat != null && lng != null) {
          location = LatLng(lat, lng);
        }
      } else {
        // 주소로부터 좌표 검색
        final address = parkingLot.address;
        if (address == null || address.isEmpty) {
          throw Exception('주소 정보가 없습니다');
        }

        final locations = await locationFromAddress(address);
        if (locations.isNotEmpty) {
          final loc = locations.first;
          location = LatLng(loc.latitude, loc.longitude);
        } else {
          throw Exception('주소에서 좌표를 찾을 수 없습니다');
        }
      }

      // 로딩 다이얼로그 닫기
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // 스트리트 뷰 화면으로 이동
      if (context.mounted && location != null) {
        final safeLocation = location;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => GoogleStreetViewScreen(
              parkingLot: parkingLot,
              latitude: safeLocation.latitude,
              longitude: safeLocation.longitude,
            ),
          ),
        );
      } else {
        // 위치 정보가 없는 경우 에러 메시지 표시
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('위치 정보를 찾을 수 없어 스트리트뷰를 표시할 수 없습니다.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      // 로딩 다이얼로그 닫기
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // 에러 표시
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('스트리트 뷰 열기 실패: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  String _getCleanSearchLocation() {
    if (widget.searchLocation.isEmpty) return widget.searchLocation;

    // ">" 기준으로 분리
    final parts =
        widget.searchLocation.split(' > ').map((e) => e.trim()).toList();

    if (parts.length <= 1) return widget.searchLocation;

    final cleanedParts = <String>[];
    cleanedParts.add(parts[0]); // 첫 번째 부분은 항상 포함

    for (int i = 1; i < parts.length; i++) {
      final currentPart = parts[i];
      final previousPart = parts[i - 1];

      // 현재 부분이 이전 부분으로 시작하는지 확인
      if (currentPart.startsWith(previousPart)) {
        // 중복 부분 제거
        final cleanedPart = currentPart.substring(previousPart.length).trim();
        if (cleanedPart.isNotEmpty) {
          cleanedParts.add(cleanedPart);
        }
      } else {
        cleanedParts.add(currentPart);
      }
    }

    return cleanedParts.join(' > ');
  }
}
