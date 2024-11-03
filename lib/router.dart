// Flutter imports:
import 'page/setting_page.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'logic/data.dart';
import 'page/menu_page.dart';
import 'page/dynamic_page.dart';
import 'app_route.dart';

List<GoRoute> generateRoutes(int count) {
  const transitionDuration = Duration(milliseconds: 100);

  return List.generate(
    count,
    (index) {
      return GoRoute(
        path: '$index',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: DynamicPage(pageId: index),
            transitionDuration: transitionDuration,
            reverseTransitionDuration: transitionDuration, // 戻る時の時間を追加
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              final tween = Tween(begin: begin, end: end);
              final curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: Curves.easeInOut,
              );
              final offsetAnimation = curvedAnimation.drive(tween);

              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          );
        },
      );
    },
  );
}

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: AppRoute.menu.path, //初めに移動するページ

      routes: [
        GoRoute(
          path: AppRoute.menu.path,
          name: AppRoute.menu.name,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              key: state.pageKey,
              child: const MenuPage(),
              transitionDuration: const Duration(milliseconds: 100),
              reverseTransitionDuration:
                  const Duration(milliseconds: 100), // 戻る時の時間を追加
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(-1.0, 0.0);
                const end = Offset.zero;
                final tween = Tween(begin: begin, end: end);
                final curvedAnimation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeInOut,
                );
                final offsetAnimation = curvedAnimation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: child,
                );
              },
            );
          },
          routes: [
            GoRoute(
              path: AppRoute.config.path,
              name: AppRoute.config.name,
              builder: (BuildContext context, GoRouterState state) {
                return const SettingPage();
              },
            ),
            ...generateRoutes(Units.values.length),
          ],
        ),
      ],
    );
  },
);
