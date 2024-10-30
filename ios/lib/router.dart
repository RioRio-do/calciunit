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
  return List.generate(
    count,
    (index) {
      return GoRoute(
        path: '/$index',
        builder: (context, state) => DynamicPage(pageId: index),
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
          builder: (BuildContext context, GoRouterState state) {
            return const MenuPage();
          },
        ),
        GoRoute(
          path: AppRoute.config.path,
          name: AppRoute.config.name,
          builder: (BuildContext context, GoRouterState state) {
            return const SettingPage();
          },
        ),
        ...generateRoutes(Units.values.length)
      ],
    );
  },
);
