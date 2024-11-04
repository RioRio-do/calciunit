import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'sav/model_custom_unit.dart';
import 'sav/model_custom_unit_notifier.dart';

class CustomUnitDialog extends HookConsumerWidget {
  final CustomUnit? editUnit;
  final int unitType;

  const CustomUnitDialog({
    super.key,
    this.editUnit,
    required this.unitType,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final constantController =
        useTextEditingController(text: editUnit?.constant);
    final abbreviationController =
        useTextEditingController(text: editUnit?.abbreviation);
    final displayNameController =
        useTextEditingController(text: editUnit?.displayName);

    final formKey = useMemoized(() => GlobalKey<FormState>());

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(editUnit == null ? 'カスタム単位の作成' : 'カスタム単位の編集'),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: constantController,
                decoration: const InputDecoration(
                  labelText: '換算係数',
                  hintText: '例: 1000 または 1/1000',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return '換算係数を入力してください';
                  try {
                    if (value!.contains('/')) {
                      final parts = value.split('/');
                      if (parts.length != 2) throw Exception();
                      int.parse(parts[0]);
                      int.parse(parts[1]);
                    } else {
                      double.parse(value);
                    }
                    return null;
                  } catch (e) {
                    return '有効な数値または分数を入力してください';
                  }
                },
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: abbreviationController,
                decoration: const InputDecoration(
                  labelText: '略称',
                  hintText: '例: km',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return '略称を入力してください';
                  return null;
                },
              ),
              SizedBox(height: 8.h),
              TextFormField(
                controller: displayNameController,
                decoration: const InputDecoration(
                  labelText: '表示名',
                  hintText: '例: キロメートル',
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) return '表示名を入力してください';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        if (editUnit != null) // 編集モードの場合のみ削除ボタンを表示
          TextButton(
            onPressed: () async {
              // 削除確認ダイアログを表示
              final bool? shouldDelete = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('カスタム単位の削除'),
                  content: const Text('このカスタム単位を削除してもよろしいですか？'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('キャンセル'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text(
                        '削除',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );

              if (shouldDelete == true) {
                await ref
                    .read(customUnitNotifierProvider.notifier)
                    .deleteUnit(editUnit!.id);
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
            child: const Text(
              '削除',
              style: TextStyle(color: Colors.red),
            ),
          ),
        TextButton(
          onPressed: () async {
            if (!(formKey.currentState?.validate() ?? false)) return;

            final customUnitNotifier =
                ref.read(customUnitNotifierProvider.notifier);

            if (editUnit == null) {
              await customUnitNotifier.addUnit(
                constant: constantController.text,
                abbreviation: abbreviationController.text,
                displayName: displayNameController.text,
                unitType: unitType,
              );
            } else {
              await customUnitNotifier.updateUnit(
                editUnit!.copyWith(
                  constant: constantController.text,
                  abbreviation: abbreviationController.text,
                  displayName: displayNameController.text,
                ),
              );
            }

            if (context.mounted) Navigator.of(context).pop();
          },
          child: Text(editUnit == null ? '作成' : '更新'),
        ),
      ],
    );
  }
}
