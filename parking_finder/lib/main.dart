import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'app/router.dart';
import 'app/theme.dart';
import 'core/config/app_config.dart';
import 'features/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 스플래시 화면 유지
  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  // .env 파일 로드 (에러 처리 추가)
  try {
    await dotenv.load(fileName: '.env');
    print('✅ .env 파일 로드 성공');

    // dotenv 상태 확인
    print('🔍 dotenv.isInitialized: ${dotenv.isInitialized}');
    print('🔍 dotenv.env.length: ${dotenv.env.length}');

    // API 키 확인
    final architectureKey = dotenv.env['ARCHITECTURE_HUB_API_KEY'];
    final apiKey = dotenv.env['API_KEY'];
    final standardKey = dotenv.env['STANDARD_REGION_API_KEY'];
    final naverMapClientId = dotenv.env['NAVER_MAP_CLIENT_ID'];

    print(
      '🔑 ARCHITECTURE_HUB_API_KEY: ${architectureKey != null ? "존재함 (${architectureKey.length}자)" : "없음"}',
    );
    print('🔑 API_KEY: ${apiKey != null ? "존재함 (${apiKey.length}자)" : "없음"}');
    print(
      '🔑 STANDARD_REGION_API_KEY: ${standardKey != null ? "존재함 (${standardKey.length}자)" : "없음"}',
    );
    print(
      '🗺️ NAVER_MAP_CLIENT_ID: ${naverMapClientId != null ? "존재함 (${naverMapClientId.length}자)" : "없음"}',
    );

    // 실제 값도 로그에 출력 (디버깅용)
    if (standardKey != null) {
      print('🔍 STANDARD_REGION_API_KEY 값: $standardKey');
    }
    if (naverMapClientId != null) {
      print('🔍 NAVER_MAP_CLIENT_ID 값: $naverMapClientId');
    }
  } catch (e) {
    print('⚠️ .env 파일 로드 실패: $e');
    print('🔍 dotenv.isInitialized: ${dotenv.isInitialized}');
    // .env 파일이 없어도 앱은 실행되도록 함
  }

  runApp(const ProviderScope(child: ParkingFinderApp()));
}

class ParkingFinderApp extends StatefulWidget {
  const ParkingFinderApp({super.key});

  @override
  State<ParkingFinderApp> createState() => _ParkingFinderAppState();
}

class _ParkingFinderAppState extends State<ParkingFinderApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();

    // 3초 후 스플래시 화면 숨기기
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() {
          _showSplash = false;
        });
      }
    });

    // 네이티브 스플래시 화면은 즉시 제거
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConfig.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: AppConfig.debugMode,
      builder: (context, child) {
        // 스플래시 화면 표시 여부에 따라 분기
        if (_showSplash) {
          return SplashScreen(child: child ?? Container());
        }
        return child ?? Container();
      },
    );
  }
}
