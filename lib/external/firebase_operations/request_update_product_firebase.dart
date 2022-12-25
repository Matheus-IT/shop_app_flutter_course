import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../domain/entities/product.dart';

Future<void> requestUpdateProductFromFirebase(Product newProduct) async {
  final firebaseUrl = dotenv.env['FIREBASE_URL'];
  final url = Uri.parse('$firebaseUrl/products/${newProduct.id}.json');

  await http.patch(
    url,
    body: json.encode({
      'title': newProduct.title,
      'description': newProduct.description,
      'imageUrl': newProduct.imageUrl,
      'price': newProduct.price,
    }),
  );
}
