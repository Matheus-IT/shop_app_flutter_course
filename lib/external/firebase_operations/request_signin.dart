import 'dart:convert';
import 'package:http/http.dart' as http;
import './auth_url_mapper.dart';

Future<void> requestSignIn(String email, String password) async {
  final url = AuthUrlMapper().getSignInUrl();
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
