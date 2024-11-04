class Deck {
  final int unitId;
  final List<int> items;

  const Deck({
    required this.unitId,
    required this.items,
  });

  // MapからDeckを作成するファクトリコンストラクタを追加
  factory Deck.fromMap(Map<String, dynamic> map) {
    return Deck(
      unitId: map['unitId'] as int,
      items: (map['items'] as List).cast<int>(),
    );
  }

  // DeckをMapに変換するメソッドを追加
  Map<String, dynamic> toMap() {
    return {
      'unitId': unitId,
      'items': items,
    };
  }
}
