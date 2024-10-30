import 'package:calciunit/edit_unit_dialog.dart';
import 'package:calciunit/input_value_state.dart';
import 'package:calciunit/logic/units_cov.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UnitCard extends HookConsumerWidget {
  final String title;
  final String leadingText;
  final String constanceValue;
  final String scaleOnInfinitePrecision;

  const UnitCard({
    super.key,
    required this.title,
    required this.leadingText,
    required this.constanceValue,
    required this.scaleOnInfinitePrecision,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final input = ref.watch(inputValueProvider);
    final count = useState(unitCov(
        fromS: '1',
        toS: constanceValue,
        valueS: input,
        scaleOnInfinitePrecisionS: scaleOnInfinitePrecision));

    Future<void> showEditDialog(BuildContext context) async {
      final TextEditingController controller = TextEditingController(
        text: count.value.toString(),
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
                        Navigator.of(context).pop();
                      },
                      child: const Text('保存'),
                    ),
                    TextButton(
                      onPressed: () {
                        Clipboard.setData(
                            ClipboardData(text: count.value.toString()));
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
          return editUnitDialog(controller, focusNode, context, count, ref);
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
        child: InkWell(
          borderRadius: BorderRadius.circular(12.w),
          onTap: () {
            showEditDialog(context);
          },
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
            leading: Container(
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
              count.value,
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
    );
  }
}
