import '../../domain/entities/order.dart';

Order useOrderIdentificationFieldFromFirebase({required Order newOrder, required Map responseBody}) {
  // getting the identification, in this case 'name', generated from firebase
  return Order(
    id: responseBody['name'],
    amount: newOrder.amount,
    dateTime: newOrder.dateTime,
    products: newOrder.products,
  );
}
