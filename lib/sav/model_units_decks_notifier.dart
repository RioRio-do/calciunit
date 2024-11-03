import 'dart:convert';
import 'model_units_decks.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'model_units_decks_notifier.g.dart';

@riverpod
class ModelUnitsDecksNotifier extends _$ModelUnitsDecksNotifier {
  bool _isInitialized = false;

  @override
  ModelUnitsDecks build() {
    if (!_isInitialized) {
      _isInitialized = true;
      // 非同期で初期データを読み込む
      Future.microtask(() async {
        await loadDecks();
      });
    }
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

  Future<void> addDeck(String name, int unitId, List<int> items) async {
    // 既存のデータを読み込む
    final prefs = await SharedPreferences.getInstance();
    final existingJson = prefs.getString('unitsDecks');
    Map<String, ({int unitId, List<int> items})> mergedDecks = {};

    if (existingJson != null) {
      final Map<String, dynamic> existingMap = json.decode(existingJson);
      mergedDecks = existingMap.map(
        (key, value) => MapEntry(
          key,
          (
            unitId: value['unitId'] as int,
            items: (value['items'] as List<dynamic>).cast<int>(),
          ),
        ),
      );
    }

    // 新しいデッキを追加
    mergedDecks[name] = (unitId: unitId, items: items);

    // stateを更新
    state = ModelUnitsDecks(decks: mergedDecks);

    // マージしたデータを保存
    final Map<String, dynamic> serializedDecks = mergedDecks.map(
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

  Future<void> removeDeck(String name) async {
    // stateを更新
    final newDecks =
        Map<String, ({int unitId, List<int> items})>.from(state.decks);
    newDecks.remove(name);
    state = state.copyWith(decks: newDecks);

    // SharedPreferencesに直接保存
    final prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> serializedDecks = newDecks.map(
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
}
