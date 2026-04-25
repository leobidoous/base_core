import 'package:intl/intl.dart' as nf show NumberFormat;

import '../../../presentation/extensions/string_extension.dart';

class NumberFormat {
  static String toCurrency(
    dynamic value, {
    String? locale = 'pt_BR',
    String? symbol = 'R\$',
    int? decimalDigits,
  }) {
    final format = nf.NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimalDigits,
    ).format;
    try {
      if (value.toString().contains('e')) {
        return format(value).trim();
      }
      return format(value.toString().tryParseCurrencyToDouble).trim();
    } catch (e) {
      return format(0).trim();
    }
  }

  static String toNumber(
    dynamic value, {
    String? locale = 'pt_BR',
    int? decimalDigits = 0,
  }) {
    final format = nf.NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: decimalDigits ?? 0,
    ).format;
    try {
      if (value.toString().contains('e')) {
        return format(value).trim();
      }
      return format(value.toString().tryParseCurrencyToDouble).trim();
    } catch (e) {
      return format(0).trim();
    }
  }
}
