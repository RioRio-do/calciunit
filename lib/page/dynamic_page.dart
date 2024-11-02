import 'package:calciunit/logic/data.dart';
import 'package:calciunit/sav/model_configuration_notifier.dart';
import 'package:calciunit/unit_card.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rational/rational.dart';

class DynamicPage extends HookConsumerWidget {
  const DynamicPage({super.key, required this.pageId});

  final int pageId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unit = Units.values[pageId];
    final items = useState<List<int>>([]);
    final isEdit = useState(false);
    final scrollController = useScrollController();
    final config = ref.watch(modelConfigurationNotifierProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isEdit.value = !isEdit.value;
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
                    leadingText: unit.data[items.value[index]]
                        [UnitsColumn.abbreviation.v],
                    constanceValue: _dataFormatting(
                        unit.data[items.value[index]][UnitsColumn.constant.v],
                        config.scaleOnInfinitePrecision),
                    scaleOnInfinitePrecision: config.scaleOnInfinitePrecision,
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
        ],
      ),
    );
  }
}

String _dataFormatting(String data, String scaleOnInfinitePrecision) {
  final output = Rational(BigInt.parse(data.split('/').first),
          BigInt.parse(data.split('/').last))
      .toDecimal(
          scaleOnInfinitePrecision: int.tryParse(scaleOnInfinitePrecision));
  return output.toString();
}
