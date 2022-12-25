import 'package:flutter/material.dart';
import '../domain/entities/cart.dart';
import '../domain/entities/order.dart';

class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orderItems {
    return [..._orders];
  }

  void addOrder(
    List<Cart> cartProducts,
    double total,
    DateTime dateTime,
    String identifier,
  ) {
    _orders.insert(
      0,
      Order(
        id: identifier,
        amount: total,
        products: cartProducts,
        dateTime: dateTime,
      ),
    );
    notifyListeners();
  }

  void updateItemsList(List<Order> orders) {
    _orders.clear();
    _orders.addAll(orders);
    notifyListeners();
  }
}
