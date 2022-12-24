import 'dart:convert';

import 'package:shop_app_flutter_course/exceptions/orders_exceptions.dart';
import 'package:shop_app_flutter_course/external/firebase_operations/get_firebase_url.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> requestAllOrdersFromFirebase() async {
  final firebaseUrl = getFirebaseUrl();
  final url = Uri.parse('$firebaseUrl/products.json');

  final response = await http.get(url);

  if (response.statusCode == 200 && response.body == 'null') {
    throw NoOrdersToFetch();
  }

  return json.decode(response.body) as Map<String, dynamic>;
}
