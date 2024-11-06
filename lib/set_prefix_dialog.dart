import 'package:calciunit/logic/prefix.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SetPrefixDialog extends StatelessWidget {
  const SetPrefixDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: SizedBox(
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('接頭辞変換'),
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(null), // nullを返す
            ),
          ],
        ),
      ),
      content: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(Prefix.values[index].siName,
                style: TextStyle(fontSize: 16.w)),
            trailing: Text(Prefix.values[index].siSymbol,
                style: TextStyle(fontSize: 24.w)),
            onTap: () {
              Navigator.of(context).pop(Prefix.values[index]); // 選択したPrefixを返す
            },
          );
        },
        itemCount: Prefix.values.length,
        shrinkWrap: true,
      ),
      actions: const [],
    );
  }
}
