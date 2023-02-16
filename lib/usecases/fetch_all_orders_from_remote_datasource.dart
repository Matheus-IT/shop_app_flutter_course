import '../domain/entities/order.dart';
import '../external/rest_operations/request_all_orders.dart';

Future<List<Order>> fetchAllOrdersFromRemoteDatasource(String userId, String authToken) async {
  final List<Order> loadedOrders = [];

  final response = await requestAllOrdersFromFirebase(userId, authToken);

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
