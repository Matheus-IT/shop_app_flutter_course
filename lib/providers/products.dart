import 'package:flutter/material.dart';
import 'package:shop_app_flutter_course/providers/product.dart';

import '../dummy_data.dart';

class Products with ChangeNotifier {
  final List<Product> _items = dummyData;

  List<Product> get items => [..._items];

  void addProduct() {
    // _items.add();
    print('Tried to add item');
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
