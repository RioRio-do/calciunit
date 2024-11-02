import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:calciunit/sav/model_units_decks_notifier.dart';
import 'package:calciunit/logic/data.dart';

class DeckListDialog extends ConsumerWidget {
  final int unitId;
  final Function(List<int>) onDeckSelect; // 追加

  const DeckListDialog({
    super.key,
    required this.unitId,
    required this.onDeckSelect, // 追加
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decks = ref.watch(modelUnitsDecksNotifierProvider).decks;
    final filteredDecks =
        decks.entries.where((entry) => entry.value.unitId == unitId).toList();

    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.library_books),
          SizedBox(width: 8.w),
          const Text('デッキ一覧'),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.6,
        child: Column(
          children: [
            Text(
              Units.values[unitId].name,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            Divider(height: 24.h),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8.w),
                ),
                child: filteredDecks.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.library_books_outlined,
                              size: 48.w,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16.h),
                            const Text(
                              'デッキがありません',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      )
                    : RawScrollbar(
                        thumbColor: Colors.grey[400],
                        radius: Radius.circular(4.w),
                        thickness: 4.w,
                        child: ListView.separated(
                          padding: EdgeInsets.all(8.w),
                          itemCount: filteredDecks.length,
                          separatorBuilder: (context, index) =>
                              const Divider(height: 1),
                          itemBuilder: (context, index) {
                            final entry = filteredDecks[index];
                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 4.h,
                              ),
                              title: Text(
                                entry.key,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.sp,
                                ),
                              ),
                              subtitle: Text(
                                '${entry.value.items.length}個のアイテム',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('確認'),
                                      content:
                                          Text('デッキ「${entry.key}」を削除しますか？'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('キャンセル'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            ref
                                                .read(
                                                    modelUnitsDecksNotifierProvider
                                                        .notifier)
                                                .removeDeck(entry.key);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            '削除',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              onTap: () {
                                // 追加
                                onDeckSelect(entry.value.items); // 追加
                                Navigator.of(context).pop(); // 追加
                              },
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
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}
