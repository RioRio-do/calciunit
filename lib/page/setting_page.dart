import 'package:calciunit/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:calciunit/sav/save_configuration.dart';
import 'package:calciunit/sav/model_configuration.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SettingPage extends HookWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final config = useState<ModelConfiguration>(const ModelConfiguration());

    useEffect(() {
      loadConfiguration().then((loadedConfig) {
        config.value = loadedConfig;
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
        leading: IconButton(
            onPressed: () {
              GoRouter.of(context).go(AppRoute.menu.path);
            },
            icon: const Icon(Icons.home)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: '小数点桁数'),
              controller: useTextEditingController(
                  text: config.value.scaleOnInfinitePrecision),
              onChanged: (value) {
                config.value =
                    config.value.copyWith(scaleOnInfinitePrecision: value);
              },
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () async {
                await saveConfiguration(config.value);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('設定は保存されました')),
                  );
                }
              },
              child: const Text('保存'),
            ),
          ],
        ),
      ),
    );
  }
}
