import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app_flutter_course/external/exceptions/products_related_exceptions.dart';

Future<Map<String, dynamic>> requestAllProductsFromFirebase() async {
  try {
    final firebaseUrl = dotenv.env['FIREBASE_URL'];
    final url = Uri.parse('$firebaseUrl/products.json');

    final response = await http.get(url);

    if (response.statusCode == 200 && response.body == 'null') {
      throw NoProductsToFetch('No products available to fetch');
    }

    return json.decode(response.body) as Map<String, dynamic>;
  } catch (error) {
    rethrow;
  }
}
