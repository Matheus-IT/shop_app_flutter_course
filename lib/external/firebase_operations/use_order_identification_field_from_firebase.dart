import 'package:shop_app_flutter_course/providers/orders.dart';

OrderItem useOrderIdentificationFieldFromFirebase({required OrderItem newOrder, required Map responseBody}) {
  // getting the identification, in this case 'name', generated from firebase
  return OrderItem(
    id: responseBody['name'],
    amount: newOrder.amount,
    dateTime: newOrder.dateTime,
    products: newOrder.products,
  );
}
