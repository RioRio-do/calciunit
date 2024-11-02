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
            // ヘッダーセクション
            Center(
              child: Column(
                children: [
                  Icon(
                    Icons.calculate_outlined,
                    size: 64.w,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Select Unit Type',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '単位の種類を選択してください',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 32.h),
            // 単位一覧グリッド
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.w,
                  childAspectRatio: 1.5,
                ),
                itemCount: Units.values.length,
                itemBuilder: (context, index) {
                  final unit = Units.values[index];
                  return InkWell(
                    onTap: () => GoRouter.of(context).go('/$index'),
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.w),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _getIconForUnit(unit),
                              size: 32.w,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              unit.name,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
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
