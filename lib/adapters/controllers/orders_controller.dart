import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter_course/external/providers/auth_provider.dart';

import '../../domain/entities/cart.dart';
import '../../external/rest_operations/request_add_order.dart';
import '../../external/providers/orders_provider.dart';
import '../../usecases/fetch_all_orders_from_remote_datasource.dart';

class OrdersController {
  static Future<void> handleNewOrder(
    BuildContext context, {
    required List<Cart> cartItemsList,
    required double totalAmount,
    required Function() clearCart,
  }) async {
    final ordersProvider = Provider.of<OrderProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.token == null) {
      print('Error: no auth token!');
      return;
    }

    final response = await requestAddOrderFirebase(
      cartItemsList,
      totalAmount,
      authProvider.userId as String,
      authProvider.token as String,
    );

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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.token == null) {
      print('Error: no auth token!');
      return;
    }

    final orders = await fetchAllOrdersFromRemoteDatasource(
      authProvider.userId as String,
      authProvider.token as String,
    );

    ordersProvider.updateItemsList(orders);
  }
}
