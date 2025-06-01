import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/parking/presentation/screens/main_screen.dart';

/// 앱의 라우팅을 관리하는 클래스
class AppRouter {
  static final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const MainScreen();
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}
