class Validators {
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;

    return RegExp(
      r'^[^@]+@[^@]+\.[^@]+$',
    ).hasMatch(email);
  }

  static bool isValidUsername(String username) {
    return username.length >= 5;
  }
}