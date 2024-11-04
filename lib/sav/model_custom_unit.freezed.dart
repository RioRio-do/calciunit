// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_custom_unit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomUnit _$CustomUnitFromJson(Map<String, dynamic> json) {
  return _CustomUnit.fromJson(json);
}

/// @nodoc
mixin _$CustomUnit {
  String get id => throw _privateConstructorUsedError;
  String get constant => throw _privateConstructorUsedError;
  String get abbreviation => throw _privateConstructorUsedError;
  String get displayName => throw _privateConstructorUsedError;
  int get unitType => throw _privateConstructorUsedError; // どの単位系(長さ、重さなど)に属するか
  bool get isFavorite => throw _privateConstructorUsedError;

  /// Serializes this CustomUnit to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomUnit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomUnitCopyWith<CustomUnit> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomUnitCopyWith<$Res> {
  factory $CustomUnitCopyWith(
          CustomUnit value, $Res Function(CustomUnit) then) =
      _$CustomUnitCopyWithImpl<$Res, CustomUnit>;
  @useResult
  $Res call(
      {String id,
      String constant,
      String abbreviation,
      String displayName,
      int unitType,
      bool isFavorite});
}

/// @nodoc
class _$CustomUnitCopyWithImpl<$Res, $Val extends CustomUnit>
    implements $CustomUnitCopyWith<$Res> {
  _$CustomUnitCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomUnit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? constant = null,
    Object? abbreviation = null,
    Object? displayName = null,
    Object? unitType = null,
    Object? isFavorite = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      constant: null == constant
          ? _value.constant
          : constant // ignore: cast_nullable_to_non_nullable
              as String,
      abbreviation: null == abbreviation
          ? _value.abbreviation
          : abbreviation // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      unitType: null == unitType
          ? _value.unitType
          : unitType // ignore: cast_nullable_to_non_nullable
              as int,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomUnitImplCopyWith<$Res>
    implements $CustomUnitCopyWith<$Res> {
  factory _$$CustomUnitImplCopyWith(
          _$CustomUnitImpl value, $Res Function(_$CustomUnitImpl) then) =
      __$$CustomUnitImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String constant,
      String abbreviation,
      String displayName,
      int unitType,
      bool isFavorite});
}

/// @nodoc
class __$$CustomUnitImplCopyWithImpl<$Res>
    extends _$CustomUnitCopyWithImpl<$Res, _$CustomUnitImpl>
    implements _$$CustomUnitImplCopyWith<$Res> {
  __$$CustomUnitImplCopyWithImpl(
      _$CustomUnitImpl _value, $Res Function(_$CustomUnitImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUnit
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? constant = null,
    Object? abbreviation = null,
    Object? displayName = null,
    Object? unitType = null,
    Object? isFavorite = null,
  }) {
    return _then(_$CustomUnitImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      constant: null == constant
          ? _value.constant
          : constant // ignore: cast_nullable_to_non_nullable
              as String,
      abbreviation: null == abbreviation
          ? _value.abbreviation
          : abbreviation // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: null == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String,
      unitType: null == unitType
          ? _value.unitType
          : unitType // ignore: cast_nullable_to_non_nullable
              as int,
      isFavorite: null == isFavorite
          ? _value.isFavorite
          : isFavorite // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUnitImpl implements _CustomUnit {
  const _$CustomUnitImpl(
      {required this.id,
      required this.constant,
      required this.abbreviation,
      required this.displayName,
      this.unitType = 0,
      this.isFavorite = false});

  factory _$CustomUnitImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUnitImplFromJson(json);

  @override
  final String id;
  @override
  final String constant;
  @override
  final String abbreviation;
  @override
  final String displayName;
  @override
  @JsonKey()
  final int unitType;
// どの単位系(長さ、重さなど)に属するか
  @override
  @JsonKey()
  final bool isFavorite;

  @override
  String toString() {
    return 'CustomUnit(id: $id, constant: $constant, abbreviation: $abbreviation, displayName: $displayName, unitType: $unitType, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUnitImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.constant, constant) ||
                other.constant == constant) &&
            (identical(other.abbreviation, abbreviation) ||
                other.abbreviation == abbreviation) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.unitType, unitType) ||
                other.unitType == unitType) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, constant, abbreviation,
      displayName, unitType, isFavorite);

  /// Create a copy of CustomUnit
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUnitImplCopyWith<_$CustomUnitImpl> get copyWith =>
      __$$CustomUnitImplCopyWithImpl<_$CustomUnitImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUnitImplToJson(
      this,
    );
  }
}

abstract class _CustomUnit implements CustomUnit {
  const factory _CustomUnit(
      {required final String id,
      required final String constant,
      required final String abbreviation,
      required final String displayName,
      final int unitType,
      final bool isFavorite}) = _$CustomUnitImpl;

  factory _CustomUnit.fromJson(Map<String, dynamic> json) =
      _$CustomUnitImpl.fromJson;

  @override
  String get id;
  @override
  String get constant;
  @override
  String get abbreviation;
  @override
  String get displayName;
  @override
  int get unitType; // どの単位系(長さ、重さなど)に属するか
  @override
  bool get isFavorite;

  /// Create a copy of CustomUnit
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUnitImplCopyWith<_$CustomUnitImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomUnits _$CustomUnitsFromJson(Map<String, dynamic> json) {
  return _CustomUnits.fromJson(json);
}

/// @nodoc
mixin _$CustomUnits {
  List<CustomUnit> get units => throw _privateConstructorUsedError;

  /// Serializes this CustomUnits to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomUnits
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomUnitsCopyWith<CustomUnits> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomUnitsCopyWith<$Res> {
  factory $CustomUnitsCopyWith(
          CustomUnits value, $Res Function(CustomUnits) then) =
      _$CustomUnitsCopyWithImpl<$Res, CustomUnits>;
  @useResult
  $Res call({List<CustomUnit> units});
}

/// @nodoc
class _$CustomUnitsCopyWithImpl<$Res, $Val extends CustomUnits>
    implements $CustomUnitsCopyWith<$Res> {
  _$CustomUnitsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomUnits
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? units = null,
  }) {
    return _then(_value.copyWith(
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as List<CustomUnit>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomUnitsImplCopyWith<$Res>
    implements $CustomUnitsCopyWith<$Res> {
  factory _$$CustomUnitsImplCopyWith(
          _$CustomUnitsImpl value, $Res Function(_$CustomUnitsImpl) then) =
      __$$CustomUnitsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CustomUnit> units});
}

/// @nodoc
class __$$CustomUnitsImplCopyWithImpl<$Res>
    extends _$CustomUnitsCopyWithImpl<$Res, _$CustomUnitsImpl>
    implements _$$CustomUnitsImplCopyWith<$Res> {
  __$$CustomUnitsImplCopyWithImpl(
      _$CustomUnitsImpl _value, $Res Function(_$CustomUnitsImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomUnits
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? units = null,
  }) {
    return _then(_$CustomUnitsImpl(
      units: null == units
          ? _value._units
          : units // ignore: cast_nullable_to_non_nullable
              as List<CustomUnit>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomUnitsImpl implements _CustomUnits {
  const _$CustomUnitsImpl({final List<CustomUnit> units = const []})
      : _units = units;

  factory _$CustomUnitsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomUnitsImplFromJson(json);

  final List<CustomUnit> _units;
  @override
  @JsonKey()
  List<CustomUnit> get units {
    if (_units is EqualUnmodifiableListView) return _units;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_units);
  }

  @override
  String toString() {
    return 'CustomUnits(units: $units)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomUnitsImpl &&
            const DeepCollectionEquality().equals(other._units, _units));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_units));

  /// Create a copy of CustomUnits
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomUnitsImplCopyWith<_$CustomUnitsImpl> get copyWith =>
      __$$CustomUnitsImplCopyWithImpl<_$CustomUnitsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomUnitsImplToJson(
      this,
    );
  }
}

abstract class _CustomUnits implements CustomUnits {
  const factory _CustomUnits({final List<CustomUnit> units}) =
      _$CustomUnitsImpl;

  factory _CustomUnits.fromJson(Map<String, dynamic> json) =
      _$CustomUnitsImpl.fromJson;

  @override
  List<CustomUnit> get units;

  /// Create a copy of CustomUnits
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomUnitsImplCopyWith<_$CustomUnitsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
