import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter_course/controllers/orders_controller.dart';
import 'package:shop_app_flutter_course/exceptions/orders_exceptions.dart';
import 'package:shop_app_flutter_course/widgets/loading_presenters/loading_feedback_indicator.dart';
import 'package:shop_app_flutter_course/widgets/notice_presenters/no_orders_notice.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

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
