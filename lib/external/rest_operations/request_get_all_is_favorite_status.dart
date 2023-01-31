import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<http.Response> requestGetAllIsFavoriteStatus(String userId, String authToken) async {
  final firebaseUrl = dotenv.env['FIREBASE_URL'];
  final url = Uri.parse('$firebaseUrl/userFavorites/$userId.json?auth=$authToken');
  return await http.get(url);
}
