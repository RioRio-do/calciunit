// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Project imports:
import 'package:calciunit/sav/model_units_decks.dart';

void main() {
  group('ModelUnitsDecks Tests', () {
    test('デフォルトコンストラクタは空のマップを作成する', () {
      const model = ModelUnitsDecks();
      expect(model.decks, isEmpty);
    });

    test('copyWithは新しいインスタンスを作成する', () {
      const model = ModelUnitsDecks();
      final newModel = model.copyWith(
        decks: {
          'test': (unitId: 1, items: [1, 2, 3])
        },
      );
      expect(model.decks, isEmpty);
      expect(newModel.decks.length, 1);
      expect(newModel.decks['test']?.items, [1, 2, 3]);
    });

    test('異なるデッキ名で複数のデッキを作成できる', () {
      const model = ModelUnitsDecks();
      final newModel = model.copyWith(
        decks: {
          'deck1': (unitId: 1, items: [1, 2, 3]),
          'deck2': (unitId: 2, items: [4, 5, 6]),
        },
      );
      expect(newModel.decks.length, 2);
      expect(newModel.decks['deck1']?.items, [1, 2, 3]);
      expect(newModel.decks['deck2']?.items, [4, 5, 6]);
    });
  });
}
