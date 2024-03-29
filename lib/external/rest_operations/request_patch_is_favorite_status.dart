import 'dart:convert';

import 'package:http/http.dart' as http;
import './urls/get_firebase_url.dart';

Future<http.Response> requestPutIsFavoriteStatus(
  String productId,
  String userId,
  String authToken,
  Map<String, dynamic> attrs,
) async {
  final firebaseUrl = getFirebaseUrl();
  final url = Uri.parse('$firebaseUrl/userFavorites/$userId/$productId.json?auth=$authToken');
  return http.put(
    url,
    body: json.encode(attrs),
  );
}
