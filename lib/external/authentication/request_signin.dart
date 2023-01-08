import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shop_app_flutter_course/external/authentication/auth_response.dart';

import '../../exceptions/auth_exceptions.dart';
import './error_response.dart';
import './auth_url_mapper.dart';

Future<AuthResponse> requestSignIn(String email, String password) async {
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

  if (_responseWasSuccessful(responseBody)) {
    return AuthResponse(
      token: responseBody['idToken'],
      expiryDate: DateTime.now().add(Duration(seconds: int.parse(responseBody['expiresIn']))),
      userId: responseBody['localId'],
    );
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
  throw const HttpException('Some generic http exception');
}

bool _responseWasSuccessful(Map responseBody) {
  return responseBody['error'] == null;
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
