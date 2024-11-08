// Flutter imports:
import 'package:calciunit/page/app_page.dart';

import 'page/setting_page.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'app_route.dart';

// 共通のトランジションビルダー関数を追加
Widget _buildTransition(BuildContext context, Animation<double> animation,
    Animation<double> secondaryAnimation, Widget child, Offset beginOffset) {
  final tween = Tween(begin: beginOffset, end: Offset.zero);
  final curvedAnimation = CurvedAnimation(
    parent: animation,
    curve: Curves.easeInOut,
  );
  final offsetAnimation = curvedAnimation.drive(tween);

  return SlideTransition(
    position: offsetAnimation,
    child: child,
  );
}

// カスタムトランジションページ作成関数を追加
CustomTransitionPage _createTransitionPage(Widget child, Offset beginOffset) {
  const transitionDuration = Duration(milliseconds: 100);
  return CustomTransitionPage(
    key: null, // 必要に応じてキーを設定
    child: child,
    transitionDuration: transitionDuration,
    reverseTransitionDuration: transitionDuration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return _buildTransition(
          context, animation, secondaryAnimation, child, beginOffset);
    },
  );
}

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: AppRoute.menu.path,
      routes: [
        GoRoute(
          path: AppRoute.menu.path,
          name: AppRoute.menu.name,
          pageBuilder: (context, state) {
            return _createTransitionPage(
                const AppPage(), const Offset(-1.0, 0.0));
          },
          routes: [
            GoRoute(
              path: AppRoute.config.path,
              name: AppRoute.config.name,
              builder: (BuildContext context, GoRouterState state) {
                return const SettingPage();
              },
            ),
          ],
        ),
      ],
    );
  },
);
