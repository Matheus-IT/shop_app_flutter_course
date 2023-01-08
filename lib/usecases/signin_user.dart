import '../external/authentication/auth_response.dart';
import '../external/authentication/request_signin.dart';

class SignInRequest {
  final String email;
  final String password;
  const SignInRequest(this.email, this.password);
}

Future<AuthResponse> signInUser(SignInRequest request) async {
  final response = await requestSignIn(request.email, request.password);
  return response;
}
