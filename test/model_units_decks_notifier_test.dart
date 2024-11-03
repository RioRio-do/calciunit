import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:calciunit/sav/model_units_decks_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('ModelUnitsDecksNotifier Tests', () {
    late ProviderContainer container;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('初期状態は空のデッキ', () {
      final notifier = container.read(modelUnitsDecksNotifierProvider);
      expect(notifier.decks, isEmpty);
    });

    test('デッキの追加と削除', () async {
      final notifier = container.read(modelUnitsDecksNotifierProvider.notifier);

      await notifier.addDeck('testDeck', 1, [1, 2, 3]);
      expect(
        container
            .read(modelUnitsDecksNotifierProvider)
            .decks['testDeck']
            ?.items,
        [1, 2, 3],
      );

      await notifier.removeDeck('testDeck');
      expect(
        container.read(modelUnitsDecksNotifierProvider).decks['testDeck'],
        null,
      );
    });

    test('複数のデッキを管理できる', () async {
      final notifier = container.read(modelUnitsDecksNotifierProvider.notifier);

      await notifier.addDeck('deck1', 1, [1, 2, 3]);
      await notifier.addDeck('deck2', 2, [4, 5, 6]);

      final state = container.read(modelUnitsDecksNotifierProvider);
      expect(state.decks.length, 2);
      expect(state.decks['deck1']?.items, [1, 2, 3]);
      expect(state.decks['deck2']?.items, [4, 5, 6]);
    });

    test('同名のデッキは上書きされる', () async {
      final notifier = container.read(modelUnitsDecksNotifierProvider.notifier);

      await notifier.addDeck('testDeck', 1, [1, 2, 3]);
      await notifier.addDeck('testDeck', 1, [4, 5, 6]);

      final state = container.read(modelUnitsDecksNotifierProvider);
      expect(state.decks['testDeck']?.items, [4, 5, 6]);
    });
  });
}
