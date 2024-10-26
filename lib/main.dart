import 'package:calciunit/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
