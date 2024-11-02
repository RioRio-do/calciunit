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
    final availableItems = List.generate(unitData.length, (i) => i)
        .where((i) => !currentItems.contains(i))
        .where((i) {
      final searchLower = searchText.value.toLowerCase();
      final displayName = unitData[i][UnitsColumn.displayName.v].toLowerCase();
      final abbreviation =
          unitData[i][UnitsColumn.abbreviation.v].toLowerCase();
      final category = unitData[i][UnitsColumn.category.v].toLowerCase();

      return displayName.contains(searchLower) ||
          abbreviation.contains(searchLower) ||
          category.contains(searchLower);
    }).toList();

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
