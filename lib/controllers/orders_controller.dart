import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter_course/external/firebase_operations/request_add_order.dart';
import 'package:shop_app_flutter_course/providers/cart.dart';
import 'package:shop_app_flutter_course/providers/orders.dart';

class OrdersController {
  static Future<void> handleNewOrder(
    BuildContext context, {
    required List<CartItem> cartItemsList,
    required double totalAmount,
    required Function() clearCart,
  }) async {
    final ordersProvider = Provider.of<Orders>(context, listen: false);

    final response = await requestAddOrderFirebase(cartItemsList, totalAmount);

    ordersProvider.addOrder(
      cartItemsList,
      totalAmount,
      response.timestamp,
      response.identifier,
    );

    clearCart();
  }
}
