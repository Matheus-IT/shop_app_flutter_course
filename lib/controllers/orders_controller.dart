import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter_course/providers/cart.dart';
import 'package:shop_app_flutter_course/providers/orders.dart';

class OrdersController {
  static handleNewOrder(
    BuildContext context, {
    required List<CartItem> cartItemsList,
    required double totalAmount,
    required Function() clearCart,
  }) {
    final ordersProvider = Provider.of<Orders>(context, listen: false);
    // add persistence here
    ordersProvider.addOrder(
      cartItemsList,
      totalAmount,
    );
    clearCart();
  }
}
