import 'package:flutter/services.dart';

import '../app_route.dart';
import '../logic/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  // UIサイズの定数
  static const double _iconSize = 28.0;
  static const double _buttonIconSize = 32.0;
  static const double _arrowIconSize = 20.0;
  static const double _buttonHeight = 72.0;
  static const double _buttonSpacing = 16.0;
  static const double _contentPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calciunit'),
        centerTitle: true,
        actions: [_buildSettingsButton(context)],
      ),
      body: Padding(
        padding: EdgeInsets.all(_contentPadding.w),
        child: Column(
          children: [
            SizedBox(height: _buttonSpacing.h),
            _buildUnitButtons(),
          ],
        ),
      ),
    );
  }

  // 設定ボタン
  Widget _buildSettingsButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: IconButton(
        icon: Icon(Icons.settings, size: _iconSize.w),
        style: IconButton.styleFrom(minimumSize: Size(48.w, 48.h)),
        onPressed: () {
          HapticFeedback.lightImpact();
          GoRouter.of(context).go(AppRoute.config.path);
        },
      ),
    );
  }

  // 単位ボタンのリスト
  Widget _buildUnitButtons() {
    return Column(
      children: Units.values.map((unit) => _buildUnitButton(unit)).toList(),
    );
  }

  // 個別の単位ボタン
  Widget _buildUnitButton(Units unit) {
    return Padding(
      padding: EdgeInsets.only(bottom: _buttonSpacing.h),
      child: Builder(
        builder: (context) => ElevatedButton(
          style: _unitButtonStyle,
          onPressed: () => context.go('/${unit.index}'),
          child: _buildUnitButtonContent(unit),
        ),
      ),
    );
  }

  // ボタンのスタイル
  ButtonStyle get _unitButtonStyle => ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        minimumSize: Size.fromHeight(_buttonHeight.h),
      );

  // ボタンの中身
  Widget _buildUnitButtonContent(Units unit) {
    return Row(
      children: [
        Icon(_getIconForUnit(unit), size: _buttonIconSize.w),
        SizedBox(width: 20.w),
        Text(
          unit.name,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        Icon(Icons.arrow_forward_ios, size: _arrowIconSize.w),
      ],
    );
  }

  // 単位に応じたアイコンの取得
  IconData _getIconForUnit(Units unit) {
    if (unit == Units.length) return Icons.straighten;
    return Icons.calculate;
  }
}
