import 'package:shop_app_flutter_course/external/firebase_operations/request_all_orders_firebase.dart';
import 'package:shop_app_flutter_course/providers/orders.dart';

Future<List<OrderItem>> fetchAllOrdersFromRemoteDatasource() async {
  final List<OrderItem> loadedOrders = [];

  final response = await requestAllOrdersFromFirebase();

  response.forEach((key, orderData) {
    loadedOrders.add(OrderItem(
      id: orderData.name,
      amount: orderData.amount,
      dateTime: orderData.dateTime,
      products: orderData.products,
    ));
  });

  return loadedOrders;
}
