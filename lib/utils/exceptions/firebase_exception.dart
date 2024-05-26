class ZFirebaseException implements Exception {
  /// The error code associated with the exception.
  final String code;

  /// Constructor that takes an error code.
  ZFirebaseException(this.code);

  /// Get corresponding error message based on the error code.
  String get message {
    switch (code) {
      case 'unknown':
        return 'An unknown Firebase error occurred. Please try again.';
      case 'invalid-custom-token':
        return 'The custom token format is incorrect. Please check your custom token';
      case 'user-disabled':
        return 'The user account has been disabled. Please contact support.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'invalid-email':
        return 'The email address is not valid. Please enter a valid email address.';
      case 'user-not-found':
        return 'No user found with this email. Please check the email address and try again.';
      case 'wrong-password':
        return 'Incorrect password. Please try again or reset your password.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}
