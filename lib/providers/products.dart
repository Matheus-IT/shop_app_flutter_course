import 'package:flutter/material.dart';
import 'package:shop_app_flutter_course/providers/product.dart';

import '../dummy_data.dart';

class Products with ChangeNotifier {
  final List<Product> _items = dummyData;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  void addProduct(Product newProduct) {
    _items.add(newProduct);
    notifyListeners();
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
