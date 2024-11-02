import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../sav/model_configuration_notifier.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(modelConfigurationNotifierProvider);
    final configNotifier =
        ref.read(modelConfigurationNotifierProvider.notifier);
    final textController =
        useTextEditingController(text: config.scaleOnInfinitePrecision);

    useEffect(() {
      textController.text = config.scaleOnInfinitePrecision;
      return null;
    }, [config.scaleOnInfinitePrecision]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('設定'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: '精度'),
              controller: textController,
              onChanged: (value) {
                configNotifier.updateScaleOnInfinitePrecision(value);
              },
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              onPressed: () async {
                await configNotifier.saveConfiguration(config);
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
