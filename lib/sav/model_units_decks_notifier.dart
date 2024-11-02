import 'dart:convert';
import 'model_units_decks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model_units_decks_notifier.g.dart';

@riverpod
class ModelUnitsDecksNotifier extends _$ModelUnitsDecksNotifier {
  @override
  ModelUnitsDecks build() {
    loadDecks();
    return const ModelUnitsDecks();
  }

  Future<void> loadDecks() async {
    final prefs = await SharedPreferences.getInstance();
    final decksJson = prefs.getString('unitsDecks');
    if (decksJson != null) {
      final Map<String, dynamic> decksMap = json.decode(decksJson);
      final Map<String, ({int unitId, List<int> items})> decks = decksMap.map(
        (key, value) => MapEntry(
          key,
          (
            unitId: value['unitId'] as int,
            items: (value['items'] as List<dynamic>).cast<int>(),
          ),
        ),
      );
      state = ModelUnitsDecks(decks: decks);
    }
  }

  Future<void> saveDecks() async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> serializedDecks = state.decks.map(
      (key, value) => MapEntry(
        key,
        {
          'unitId': value.unitId,
          'items': value.items,
        },
      ),
    );
    await prefs.setString('unitsDecks', json.encode(serializedDecks));
  }

  Future<void> addDeck(String name, int unitId, List<int> items) async {
    state = state.copyWith(
      decks: {
        ...state.decks,
        name: (unitId: unitId, items: items),
      },
    );
    await saveDecks();
  }

  Future<void> removeDeck(String name) async {
    final newDecks =
        Map<String, ({int unitId, List<int> items})>.from(state.decks);
    newDecks.remove(name);
    state = state.copyWith(decks: newDecks);
    await saveDecks();
  }

  Future<void> updateDeck(String name, int unitId, List<int> items) async {
    await addDeck(name, unitId, items);
  }
}
