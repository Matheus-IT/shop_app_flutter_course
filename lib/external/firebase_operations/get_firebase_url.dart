import 'package:flutter_dotenv/flutter_dotenv.dart';

String getFirebaseUrl() {
  return dotenv.env['FIREBASE_URL']!;
}
