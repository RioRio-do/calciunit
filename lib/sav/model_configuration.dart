// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_configuration.freezed.dart';

@freezed
class ModelConfiguration with _$ModelConfiguration {
  const factory ModelConfiguration({
    @Default('16') String scaleOnInfinitePrecision,
  }) = _ModelConfiguration;
}
