// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_configuration.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ModelConfiguration {
  String get scaleOnInfinitePrecision => throw _privateConstructorUsedError;

  /// Create a copy of ModelConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ModelConfigurationCopyWith<ModelConfiguration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ModelConfigurationCopyWith<$Res> {
  factory $ModelConfigurationCopyWith(
          ModelConfiguration value, $Res Function(ModelConfiguration) then) =
      _$ModelConfigurationCopyWithImpl<$Res, ModelConfiguration>;
  @useResult
  $Res call({String scaleOnInfinitePrecision});
}

/// @nodoc
class _$ModelConfigurationCopyWithImpl<$Res, $Val extends ModelConfiguration>
    implements $ModelConfigurationCopyWith<$Res> {
  _$ModelConfigurationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ModelConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scaleOnInfinitePrecision = null,
  }) {
    return _then(_value.copyWith(
      scaleOnInfinitePrecision: null == scaleOnInfinitePrecision
          ? _value.scaleOnInfinitePrecision
          : scaleOnInfinitePrecision // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ModelConfigurationImplCopyWith<$Res>
    implements $ModelConfigurationCopyWith<$Res> {
  factory _$$ModelConfigurationImplCopyWith(_$ModelConfigurationImpl value,
          $Res Function(_$ModelConfigurationImpl) then) =
      __$$ModelConfigurationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String scaleOnInfinitePrecision});
}

/// @nodoc
class __$$ModelConfigurationImplCopyWithImpl<$Res>
    extends _$ModelConfigurationCopyWithImpl<$Res, _$ModelConfigurationImpl>
    implements _$$ModelConfigurationImplCopyWith<$Res> {
  __$$ModelConfigurationImplCopyWithImpl(_$ModelConfigurationImpl _value,
      $Res Function(_$ModelConfigurationImpl) _then)
      : super(_value, _then);

  /// Create a copy of ModelConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scaleOnInfinitePrecision = null,
  }) {
    return _then(_$ModelConfigurationImpl(
      scaleOnInfinitePrecision: null == scaleOnInfinitePrecision
          ? _value.scaleOnInfinitePrecision
          : scaleOnInfinitePrecision // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ModelConfigurationImpl implements _ModelConfiguration {
  const _$ModelConfigurationImpl({this.scaleOnInfinitePrecision = '16'});

  @override
  @JsonKey()
  final String scaleOnInfinitePrecision;

  @override
  String toString() {
    return 'ModelConfiguration(scaleOnInfinitePrecision: $scaleOnInfinitePrecision)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ModelConfigurationImpl &&
            (identical(
                    other.scaleOnInfinitePrecision, scaleOnInfinitePrecision) ||
                other.scaleOnInfinitePrecision == scaleOnInfinitePrecision));
  }

  @override
  int get hashCode => Object.hash(runtimeType, scaleOnInfinitePrecision);

  /// Create a copy of ModelConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ModelConfigurationImplCopyWith<_$ModelConfigurationImpl> get copyWith =>
      __$$ModelConfigurationImplCopyWithImpl<_$ModelConfigurationImpl>(
          this, _$identity);
}

abstract class _ModelConfiguration implements ModelConfiguration {
  const factory _ModelConfiguration({final String scaleOnInfinitePrecision}) =
      _$ModelConfigurationImpl;

  @override
  String get scaleOnInfinitePrecision;

  /// Create a copy of ModelConfiguration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ModelConfigurationImplCopyWith<_$ModelConfigurationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
