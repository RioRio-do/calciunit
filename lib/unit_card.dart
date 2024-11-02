import 'input_value_state.dart';
import 'logic/units_cov.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'deck_dialog.dart';

class UnitCard extends ConsumerWidget {
  final String title;
  final String leadingText;
  final String constanceValue;
  final String scaleOnInfinitePrecision;
  final bool isEdit;
  final bool? isSelected;
  final Set<int> selectedItems;
  final Function(bool?)? onSelect;
  final Function(Set<int>)? onDelete;
  final List<List<String>> unitData;
  final int unitId; // 追加

  const UnitCard({
    super.key,
    required this.title,
    required this.leadingText,
    required this.constanceValue,
    required this.scaleOnInfinitePrecision,
    this.isEdit = false,
    this.isSelected,
    required this.selectedItems,
    this.onSelect,
    this.onDelete,
    required this.unitData,
    required this.unitId, // 追加
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final input = ref.watch(inputValueProvider);

    Future<void> editDialog(BuildContext context) async {
      final TextEditingController controller = TextEditingController(
        text: unitCov(
            fromS: '1',
            toS: constanceValue,
            valueS: input,
            scaleOnInfinitePrecisionS: scaleOnInfinitePrecision),
      );
      FocusNode focusNode = FocusNode();
      controller.selection = TextSelection(
        baseOffset: 0,
        extentOffset: controller.text.length,
      );

      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            title: const Text('数値を編集'),
            content: SingleChildScrollView(
              child: Column(
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
                          Clipboard.setData(ClipboardData(
                              text: unitCov(
                                  fromS: '1',
                                  toS: constanceValue,
                                  valueS: input,
                                  scaleOnInfinitePrecisionS:
                                      scaleOnInfinitePrecision)));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('クリップボードにコピーされました')),
                          );
                        },
                        child: const Text('コピー'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('キャンセル'),
                      ),
                      TextButton(
                        onPressed: () {
                          String? newValue = unitCov(
                              fromS: constanceValue,
                              toS: '1',
                              valueS: controller.text,
                              scaleOnInfinitePrecisionS:
                                  scaleOnInfinitePrecision);
                          ref.read(inputValueProvider.notifier).set(newValue);
                          Navigator.of(context).pop();
                        },
                        child: const Text('保存'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ).then((_) {
        focusNode.dispose();
      });
    }

    return Padding(
      padding: EdgeInsets.all(8.w),
      child: Material(
        elevation: 1.w,
        borderRadius: BorderRadius.circular(12.w),
        color: Colors.white,
        child: GestureDetector(
          onLongPressStart: (isEdit && (isSelected ?? false))
              ? (LongPressStartDetails details) {
                  showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(
                      details.globalPosition.dx,
                      details.globalPosition.dy,
                      details.globalPosition.dx,
                      details.globalPosition.dy,
                    ),
                    items: [
                      PopupMenuItem(
                        onTap: () {
                          if (onDelete != null) {
                            onDelete!(selectedItems);
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8.w),
                            const Text('削除'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          Future.delayed(
                            const Duration(seconds: 0),
                            () => showDialog(
                              context: context,
                              builder: (context) => DeckDialog(
                                selectedItems: selectedItems,
                                unitData: unitData,
                                unitId: unitId, // unitIdを追加
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.library_books),
                            SizedBox(width: 8.w),
                            const Text('デッキ'),
                          ],
                        ),
                      ),
                    ],
                  );
                }
              : null,
          child: InkWell(
            borderRadius: BorderRadius.circular(12.w),
            onTap: isEdit
                ? () {
                    if (onSelect != null) {
                      onSelect!(!isSelected!);
                    }
                  }
                : () {
                    editDialog(context);
                  },
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              leading: isEdit
                  ? Checkbox(
                      value: isSelected,
                      onChanged: onSelect,
                    )
                  : Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        leadingText,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
              title: Text(
                unitCov(
                    fromS: '1',
                    toS: constanceValue,
                    valueS: input,
                    scaleOnInfinitePrecisionS: scaleOnInfinitePrecision),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              subtitle: Text(
                title,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
