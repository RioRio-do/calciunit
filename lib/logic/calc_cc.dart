import 'package:decimal/decimal.dart';

/// SI接頭辞の定義
enum SIPrefix {
  Q('1e30'), // クエタ
  R('1e27'), // ロナ
  Y('1e24'), // ヨタ
  Z('1e21'), // ゼタ
  E('1e18'), // エクサ
  P('1e15'), // ペタ
  T('1e12'), // テラ
  G('1e9'), // ギガ
  M('1e6'), // メガ
  k('1e3'), // キロ
  h('1e2'), // ヘクト
  da('1e1'), // デカ
  d('1e-1'), // デシ
  c('1e-2'), // センチ
  m('1e-3'), // ミリ
  u('1e-6'), // マイクロ
  n('1e-9'), // ナノ
  p('1e-12'), // ピコ
  f('1e-15'), // フェムト
  a('1e-18'), // アト
  z('1e-21'), // ゼプト
  y('1e-24'), // ヨクト
  r('1e-27'), // ロント
  q('1e-30'); // クエクト

  final String factor;
  const SIPrefix(this.factor);

  String get value => factor;
}

/// SI単位から変換
String convertFromSI(String number, SIPrefix prefix) {
  return (Decimal.parse(number) * Decimal.parse(prefix.value)).toString();
}

/// SI単位へ変換
String convertToSI(
    String number, SIPrefix prefix, String scaleOnInfinitePrecisionS) {
  return (Decimal.parse(number) / Decimal.parse(prefix.value))
      .toDecimal(
          scaleOnInfinitePrecision: int.tryParse(scaleOnInfinitePrecisionS))
      .toString();
}
