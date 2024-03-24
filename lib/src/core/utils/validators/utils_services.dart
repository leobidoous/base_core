class UtilsServices {
  static String emailMask(String email) {
    List<String> emailSplit = email.split('@');
    String emailUsuarioMascarado =
        '''${emailSplit[0].substring(0, 2)}***${emailSplit[0].substring(emailSplit[0].length - 2)}''';
    String dominioMascarado =
        '***${emailSplit[1].substring(emailSplit[1].length - 5)}';
    return '$emailUsuarioMascarado@$dominioMascarado';
  }
}
