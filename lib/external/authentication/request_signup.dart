import 'dart:convert';
import 'package:http/http.dart' as http;
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

  print(json.decode(response.body));

  // Response interface:
  // kind: identitytoolkit#SignupNewUserResponse,
  // idToken: eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlOWI,
  // email: test@mail.com,
  // refreshToken: AOkPPWQLpHgax282zUXCWq9qCQwV
}
