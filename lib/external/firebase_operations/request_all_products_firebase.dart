import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app_flutter_course/exceptions/products_exceptions.dart';

Future<Map<String, dynamic>> requestAllProductsFromFirebase() async {
  final firebaseUrl = dotenv.env['FIREBASE_URL'];
  final url = Uri.parse('$firebaseUrl/products.json');

  final response = await http.get(url);

  if (response.statusCode == 200 && response.body == 'null') {
    throw NoProductsToFetch();
  }

  return json.decode(response.body) as Map<String, dynamic>;
}
