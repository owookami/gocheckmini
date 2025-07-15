import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:logger/logger.dart';
import '../../data/models/parking_lot_model.dart';
import '../../data/services/favorites_service.dart';
import '../../data/services/parking_search_service.dart';
import 'google_street_view_screen.dart';
import '../services/web_street_view_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// 즐겨찾기 주차장 목록 화면
class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService _favoritesService = FavoritesService.instance;
  final Logger _logger = Logger();
  List<ParkingLotModel> _favorites = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  /// 즐겨찾기 목록 로드
  Future<void> _loadFavorites() async {
    setState(() => _isLoading = true);

    try {
      final favorites = await _favoritesService.getFavorites();
      if (mounted) {
        setState(() {
          _favorites = favorites;
          _isLoading = false;
        });
      }
    } catch (e) {
      _logger.e('즐겨찾기 로드 실패: $e');
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  /// 즐겨찾기 제거
  Future<void> _removeFavorite(ParkingLotModel parkingLot) async {
    final success = await _favoritesService.removeFavorite(parkingLot);
    if (success) {
      await _loadFavorites(); // 목록 새로고침
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('즐겨찾기에서 제거되었습니다'),
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  /// 전체 즐겨찾기 삭제 확인
  Future<void> _confirmClearAll() async {
    if (_favorites.isEmpty) return;

    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('전체 삭제'),
            content: Text('저장된 ${_favorites.length}개의 즐겨찾기를 모두 삭제하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('삭제'),
              ),
            ],
          ),
    );

    if (result == true) {
      await _favoritesService.clearAllFavorites();
      await _loadFavorites();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('모든 즐겨찾기가 삭제되었습니다'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('즐겨찾기'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_favorites.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: _confirmClearAll,
              tooltip: '전체 삭제',
            ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : _favorites.isEmpty
              ? _buildEmptyState()
              : _buildFavoritesList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.star_border,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              '저장된 즐겨찾기가 없습니다',
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '주차장 목록에서 카드를 길게 눌러\n즐겨찾기에 추가해보세요.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesList() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
              ),
            ),
          ),
          child: Row(
            children: [
              const Icon(Icons.star, color: Colors.amber),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '즐겨찾기 · ${_favorites.length}개 저장됨',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
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
            itemCount: _favorites.length,
            itemBuilder: (context, index) {
              final item = _favorites[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.amber,
                    child: Icon(Icons.star, color: Colors.white, size: 20),
                  ),
                  title: Text(
                    item.name ?? '이름 없음',
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
                        item.address ?? '주소 정보 없음',
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
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () => _removeFavorite(item),
                    tooltip: '즐겨찾기 제거',
                  ),
                  onTap: () => _navigateToStreetView(item),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getItemInfo(ParkingLotModel item) {
    final totalCapacity =
        (item.totalCapacity ?? 0) > 0 ? '${item.totalCapacity}대' : '정보없음';

    if (item.facilityInfo != null) {
      // 공작물관리대장의 경우
      final areaValue = item.area;
      final area = (areaValue != null && areaValue > 0)
              ? '면적: ${areaValue.toStringAsFixed(1)}㎡'
              : '면적: 정보없음';
      return '${item.facilityInfo} · $area';
    } else {
      // 일반/부설 주차장
      return '주차면수: $totalCapacity';
    }
  }

  /// 스트리트 뷰로 이동
  Future<void> _navigateToStreetView(ParkingLotModel parkingLot) async {
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
        // 웹에서는 geocoding 건너뛰기 (null check operator 오류 방지)
        if (kIsWeb) {
          location = null;
        } else {
          // 주소로부터 좌표 검색 (모바일에서만)
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
      }

      // 로딩 다이얼로그 닫기
      if (context.mounted) {
        Navigator.of(context).pop();
      }

      // 스트리트 뷰 화면으로 이동
      if (context.mounted) {
        // 웹에서는 새로운 WebStreetViewService 사용
        if (kIsWeb) {
          final success = await WebStreetViewService.openStreetViewForParkingLot(
            parkingLotName: parkingLot.name ?? '주차장',
            address: parkingLot.address,
            latitude: location?.latitude,
            longitude: location?.longitude,
          );
          
          if (!success && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('스트리트 뷰를 열 수 없습니다. 브라우저 설정을 확인해주세요.'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        } 
        // 모바일에서는 기존대로 GoogleStreetViewScreen 사용 (location이 있을 때만)
        else if (location != null) {
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
          // 모바일에서 위치 정보가 없는 경우 에러 메시지 표시
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('위치 정보를 찾을 수 없어 스트리트뷰를 표시할 수 없습니다.'),
                backgroundColor: Colors.red,
              ),
            );
          }
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
}
