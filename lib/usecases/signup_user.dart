import '../external/authentication/request_signup.dart';

class SignUpRequest {
  final String email;
  final String password;
  const SignUpRequest(this.email, this.password);
}

Future<void> signUpUser(SignUpRequest request) async {
  final response = await requestSignUp(request.email, request.password);
}
