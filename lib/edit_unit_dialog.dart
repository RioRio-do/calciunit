import 'package:calciunit/input_value_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

AlertDialog editUnitDialog(
    TextEditingController controller,
    FocusNode focusNode,
    BuildContext context,
    ValueNotifier<String> count,
    WidgetRef ref) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0),
    ),
    title: const Text('数値を編集'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(hintText: '新しい数値を入力'),
          focusNode: focusNode,
          autofocus: true,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                String? newValue = controller.text;
                count.value = newValue;
                ref.read(inputValueProvider.notifier).set(newValue);
                Navigator.of(context).pop();
              },
              child: const Text('保存'),
            ),
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: count.value.toString()));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('クリップボードにコピーされました')),
                );
              },
              child: const Text('コピー'),
            )
          ],
        )
      ],
    ),
  );
}
