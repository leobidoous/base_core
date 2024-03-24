import 'package:intl/intl.dart';

/// Retorna tempo de duração fazendo a comparação do 
/// tempo final com o tempo passado
/// EXEMPLOS DE RETORNO: 1 Dia, 30 min, 2 Hrs, 1 H, 3 Dias, ...
/// Necessário passar o DateTime.
String permanenceTime({required DateTime lastTime}) {
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

/// Retorna o padrão data de acorodo com o formato passado.
/// Obrigatório passar o tempo. Por padrão o formato é: dd-MM-yyyy hh:mm
String formatDate({
  required DateTime time,
  String? mask = 'dd/MM/yyyy',
}) {
  return DateFormat(mask).format(time);
}

/// Retorna o valor em String do dinheiro. Exemplos:
/// formatCash(147.0) -> 147,00
String formatCash({
  required double value,
}) {
  const locale = 'BRL';
  return NumberFormat.simpleCurrency(
    locale: locale,
    decimalDigits: 2,
    name: '',
  ).format(value);
}
