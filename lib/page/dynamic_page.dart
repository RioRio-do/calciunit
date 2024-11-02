import 'package:calciunit/add_item_bottom_sheet.dart';
import 'package:calciunit/logic/data.dart';
import 'package:calciunit/sav/model_configuration_notifier.dart';
import 'package:calciunit/unit_card.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rational/rational.dart';
import 'package:calciunit/deck_list_dialog.dart';

class DynamicPage extends HookConsumerWidget {
  const DynamicPage({super.key, required this.pageId});

  final int pageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = Units.values[pageId];
    final items = useState<List<int>>([0]);
    final isEdit = useState(false);
    final selectedItems = useState<Set<int>>({});
    final scrollController = useScrollController();
    final config = ref.watch(modelConfigurationNotifierProvider);

    // 新しいメソッドを追加
    void addDeckItems(List<int> deckItems) {
      final Set<int> uniqueItems = {...items.value};
      final List<int> newItems = items.value.toList();

      // 既存のアイテムで、デッキのアイテムと重複するものを削除
      for (final item in deckItems) {
        if (uniqueItems.contains(item)) {
          newItems.removeWhere((existing) => existing == item);
        }
      }

      // デッキのアイテムを追加する位置を決定
      // （最後に見つかった重複アイテムの位置、または末尾）
      int insertPosition = 0;
      for (final item in deckItems) {
        final existingIndex = newItems.indexOf(item);
        if (existingIndex != -1) {
          insertPosition = existingIndex;
        }
      }

      // デッキのアイテムを挿入
      newItems.insertAll(insertPosition, deckItems);

      // 重複を除去
      items.value = newItems.toSet().toList();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isEdit.value = !isEdit.value;
          selectedItems.value = {};
        },
        child: Icon(isEdit.value ? Icons.done : Icons.edit),
      ),
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            title: Text(unit.name),
            floating: true,
            snap: true,
            actions: [
              IconButton(
                icon: const Icon(Icons.library_books),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => DeckListDialog(
                      unitId: pageId,
                      onDeckSelect: addDeckItems, // コールバックを追加
                    ),
                  );
                },
              ),
            ],
          ),
          SliverReorderableList(
            itemBuilder: (BuildContext context, int index) {
              if (index >= items.value.length) {
                return Center(child: Text('Invalid index: $index'));
              }
              return ReorderableDelayedDragStartListener(
                key: ValueKey(items.value[index]),
                index: index,
                child: Material(
                  child: UnitCard(
                    title: unit.data[items.value[index]]
                        [UnitsColumn.displayName.v],
                    leadingText: unit.data[items.value[index]]
                        [UnitsColumn.abbreviation.v],
                    constanceValue: dataFormatting(
                      unit.data[items.value[index]][UnitsColumn.constant.v],
                      config.scaleOnInfinitePrecision,
                    ),
                    scaleOnInfinitePrecision: config.scaleOnInfinitePrecision,
                    isEdit: isEdit.value,
                    isSelected:
                        selectedItems.value.contains(items.value[index]),
                    onSelect: (selected) {
                      if (selected ?? false) {
                        selectedItems.value = {
                          ...selectedItems.value,
                          items.value[index]
                        };
                      } else {
                        selectedItems.value = {...selectedItems.value}
                          ..remove(items.value[index]);
                      }
                    },
                    selectedItems: selectedItems.value,
                    onDelete: (selectedIndices) {
                      items.value = items.value
                          .where((item) => !selectedIndices.contains(item))
                          .toList();
                      selectedItems.value = {};
                      isEdit.value = false;
                    },
                    unitData: unit.data,
                    unitId: pageId, // この行を追加
                  ),
                ),
              );
            },
            itemCount: items.value.length,
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final item = items.value.removeAt(oldIndex);
              items.value.insert(newIndex, item);
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(16.w)),
                    ),
                    builder: (BuildContext context) {
                      return AddItemsBottomSheet(
                        currentItems: items.value,
                        unitData: unit.data,
                        onAdd: (newItems) {
                          items.value = [...items.value, ...newItems];
                        },
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.add),
                    SizedBox(width: 8.w),
                    const Text('アイテムを追加'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String dataFormatting(String data, String scaleOnInfinitePrecision) {
  if (data.contains('/')) {
    final output = Rational(BigInt.parse(data.split('/').first),
            BigInt.parse(data.split('/').last))
        .toDecimal(
            scaleOnInfinitePrecision: int.tryParse(scaleOnInfinitePrecision));
    return output.toString();
  }
  return data;
}
