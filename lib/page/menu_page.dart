import 'package:flutter/services.dart';

import '../app_route.dart';
import '../logic/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calciunit'),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: IconButton(
              icon: Icon(
                Icons.settings,
                size: 28.w, // アイコンサイズを大きく
              ),
              style: IconButton.styleFrom(
                minimumSize: Size(48.w, 48.h), // タップ領域を広げる
              ),
              onPressed: () {
                HapticFeedback.lightImpact(); // 触覚フィードバックを追加
                GoRouter.of(context).go(AppRoute.config.path);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            ...Units.values.map((unit) => Padding(
                  padding: EdgeInsets.only(bottom: 16.h), // 間隔を広げる
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w, // 左右のパディングを増やす
                        vertical: 20.h, // 上下のパディングを増やす
                      ),
                      minimumSize: Size.fromHeight(72.h), // 最小の高さを設定
                    ),
                    onPressed: () {
                      context.go('/${unit.index}');
                    },
                    child: Row(
                      children: [
                        Icon(
                          _getIconForUnit(unit),
                          size: 32.w, // アイコンを大きく
                        ),
                        SizedBox(width: 20.w), // アイコンとテキストの間隔を広げる
                        Text(
                          unit.name,
                          style: TextStyle(
                            fontSize: 18.sp, // フォントサイズを大きく
                            fontWeight: FontWeight.w500, // やや���く
                          ),
                        ),
                        const Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20.w, // 矢印も少し大きく
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  IconData _getIconForUnit(Units unit) {
    switch (unit) {
      case Units.length:
        return Icons.straighten;
      // case Units.area:
      //   return Icons.square_foot;
      // case Units.volume:
      //   return Icons.view_in_ar;
      // case Units.mass:
      //   return Icons.monitor_weight;
      // case Units.speed:
      //   return Icons.speed;
      // case Units.time:
      //   return Icons.timer;
      // case Units.temperature:
      //   return Icons.thermostat;
      // case Units.pressure:
      //   return Icons.compress;
      // case Units.energy:
      //   return Icons.bolt;
      // case Units.power:
      //   return Icons.power;
      // case Units.angle:
      //   return Icons.architecture;
      default:
        return Icons.calculate;
    }
  }
}
