import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthUrlMapper {
  final String apiKey;

  AuthUrlMapper() : apiKey = dotenv.env['API_KEY']!;

  Uri getSignInUrl() {
    return Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=$apiKey');
  }

  Uri getSignUpUrl() {
    return Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');
  }
}
