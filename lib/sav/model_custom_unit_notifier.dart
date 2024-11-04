import 'dart:convert';
import 'model_custom_unit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'model_custom_unit_notifier.g.dart';

@riverpod
class CustomUnitNotifier extends _$CustomUnitNotifier {
  final String _storageKey = 'custom_units';
  final _uuid = const Uuid();

  @override
  CustomUnits build() {
    _loadUnits();
    return const CustomUnits();
  }

  Future<void> _loadUnits() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      state = CustomUnits.fromJson(jsonDecode(jsonString));
    }
  }

  Future<void> _saveUnits() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(state.toJson());
    await prefs.setString(_storageKey, jsonString);
  }

  Future<void> addUnit({
    required String constant,
    required String abbreviation,
    required String displayName,
    required int unitType,
  }) async {
    final newUnit = CustomUnit(
      id: _uuid.v4(),
      constant: constant,
      abbreviation: abbreviation,
      displayName: displayName,
      unitType: unitType,
    );

    state = CustomUnits(units: [...state.units, newUnit]);
    await _saveUnits();
  }

  Future<void> updateUnit(CustomUnit unit) async {
    final updatedUnits = state.units.map((u) {
      return u.id == unit.id ? unit : u;
    }).toList();

    state = CustomUnits(units: updatedUnits);
    await _saveUnits();
  }

  Future<void> deleteUnit(String id) async {
    final updatedUnits = state.units.where((u) => u.id != id).toList();
    state = CustomUnits(units: updatedUnits);
    await _saveUnits();
  }

  Future<void> toggleFavorite(String id) async {
    final updatedUnits = state.units.map((u) {
      if (u.id == id) {
        return u.copyWith(isFavorite: !u.isFavorite);
      }
      return u;
    }).toList();

    state = CustomUnits(units: updatedUnits);
    await _saveUnits();
  }

  List<CustomUnit> getUnitsByType(int unitType) {
    return state.units.where((u) => u.unitType == unitType).toList();
  }
}
