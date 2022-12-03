import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> requestAllProductsFromFirebase() async {
  try {
    final firebaseUrl = dotenv.env['FIREBASE_URL'];
    final url = Uri.parse('$firebaseUrl/products.json');

    final response = await http.get(url);
    return json.decode(response.body) as Map<String, dynamic>;
  } catch (error) {
    print(error);
    rethrow;
  }
}
