import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter_course/controllers/orders_controller.dart';
import 'package:shop_app_flutter_course/exceptions/orders_exceptions.dart';
import 'package:shop_app_flutter_course/widgets/warningPresenters.dart/present_warning_no_orders.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  bool _isTheFirstTime = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isTheFirstTime) {
      performInitializationOfScreenDependencies();
    }
  }

  void performInitializationOfScreenDependencies() {
    setState(() => _isLoading = true);

    OrdersController.handleFetchAllOrders(context).onError<NoOrdersToFetch>((error, stackTrace) {
      presentWarningNoOrders(context);
    }).whenComplete(() {
      setState(() => _isLoading = false);
      _isTheFirstTime = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your orders')),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orders.orderItems.length,
              itemBuilder: (ctx, index) => OrderItem(
                order: orders.orderItems[index],
              ),
            ),
    );
  }
}
