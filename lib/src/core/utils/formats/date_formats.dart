import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:intl/intl.dart' as df show DateFormat;

class DateFormat {
  static String toDate(
    DateTime? date, {
    String pattern = 'dd/MM/yyyy',
    String? locale,
  }) {
    if (date == null) return '';

    return df.DateFormat(pattern, locale).format(date);
  }

  static DateTime tryParseOrDateNow(
    String? date, {
    String pattern = 'yyyy-MM-dd',
    String? locale,
    bool utc = false,
  }) {
    if (date == null || date.isEmpty) {
      return DateTime.now();
    } else {
      return tryParse(date, pattern: pattern, locale: locale, utc: utc) ??
          DateTime.now();
    }
  }

  static DateTime? tryParse(
    String? date, {
    String pattern = 'yyyy-MM-dd',
    String? locale,
    bool utc = false,
  }) {
    if (date == null || date.isEmpty) {
      return null;
    } else {
      try {
        return df.DateFormat(pattern, locale).parse(date, utc);
      } catch (e) {
        return null;
      }
    }
  }

  static String toTime(
    DateTime? date, {
    String pattern = 'HH:mm:ss',
    String? locale,
  }) {
    if (date == null) return '';

    return df.DateFormat(pattern, locale).format(date);
  }

  static String toDateTime(
    DateTime? date, {
    String pattern = 'dd/MM/yyyy HH:mm:ss',
    String? locale,
  }) {
    if (date == null) return '';

    return df.DateFormat(pattern, locale).format(date);
  }

  static DateTime? fromString(
    String date, {
    format = '',
    String? locale,
    bool utc = false,
  }) {
    try {
      return df.DateFormat(format, locale).parse(date, utc);
    } catch (e) {
      return null;
    }
  }

  static bool isSameDate(
    DateTime date1,
    DateTime date2, {
    String? locale,
    bool utc = false,
  }) {
    return toDate(date1, locale: locale) == toDate(date2, locale: locale);
  }

  static bool dateIsToday(DateTime date, {String? locale}) {
    return toDate(date, locale: locale) ==
        toDate(DateTime.now(), locale: locale);
  }

  static DateTime? timestampToDate(Timestamp? date) {
    return date?.toDate();
  }
}
