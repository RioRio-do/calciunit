// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_custom_unit.freezed.dart';
part 'model_custom_unit.g.dart';

@freezed
class CustomUnit with _$CustomUnit {
  const factory CustomUnit({
    required String id,
    required String constant,
    required String abbreviation,
    required String displayName,
    @Default(0) int unitType, // どの単位系(長さ、重さなど)に属するか
  }) = _CustomUnit;

  factory CustomUnit.fromJson(Map<String, dynamic> json) =>
      _$CustomUnitFromJson(json);
}

@freezed
class CustomUnits with _$CustomUnits {
  const factory CustomUnits({
    @Default([]) List<CustomUnit> units,
  }) = _CustomUnits;

  factory CustomUnits.fromJson(Map<String, dynamic> json) =>
      _$CustomUnitsFromJson(json);
}
