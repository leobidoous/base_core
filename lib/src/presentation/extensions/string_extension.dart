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
        final rest = word.substring(1).toLowerCase();
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

  String get initials {
    final name = trim().split(' ');
    if (name.isEmpty) {
      return '-';
    } else if (name.length == 1) {
      if (name.first.isEmpty) {
      } else if (name.first.length > 1) {
        return name.first.substring(0, 2).toUpperCase();
      }
      return '-';
    } else {
      return '${name.first[0]}${name.last[0]}'.toUpperCase();
    }
  }
}
