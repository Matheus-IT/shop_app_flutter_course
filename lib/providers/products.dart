import 'package:flutter/material.dart';
import 'package:shop_app_flutter_course/exceptions/http_exceptions.dart';
import 'package:shop_app_flutter_course/exceptions/products_exceptions.dart';
import 'package:shop_app_flutter_course/external/firebase_operations/request_add_product_firebase.dart';
import 'package:shop_app_flutter_course/external/firebase_operations/request_all_products_firebase.dart';
import 'package:shop_app_flutter_course/external/firebase_operations/request_delete_product_firebase.dart';
import 'package:shop_app_flutter_course/external/firebase_operations/request_update_product_firebase.dart';
import 'package:shop_app_flutter_course/providers/product.dart';

class Products with ChangeNotifier {
  final List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  Future<List<Product>> fetchAllProductsAndUpdateList() async {
    try {
      final List<Product> loadedProducts = [];
      final response = await requestAllProductsFromFirebase();

      response.forEach((key, prodData) {
        loadedProducts.add(Product(
          id: key,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
        ));
      });
      _updateItemsList(loadedProducts);
      notifyListeners();

      return loadedProducts;
    } on NoProductsToFetch catch (_) {
      rethrow;
    }
  }

  void _updateItemsList(List<Product> prods) {
    _items.clear();
    _items.addAll(prods);
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Future<void> addProduct(Product newProduct) async {
    try {
      await requestAddProductFirebase(newProduct);
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<Product> updateProductIfExists(
    String productId,
    Map<String, String> newProductData,
  ) async {
    final existingProduct = findById(productId);

    final newProduct = Product(
      id: existingProduct.id,
      title: newProductData['title']!,
      price: double.parse(newProductData['price']!),
      description: newProductData['description']!,
      imageUrl: newProductData['imageUrl']!,
      isFavorite: existingProduct.isFavorite,
    );

    await requestUpdateProductFromFirebase(newProduct);

    final index = _items.indexWhere(
      (element) => element.id == existingProduct.id,
    );

    _items[index] = newProduct;
    notifyListeners();
    return newProduct;
  }

  void deleteProductIfExists(String id) async {
    final productIndex = _items.indexWhere((product) => product.id == id);

    try {
      final response = await requestDeleteProductFromFirebase(id);

      if (response.statusCode >= 400) {
        throw BadRequest();
      }

      _items.removeAt(productIndex);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
