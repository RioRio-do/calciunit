import 'package:calciunit/add_deck_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                            return Material(
                              // InkWellを使うためにMaterialが必要
                              color: Colors.transparent,
                              child: GestureDetector(
                                onLongPressStart:
                                    (LongPressStartDetails details) {
                                  // 触覚フィードバック
                                  HapticFeedback.mediumImpact();
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
                                          // 編集
                                          Future.delayed(Duration.zero,
                                              () async {
                                            if (context.mounted) {
                                              showModalBottomSheet(
                                                context: context,
                                                isScrollControlled: true,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.zero,
                                                ),
                                                builder: (context) =>
                                                    AddDeckBottomSheet(
                                                  unitData:
                                                      Units.values[unitId].data,
                                                  unitId: unitId,
                                                  isEdit: true,
                                                  deckName: entry.key,
                                                  initialItems:
                                                      entry.value.items,
                                                ),
                                              );
                                            }
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(Icons.edit),
                                            SizedBox(width: 8.w),
                                            const Text('編集'),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem(
                                        onTap: () {
                                          // 削除
                                          Future.delayed(Duration.zero,
                                              () async {
                                            if (context.mounted) {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  title: const Text('確認'),
                                                  content: Text(
                                                      'デッキ「${entry.key}」を削除しますか？'),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child:
                                                          const Text('キャンセル'),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        ref
                                                            .read(
                                                                modelUnitsDecksNotifierProvider
                                                                    .notifier)
                                                            .removeDeck(
                                                                entry.key);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('削除',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.red)),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(Icons.delete,
                                                color: Colors.red),
                                            SizedBox(width: 8.w),
                                            const Text('削除'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                child: InkWell(
                                  // タップエフェクト用のInkWell
                                  onTap: () {
                                    // 触覚フィードバック
                                    HapticFeedback.lightImpact();
                                    onDeckSelect(entry.value.items);
                                    Navigator.of(context).pop();
                                  },
                                  child: ListTile(
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
                                  ),
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
          onPressed: () {
            // デッキ追加ボトムシートを表示
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              builder: (context) => AddDeckBottomSheet(
                unitData: Units.values[unitId].data,
                unitId: unitId,
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.add),
              SizedBox(width: 8.w),
              const Text('デッキを追加'),
            ],
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}
