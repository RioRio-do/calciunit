import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:calciunit/logic/data.dart';
import 'package:calciunit/sav/model_units_decks_notifier.dart';

class AddDeckBottomSheet extends HookConsumerWidget {
  final List<List<String>> unitData;
  final int unitId;
  final bool isEdit;
  final String? deckName;
  final List<int>? initialItems;

  const AddDeckBottomSheet({
    super.key,
    required this.unitData,
    required this.unitId,
    this.isEdit = false,
    this.deckName,
    this.initialItems,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedItems = useState<Set<int>>(
      initialItems != null ? Set.from(initialItems!) : {},
    );
    final searchText = useState('');
    final nameController = useTextEditingController(text: deckName);
    final showError = useState(false);

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Text(
            isEdit ? 'デッキを編集' : 'デッキを追加',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.h),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'デッキ名',
              hintText: 'デッキの名前を入力',
              errorText: showError.value ? 'デッキ名を入力してください' : null,
            ),
            onChanged: (_) => showError.value = false,
          ),
          SizedBox(height: 16.h),
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
                onPressed: () async {
                  if (nameController.text.trim().isEmpty) {
                    showError.value = true;
                    return;
                  }
                  if (selectedItems.value.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('アイテムを選択してください')),
                    );
                    return;
                  }

                  final notifier =
                      ref.read(modelUnitsDecksNotifierProvider.notifier);

                  if (isEdit && deckName != null) {
                    // 編集モードの場合は、既存のデッキを削除してから新しいデッキを追加
                    await notifier.removeDeck(deckName!);
                  }

                  await notifier.addDeck(
                    nameController.text,
                    unitId,
                    selectedItems.value.toList(),
                  );

                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: Text(isEdit ? '更新' : '保存'),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: unitData.length,
              itemBuilder: (context, index) {
                final displayName = unitData[index][UnitsColumn.displayName.v];
                final abbreviation =
                    unitData[index][UnitsColumn.abbreviation.v];
                final category = unitData[index][UnitsColumn.category.v];

                if (searchText.value.isNotEmpty) {
                  final searchLower = searchText.value.toLowerCase();
                  if (!displayName.toLowerCase().contains(searchLower) &&
                      !abbreviation.toLowerCase().contains(searchLower) &&
                      !category.toLowerCase().contains(searchLower)) {
                    return const SizedBox.shrink();
                  }
                }

                return CheckboxListTile(
                  title: Text(displayName),
                  subtitle: Text(abbreviation),
                  value: selectedItems.value.contains(index),
                  onChanged: (bool? value) {
                    if (value ?? false) {
                      selectedItems.value = {...selectedItems.value, index};
                    } else {
                      selectedItems.value = {...selectedItems.value}
                        ..remove(index);
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
