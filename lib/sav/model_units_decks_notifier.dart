// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Project imports:
import 'model_units_decks.dart';

part 'model_units_decks_notifier.g.dart';

@riverpod
class ModelUnitsDecksNotifier extends _$ModelUnitsDecksNotifier {
  bool _isInitialized = false;

  @override
  ModelUnitsDecks build() {
    if (!_isInitialized) {
      _isInitialized = true;
      Future.microtask(() async {
        await loadDecks();
      });
    }
    return const ModelUnitsDecks();
  }

  Map<String, dynamic> _serializeDecks(
      Map<String, ({int unitId, List<int> items})> decks) {
    return decks.map(
      (key, value) => MapEntry(
        key,
        {
          'unitId': value.unitId,
          'items': value.items,
        },
      ),
    );
  }

  Map<String, ({int unitId, List<int> items})> _deserializeDecks(
      String decksJson) {
    final Map<String, dynamic> decksMap = json.decode(decksJson);
    return decksMap.map(
      (key, value) => MapEntry(
        key,
        (
          unitId: value['unitId'] as int,
          items: (value['items'] as List<dynamic>).cast<int>(),
        ),
      ),
    );
  }

  Future<void> loadDecks() async {
    final prefs = await SharedPreferences.getInstance();
    final decksJson = prefs.getString('unitsDecks');
    if (decksJson != null) {
      final decks = _deserializeDecks(decksJson);
      state = ModelUnitsDecks(decks: decks);
    }
  }

  Future<void> addDeck(String name, int unitId, List<int> items) async {
    final prefs = await SharedPreferences.getInstance();
    final existingJson = prefs.getString('unitsDecks');
    Map<String, ({int unitId, List<int> items})> mergedDecks =
        existingJson != null ? _deserializeDecks(existingJson) : {};

    mergedDecks[name] = (unitId: unitId, items: items);
    state = ModelUnitsDecks(decks: mergedDecks);
    await prefs.setString(
        'unitsDecks', json.encode(_serializeDecks(mergedDecks)));
  }

  Future<void> removeDeck(String name) async {
    final newDecks =
        Map<String, ({int unitId, List<int> items})>.from(state.decks);
    newDecks.remove(name);
    state = state.copyWith(decks: newDecks);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('unitsDecks', json.encode(_serializeDecks(newDecks)));
  }
}
