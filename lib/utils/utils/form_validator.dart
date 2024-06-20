// form_validators.dart

class FormValidators {
  static String? validateName(String value) {
    final RegExp nameRegExp = RegExp(r'^[a-zA-Z]{4,}$');

    if (!nameRegExp.hasMatch(value)) {
      return 'Name must contain only alphabets and have minimum 4 characters';
    }

    return null;
  }

  static String? validatePhoneNumber(String value) {
    if (value.length != 10) {
      return 'Phone number must be 10 digits';
    }

    return null;
  }

  static String? validatePassword(String value) {
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    return null;
  }

  static String? validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }

    return null;
  }
}
