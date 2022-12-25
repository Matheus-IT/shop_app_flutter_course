import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/orders_controller.dart';
import '../exceptions/orders_exceptions.dart';
import '../widgets/loading_presenters/loading_feedback_indicator.dart';
import '../widgets/notice_presenters/no_orders_notice.dart';
import '../providers/orders_provider.dart' show OrderProvider;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your orders')),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: OrdersController.handleFetchAllOrders(context),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingFeedbackIndicator();
          }

          if (snapshot.error == NoOrdersToFetch()) {
            return const NoOrdersNotice();
          }

          return ListView.builder(
            itemCount: orders.orderItems.length,
            itemBuilder: (ctx, index) => OrderItem(
              order: orders.orderItems[index],
            ),
          );
        },
      ),
    );
  }
}
