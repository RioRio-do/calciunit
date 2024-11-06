// ignore_for_file: constant_identifier_names

import 'package:decimal/decimal.dart';

enum Prefix {
  Q('1e30', 'クエタ', 'Q'),
  R('1e27', 'ロナ', 'R'),
  Y('1e24', 'ヨタ', 'Y'),
  Z('1e21', 'ゼタ', 'Z'),
  E('1e18', 'エクサ', 'E'),
  P('1e15', 'ペタ', 'P'),
  T('1e12', 'テラ', 'T'),
  G('1e9', 'ギガ', 'G'),
  M('1e6', 'メガ', 'M'),
  k('1e3', 'キロ', 'k'),
  h('1e2', 'ヘクト', 'h'),
  da('1e1', 'デカ', 'da'),
  none('1', 'なし', '-'),
  d('1e-1', 'デシ', 'd'),
  c('1e-2', 'センチ', 'c'),
  m('1e-3', 'ミリ', 'm'),
  u('1e-6', 'マイクロ', 'μ'),
  n('1e-9', 'ナノ', 'n'),
  p('1e-12', 'ピコ', 'p'),
  f('1e-15', 'フェムト', 'f'),
  a('1e-18', 'アト', 'a'),
  z('1e-21', 'ゼプト', 'z'),
  y('1e-24', 'ヨクト', 'y'),
  r('1e-27', 'ロント', 'r'),
  q('1e-30', 'クエント', 'q'),

  Ki('1024', 'キビ', 'ki'),
  Mi('1048576', 'メビ', 'Mi'),
  Gi('1073741824', 'ギビ', 'Gi'),
  Ti('1099511627776', 'テビ', 'Ti'),
  Pi('1125899906842624', 'ペビ', 'Pi'),
  Ei('1152921504606846976', 'エクスビ', 'Ei'),
  Zi('1180591620717411303424', 'ゼビ', 'Zi'),
  Yi('1208925819614629174706176', 'ヨビ', 'Yi'),
  Ri('1237940039285380274899124224', 'ロビ', 'Ri'),
  Qi('1267650600228229401496703205376', 'クエビ', 'Qi'),
  ;

  final String factor;
  final String siName;
  final String siSymbol;
  const Prefix(this.factor, this.siName, this.siSymbol);

  String get value => factor;
}

/// SI単位から変換
String convertFromSI(String number, Prefix prefix) {
  return (Decimal.parse(number) * Decimal.parse(prefix.value)).toString();
}

/// SI単位へ変換
String convertToSI(
    String number, Prefix prefix, String scaleOnInfinitePrecisionS) {
  return (Decimal.parse(number) / Decimal.parse(prefix.value))
      .toDecimal(
          scaleOnInfinitePrecision: int.tryParse(scaleOnInfinitePrecisionS))
      .toString();
}
