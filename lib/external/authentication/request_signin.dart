import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../exceptions/auth_exceptions.dart';
import './error_response.dart';
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

  final responseBody = json.decode(response.body);

  if (responseBody['error'] == null) {
    // Response Interface:
    // kind: identitytoolkit#VerifyPasswordResponse,
    // localId: hP7yPLVrZ2OvRcFyXGDbCsD5ZU42,
    // email: test@mail.com,
    // displayName: ,
    // idToken: eyJhbGciOiJSUzI1NiIsImtpZCI6Ijg3NTNi,
    return;
  }

  final errorResponse = ErrorResponse(
    responseBody['error']['code'],
    responseBody['error']['message'],
  );

  if (_requestedEmailDoesNotExist(errorResponse)) {
    throw NonExistingEmail();
  }

  if (_passwordIsWrong(errorResponse)) {
    throw WrongPassword();
  }

  if (_emailIsInvalid(errorResponse)) {
    throw InvalidEmail();
  }
}

bool _requestedEmailDoesNotExist(ErrorResponse error) {
  return error.message == 'EMAIL_NOT_FOUND';
}

bool _passwordIsWrong(ErrorResponse error) {
  return error.message == 'INVALID_PASSWORD';
}

bool _emailIsInvalid(ErrorResponse error) {
  return error.message == 'INVALID_EMAIL';
}
