class ZFormatException implements Exception {
  final String message;

  ZFormatException([this.message = 'An unexpected format error occurred. Please check your input']);

  factory ZFormatException.fromMessage(String message) {
    return ZFormatException(message);
  }

  String get formatMessage => message;

  factory ZFormatException.fromCode(String code) {
    switch (code) {
      case 'invalid-email-format':
        return ZFormatException('The email format is invalid. Please enter a valid email.');
      case 'invalid-password-format':
        return ZFormatException('The password format is invalid. Password must be at least 6 characters long.');
      case 'invalid-username-format':
        return ZFormatException('The username format is invalid. Please enter a valid username.');
      case 'invalid-creditcard-format':
        return ZFormatException('The credit card format is invalid. Please enter a valid credit card number.');
      case 'invalid-numeric-format':
        return ZFormatException('Invalid numeric format. Please enter a valid numeric value.');
      default:
        return ZFormatException('Something went wrong.');
    }
  }
}