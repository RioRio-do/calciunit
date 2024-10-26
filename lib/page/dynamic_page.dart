import 'package:calciunit/logic/data.dart';
import 'package:calciunit/unit_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DynamicPage extends HookConsumerWidget {
  const DynamicPage({super.key, required this.pageId});

  final int pageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = Units.values[pageId];
    final items = useState<List<int>>([0, 1]);
    final scrollController = useScrollController();

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          SliverAppBar(
            title: Text(unit.name),
            floating: true,
            snap: true,
          ),
          SliverReorderableList(
            itemBuilder: (BuildContext context, int index) {
              return ReorderableDelayedDragStartListener(
                key: ValueKey(items.value[index]),
                index: index,
                child: Material(
                  child: UnitCard(
                    title: unit.data[items.value[index]]
                        [UnitsColumn.displayName.v],
                    leadingText: '?',
                    initialCount: unit.data[items.value[index]]
                        [UnitsColumn.constant.v],
                  ),
                ),
              );
            },
            itemCount: items.value.length,
            onReorder: (int oldIndex, int newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final int item = items.value.removeAt(oldIndex);
              items.value.insert(newIndex, item);
            },
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: SizedBox(
                width: 18.w,
                child: ElevatedButton(
                  onPressed: () {
                    items.value = [...items.value, items.value.length];
                  },
                  child: const Text('追加'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
