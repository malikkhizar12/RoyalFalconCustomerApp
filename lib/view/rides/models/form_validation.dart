// form_validation.dart
class RidesFormValidation {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    );
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String? validatePassengers(String? value) {
    if (value == null || value.isEmpty) {
      return 'Number of passengers is required';
    }
    final int? passengers = int.tryParse(value);
    if (passengers == null || passengers <= 0) {
      return 'Enter a valid number of passengers';
    }
    return null;
  }

  static String? validateBags(String? value) {
    if (value == null || value.isEmpty) {
      return 'Number of bags is required';
    }
    final int? bags = int.tryParse(value);
    if (bags == null || bags < 0) {
      return 'Enter a valid number of bags';
    }
    return null;
  }

  static String? validateContactNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact number is required';
    }
    final RegExp phoneRegex = RegExp(
      r'^\+?[0-9]{10,13}$',
    );
    if (!phoneRegex.hasMatch(value)) {
      return 'Enter a valid contact number';
    }
    return null;
  }

  static String? validateCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    }
    return null;
  }

  static String? validatePickupTime(String? value) {
    if (value == null || value.isEmpty) {
      return 'Pickup time is required';
    }
    return null;
  }

  static String? validateFlightNo(String? value) {
    if (value == null || value.isEmpty) {
      return 'Flight number is required';
    }
    return null;
  }

  static String? validateSpecialRequest(String? value) {
    if (value == null || value.isEmpty) {
      return 'Special request is required';
    }
    return null;
  }
}
