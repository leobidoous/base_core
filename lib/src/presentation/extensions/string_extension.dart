/// String extensions for digital account
extension StringExt on String {
  double? get tryParseToDouble {
    return double.tryParse(toString().replaceFirst(',', '.'));
  }

  double? get tryParseCurrencyToDouble {
    if (split('.').length == 2 && !contains(',')) {
      return double.tryParse(this);
    }
    return double.tryParse(replaceAll('.', '').replaceAll(',', '.'));
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
