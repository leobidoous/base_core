import '../../../presentation/extensions/string_extension.dart';
import '../formats/date_formats.dart';
import '../formats/number_formats.dart';
import 'cnpj_validator.dart';
import 'cpf_validator.dart';

class FormValidators {
  static String? emptyField(String? input) {
    if (input == null || input.isEmpty) {
      return 'Este campo não pode ser vazio.';
    }
    return null;
  }

  static String? invalidLength(String? input, int length) {
    if (input == null || input.isEmpty) return null;
    if (input.length < length) {
      return 'Campo deve conter no mínimo $length caractére(s).';
    }
    return null;
  }

  static String? invalidZipCode(String? input) {
    if (input == null || input.isEmpty) return null;
    if (input.replaceAll(RegExp('[^0-9]'), '').length < 8) {
      return 'CEP inválido.';
    }
    return null;
  }

  static String? invalidDouble(String? input) {
    if (input == null || input.isEmpty) return null;
    if (double.tryParse(input.replaceAll(',', '.')) == null) {
      return 'Campo deve ser um valor decimal.';
    }
    return null;
  }

  static String? invalidCurrency(String? input) {
    if (input == null || input.isEmpty) return null;
    if (input.tryParseCurrencyToDouble == null) {
      return 'Campo deve ser um valor decimal.';
    }
    return null;
  }

  static String? invalidStrongPassword(String? input) {
    if (input == null || input.isEmpty) return null;

    if (invalidLength(input, 6) != null) {
      return 'A senha deve conter pelo menos 6 caracteres.';
    }
    if (invalidSpecialCharacter(input) != null) {
      return '''A senha deve conter pelo menos um número e um caractere especial.''';
    }
    if (invalidUppercase(input) != null || invalidLowercase(input) != null) {
      return '''A senha deve conter pelo menos uma letra maiúscula e minúscula.''';
    }
    return null;
  }

  static String? invalidSpecialCharacter(String? input) {
    if (input == null || input.isEmpty) return null;

    if (RegExp(r'^[a-zA-Z0-9]+$').hasMatch(input) ||
        !RegExp('[0-9]').hasMatch(input)) {
      return '''Campo deve conter pelo menos um número e um caractere especial.''';
    }
    return null;
  }

  static String? invalidUppercase(String? input) {
    if (input == null || input.isEmpty) {
      return null;
    }
    if (!RegExp('[a-z]').hasMatch(input)) {
      return 'Campo deve conter pelo menos um caractere maiúsculo.';
    }
    return null;
  }

  static String? invalidLowercase(String? input) {
    if (input == null || input.isEmpty) {
      return null;
    }
    if (!RegExp('[A-Z]').hasMatch(input)) {
      return 'Campo deve conter pelo menos um caractere minúsculo.';
    }
    return null;
  }

  static String? invalidPhone(String? input) {
    if (emptyField(input) != null) return null;
    final RegExp regex = RegExp(r'^(\d{2}) \d{4}-\d{4}$');
    if (regex.hasMatch(input!) ||
        input.replaceAll(RegExp('[^0-9]'), '').length < 10) {
      return 'Número de telefone inválido';
    }
    return null;
  }

  static String? invalidFullName(String? input) {
    if (input == null || input.isEmpty) return null;

    if (input.trim().split(' ').length < 2) {
      return 'Campo deve conter nome completo.';
    }
    if (input.contains(RegExp('[0-9]'))) {
      return 'Campo não deve conter números.';
    }
    if (RegExp(r'[$#@!%.*\|/?><,º;:&_ª•¶§∞¢£™πø¥†®œå()+-=]+').hasMatch(input)) {
      return 'Nome não pode conter caracteres especiais';
    }
    return null;
  }

  static String? invalidEmail(String? input) {
    if (input == null || input.isEmpty) return null;

    RegExp regex = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!regex.hasMatch(input)) {
      return 'E-mail inválido';
    }
    return null;
  }

  static String? invalidSameField(String? input, String refer) {
    if (input != refer) return 'Campos devem ser iguais';
    return null;
  }

  static String? invalidCfpOrCnpj(String? input) {
    if (input == null || input.isEmpty) return null;

    final value = input.replaceAll(RegExp('[^0-9]'), '');

    if (value.length < 11) {
      return 'CPF inválido';
    } else if (value.length < 14) {
      return 'CNPJ inválido';
    }
    if (value.length == 11) {
      if (!CPFValidator.isValid(input)) {
        return 'CPF inválido';
      }
    } else if (value.length == 14) {
      if (!CNPJValidator.isValid(input)) {
        return 'CNPJ inválido';
      }
    }

    return null;
  }

  static String? invalidCNPJ(String? input) {
    if (!CNPJValidator.isValid(input)) {
      return 'CNPJ inválido.';
    }
    return null;
  }

  static String? invalidGreaterThan(String? input, double refer) {
    final value = input?.replaceFirst(',', '.') ?? '';
    if (double.tryParse(value) != null) {
      if (double.parse(value) < refer) {
        return 'Campo deve ser maior ou igual à $refer';
      }
    } else if (double.tryParse(value) == null && value.isNotEmpty) {
      return 'Campo deve ser um número decimal.';
    }
    return null;
  }

  static String? invalidLessThan(String? input, double refer) {
    final value = input?.replaceFirst(',', '.') ?? '';
    if (double.tryParse(value) != null) {
      if (double.parse(value) > refer) {
        return 'Campo deve ser menor ou igual à $refer';
      }
    } else if (double.tryParse(value) == null && value.isNotEmpty) {
      return 'Campo deve ser um número decimal.';
    }
    return null;
  }

  static String? invalidGreaterThanCurrency(String? input, double refer) {
    if (input == null || input.isEmpty) return null;
    if ((input.tryParseCurrencyToDouble ?? 0) < refer) {
      return '''Campo deve ser maior ou igual à ${NumberFormat.toCurrency(refer)}''';
    }
    return null;
  }

  static String? invalidGreaterThanAndLessThanOrEqualToCurrency(
    String? input,
    double min,
    double max,
  ) {
    if (input == null || input.isEmpty) return null;
    if ((input.tryParseCurrencyToDouble ?? 0) < min ||
        (input.tryParseCurrencyToDouble ?? 0) > max) {
      return '''Valor deve ser maior ou igual à ${NumberFormat.toCurrency(min)} e menor ou igual à ${NumberFormat.toCurrency(max)}''';
    }
    return null;
  }

  static String? invalidLessThanCurrency(String? input, double refer) {
    if (input == null || input.isEmpty) return null;
    if ((input.tryParseCurrencyToDouble ?? 0) > refer) {
      return '''Campo deve ser menor ou igual à ${NumberFormat.toCurrency(refer)}''';
    }
    return null;
  }

  static String? invalidCardExpirationDate(String? input) {
    if (emptyField(input) != null) return null;

    if (input!.length < 5) return 'Campo deve conter mês e ano.';

    final month = int.parse(input.substring(0, 2));
    final year = int.parse(input.substring(3, 5));

    final now = DateTime.now();

    final yearNow = int.parse(now.year.toString().substring(2));
    final monthNow = now.month;

    // Verifica se mês é menor que 01 e maior que 12
    if (month < 1 || month > 12) {
      return 'Mês inválido.';
    }
    if ((year == yearNow && month < monthNow) || year < yearNow) {
      return 'Cartão vencido';
    }
    return null;
  }

  static String? invalidCreditCard(String? input) {
    if (input == null || input.isEmpty) return null;

    if (input.replaceAll(' ', '').trim().length != 16) {
      return 'Cartão de crétido inválido.';
    }
    return null;
  }

  static String? isvalidPin(
    String? input,
  ) {
    if (input == null || input.isEmpty) {
      return 'Por favor, insira o código';
    }
    final regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(input)) {
      return 'PIN inválido.';
    }
    return null;
  }

  static String? plate({String? input}) {
    if (input == null || input.isEmpty) return 'Este campo não pode ser vazio.';

    final regx = RegExp('(^[A-Z]{3}-[0-9][0-9A-Z][0-9]{2})');
    if (!regx.hasMatch(input)) {
      return 'Placa inválida';
    }
    return null;
  }

  static String? invalidDate(String? input) {
    if (emptyField(input) != null) {
      return emptyField(input);
    }
    final date = DateFormat.fromString(input ?? '', format: 'dd/MM/yyyy')
        ?.isAfter(DateTime.now());
    if ((date == null || date) || input?.length != 10) {
      return 'Data inválida';
    }
    return null;
  }
}
