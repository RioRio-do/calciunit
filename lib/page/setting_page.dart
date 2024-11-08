// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Project imports:
import 'package:calciunit/sav/model_configuration.dart';
import '../sav/model_configuration_notifier.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({super.key});

  // 定数
  static const double _padding = 16.0;
  static const double _spacing = 20.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 設定の状態管理
    final config = ref.watch(modelConfigurationNotifierProvider);
    final configNotifier =
        ref.read(modelConfigurationNotifierProvider.notifier);

    // テキストコントローラーの初期化
    final textController =
        useTextEditingController(text: config.scaleOnInfinitePrecision);

    // 設定値が変更された時の同期処理
    useEffect(() {
      textController.text = config.scaleOnInfinitePrecision;
      return null;
    }, [config.scaleOnInfinitePrecision]);

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: Padding(
        padding: EdgeInsets.all(_padding.w),
        child: Column(
          children: [
            _buildPrecisionTextField(textController, configNotifier),
            SizedBox(height: _spacing.h),
            _buildSaveButton(context, config, configNotifier),
          ],
        ),
      ),
    );
  }

  // 精度入力フィールド
  Widget _buildPrecisionTextField(
    TextEditingController controller,
    ModelConfigurationNotifier notifier,
  ) {
    return TextField(
      decoration: const InputDecoration(labelText: '精度'),
      controller: controller,
      onChanged: notifier.updateScaleOnInfinitePrecision,
      keyboardType: TextInputType.number,
    );
  }

  // 保存ボタン
  Widget _buildSaveButton(
    BuildContext context,
    ModelConfiguration config,
    ModelConfigurationNotifier notifier,
  ) {
    return ElevatedButton(
      onPressed: () async {
        await notifier.saveConfiguration(config);
        if (context.mounted) {
          _showSaveCompleteSnackBar(context);
        }
      },
      child: const Text('保存'),
    );
  }

  // 保存完了通知
  void _showSaveCompleteSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('設定は保存されました')),
    );
  }
}
