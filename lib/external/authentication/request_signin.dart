import 'dart:convert';
import 'package:http/http.dart' as http;
import '../authentication/auth_url_mapper.dart';

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

  // Response Interface:
  // kind: identitytoolkit#VerifyPasswordResponse,
  // localId: hP7yPLVrZ2OvRcFyXGDbCsD5ZU42,
  // email: test@mail.com,
  // displayName: ,
  // idToken: eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg3NTNi,
}
