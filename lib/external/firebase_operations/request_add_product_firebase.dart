import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop_app_flutter_course/external/firebase_operations/use_identification_field_from_firebase.dart';
import 'package:shop_app_flutter_course/providers/product.dart';
import 'dart:convert';

Future<void> requestAddProductFirebase(Product newProduct) async {
  final firebaseUrl = dotenv.env['FIREBASE_URL'];
  final url = Uri.parse('$firebaseUrl/products.json');

  final response = await http.post(
    url,
    body: json.encode({
      'title': newProduct.title,
      'description': newProduct.description,
      'imageUrl': newProduct.imageUrl,
      'price': newProduct.price,
      'isFavorite': newProduct.isFavorite,
    }),
  );

  newProduct = useIdentificationFieldFromFirebase(
    newProduct: newProduct,
    responseBody: json.decode(response.body),
  );
}
