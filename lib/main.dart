// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'app.dart';

void main() {
  runApp(
    const ScreenUtilInit(
      designSize: Size(360, 760),
      child: ProviderScope(
        child: App(),
      ),
    ),
  );
}
