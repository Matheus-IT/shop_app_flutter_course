import 'package:flutter_dotenv/flutter_dotenv.dart';

Uri getSignUpUrl() {
  final apiKey = dotenv.env['API_KEY']!;
  return Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$apiKey');
}
