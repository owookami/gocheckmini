import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// 웹 전용 간단한 주차장 찾기 앱
class WebParkingFinderApp extends StatelessWidget {
  const WebParkingFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '주차장 찾기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const WebMainScreen(),
    );
  }
}

class WebMainScreen extends StatelessWidget {
  const WebMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('주차장 찾기 (웹버전)'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_parking,
                size: 80,
                color: Colors.blue,
              ),
              SizedBox(height: 24),
              Text(
                '웹버전 주차장 찾기',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                '현재 웹버전에서는 일부 기능에 제한이 있습니다.\n'
                '모든 기능을 사용하시려면 모바일 앱을 다운로드해주세요.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 32),
              _QuickLinkCard(
                title: '서울시 주차정보',
                description: '서울시 공영주차장 정보',
                url: 'https://parking.seoul.go.kr',
                icon: Icons.location_city,
              ),
              SizedBox(height: 16),
              _QuickLinkCard(
                title: '네이버 지도',
                description: '주변 주차장 찾기',
                url: 'https://map.naver.com/v5/search/주차장',
                icon: Icons.map,
              ),
              SizedBox(height: 16),
              _QuickLinkCard(
                title: '카카오맵',
                description: '실시간 주차정보',
                url: 'https://map.kakao.com',
                icon: Icons.navigation,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickLinkCard extends StatelessWidget {
  final String title;
  final String description;
  final String url;
  final IconData icon;

  const _QuickLinkCard({
    required this.title,
    required this.description,
    required this.url,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () async {
          try {
            await launchUrl(
              Uri.parse(url),
              webOnlyWindowName: '_blank',
              mode: LaunchMode.platformDefault,
            );
          } catch (e) {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('링크를 열 수 없습니다: $e')),
              );
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.blue[600]),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.open_in_new, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}