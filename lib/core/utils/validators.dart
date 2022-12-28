import 'package:yts_mobile/core/core.dart';

class Validators {
  static String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter email'.hardcoded;
    } else if (!RegExp(r'^[\w-\.\+]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(value.trim())) {
      return 'Please enter valid email'.hardcoded;
    } else {
      return null;
    }
  }

  static String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter password'.hardcoded;
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(value.trim())) {
      return 'Password too weak';
    } else {
      return null;
    }
  }
}
