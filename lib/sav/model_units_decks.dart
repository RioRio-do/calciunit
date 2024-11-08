// Package imports:
import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_units_decks.freezed.dart';

@freezed
class ModelUnitsDecks with _$ModelUnitsDecks {
  const factory ModelUnitsDecks({
    @Default(<String, ({int unitId, List<int> items})>{})
    Map<String, ({int unitId, List<int> items})> decks,
  }) = _ModelUnitsDecks;
}
