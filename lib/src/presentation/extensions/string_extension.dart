extension StringExt on String {
  double? get tryParseToDouble {
    return double.tryParse(toString().replaceFirst(',', '.'));
  }

  double? get tryParseCurrencyToDouble {
    String value = replaceAll(RegExp('[^0-9,.]'), '');
    if (value.split('.').length == 2 && !value.contains(',')) {
      return double.tryParse(value);
    } else if (value.split(',').length > 2 && value.contains('.')) {
      return double.tryParse(value.replaceAll(',', ''));
    }
    value = value.replaceAll('.', '');
    value = value.replaceAll(',', '.');
    return double.tryParse(value);
  }

  int? get tryParseToInt => int.tryParse(this);

  String capitalize({bool onlyFirstWord = false}) {
    String cap(List<String> sentence) {
      return sentence.map((word) {
        if (word.isEmpty) return word;

        if (word.length == 1) return word.toUpperCase();

        final first = word.substring(0, 1).toUpperCase();
        final rest = word.substring(1);
        return first + rest;
      }).join(' ');
    }

    final splited = split(' ');

    if (onlyFirstWord) {
      return splited.isNotEmpty
          ? '${cap([splited.first])} ${splited.sublist(1).join(' ')}'
          : this;
    }
    return cap(splited);
  }
}
