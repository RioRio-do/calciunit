import 'package:calciunit/logic/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'custom_unit_dialog.dart';

class AddItemsBottomSheet extends HookConsumerWidget {
  final List<int> currentItems;
  final List<List<String>> unitData;
  final Function(List<int>) onAdd;
  final int pageId; // 追加

  const AddItemsBottomSheet({
    super.key,
    required this.currentItems,
    required this.unitData,
    required this.onAdd,
    required this.pageId, // 追加
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedNewItems = useState<Set<int>>({});
    final searchText = useState('');

    // 検索フィルタリングのロジックを関数に分出
    List<int> filterAvailableItems(
        String search, List<int> current, List<List<String>> data) {
      final searchLower = search.toLowerCase();
      return List.generate(data.length, (i) => i)
          .where((i) => !current.contains(i))
          .where((i) {
        final displayName = data[i][UnitsColumn.displayName.v].toLowerCase();
        final abbreviation = data[i][UnitsColumn.abbreviation.v].toLowerCase();

        return displayName.contains(searchLower) ||
            abbreviation.contains(searchLower);
      }).toList();
    }

    // buildメソッド内のavailableItemsを更新
    final availableItems =
        filterAvailableItems(searchText.value, currentItems, unitData);

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
      ),
      child: Column(
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(top: 8.h, bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.h),
            ),
          ),
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
          // カスタム単位作成ボタンを追加
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomUnitDialog(unitType: pageId),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('カスタム単位を作成'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 48.h),
              ),
            ),
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
