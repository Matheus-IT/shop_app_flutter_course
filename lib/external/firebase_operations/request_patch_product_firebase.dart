import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shop_app_flutter_course/external/firebase_operations/get_firebase_url.dart';

Future<void> requestPatchProductFirebase(String productId, Map<String, dynamic> attrs) async {
  final firebaseUrl = getFirebaseUrl();
  final url = Uri.parse('$firebaseUrl/products/$productId.json');

  await http.patch(
    url,
    body: json.encode(attrs),
  );
}
