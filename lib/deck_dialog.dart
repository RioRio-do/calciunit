import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:calciunit/logic/data.dart';
import 'package:calciunit/sav/model_units_decks_notifier.dart';

class DeckDialog extends HookConsumerWidget {
  final Set<int> selectedItems;
  final List<List<String>> unitData;
  final int unitId; // 追加

  const DeckDialog({
    super.key,
    required this.selectedItems,
    required this.unitData,
    required this.unitId, // 追加
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController nameController = TextEditingController();
    final showError = useState(false);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.w),
      ),
      contentPadding: EdgeInsets.all(16.w),
      title: const Text('デッキを保存'),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'デッキ名',
                hintText: 'デッキの名前を入力',
                errorText: showError.value ? 'デッキ名を入力してください' : null,
              ),
              onChanged: (_) => showError.value = false,
            ),
            SizedBox(height: 6.h),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.zero, // 角を四角く
                ),
                child: RawScrollbar(
                  thumbColor: Colors.grey[400],
                  radius: Radius.circular(4.w),
                  thickness: 4.w,
                  child: ListView.separated(
                    padding: EdgeInsets.all(8.w),
                    shrinkWrap: true,
                    itemCount: selectedItems.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final itemId = selectedItems.elementAt(index);
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 4.h,
                        ),
                        title:
                            Text(unitData[itemId][UnitsColumn.displayName.v]),
                        leading: Text(
                          unitData[itemId][UnitsColumn.abbreviation.v],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () async {
            if (nameController.text.trim().isEmpty) {
              showError.value = true;
            } else {
              await ref.read(modelUnitsDecksNotifierProvider.notifier).addDeck(
                    nameController.text,
                    unitId,
                    selectedItems.toList(),
                  );
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
