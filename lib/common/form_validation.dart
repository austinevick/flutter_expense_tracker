RegExp removeWhiteSpace = RegExp(r'\s');



RegExp emailRegExp = RegExp(
    "^[a-zA-Z0-9.!#\$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*\$");
String? validateEmail(String value) {
  if (value.isEmpty) {
    return 'Field is required';
  }
  if (!emailRegExp.hasMatch(value)) {
    return 'Please enter a valid email';
  }
  return null;
}


RegExp passwordRegExp = RegExp(
    r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!/%*?+=_^.&])[A-Za-z\d@$!%*?+=_^.&]{8,}$");
String? validatePassword(String value) {
  if (value.isEmpty) {
    return 'Field is required';
  }
  if (!passwordRegExp.hasMatch(value)) {
    return '';
  }
  return null;
}

///Password must be a minimum of 8 characters, with letters, numbers, and a symbol.
bool isValidPassword(String input) => passwordRegExp.hasMatch(input);

