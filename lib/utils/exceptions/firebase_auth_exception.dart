class ZFirebaseAuthException implements Exception {
  /// The error code associated with exception.
  final String code;

  /// Constructor that takes error code
  ZFirebaseAuthException(this.code);

  /// Get corresponding error message based on the error code
  String get message {
    switch (code) {
      case 'email-already-in-use':
        return 'The email address is already registered. Please use a different email.';
      case 'invalid-email':
        return 'The email address is not valid. Please enter a valid email address.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Please contact support.';
      case 'weak-password':
        return 'The password is too weak. Please enter a stronger password.';
      case 'user-disabled':
        return 'The user account has been disabled. Please contact support.';
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
