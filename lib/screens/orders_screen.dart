import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your orders')),
      body: ListView.builder(
        itemCount: orders.orderItems.length,
        itemBuilder: (ctx, index) => OrderItem(
          order: orders.orderItems[index],
        ),
      ),
    );
  }
}
