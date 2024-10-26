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
  BigInt scaleOnInfinitePrecision = BigInt.parse(scaleOnInfinitePrecisionS);

  Rational out = value * from / to;

  return out
      .toDecimal(scaleOnInfinitePrecision: scaleOnInfinitePrecision.toInt())
      .toString();
}
