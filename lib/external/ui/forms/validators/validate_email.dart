String? validateEmail(String? value) {
  if (value != null && (value.isEmpty || !value.contains('@'))) {
    return 'Invalid email!';
  }
  return null;
}
