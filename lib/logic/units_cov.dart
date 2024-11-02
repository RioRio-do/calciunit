// Package imports:
import 'package:decimal/decimal.dart';
import 'package:rational/rational.dart';

String unitCov({
  required String fromS,
  required String toS,
  required String valueS,
  required String scaleOnInfinitePrecisionS,
}) {
  Rational from = Rational.parse(fromS);
  Rational to = Rational.parse(toS);
  Rational value = Rational.parse(valueS);
  int scale = int.parse(scaleOnInfinitePrecisionS);

  // 1桁多く計算
  Rational out = value * from / to;
  Decimal decimal = out.toDecimal(scaleOnInfinitePrecision: scale + 1);

  // 文字列に変換して四捨五入の処理を行う
  String strValue = decimal.toString();
  int dotIndex = strValue.indexOf('.');

  // 小数点がない場合はそのまま返す
  if (dotIndex == -1) return strValue;

  // 目標の桁数より短い場合はそのまま返す
  if (strValue.length <= dotIndex + scale + 1) return strValue;

  // 四捨五入の処理
  int roundPosition = dotIndex + scale + 1;
  int roundDigit = int.parse(strValue[roundPosition]);

  if (roundDigit >= 5) {
    // 四捨五入で切り上げる場合
    Decimal increment = Decimal.parse('0.${'0' * (scale - 1)}1');
    decimal = Decimal.parse(strValue.substring(0, roundPosition)) + increment;
  } else {
    // 切り捨ての場合
    decimal = Decimal.parse(strValue.substring(0, roundPosition));
  }

  return decimal.toString();
}
