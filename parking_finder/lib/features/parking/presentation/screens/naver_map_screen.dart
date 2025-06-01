import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:logger/logger.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../data/models/parking_lot_model.dart';
import 'package:url_launcher/url_launcher.dart';

/// 네이버 지도 화면
class NaverMapScreen extends StatefulWidget {
  final ParkingLotModel parkingLot;

  const NaverMapScreen({Key? key, required this.parkingLot}) : super(key: key);

  @override
  State<NaverMapScreen> createState() => _NaverMapScreenState();
}

class _NaverMapScreenState extends State<NaverMapScreen> {
  final Logger _logger = Logger();
  NaverMapController? _mapController;
  NLatLng? _parkingLocation;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeMap();
  }

  /// 지도 초기화
  Future<void> _initializeMap() async {
    try {
      // 네이버 지도 SDK 초기화
      await NaverMapSdk.instance.initialize(
        clientId:
            dotenv.env['NAVER_MAP_CLIENT_ID'] ??
            'YOUR_NAVER_MAP_CLIENT_ID', // 실제 네이버 지도 Client ID로 교체 필요
        onAuthFailed: (ex) {
          _logger.e('❌ 네이버 지도 인증 실패: $ex');
          setState(() {
            _errorMessage = '네이버 지도 인증에 실패했습니다.\nClient ID를 확인해주세요.';
            _isLoading = false;
          });
        },
      );

      // 주소로부터 좌표 가져오기
      await _getLocationFromAddress();
    } catch (e) {
      _logger.e('❌ 지도 초기화 실패: $e');
      setState(() {
        _errorMessage = '지도 초기화에 실패했습니다: $e';
        _isLoading = false;
      });
    }
  }

  /// 주소로부터 좌표 가져오기
  Future<void> _getLocationFromAddress() async {
    try {
      if (widget.parkingLot.latitude != null &&
          widget.parkingLot.longitude != null) {
        // 이미 좌표가 있는 경우
        setState(() {
          _parkingLocation = NLatLng(
            widget.parkingLot.latitude!,
            widget.parkingLot.longitude!,
          );
          _isLoading = false;
        });
        return;
      }

      // 주소로부터 좌표 검색
      final address = widget.parkingLot.address;
      if (address == null || address.isEmpty) {
        throw Exception('주소 정보가 없습니다');
      }

      _logger.d('📍 주소로 좌표 검색: $address');
      final locations = await locationFromAddress(address);

      if (locations.isNotEmpty) {
        final location = locations.first;
        setState(() {
          _parkingLocation = NLatLng(location.latitude, location.longitude);
          _isLoading = false;
        });
        _logger.i('✅ 좌표 검색 성공: ${location.latitude}, ${location.longitude}');
      } else {
        throw Exception('주소에서 좌표를 찾을 수 없습니다');
      }
    } catch (e) {
      _logger.e('❌ 좌표 검색 실패: $e');
      setState(() {
        _errorMessage = '주소를 찾을 수 없습니다: $e';
        _isLoading = false;
      });
    }
  }

  /// 지도 준비 완료 콜백
  void _onMapReady(NaverMapController controller) {
    _mapController = controller;
    _logger.d('🗺️ 네이버 지도 준비 완료');

    if (_parkingLocation != null) {
      _addMarkerAndMoveCamera();
    }
  }

  /// 마커 추가 및 카메라 이동
  Future<void> _addMarkerAndMoveCamera() async {
    if (_mapController == null || _parkingLocation == null) return;

    try {
      // 카메라를 해당 위치로 이동
      await _mapController!.updateCamera(
        NCameraUpdate.fromCameraPosition(
          NCameraPosition(target: _parkingLocation!, zoom: 16),
        ),
      );

      // 마커 추가
      final marker = NMarker(
        id: 'parking_marker',
        position: _parkingLocation!,
        caption: NOverlayCaption(
          text: widget.parkingLot.name ?? '주차장',
          textSize: 12,
          color: Colors.blue,
          haloColor: Colors.white,
        ),
      );

      await _mapController!.addOverlay(marker);
      _logger.d('📍 마커 추가 완료');
    } catch (e) {
      _logger.e('❌ 마커 추가 실패: $e');
    }
  }

  Future<void> _openInNaverMap() async {
    if (_parkingLocation == null) return;

    final lat = _parkingLocation!.latitude;
    final lng = _parkingLocation!.longitude;
    final name = Uri.encodeComponent(widget.parkingLot.name ?? '주차장');

    // 네이버 지도 앱 URL 스킴
    final naverMapUrl =
        'nmap://place?lat=$lat&lng=$lng&name=$name&appname=com.zan.parking_finder';

    try {
      final uri = Uri.parse(naverMapUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        // 네이버 지도 앱이 없으면 웹 버전으로 이동
        await _openInNaverMapWeb();
      }
    } catch (e) {
      // 오류 시 웹 버전으로 대체
      await _openInNaverMapWeb();
    }
  }

  Future<void> _openInNaverMapWeb() async {
    if (_parkingLocation == null) return;

    final lat = _parkingLocation!.latitude;
    final lng = _parkingLocation!.longitude;

    // 네이버 지도 웹 URL (정확한 좌표계 사용)
    final webUrl = 'https://map.naver.com/v5/?c=$lng,$lat,16,0,0,0,dh';

    try {
      final uri = Uri.parse(webUrl);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      _logger.d('네이버 지도 웹 열기 성공: $webUrl');
    } catch (e) {
      _logger.e('네이버 지도 웹 열기 실패: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('지도 열기 실패: $e')));
      }
    }
  }

  Future<void> _openStreetView() async {
    try {
      String searchQuery = '';

      // 주소를 우선적으로 사용
      if (widget.parkingLot.address != null &&
          widget.parkingLot.address!.isNotEmpty) {
        searchQuery = widget.parkingLot.address!;
      } else if (widget.parkingLot.name != null &&
          widget.parkingLot.name!.isNotEmpty) {
        searchQuery = widget.parkingLot.name!;
      }

      if (searchQuery.isEmpty) {
        // 좌표가 있으면 좌표 기반으로 시도
        if (_parkingLocation != null) {
          final lat = _parkingLocation!.latitude;
          final lng = _parkingLocation!.longitude;
          searchQuery = '$lat,$lng';
        } else {
          throw Exception('검색할 주소나 이름이 없습니다');
        }
      }

      final encodedQuery = Uri.encodeComponent(searchQuery);

      // 네이버 지도 검색 URL (거리뷰 안내 포함)
      final searchUrl = 'https://map.naver.com/v5/search/$encodedQuery';

      final uri = Uri.parse(searchUrl);
      await launchUrl(uri, mode: LaunchMode.externalApplication);

      _logger.d('네이버 지도 검색 열기 성공: $searchUrl');

      // 사용자에게 거리뷰 사용법 안내
      if (mounted) {
        _showStreetViewGuide();
      }
    } catch (e) {
      _logger.e('네이버 지도 검색 열기 실패: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('지도 열기 실패: $e')));
      }
    }
  }

  /// 거리뷰 사용법 안내 다이얼로그
  void _showStreetViewGuide() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.streetview, color: Colors.blue),
              SizedBox(width: 8),
              Text('거리뷰 이용 안내'),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('네이버 지도에서 거리뷰를 보려면:'),
              SizedBox(height: 8),
              Text('1. 해당 위치를 찾아주세요'),
              Text('2. 화면 우하단의 "거리뷰" 버튼을 클릭하세요'),
              Text('3. 또는 지도를 길게 눌러 "거리뷰" 선택하세요'),
              SizedBox(height: 8),
              Text(
                '※ 거리뷰는 촬영된 지역에서만 이용 가능합니다',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.parkingLot.address ?? widget.parkingLot.name ?? '주차장 위치',
          style: const TextStyle(fontSize: 14),
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // 거리뷰 보기 버튼
          IconButton(
            icon: const Icon(Icons.streetview),
            tooltip: '거리뷰 보기',
            onPressed: _openStreetView,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('지도를 불러오는 중...'),
          ],
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
              const SizedBox(height: 16),
              Text(
                '지도 로드 실패',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                    _errorMessage = null;
                  });
                  _initializeMap();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('다시 시도'),
              ),
            ],
          ),
        ),
      );
    }

    if (_parkingLocation == null) {
      return const Center(child: Text('위치 정보를 찾을 수 없습니다'));
    }

    return Stack(
      children: [
        // 네이버 지도
        NaverMap(
          options: NaverMapViewOptions(
            initialCameraPosition: NCameraPosition(
              target: _parkingLocation!,
              zoom: 16,
            ),
            mapType: NMapType.basic,
            activeLayerGroups: [NLayerGroup.building, NLayerGroup.traffic],
          ),
          onMapReady: _onMapReady,
        ),
        // 하단 정보 카드
        // Positioned(bottom: 16, left: 16, right: 16, child: _buildInfoCard()),
      ],
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 8,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.parkingLot.name ?? '주차장',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (widget.parkingLot.address != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.parkingLot.address!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            if (widget.parkingLot.totalCapacity != null &&
                widget.parkingLot.totalCapacity! > 0) ...[
              Row(
                children: [
                  Icon(Icons.local_parking, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '주차면수: ${widget.parkingLot.totalCapacity}대',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
            ],
            if (widget.parkingLot.feeInfo != null &&
                widget.parkingLot.feeInfo!.isNotEmpty) ...[
              Row(
                children: [
                  Icon(Icons.payments, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      widget.parkingLot.feeInfo!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _openInNaverMap,
                    icon: const Icon(Icons.navigation, size: 16),
                    label: const Text('네이버 지도'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _openStreetView,
                    icon: const Icon(Icons.streetview, size: 16),
                    label: const Text('거리뷰'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}
