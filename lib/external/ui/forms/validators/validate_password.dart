String? validatePassword(String? value) {
  if (value == null) {
    return 'value is null';
  }
  if (value.isEmpty || value.length < 5) {
    return 'Password is too short!';
  }
  return null;
}
