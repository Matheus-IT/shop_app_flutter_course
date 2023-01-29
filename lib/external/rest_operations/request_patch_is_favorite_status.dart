import 'dart:convert';

import 'package:http/http.dart' as http;
import './urls/get_firebase_url.dart';

Future<http.Response> requestPatchIsFavoriteStatus(
  String productId,
  String userId,
  Map<String, dynamic> attrs,
) async {
  final firebaseUrl = getFirebaseUrl();
  final url = Uri.parse('$firebaseUrl/userFavorites/$userId/$productId.json');
  return http.patch(
    url,
    body: json.encode(attrs),
  );
}
