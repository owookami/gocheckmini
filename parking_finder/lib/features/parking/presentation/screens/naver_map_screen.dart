import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import '../../data/models/parking_lot_model.dart';
import 'package:url_launcher/url_launcher.dart';

/// 지도 화면 (웹/모바일 호환)
class NaverMapScreen extends StatefulWidget {
  final ParkingLotModel parkingLot;

  const NaverMapScreen({Key? key, required this.parkingLot}) : super(key: key);

  @override
  State<NaverMapScreen> createState() => _NaverMapScreenState();
}

class _NaverMapScreenState extends State<NaverMapScreen> {
  final Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    // 웹에서는 대체 화면 표시
    if (kIsWeb) {
      return _buildWebAlternativeScreen();
    }
    
    // 모바일에서는 "지도 기능 준비 중" 메시지 표시
    return _buildMobilePreparingScreen();
  }

  /// 웹용 대체 화면
  Widget _buildWebAlternativeScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parkingLot.name ?? '주차장'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.map_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              '지도 기능은 모바일 앱에서\n이용 가능합니다',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            if (widget.parkingLot.address != null)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '주소',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.parkingLot.address ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _openInWebMap(),
              icon: const Icon(Icons.open_in_new),
              label: const Text('웹 지도에서 보기'),
            ),
          ],
        ),
      ),
    );
  }

  /// 모바일용 준비 중 화면
  Widget _buildMobilePreparingScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.parkingLot.name ?? '주차장'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 24),
            Text(
              '지도 기능 준비 중입니다',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            if (widget.parkingLot.address != null)
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(horizontal: 32),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '주소',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.parkingLot.address ?? '',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 웹 지도에서 열기
  Future<void> _openInWebMap() async {
    if (widget.parkingLot.address == null) return;

    try {
      final address = Uri.encodeComponent(widget.parkingLot.address ?? '');
      final googleMapsUrl = 'https://maps.google.com/?q=$address';
      
      final uri = Uri.parse(googleMapsUrl);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
      _logger.d('구글 맵 웹 열기 성공: $googleMapsUrl');
    } catch (e) {
      _logger.e('웹 지도 열기 실패: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('지도 열기 실패: $e')),
        );
      }
    }
  }
}
