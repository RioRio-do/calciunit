import 'package:calciunit/add_item_bottom_sheet.dart';
import 'package:calciunit/app_route.dart';
import 'package:calciunit/logic/data.dart';
import 'package:calciunit/logic/units_data_provider.dart';
import 'package:calciunit/sav/model_configuration_notifier.dart';
import 'package:calciunit/sav/model_custom_unit_notifier.dart';
import 'package:calciunit/unit_card.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rational/rational.dart';
import 'package:calciunit/deck_list_dialog.dart';

class AppPage extends HookConsumerWidget {
  const AppPage({super.key});

  static const double _iconSize = 28.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 初期設定
    final unit = Units.values[0];
    final items = useState<List<int>>([0]);
    final isEdit = useState(false);
    final selectedItems = useState<Set<int>>({});
    final scrollController = useScrollController();
    final config = ref.watch(modelConfigurationNotifierProvider);
    final unitData = ref.watch(unitsDataNotifierProvider(0));

    // デッキアイテムを追加する関数
    void addDeckItems(List<int> deckItems) {
      final currentItems = items.value.toList();

      currentItems.removeWhere((item) => deckItems.contains(item));

      int insertPosition = currentItems.length;
      for (final item in deckItems.reversed) {
        final index = currentItems.indexOf(item);
        if (index != -1) {
          insertPosition = index;
          break;
        }
      }
      currentItems.insertAll(insertPosition, deckItems);
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
          // アプリバーを構築
          _buildAppBar(
              unit, isEdit, items, selectedItems, context, addDeckItems),
          // 並べ替え可能なリストを構築
          _buildReorderableList(
              unitData, items, isEdit, selectedItems, config, ref),
          // アイテム追加ボタンを構築
          _buildAddItemButton(context, isEdit, unitData, items),
        ],
      ),
    );
  }

  // アプリバーを構築する関数
  SliverAppBar _buildAppBar(
    Units unit,
    ValueNotifier<bool> isEdit,
    ValueNotifier<List<int>> items,
    ValueNotifier<Set<int>> selectedItems,
    BuildContext context,
    Function(List<int>) addDeckItems,
  ) {
    return SliverAppBar(
      title: const Text('Calciunit'),
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
                unitId: 0,
                onDeckSelect: addDeckItems,
              ),
            );
          },
        ),
        _buildSettingsButton(context)
      ],
    );
  }

  // 設定ボタンを構築する関数
  Widget _buildSettingsButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: IconButton(
        icon: Icon(Icons.settings, size: _iconSize.w),
        style: IconButton.styleFrom(minimumSize: Size(48.w, 48.h)),
        onPressed: () {
          HapticFeedback.lightImpact();
          GoRouter.of(context).go(AppRoute.config.path);
        },
      ),
    );
  }

  // 並べ替え可能なリストを構築する関数
  SliverReorderableList _buildReorderableList(
    List<List<String>> unitData,
    ValueNotifier<List<int>> items,
    ValueNotifier<bool> isEdit,
    ValueNotifier<Set<int>> selectedItems,
    dynamic config,
    WidgetRef ref,
  ) {
    final unitsDataNotifier = ref.read(unitsDataNotifierProvider(0).notifier);

    return SliverReorderableList(
      itemBuilder: (BuildContext context, int index) {
        if (index >= items.value.length) {
          return Center(child: Text('無効なインデックス: $index'));
        }
        final itemIndex = items.value[index];
        final isCustom = unitsDataNotifier.isCustomUnit(itemIndex);
        final customUnitId = unitsDataNotifier.getCustomUnitId(itemIndex);

        return ReorderableDelayedDragStartListener(
          key: ValueKey(items.value[index]),
          index: index,
          child: Material(
            child: UnitCard(
              title: unitData[itemIndex][UnitsColumn.displayName.v],
              leadingText: unitData[itemIndex][UnitsColumn.abbreviation.v],
              constanceValue: dataFormatting(
                unitData[itemIndex][UnitsColumn.constant.v],
                config.scaleOnInfinitePrecision,
              ),
              scaleOnInfinitePrecision: config.scaleOnInfinitePrecision,
              isEdit: isEdit.value,
              isSelected: selectedItems.value.contains(itemIndex),
              onSelect: (selected) {
                if (selected ?? false) {
                  selectedItems.value = {...selectedItems.value, itemIndex};
                } else {
                  selectedItems.value = {...selectedItems.value}
                    ..remove(itemIndex);
                }
              },
              selectedItems: selectedItems.value,
              onDelete: (selectedIndices) {
                if (isCustom && customUnitId != null) {
                  ref
                      .read(customUnitNotifierProvider.notifier)
                      .deleteUnit(customUnitId);
                }
                items.value = items.value
                    .where((item) => !selectedIndices.contains(item))
                    .toList();
                selectedItems.value = {};
                isEdit.value = false;
              },
              isCustomUnit: isCustom,
              customUnitId: customUnitId,
              unitData: unitData,
              unitId: 0,
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

  // アイテム追加ボタンを構築する関数
  SliverToBoxAdapter _buildAddItemButton(
    BuildContext context,
    ValueNotifier<bool> isEdit,
    List<List<String>> unitData,
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
                        unitData: unitData,
                        onAdd: (newItems) {
                          items.value = [...items.value, ...newItems];
                        },
                        pageId: 0,
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

// データをフォーマットする関数
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
