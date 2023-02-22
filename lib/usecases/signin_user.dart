import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app_flutter_course/external/providers/auth_provider.dart';

import '../external/authentication/auth_response.dart';
import '../external/authentication/request_signin.dart';

class SignInRequest {
  final String email;
  final String password;
  const SignInRequest(this.email, this.password);
}

Future<AuthResponse> signInUser(SignInRequest request) async {
  final response = await requestSignIn(request.email, request.password);

  await storeResponseInLocalDataSource(response);

  return response;
}

Future<bool> tryAutoLogin(AuthProvider authProvider) async {
  final prefs = await SharedPreferences.getInstance();

  if (!prefs.containsKey('userData')) {
    return false;
  }

  final extractedUserData = json.decode(prefs.getString('userData') ?? '') as Map<String, dynamic>;
  final expiryDate = DateTime.parse(extractedUserData['expiryDate'] ?? '');

  if (expiryDate.isBefore(DateTime.now())) {
    return false;
  }

  authProvider.receive(AuthResponse(
    token: extractedUserData['token'],
    userId: extractedUserData['userId'],
    expiryDate: extractedUserData['expiryDate'],
  ));
  return true;
}

Future<void> storeResponseInLocalDataSource(AuthResponse response) async {
  final prefs = await SharedPreferences.getInstance();
  final userData = json.encode({
    'token': response.token,
    'userId': response.userId,
    'expiryDate': response.expiryDate,
  });
  prefs.setString('userData', userData);
}
