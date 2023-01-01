import '../external/firebase_operations/request_signin.dart';

class SignInRequest {
  final String email;
  final String password;
  const SignInRequest(this.email, this.password);
}

Future<void> signInUser(SignInRequest request) async {
  final response = await requestSignIn(request.email, request.password);
}
