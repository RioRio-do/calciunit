import 'package:calciunit/edit_unit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UnitCard extends HookWidget {
  final String title;
  final String leadingText;
  final String initialCount;

  const UnitCard({
    super.key,
    required this.title,
    required this.leadingText,
    required this.initialCount,
  });

  @override
  Widget build(BuildContext context) {
    final count = useState(initialCount);

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
          return editUnitDialog(controller, focusNode, context, count);
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
