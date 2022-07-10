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

  void addProduct() {
    debugPrint('Tried to add item');
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
