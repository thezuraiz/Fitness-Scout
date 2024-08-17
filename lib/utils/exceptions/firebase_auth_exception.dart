
import 'package:fitness_scout/utils/helpers/logger.dart';

class ZFirebaseAuthException implements Exception{

  /// The error code associated with exception.
  final String code;

  /// Constructor that takes error code
  ZFirebaseAuthException(this.code);

  /// Get corresponding error message based on the error code
  String get message {
    ZLogger.warning('Firebase Error => $code');
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
      case 'invalid-credential':
        return 'The credential is invalid. Please provide valid credentials.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your connection and try again.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please log in again.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address but different credentials. Please sign in using a different method.';
      case 'auth/credential-already-in-use':
        return 'The credential is already associated with a different user account.';
      case 'auth/email-already-in-use':
        return 'The email address is already in use by another account.';
      case 'auth/expired-action-code':
        return 'The action code has expired. Please request a new one.';
      case 'auth/invalid-action-code':
        return 'The action code is invalid. Please check the code and try again.';
      case 'auth/invalid-email':
        return 'The email address is malformed. Please enter a valid email address.';
      case 'auth/invalid-credential':
        return 'The credential is invalid. Please provide a valid credential.';
      case 'auth/operation-not-allowed':
        return 'The operation is not allowed. Please contact support.';
      case 'auth/weak-password':
        return 'The password is too weak. Please enter a stronger password.';
      default:
        return 'An unknown error occurred. Please try again.';
    }
  }
}