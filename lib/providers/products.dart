import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shop_app_flutter_course/providers/product.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dummy_data.dart';

class Products with ChangeNotifier {
  final List<Product> _items = dummyData;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Future<void> addProduct(Product newProduct) {
    final firebaseUrl = dotenv.env['FIREBASE_URL'];
    final url = Uri.parse('$firebaseUrl/products.json');

    return http
        .post(url,
            body: json.encode({
              'title': newProduct.title,
              'description': newProduct.description,
              'imageUrl': newProduct.imageUrl,
              'price': newProduct.price,
              'isFavorite': newProduct.isFavorite,
            }))
        .then((response) {
      // getting the id, in this case 'name', generated from firebase
      newProduct = Product(
        id: json.decode(response.body)['name'],
        title: newProduct.title,
        description: newProduct.description,
        imageUrl: newProduct.imageUrl,
        price: newProduct.price,
        isFavorite: newProduct.isFavorite,
      );

      _items.add(newProduct);
      notifyListeners();
    });
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Product updateProductIfExists(
    String productId,
    Map<String, String> newProductData,
  ) {
    final existingProduct = findById(productId);
    final newProduct = Product(
      id: existingProduct.id,
      title: newProductData['title']!,
      price: double.parse(newProductData['price']!),
      description: newProductData['description']!,
      imageUrl: newProductData['imageUrl']!,
      isFavorite: existingProduct.isFavorite,
    );
    final index = _items.indexWhere(
      (element) => element.id == existingProduct.id,
    );
    _items[index] = newProduct;
    notifyListeners();
    return newProduct;
  }

  void deleteProductIfExists(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
