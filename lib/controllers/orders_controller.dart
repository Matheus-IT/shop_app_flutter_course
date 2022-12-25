import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../domain/entities/cart.dart';
import '../external/firebase_operations/request_add_order.dart';
import '../providers/orders_provider.dart';
import '../usecases/fetch_all_orders_from_remote_datasource.dart';

class OrdersController {
  static Future<void> handleNewOrder(
    BuildContext context, {
    required List<Cart> cartItemsList,
    required double totalAmount,
    required Function() clearCart,
  }) async {
    final ordersProvider = Provider.of<OrderProvider>(context, listen: false);

    final response = await requestAddOrderFirebase(cartItemsList, totalAmount);

    ordersProvider.addOrder(
      cartItemsList,
      totalAmount,
      response.timestamp,
      response.identifier,
    );

    clearCart();
  }

  static Future<void> handleFetchAllOrders(BuildContext context) async {
    final ordersProvider = Provider.of<OrderProvider>(context);

    final orders = await fetchAllOrdersFromRemoteDatasource();

    ordersProvider.updateItemsList(orders);
  }
}
