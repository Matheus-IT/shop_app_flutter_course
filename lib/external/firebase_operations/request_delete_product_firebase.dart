import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<void> requestDeleteProductFromFirebase(id) async {
  final firebaseUrl = dotenv.env['FIREBASE_URL'];
  final url = Uri.parse('$firebaseUrl/products/$id.json');
  await http.delete(url);
}
