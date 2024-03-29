import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import './firebase_adapters/use_product_identification_field_from_firebase.dart';
import '../../domain/entities/product.dart';

Future<void> requestAddProductFirebase(Product newProduct, String userId, String authToken) async {
  final firebaseUrl = dotenv.env['FIREBASE_URL'];
  final url = Uri.parse('$firebaseUrl/products.json?auth=$authToken');

  final response = await http.post(
    url,
    body: json.encode({
      'title': newProduct.title,
      'description': newProduct.description,
      'imageUrl': newProduct.imageUrl,
      'price': newProduct.price,
      'creatorId': userId,
    }),
  );

  newProduct = useProductIdentificationFieldFromFirebase(
    newProduct: newProduct,
    responseBody: json.decode(response.body),
  );
}
