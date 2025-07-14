import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/router.dart';
import 'app/theme.dart';
import 'core/config/app_config.dart';
import 'core/config/env_config.dart';
import 'features/splash/splash_screen.dart';
import 'web/web_main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 스플래시 화면 유지 (모바일 전용)
  if (!kIsWeb) {
    try {
      // FlutterNativeSplash는 모바일에서만 사용 가능
      // 동적으로 로드하여 웹에서는 사용하지 않음
      // FlutterNativeSplash.preserve(
      //   widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
      // );
    } catch (e) {
      print('네이티브 스플래시 설정 실패: $e');
    }
  }

  // 환경 설정 로그 (디버그 모드에서만)
  if (kDebugMode) {
    EnvConfig.printConfig();
  }

  // 웹에서는 별도의 간단한 앱 실행
  if (kIsWeb) {
    runApp(const ProviderScope(child: WebParkingFinderApp()));
  } else {
    runApp(const ProviderScope(child: ParkingFinderApp()));
  }
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

    // 네이티브 스플래시 화면은 즉시 제거 (모바일 전용)
    if (!kIsWeb) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        try {
          // FlutterNativeSplash.remove();
        } catch (e) {
          print('네이티브 스플래시 제거 실패: $e');
        }
      });
    }
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
