import '../external/firebase_operations/request_signup.dart';

class SignUpRequest {
  final String email;
  final String password;
  const SignUpRequest(this.email, this.password);
}

Future<void> signupUser(SignUpRequest request) async {
  // final url = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=<YOUR_API_KEY>');
  final response = await requestSignUp(request.email, request.password);
}
