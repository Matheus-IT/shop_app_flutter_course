import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../exceptions/auth_exceptions.dart';
import '../authentication/auth_url_mapper.dart';

Future<void> requestSignUp(String email, String password) async {
  final url = AuthUrlMapper().getSignUpUrl();
  final response = await http.post(
    url,
    body: json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true,
    }),
  );

  final responseBody = json.decode(response.body);

  if (responseBody['error'] != null && responseBody['error']['message'] == 'EMAIL_EXISTS') {
    throw ExistingEmail();
  }

  // Response interface:
  // kind: identitytoolkit#SignupNewUserResponse,
  // idToken: eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlOWI,
  // email: test@mail.com,
  // refreshToken: AOkPPWQLpHgax282zUXCWq9qCQwV
}
