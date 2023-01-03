import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app_flutter_course/exceptions/auth_exceptions.dart';
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

  final responseBody = json.decode(response.body);

  if (_requestedEmailDoesNotExist(responseBody['error'], responseBody['error']?['message'])) {
    throw NonExistingEmail();
  }

  // Response Interface:
  // kind: identitytoolkit#VerifyPasswordResponse,
  // localId: hP7yPLVrZ2OvRcFyXGDbCsD5ZU42,
  // email: test@mail.com,
  // displayName: ,
  // idToken: eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg3NTNi,
}

bool _requestedEmailDoesNotExist(Map? responseError, String responseMsg) {
  return responseError != null && responseMsg == 'EMAIL_NOT_FOUND';
}
