import 'package:flutter/material.dart';
import 'package:shop_app_flutter_course/providers/product_provider.dart';

import '../dummy_data.dart';

class ProductsProvider with ChangeNotifier {
  final List<ProductProvider> _items = dummyData;

  List<ProductProvider> get items => [..._items];

  void addProduct() {
    // _items.add();
    print('Tried to add item');
    notifyListeners();
  }

  ProductProvider findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }
}
