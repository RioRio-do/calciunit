import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:calciunit/logic/data.dart';
import 'package:calciunit/sav/model_units_decks_notifier.dart';

class DeckDialog extends HookConsumerWidget {
  final Set<int> selectedItems;
  final List<List<String>> unitData;
  final int unitId;

  const DeckDialog({
    super.key,
    required this.selectedItems,
    required this.unitData,
    required this.unitId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final showError = useState(false);

    return AlertDialog(
      shape: _dialogShape(),
      contentPadding: EdgeInsets.all(16.w),
      title: const Text('デッキを保存'),
      content: _buildContent(nameController, showError),
      actions: _buildActions(context, ref, nameController, showError),
    );
  }

  RoundedRectangleBorder _dialogShape() {
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.w),
    );
  }

  Widget _buildContent(
    TextEditingController nameController,
    ValueNotifier<bool> showError,
  ) {
    return SizedBox(
      width: double.maxFinite,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDeckNameField(nameController, showError),
          SizedBox(height: 6.h),
          _buildSelectedItemsList(),
        ],
      ),
    );
  }

  Widget _buildDeckNameField(
    TextEditingController nameController,
    ValueNotifier<bool> showError,
  ) {
    return TextField(
      controller: nameController,
      decoration: InputDecoration(
        labelText: 'デッキ名',
        hintText: 'デッキの名前を入力',
        errorText: showError.value ? 'デッキ名を入力してください' : null,
      ),
      onChanged: (_) => showError.value = false,
    );
  }

  Widget _buildSelectedItemsList() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.zero,
        ),
        child: _buildScrollableList(),
      ),
    );
  }

  Widget _buildScrollableList() {
    return RawScrollbar(
      thumbColor: Colors.grey[400],
      radius: Radius.circular(4.w),
      thickness: 4.w,
      child: ListView.separated(
        padding: EdgeInsets.all(8.w),
        shrinkWrap: true,
        itemCount: selectedItems.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: _buildListItem,
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    final itemId = selectedItems.elementAt(index);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 12.w,
        vertical: 4.h,
      ),
      title: Text(unitData[itemId][UnitsColumn.displayName.v]),
      leading: _buildLeadingText(itemId),
    );
  }

  Widget _buildLeadingText(int itemId) {
    return Text(
      unitData[itemId][UnitsColumn.abbreviation.v],
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 14.sp,
      ),
    );
  }

  List<Widget> _buildActions(
    BuildContext context,
    WidgetRef ref,
    TextEditingController nameController,
    ValueNotifier<bool> showError,
  ) {
    return [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text('キャンセル'),
      ),
      TextButton(
        onPressed: () => _handleSave(context, ref, nameController, showError),
        child: const Text('保存'),
      ),
    ];
  }

  Future<void> _handleSave(
    BuildContext context,
    WidgetRef ref,
    TextEditingController nameController,
    ValueNotifier<bool> showError,
  ) async {
    final name = nameController.text.trim();
    if (name.isEmpty) {
      showError.value = true;
      return;
    }

    try {
      await _saveDeck(ref, name);
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (context.mounted) {
        _showErrorDialog(context, e.toString());
      }
    }
  }

  Future<void> _saveDeck(WidgetRef ref, String name) async {
    await ref.read(modelUnitsDecksNotifierProvider.notifier).addDeck(
          name,
          unitId,
          selectedItems.toList(),
        );
  }

  Future<void> _showErrorDialog(BuildContext context, String message) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('エラー'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
