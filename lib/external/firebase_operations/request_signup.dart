import 'dart:convert';
import 'package:http/http.dart' as http;
import './auth_url_mapper.dart';

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
  //  kind: identitytoolkit#SignupNewUserResponse,
  //  idToken: eyJhbGciOiJSUzI1NiIsImtpZCI6ImNlOWI,
  //  email: test@mail.com,
  //  refreshToken: AOkPPWQLpHgax282zUXCWq9qCQwV
}
