import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../sav/model_custom_unit_notifier.dart';
import 'data.dart';

part 'units_data_provider.g.dart';

@riverpod
class UnitsDataNotifier extends _$UnitsDataNotifier {
  @override
  List<List<String>> build(int unitType) {
    final standardUnits = Units.values[unitType].data;
    final customUnits = ref
        .watch(customUnitNotifierProvider)
        .units
        .where((unit) => unit.unitType == unitType)
        .map((unit) => [
              unit.constant,
              unit.abbreviation,
              unit.displayName,
            ])
        .toList();

    return [...standardUnits, ...customUnits];
  }

  bool isCustomUnit(int index) {
    final standardUnits = Units.values[unitType].data;
    return index >= standardUnits.length;
  }

  String? getCustomUnitId(int index) {
    if (!isCustomUnit(index)) return null;
    final standardUnits = Units.values[unitType].data;
    final customUnits = ref
        .read(customUnitNotifierProvider)
        .units
        .where((unit) => unit.unitType == unitType)
        .toList();
    return customUnits[index - standardUnits.length].id;
  }
}
