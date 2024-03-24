import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:intl/intl.dart' as df show DateFormat;

class DateFormat {
  /// Retorna tempo de duração fazendo a comparação do
  /// tempo final com o tempo passado
  /// EXEMPLOS DE RETORNO: 1 Dia, 30 min, 2 Hrs, 1 H, 3 Dias, ...
  /// Necessário passar o DateTime.
  static String permanenceTime({required DateTime lastTime}) {
    final time = DateTime.now().difference(lastTime);
    if (time.inSeconds < 60) {
      return '${time.inSeconds} s';
    } else if (time.inMinutes < 60) {
      return '${time.inMinutes} min';
    } else if (time.inHours < 24) {
      return '${time.inHours} h';
    } else if (time.inDays > 0 && time.inDays == 1) {
      return '${time.inDays} Dia';
    } else if (time.inDays > 1) {
      return '${time.inDays} Dias';
    } else {
      return 'Não informado';
    }
  }

  static String toDate(
    DateTime? date, {
    String pattern = 'dd/MM/yyyy',
    String locale = 'pt_BR',
  }) {
    if (date == null) return '';

    return df.DateFormat(pattern, locale).format(date.toLocal());
  }

  static DateTime tryParseOrDateNow(
    String? date, {
    String pattern = 'yyyy-MM-dd',
  }) {
    if (date == null || date.isEmpty) {
      return DateTime.now();
    } else {
      return tryParse(date, pattern: pattern) ?? DateTime.now();
    }
  }

  static DateTime? tryParse(String? date, {String pattern = 'yyyy-MM-dd'}) {
    if (date == null || date.isEmpty) {
      return null;
    } else {
      try {
        return df.DateFormat(pattern).parse(date).toLocal();
      } catch (e) {
        return DateTime.now();
      }
    }
  }

  static String toTime(DateTime? date, {String pattern = 'HH:mm:ss'}) {
    if (date == null) return '';

    return df.DateFormat(pattern, 'pt_BR').format(date.toLocal());
  }

  static String toDateTime(
    DateTime? date, {
    String pattern = 'dd/MM/yyyy HH:mm:ss',
  }) {
    if (date == null) return '';

    return df.DateFormat(pattern, 'pt_BR').format(date.toLocal());
  }

  static DateTime? fromString(String date, {format = ''}) {
    try {
      return df.DateFormat(format).parse(date).toLocal();
    } catch (e) {
      return null;
    }
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    return toDate(date1) == toDate(date2);
  }

  static bool dateIsToday(DateTime date) {
    return toDate(date) == toDate(DateTime.now());
  }

  static DateTime? timestampToDate(Timestamp? date) {
    return date?.toDate().toLocal();
  }
}
