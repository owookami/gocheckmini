import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:logger/logger.dart';
import '../../data/models/parking_lot_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'google_street_view_screen.dart';

/// 구글 지도 화면 (지도 + 스트리트 뷰 탭)
class GoogleMapScreen extends StatefulWidget {
  final ParkingLotModel parkingLot;

  const GoogleMapScreen({Key? key, required this.parkingLot}) : super(key: key);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen>
    with SingleTickerProviderStateMixin {
  final Logger _logger = Logger();
  GoogleMapController? _mapController;
  LatLng? _parkingLocation;
  bool _isLoading = true;
  String? _errorMessage;
  Set<Marker> _markers = {};

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeMap();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _mapController?.dispose();
    super.dispose();
  }

  /// 지도 초기화
  Future<void> _initializeMap() async {
    try {
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
        final lat = widget.parkingLot.latitude;
        final lng = widget.parkingLot.longitude;
        if (lat != null && lng != null) {
          setState(() {
            _parkingLocation = LatLng(lat, lng);
            _isLoading = false;
          });
          _addMarker();
          return;
        }
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
          _parkingLocation = LatLng(location.latitude, location.longitude);
          _isLoading = false;
        });
        _addMarker();
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

  /// 마커 추가
  void _addMarker() {
    final location = _parkingLocation;
    if (location == null) return;

    final marker = Marker(
      markerId: MarkerId('parking_marker'),
      position: location,
      infoWindow: InfoWindow(
        title: widget.parkingLot.name ?? '주차장',
        snippet: widget.parkingLot.address,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    );

    setState(() {
      _markers = {marker};
    });
  }

  /// 지도 준비 완료 콜백
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    _logger.d('🗺️ 구글 지도 준비 완료');
  }

  /// 구글 지도 앱에서 열기
  Future<void> _openInGoogleMaps() async {
    final location = _parkingLocation;
    if (location == null) return;

    final lat = location.latitude;
    final lng = location.longitude;
    final name = Uri.encodeComponent(widget.parkingLot.name ?? '주차장');

    // 구글 지도 URL
    final googleMapsUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng&query_place_id=$name';

    try {
      final uri = Uri.parse(googleMapsUrl);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      _logger.d('구글 지도 열기 성공: $googleMapsUrl');
    } catch (e) {
      _logger.e('구글 지도 열기 실패: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('구글 지도 열기 실패: $e')));
      }
    }
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
        backgroundColor: const Color(0xFF4285F4), // 구글 블루
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          // 구글 지도 앱에서 열기 버튼
          IconButton(
            icon: const Icon(Icons.open_in_new),
            tooltip: '구글 지도 앱에서 열기',
            onPressed: _openInGoogleMaps,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.map), text: '지도'),
            Tab(icon: Icon(Icons.streetview), text: '스트리트 뷰'),
          ],
        ),
      ),
      body:
          _isLoading
              ? _buildLoadingState()
              : _errorMessage != null
              ? _buildErrorState()
              : _parkingLocation == null
              ? const Center(child: Text('위치 정보를 찾을 수 없습니다'))
              : TabBarView(
                controller: _tabController,
                children: [_buildMapView(), _buildStreetView()],
              ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Color(0xFF4285F4)),
          SizedBox(height: 16),
          Text('지도를 불러오는 중...'),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            const SizedBox(height: 16),
            Text('지도 로드 실패', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              _errorMessage ?? '',
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
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4285F4),
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMapView() {
    final location = _parkingLocation;
    if (location == null) {
      return const Center(child: Text('위치 정보를 불러올 수 없습니다'));
    }
    
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: location,
        zoom: 16.0,
      ),
      markers: _markers,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
    );
  }

  Widget _buildStreetView() {
    final location = _parkingLocation;
    if (location == null) {
      return const Center(child: Text('위치 정보를 불러올 수 없습니다'));
    }
    
    return GoogleStreetViewScreen(
      parkingLot: widget.parkingLot,
      latitude: location.latitude,
      longitude: location.longitude,
    );
  }
}
