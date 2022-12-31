import 'dart:convert';
import 'package:http/http.dart' as http;
import './get_signup_url.dart';

Future<void> requestSignUp(String email, String password) async {
  final url = getSignUpUrl();
  final response = await http.post(
    url,
    body: json.encode({
      'email': email,
      'password': password,
      'returnSecureToken': true,
    }),
  );
  print(json.decode(response.body));
}
