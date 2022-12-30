import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../firebase_operations/get_signup_url.dart';

class AuthProvider extends ChangeNotifier {
  late String _token;
  late DateTime _expireDate;
  late String _userId;

  Future<void> signup(String email, String password) async {
    // final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=<YOUR_API_KEY>');
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
}
