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
        title: const Text('CalciUnit'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              GoRouter.of(context).go(AppRoute.config.path);
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            ...Units.values.map((unit) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, // 角を四角く
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                    ),
                    onPressed: () {
                      context.go('/${unit.index}');
                    },
                    child: Row(
                      children: [
                        Icon(_getIconForUnit(unit), size: 24.w),
                        SizedBox(width: 12.w),
                        Text(
                          unit.name,
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        const Spacer(),
                        Icon(Icons.arrow_forward_ios, size: 16.w),
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
