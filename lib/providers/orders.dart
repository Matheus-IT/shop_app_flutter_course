import 'package:flutter/material.dart';
import 'package:shop_app_flutter_course/providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orderItems {
    return [..._orders];
  }

  void addOrder(
    List<CartItem> cartProducts,
    double total,
    DateTime dateTime,
    String identifier,
  ) {
    _orders.insert(
      0,
      OrderItem(
        id: identifier,
        amount: total,
        products: cartProducts,
        dateTime: dateTime,
      ),
    );
    notifyListeners();
  }

  void updateItemsList(List<OrderItem> orders) {
    _orders.clear();
    _orders.addAll(orders);
    notifyListeners();
  }
}
