// Package imports:
import 'package:decimal/decimal.dart';
import 'package:rational/rational.dart';

String unitCov({
  required String fromS,
  required String toS,
  required String valueS,
  required String scaleOnInfinitePrecisionS,
}) {
  // 文字列を数値に変換
  Rational from = Rational.parse(fromS);
  Rational to = Rational.parse(toS);
  Rational value = Rational.parse(valueS);
  int scale = int.parse(scaleOnInfinitePrecisionS);

  // 単位変換の計算（1桁多く計算）
  Rational result = value * from / to;
  return _roundDecimal(
      result.toDecimal(scaleOnInfinitePrecision: scale + 1), scale);
}

/// 指定された桁数で四捨五入を行う
String _roundDecimal(Decimal value, int scale) {
  String strValue = value.toString();
  int dotIndex = strValue.indexOf('.');

  if (dotIndex == -1) return strValue;
  if (strValue.length <= dotIndex + scale + 1) return strValue;

  int roundPosition = dotIndex + scale + 1;
  int roundDigit = int.parse(strValue[roundPosition]);

  if (roundDigit >= 5) {
    // 切り上げ
    Decimal increment = Decimal.parse('0.${'0' * (scale - 1)}1');
    return (Decimal.parse(strValue.substring(0, roundPosition)) + increment)
        .toString();
  }
  // 切り捨て
  return strValue.substring(0, roundPosition);
}
