class ZFirebaseException implements Exception {
  final String code;

  ZFirebaseException(this.code);

  String get message {
    switch (code) {
      case 'INVALID-LOGIN-CREDENTIALS':
        return 'Invalid login credentials. Please double-check your information.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'invalid-arguments':
        return 'Invalid argument provided to the authentication method.';
      case 'email-already-in-use':
        return 'The email address is already in use. Please use a different email.';
      case 'invalid-email':
        return 'The email address is not valid. Please enter a valid email address.';
      case 'user-not-found':
        return 'No user found with this email. Please check the email address and try again.';
      case 'wrong-password':
        return 'Incorrect password. Please try again or reset your password.';
      case 'user-disabled':
        return 'The user account has been disabled. Please contact support.';
      case 'operation-not-allowed':
        return 'This operation is not allowed. Please contact support.';
      case 'weak-password':
        return 'The password is too weak. Please enter a stronger password.';
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';
      case 'provider-already-linked':
        return 'This provider is already linked to the user.';
      case 'credential-already-in-use':
        return 'The credential is already in use.';
      case 'invalid-credential':
        return 'The provided credential is invalid.';
      case 'expired-action-code':
        return 'The action code has expired. Please request a new one.';
      case 'invalid-action-code':
        return 'The action code is invalid. Please double-check and try again.';
      case 'missing-verification-code':
        return 'The verification code is missing. Please enter a valid code.';
      case 'invalid-verification-code':
        return 'The verification code is invalid. Please double-check and try again.';
      case 'session-expired':
        return 'The session has expired. Please log in again.';
      default:
        return 'An unexpected Firebase error occurred. Please try again later.';
    }
  }
}
