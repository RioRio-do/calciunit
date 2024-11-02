// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_units_decks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ModelUnitsDecks {
  Map<String, ({List<int> items, int unitId})> get decks =>
      throw _privateConstructorUsedError;

  /// Create a copy of ModelUnitsDecks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModelUnitsDecksCopyWith<ModelUnitsDecks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelUnitsDecksCopyWith<$Res> {
  factory $ModelUnitsDecksCopyWith(
          ModelUnitsDecks value, $Res Function(ModelUnitsDecks) then) =
      _$ModelUnitsDecksCopyWithImpl<$Res, ModelUnitsDecks>;
  @useResult
  $Res call({Map<String, ({List<int> items, int unitId})> decks});
}

/// @nodoc
class _$ModelUnitsDecksCopyWithImpl<$Res, $Val extends ModelUnitsDecks>
    implements $ModelUnitsDecksCopyWith<$Res> {
  _$ModelUnitsDecksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModelUnitsDecks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decks = null,
  }) {
    return _then(_value.copyWith(
      decks: null == decks
          ? _value.decks
          : decks // ignore: cast_nullable_to_non_nullable
              as Map<String, ({List<int> items, int unitId})>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModelUnitsDecksImplCopyWith<$Res>
    implements $ModelUnitsDecksCopyWith<$Res> {
  factory _$$ModelUnitsDecksImplCopyWith(_$ModelUnitsDecksImpl value,
          $Res Function(_$ModelUnitsDecksImpl) then) =
      __$$ModelUnitsDecksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, ({List<int> items, int unitId})> decks});
}

/// @nodoc
class __$$ModelUnitsDecksImplCopyWithImpl<$Res>
    extends _$ModelUnitsDecksCopyWithImpl<$Res, _$ModelUnitsDecksImpl>
    implements _$$ModelUnitsDecksImplCopyWith<$Res> {
  __$$ModelUnitsDecksImplCopyWithImpl(
      _$ModelUnitsDecksImpl _value, $Res Function(_$ModelUnitsDecksImpl) _then)
      : super(_value, _then);

  /// Create a copy of ModelUnitsDecks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decks = null,
  }) {
    return _then(_$ModelUnitsDecksImpl(
      decks: null == decks
          ? _value._decks
          : decks // ignore: cast_nullable_to_non_nullable
              as Map<String, ({List<int> items, int unitId})>,
    ));
  }
}

/// @nodoc

class _$ModelUnitsDecksImpl implements _ModelUnitsDecks {
  const _$ModelUnitsDecksImpl(
      {final Map<String, ({List<int> items, int unitId})> decks =
          const <String, ({int unitId, List<int> items})>{}})
      : _decks = decks;

  final Map<String, ({List<int> items, int unitId})> _decks;
  @override
  @JsonKey()
  Map<String, ({List<int> items, int unitId})> get decks {
    if (_decks is EqualUnmodifiableMapView) return _decks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_decks);
  }

  @override
  String toString() {
    return 'ModelUnitsDecks(decks: $decks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelUnitsDecksImpl &&
            const DeepCollectionEquality().equals(other._decks, _decks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_decks));

  /// Create a copy of ModelUnitsDecks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelUnitsDecksImplCopyWith<_$ModelUnitsDecksImpl> get copyWith =>
      __$$ModelUnitsDecksImplCopyWithImpl<_$ModelUnitsDecksImpl>(
          this, _$identity);
}

abstract class _ModelUnitsDecks implements ModelUnitsDecks {
  const factory _ModelUnitsDecks(
          {final Map<String, ({List<int> items, int unitId})> decks}) =
      _$ModelUnitsDecksImpl;

  @override
  Map<String, ({List<int> items, int unitId})> get decks;

  /// Create a copy of ModelUnitsDecks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModelUnitsDecksImplCopyWith<_$ModelUnitsDecksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
