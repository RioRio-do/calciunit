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

    // デッキアイテムを追加するメソッドの最適化
    void addDeckItems(List<int> deckItems) {
      final currentItems = items.value.toList();

      // 重複するアイテムを削除
      currentItems.removeWhere((item) => deckItems.contains(item));

      // 挿入位置を決定
      int insertPosition = currentItems.length;
      for (final item in deckItems.reversed) {
        final index = currentItems.indexOf(item);
        if (index != -1) {
          insertPosition = index;
          break;
        }
      }

      // アイテムを挿入
      currentItems.insertAll(insertPosition, deckItems);

      // 重複を除去して状態を更新
      items.value = currentItems.toSet().toList();
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
          _buildAppBar(
              unit, isEdit, items, selectedItems, context, addDeckItems),
          _buildReorderableList(unit, items, isEdit, selectedItems, config),
          _buildAddItemButton(context, isEdit, unit, items),
        ],
      ),
    );
  }

  // アプリバーを構築するヘルパーメソッド
  SliverAppBar _buildAppBar(
    Units unit,
    ValueNotifier<bool> isEdit,
    ValueNotifier<List<int>> items,
    ValueNotifier<Set<int>> selectedItems,
    BuildContext context,
    Function(List<int>) addDeckItems,
  ) {
    return SliverAppBar(
      title: Text(unit.name),
      floating: true,
      snap: true,
      actions: [
        if (isEdit.value)
          IconButton(
            icon: const Icon(Icons.select_all),
            onPressed: () {
              bool allSelected = items.value
                  .every((item) => selectedItems.value.contains(item));
              selectedItems.value = allSelected ? {} : Set.from(items.value);
            },
          ),
        IconButton(
          icon: const Icon(Icons.library_books),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => DeckListDialog(
                unitId: pageId,
                onDeckSelect: addDeckItems,
              ),
            );
          },
        ),
      ],
    );
  }

  // リオーダブルリストを構築するヘルパーメソッド
  SliverReorderableList _buildReorderableList(
    Units unit,
    ValueNotifier<List<int>> items,
    ValueNotifier<bool> isEdit,
    ValueNotifier<Set<int>> selectedItems,
    dynamic config,
  ) {
    return SliverReorderableList(
      itemBuilder: (BuildContext context, int index) {
        if (index >= items.value.length) {
          return Center(child: Text('無効なインデックス: $index'));
        }
        return ReorderableDelayedDragStartListener(
          key: ValueKey(items.value[index]),
          index: index,
          child: Material(
            child: UnitCard(
              title: unit.data[items.value[index]][UnitsColumn.displayName.v],
              leadingText: unit.data[items.value[index]]
                  [UnitsColumn.abbreviation.v],
              constanceValue: dataFormatting(
                unit.data[items.value[index]][UnitsColumn.constant.v],
                config.scaleOnInfinitePrecision,
              ),
              scaleOnInfinitePrecision: config.scaleOnInfinitePrecision,
              isEdit: isEdit.value,
              isSelected: selectedItems.value.contains(items.value[index]),
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
              unitId: pageId,
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
    );
  }

  // アイテム追加ボタンを構築するヘルパーメソッド
  SliverToBoxAdapter _buildAddItemButton(
    BuildContext context,
    ValueNotifier<bool> isEdit,
    Units unit,
    ValueNotifier<List<int>> items,
  ) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: ElevatedButton(
          onPressed: isEdit.value
              ? null
              : () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
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
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            disabledBackgroundColor: Colors.grey[300],
            disabledForegroundColor: Colors.grey[500],
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
    );
  }
}

// データフォーマット用ユーティリティ関数
String dataFormatting(String data, String scaleOnInfinitePrecision) {
  if (data.contains('/')) {
    final parts = data.split('/');
    final rational = Rational(
      BigInt.parse(parts.first),
      BigInt.parse(parts.last),
    );
    return rational
        .toDecimal(
          scaleOnInfinitePrecision: int.tryParse(scaleOnInfinitePrecision),
        )
        .toString();
  }
  return data;
}
