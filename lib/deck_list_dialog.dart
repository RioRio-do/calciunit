import 'package:calciunit/add_deck_bottom_sheet.dart';
import 'package:calciunit/deck.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:calciunit/sav/model_units_decks_notifier.dart';
import 'package:calciunit/logic/data.dart';

class DeckListDialog extends ConsumerWidget {
  final int unitId;
  final Function(List<int>) onDeckSelect;

  const DeckListDialog({
    super.key,
    required this.unitId,
    required this.onDeckSelect,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final decks = ref.watch(modelUnitsDecksNotifierProvider).decks;
    // MapEntryのリストに変換する際にDeckオブジェクトを作成
    final filteredDecks = decks.entries
        .map((entry) => MapEntry(
              entry.key,
              Deck(
                unitId: entry.value.unitId,
                items: entry.value.items,
              ),
            ))
        .where((entry) => entry.value.unitId == unitId)
        .toList();

    return AlertDialog(
      title: _buildTitle(),
      content: _buildContent(context, filteredDecks, ref),
      actions: _buildActions(context),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        const Icon(Icons.library_books),
        SizedBox(width: 8.w),
        const Text('デッキ一覧'),
      ],
    );
  }

  Widget _buildContent(
    BuildContext context,
    List<MapEntry<String, Deck>> filteredDecks,
    WidgetRef ref,
  ) {
    return SizedBox(
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        children: [
          _buildUnitName(),
          Divider(height: 24.h),
          _buildDeckList(context, filteredDecks, ref),
        ],
      ),
    );
  }

  Widget _buildUnitName() {
    return Text(
      Units.values[unitId].name,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Colors.grey[700],
      ),
    );
  }

  Widget _buildDeckList(
    BuildContext context,
    List<MapEntry<String, Deck>> filteredDecks,
    WidgetRef ref,
  ) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.w),
        ),
        child: filteredDecks.isEmpty
            ? _buildEmptyState()
            : _buildDeckListView(context, filteredDecks, ref),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
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
    );
  }

  Widget _buildDeckListView(
    BuildContext context,
    List<MapEntry<String, Deck>> filteredDecks,
    WidgetRef ref,
  ) {
    return RawScrollbar(
      thumbColor: Colors.grey[400],
      radius: Radius.circular(4.w),
      thickness: 4.w,
      child: ListView.separated(
        padding: EdgeInsets.all(8.w),
        itemCount: filteredDecks.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) =>
            _buildDeckItem(context, filteredDecks[index], ref),
      ),
    );
  }

  Widget _buildDeckItem(
    BuildContext context,
    MapEntry<String, Deck> entry,
    WidgetRef ref,
  ) {
    return Material(
      color: Colors.transparent,
      child: _buildDeckItemGestureDetector(context, entry, ref),
    );
  }

  Widget _buildDeckItemGestureDetector(
    BuildContext context,
    MapEntry<String, Deck> entry,
    WidgetRef ref,
  ) {
    return GestureDetector(
      onLongPressStart: (details) =>
          _showDeckContextMenu(context, entry, ref, details),
      child: _buildDeckItemInkWell(context, entry),
    );
  }

  Widget _buildDeckItemInkWell(
      BuildContext context, MapEntry<String, Deck> entry) {
    return InkWell(
      onTap: () => _handleDeckTap(context, entry),
      child: _buildDeckItemTile(entry),
    );
  }

  Widget _buildDeckItemTile(MapEntry<String, Deck> entry) {
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
    );
  }

  void _handleDeckTap(BuildContext context, MapEntry<String, Deck> entry) {
    HapticFeedback.lightImpact();
    onDeckSelect(entry.value.items);
    Navigator.of(context).pop();
  }

  void _showDeckContextMenu(
    BuildContext context,
    MapEntry<String, Deck> entry,
    WidgetRef ref,
    LongPressStartDetails details,
  ) {
    HapticFeedback.mediumImpact();
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        details.globalPosition.dx,
        details.globalPosition.dy,
        details.globalPosition.dx,
        details.globalPosition.dy,
      ),
      items: _buildContextMenuItems(context, entry, ref),
    );
  }

  List<PopupMenuItem> _buildContextMenuItems(
    BuildContext context,
    MapEntry<String, Deck> entry,
    WidgetRef ref,
  ) {
    return [
      _buildEditMenuItem(context, entry),
      _buildDeleteMenuItem(context, entry, ref),
    ];
  }

  PopupMenuItem _buildEditMenuItem(
    BuildContext context,
    MapEntry<String, Deck> entry,
  ) {
    return PopupMenuItem(
      onTap: () => _handleEditDeck(context, entry),
      child: _buildMenuItemContent(Icons.edit, '編集'),
    );
  }

  PopupMenuItem _buildDeleteMenuItem(
    BuildContext context,
    MapEntry<String, Deck> entry,
    WidgetRef ref,
  ) {
    return PopupMenuItem(
      onTap: () => _handleDeleteDeck(context, entry, ref),
      child: _buildMenuItemContent(Icons.delete, '削除', color: Colors.red),
    );
  }

  Widget _buildMenuItemContent(IconData icon, String text, {Color? color}) {
    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 8.w),
        Text(text),
      ],
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      TextButton(
        onPressed: () => _showAddDeckBottomSheet(context),
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
    ];
  }

  void _showAddDeckBottomSheet(BuildContext context) {
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
  }

  Future<void> _handleEditDeck(
    BuildContext context,
    MapEntry<String, Deck> entry,
  ) async {
    Future.delayed(Duration.zero, () {
      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          builder: (context) => AddDeckBottomSheet(
            unitData: Units.values[unitId].data,
            unitId: unitId,
            isEdit: true,
            deckName: entry.key,
            initialItems: entry.value.items,
          ),
        );
      }
    });
  }

  Future<void> _handleDeleteDeck(
    BuildContext context,
    MapEntry<String, Deck> entry,
    WidgetRef ref,
  ) async {
    Future.delayed(Duration.zero, () {
      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('確認'),
            content: Text('デッキ「${entry.key}」を削除しますか？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('キャンセル'),
              ),
              TextButton(
                onPressed: () {
                  ref
                      .read(modelUnitsDecksNotifierProvider.notifier)
                      .removeDeck(entry.key);
                  Navigator.of(context).pop();
                },
                child: const Text('削除', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
      }
    });
  }
}
