class Validator {
  //?-----------------------------------usernamename---------------------------
  String? usernameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }

    return null;
  }

//?-----------------------------------password---------------------------
  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }

   

    return null;
  }
}
