import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:intl/intl.dart' as df show DateFormat;

class DateFormat {
  static String toDate(
    DateTime? date, {
    String pattern = 'dd/MM/yyyy',
    String? locale = 'pt_BR',
  }) {
    if (date == null) return '';

    return df.DateFormat(pattern, locale).format(date.toLocal());
  }

  static DateTime tryParseOrDateNow(
    String? date, {
    String pattern = 'yyyy-MM-dd',
    String? locale = 'pt_BR',
  }) {
    if (date == null || date.isEmpty) {
      return DateTime.now();
    } else {
      return tryParse(date, pattern: pattern, locale: locale) ?? DateTime.now();
    }
  }

  static DateTime? tryParse(
    String? date, {
    String pattern = 'yyyy-MM-dd',
    String? locale = 'pt_BR',
  }) {
    if (date == null || date.isEmpty) {
      return null;
    } else {
      try {
        return df.DateFormat(pattern, locale).parse(date).toLocal();
      } catch (e) {
        return null;
      }
    }
  }

  static String toTime(
    DateTime? date, {
    String pattern = 'HH:mm:ss',
    String? locale = 'pt_BR',
  }) {
    if (date == null) return '';

    return df.DateFormat(pattern, locale).format(date.toLocal());
  }

  static String toDateTime(
    DateTime? date, {
    String pattern = 'dd/MM/yyyy HH:mm:ss',
    String? locale = 'pt_BR',
  }) {
    if (date == null) return '';

    return df.DateFormat(pattern, locale).format(date.toLocal());
  }

  static DateTime? fromString(
    String date, {
    format = '',
    String? locale = 'pt_BR',
  }) {
    try {
      return df.DateFormat(format, locale).parse(date).toLocal();
    } catch (e) {
      return null;
    }
  }

  static bool isSameDate(
    DateTime date1,
    DateTime date2, {
    String? locale = 'pt_BR',
  }) {
    return toDate(date1, locale: locale) == toDate(date2, locale: locale);
  }

  static bool dateIsToday(DateTime date, {String? locale = 'pt_BR'}) {
    return toDate(date, locale: locale) ==
        toDate(
          DateTime.now(),
          locale: locale,
        );
  }

  static DateTime? timestampToDate(Timestamp? date) {
    return date?.toDate().toLocal();
  }
}
