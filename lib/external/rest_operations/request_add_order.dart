import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/cart.dart';
import './urls/get_firebase_url.dart';

Future<AddOrderResponse> requestAddOrderFirebase(
  List<Cart> cartItemsList,
  double totalAmount,
  String userId,
  String authToken,
) async {
  final firebaseUrl = getFirebaseUrl();
  final url = Uri.parse('$firebaseUrl/orders/$userId.json?auth=$authToken');

  final timestamp = DateTime.now();

  final response = await http.post(
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

  final identifier = json.decode(response.body)['name'];

  return AddOrderResponse(timestamp, identifier);
}

class AddOrderResponse {
  final DateTime timestamp;
  final String identifier;

  AddOrderResponse(this.timestamp, this.identifier);
}
