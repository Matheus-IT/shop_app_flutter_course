import '../domain/entities/order.dart';
import '../external/firebase_operations/request_all_orders_firebase.dart';

Future<List<Order>> fetchAllOrdersFromRemoteDatasource() async {
  final List<Order> loadedOrders = [];

  final response = await requestAllOrdersFromFirebase();

  response.forEach((key, orderData) {
    loadedOrders.add(Order(
      id: orderData.name,
      amount: orderData.amount,
      dateTime: orderData.dateTime,
      products: orderData.products,
    ));
  });

  return loadedOrders;
}
