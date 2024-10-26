enum AppRoute {
  menu,
}

extension AppRouteX on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.menu:
        return '/';
    }
  }

  String get name {
    switch (this) {
      case AppRoute.menu:
        return 'menu';
    }
  }
}
