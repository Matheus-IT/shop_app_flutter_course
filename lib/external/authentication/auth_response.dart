class AuthResponse {
  final String token;
  final DateTime expiryDate;
  final String userId;
  const AuthResponse({
    required this.token,
    required this.expiryDate,
    required this.userId,
  });
}
