import 'dart:convert';
import 'package:http/http.dart' as http;
import './urls/get_firebase_url.dart';

Future<http.Response> requestPatchProductFirebase(String productId, Map<String, dynamic> attrs) async {
  final firebaseUrl = getFirebaseUrl();
  final url = Uri.parse('$firebaseUrl/products/$productId.json');

  return await http.patch(
    url,
    body: json.encode(attrs),
  );
}
