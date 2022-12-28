import 'package:firebase_auth/firebase_auth.dart';

extension FirebaseAuthError on FirebaseAuthException {
  String get getMessageFromErrorCode {
    final errorCode = code;
    switch (errorCode) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        return 'Email already used, please use other email.';
      case 'email-already-in-use':
        return 'Email already used, please use other email.';
      case 'ERROR_WRONG_PASSWORD':
        return 'Wrong email or password.';
      case 'wrong-password':
        return 'Wrong email or password.';
      case 'ERROR_USER_NOT_FOUND':
        return 'No user found with this email.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'ERROR_USER_DISABLED':
        return 'User disabled.';
      case 'user-disabled':
        return 'User disabled.';
      case 'ERROR_TOO_MANY_REQUESTS':
        return 'Too many requests to log into this account.';
      case 'operation-not-allowed':
        return 'Too many requests to log into this account.';
      case 'ERROR_OPERATION_NOT_ALLOWED':
        return 'Server error, please try again later.';
      case 'ERROR_INVALID_EMAIL':
        return 'Email address is invalid.';
      case 'invalid-email':
        return 'Email address is invalid.';
      default:
        return 'Login failed. Please try again.';
    }
  }
}
