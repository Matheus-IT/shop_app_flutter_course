import 'dart:convert';
import 'package:shop_app_flutter_course/external/firebase_operations/get_firebase_url.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app_flutter_course/providers/cart.dart';

Future<DateTime> requestAddOrderFirebase(List<CartItem> cartItemsList, double totalAmount) async {
  final firebaseUrl = getFirebaseUrl();
  final url = Uri.parse('$firebaseUrl/orders.json');

  final timestamp = DateTime.now();

  await http.post(
    url,
    body: json.encode({
      'amount': totalAmount,
      'dateTime': timestamp.toIso8601String(),
      'products': cartItemsList
          .map(
            (item) => {
              'id': item.id,
              'title': item.title,
              'quantity': item.quantity,
              'price': item.price,
            },
          )
          .toList()
    }),
  );

  return timestamp;
}