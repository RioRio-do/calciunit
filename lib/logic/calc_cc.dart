import 'package:decimal/decimal.dart';

enum SIPrefix {
  Q, // quetta
  R, // ronna
  Y, // yotta
  Z, // zetta
  E, // exa
  P, // peta
  T, // tera
  G, // giga
  M, // mega
  k, // kilo
  h, // hecto
  da, // deca
  d, // deci
  c, // centi
  m, // milli
  u, // micro
  n, // nano
  p, // pico
  f, // femto
  a, // atto
  z, // zepto
  y, // yocto
  r, // ronto
  q // quecto
}

extension SIPrefixExtension on SIPrefix {
  String get value {
    switch (this) {
      case SIPrefix.Q:
        return '1e30';
      case SIPrefix.R:
        return '1e27';
      case SIPrefix.Y:
        return '1e24';
      case SIPrefix.Z:
        return '1e21';
      case SIPrefix.E:
        return '1e18';
      case SIPrefix.P:
        return '1e15';
      case SIPrefix.T:
        return '1e12';
      case SIPrefix.G:
        return '1e9';
      case SIPrefix.M:
        return '1e6';
      case SIPrefix.k:
        return '1e3';
      case SIPrefix.h:
        return '1e2';
      case SIPrefix.da:
        return '1e1';
      case SIPrefix.d:
        return '1e-1';
      case SIPrefix.c:
        return '1e-2';
      case SIPrefix.m:
        return '1e-3';
      case SIPrefix.u:
        return '1e-6';
      case SIPrefix.n:
        return '1e-9';
      case SIPrefix.p:
        return '1e-12';
      case SIPrefix.f:
        return '1e-15';
      case SIPrefix.a:
        return '1e-18';
      case SIPrefix.z:
        return '1e-21';
      case SIPrefix.y:
        return '1e-24';
      case SIPrefix.r:
        return '1e-27';
      case SIPrefix.q:
        return '1e-30';
      default:
        return '1.0';
    }
  }
}

String convertFromSI(String number, SIPrefix prefix) {
  Decimal num = Decimal.parse(number);
  Decimal factor = Decimal.parse(prefix.value);
  Decimal result = num * factor;
  return result.toString();
}

String convertToSI(
    String number, SIPrefix prefix, String scaleOnInfinitePrecisionS) {
  Decimal num = Decimal.parse(number);
  Decimal factor = Decimal.parse(prefix.value);
  Decimal result = (num / factor).toDecimal(
    scaleOnInfinitePrecision: int.tryParse(scaleOnInfinitePrecisionS),
  );
  return result.toString();
}
