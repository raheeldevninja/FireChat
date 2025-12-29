class Validators {
  static bool isEmailValid(String? email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email ?? '');
  }

  static bool isFieldEmpty(String? value) {
    return value == null || value.isEmpty;
  }
}
