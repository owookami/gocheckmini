import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:logger/logger.dart';
import '../../data/models/parking_lot_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

/// 구글 스트리트 뷰 화면
class GoogleStreetViewScreen extends StatefulWidget {
  final ParkingLotModel parkingLot;
  final double? latitude;
  final double? longitude;

  const GoogleStreetViewScreen({
    Key? key,
    required this.parkingLot,
    this.latitude,
    this.longitude,
  }) : super(key: key);

  @override
  State<GoogleStreetViewScreen> createState() => _GoogleStreetViewScreenState();
}

class _GoogleStreetViewScreenState extends State<GoogleStreetViewScreen> {
  final Logger _logger = Logger();
  WebViewController? _controller;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // 웹 환경에서는 바로 외부 브라우저로 리다이렉트
    if (kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _openInExternalBrowser();
        Navigator.of(context).pop();
      });
    } else {
      _initializeWebView();
    }
  }

  void _initializeWebView() async {
    final lat = widget.latitude;
    final lng = widget.longitude;
    final name = widget.parkingLot.name ?? '주차장';

    // 좌표 유효성 체크
    if (lat == null || lng == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = '유효하지 않은 좌표입니다';
      });
      return;
    }

    try {
      _logger.d('🔍 스트리트 뷰 초기화 시작: lat=$lat, lng=$lng');
      
      // WebViewController 생성
      final controller = WebViewController();
      
      // JavaScript 모드 설정
      await controller.setJavaScriptMode(JavaScriptMode.unrestricted);
      
      // NavigationDelegate 설정
      await controller.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            _logger.d('WebView loading progress: $progress%');
          },
          onPageStarted: (String url) {
            _logger.d('Page started loading: $url');
            if (mounted) {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });
            }
          },
          onPageFinished: (String url) {
            _logger.d('Page finished loading: $url');
            if (mounted) {
              setState(() {
                _isLoading = false;
              });
            }
          },
          onHttpError: (HttpResponseError error) {
            _logger.e('HTTP error: ${error.response?.statusCode}');
            if (mounted) {
              setState(() {
                _isLoading = false;
                _errorMessage = 'HTTP 오류: ${error.response?.statusCode}';
              });
            }
          },
          onWebResourceError: (WebResourceError error) {
            _logger.e('Web resource error: ${error.description}');
            if (mounted) {
              setState(() {
                _isLoading = false;
                _errorMessage = '로딩 오류: ${error.description}';
              });
            }
          },
        ),
      );
      
      // Google Street View embed URL 사용
      final streetViewUrl = 'https://www.google.com/maps/embed/v1/streetview'
          '?key=AIzaSyAk5S38hNXK1IGs7wMxGl4vP5genqwCIvY'
          '&location=$lat,$lng'
          '&heading=210'
          '&pitch=10'
          '&fov=90';
      
      _logger.d('🌐 Street View URL: $streetViewUrl');
      
      // URL 로드
      await controller.loadRequest(Uri.parse(streetViewUrl));

      // setState를 호출하여 UI 업데이트
      if (mounted) {
        setState(() {
          _controller = controller;
        });
      }

      _logger.i('✅ 스트리트 뷰 초기화 완료: $lat, $lng');
    } catch (e) {
      _logger.e('❌ WebView 초기화 실패: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = '스트리트 뷰를 불러올 수 없습니다.\n브라우저에서 열기를 시도해보세요.';
        });
      }
    }
  }

  /// 구글 스트리트 뷰 iframe을 포함한 HTML 생성
  String _generateStreetViewHtml(double lat, double lng, String name) {
    return '''
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$name - 스트리트 뷰</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #f5f5f5;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }
        .container {
            width: 100%;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }
        .header {
            background-color: #4285F4;
            color: white;
            padding: 12px 16px;
            font-size: 16px;
            font-weight: 500;
            text-align: center;
        }
        .streetview-container {
            flex: 1;
            position: relative;
            background-color: #e9ecef;
        }
        iframe {
            width: 100%;
            height: 100%;
            border: none;
            display: block;
        }
        .loading {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            color: #666;
        }
        .error {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            color: #dc3545;
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            $name - 구글 스트리트 뷰
        </div>
        <div class="streetview-container">
            <div class="loading" id="loading">
                <div>스트리트 뷰 로딩 중...</div>
            </div>
            <iframe 
                src="https://www.google.com/maps/embed/v1/streetview?key=AIzaSyAk5S38hNXK1IGs7wMxGl4vP5genqwCIvY&location=$lat,$lng&heading=210&pitch=10&fov=90"
                allowfullscreen=""
                loading="lazy"
                referrerpolicy="no-referrer-when-downgrade"
                onload="document.getElementById('loading').style.display='none';"
                onerror="document.getElementById('loading').innerHTML='<div class=&quot;error&quot;>스트리트 뷰를 불러올 수 없습니다.<br>이 위치에는 스트리트 뷰가 제공되지 않을 수 있습니다.</div>';">
            </iframe>
        </div>
    </div>

    <script>
        // iframe 로드 실패 시 에러 메시지 표시
        setTimeout(function() {
            const loading = document.getElementById('loading');
            if (loading && loading.style.display !== 'none') {
                loading.innerHTML = '<div class="error">스트리트 뷰를 불러오는 중입니다...<br>잠시만 기다려 주세요.</div>';
            }
        }, 10000);
    </script>
</body>
</html>
''';
  }

  @override
  Widget build(BuildContext context) {
    // 웹 환경에서는 로딩 화면만 표시
    if (kIsWeb) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text('스트리트 뷰를 여는 중...'),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('돌아가기'),
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.parkingLot.name ?? '주차장'} - 스트리트 뷰',
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
          IconButton(
            icon: const Icon(Icons.open_in_browser),
            onPressed: _openInExternalBrowser,
            tooltip: '브라우저에서 열기',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Stack(
      children: [
        // WebView
        if (_controller != null)
          WebViewWidget(controller: _controller!)
        else if (_errorMessage == null)
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: Color(0xFF4285F4)),
                SizedBox(height: 16),
                Text('WebView 초기화 중...'),
              ],
            ),
          )

        // 로딩 인디케이터
        if (_isLoading)
          Container(
            color: Colors.white.withOpacity(0.8),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Color(0xFF4285F4)),
                  SizedBox(height: 16),
                  Text(
                    '스트리트 뷰 로딩 중...',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ),

        // 에러 메시지
        if (_errorMessage != null && !_isLoading)
          Container(
            color: Colors.white,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
                    const SizedBox(height: 16),
                    Text(
                      '스트리트 뷰 로드 실패',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _errorMessage ?? '',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              _errorMessage = null;
                            });
                            _initializeWebView();
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('다시 시도'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4285F4),
                            foregroundColor: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton.icon(
                          onPressed: _openInExternalBrowser,
                          icon: const Icon(Icons.open_in_browser),
                          label: const Text('브라우저에서 열기'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[600],
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }

  /// 외부 브라우저에서 스트리트 뷰 열기
  Future<void> _openInExternalBrowser() async {
    final lat = widget.latitude;
    final lng = widget.longitude;

    if (lat == null || lng == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('좌표 정보가 없어 외부 브라우저를 열 수 없습니다')),
        );
      }
      return;
    }

    // 구글 지도 스트리트 뷰 URL
    final streetViewUrl =
        'https://www.google.com/maps/@$lat,$lng,3a,75y,90t/data=!3m4!1e1!3m2!1s$lat,$lng!2e0';

    try {
      final uri = Uri.parse(streetViewUrl);
      
      // 웹에서는 새 탭에서 열기
      if (kIsWeb) {
        await launchUrl(
          uri, 
          webOnlyWindowName: '_blank',
          mode: LaunchMode.platformDefault,
        );
      } else {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      
      _logger.d('외부 브라우저에서 스트리트 뷰 열기 성공: $streetViewUrl');
    } catch (e) {
      _logger.e('외부 브라우저에서 스트리트 뷰 열기 실패: $e');
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('외부 브라우저 열기 실패: $e')));
      }
    }
  }
}
