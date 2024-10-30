enum AppRoute {
  menu,
  config,
}

extension AppRouteX on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.menu:
        return '/';
      case AppRoute.config:
        return '/config';
    }
  }

  String get name {
    switch (this) {
      case AppRoute.menu:
        return 'menu';
      case AppRoute.config:
        return 'config';
    }
  }
}
