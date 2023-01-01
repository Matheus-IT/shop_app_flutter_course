String? validateConfirmationPassword(String? value, String otherPassword) {
  if (value != otherPassword) {
    return 'Passwords do not match!';
  }
  return null;
}
