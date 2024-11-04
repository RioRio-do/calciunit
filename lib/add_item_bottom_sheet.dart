import 'package:calciunit/logic/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddItemsBottomSheet extends HookConsumerWidget {
  final List<int> currentItems;
  final List<List<String>> unitData;
  final Function(List<int>) onAdd;

  const AddItemsBottomSheet({
    super.key,
    required this.currentItems,
    required this.unitData,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNewItems = useState<Set<int>>({});
    final searchText = useState('');

    // 検索フィルタリングのロジックを関数に��出
    List<int> filterAvailableItems(
        String search, List<int> current, List<List<String>> data) {
      final searchLower = search.toLowerCase();
      return List.generate(data.length, (i) => i)
          .where((i) => !current.contains(i))
          .where((i) {
        final displayName = data[i][UnitsColumn.displayName.v].toLowerCase();
        final abbreviation = data[i][UnitsColumn.abbreviation.v].toLowerCase();
        final category = data[i][UnitsColumn.category.v].toLowerCase();

        return displayName.contains(searchLower) ||
            abbreviation.contains(searchLower) ||
            category.contains(searchLower);
      }).toList();
    }

    // buildメソッド内のavailableItemsを更新
    final availableItems =
        filterAvailableItems(searchText.value, currentItems, unitData);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'アイテムを検索',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.w),
                    ),
                  ),
                  onChanged: (value) => searchText.value = value,
                ),
              ),
              SizedBox(width: 8.w),
              TextButton(
                onPressed: () {
                  if (selectedNewItems.value.isNotEmpty) {
                    onAdd(selectedNewItems.value.toList());
                  }
                  Navigator.pop(context);
                },
                child: const Text('追加'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: availableItems.length,
              itemBuilder: (context, index) {
                final itemIndex = availableItems[index];
                return CheckboxListTile(
                  title: Text(unitData[itemIndex][UnitsColumn.displayName.v]),
                  value: selectedNewItems.value.contains(itemIndex),
                  onChanged: (bool? value) {
                    if (value ?? false) {
                      selectedNewItems.value = {
                        ...selectedNewItems.value,
                        itemIndex,
                      };
                    } else {
                      selectedNewItems.value = {...selectedNewItems.value}
                        ..remove(itemIndex);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
