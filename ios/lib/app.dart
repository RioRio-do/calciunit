// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'router.dart';

class App extends ConsumerWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    return MaterialApp.router(
      theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Murecho',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey)),
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
    );
  }
}
