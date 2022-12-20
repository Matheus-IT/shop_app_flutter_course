import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter_course/controllers/orders_controller.dart';
import 'package:shop_app_flutter_course/providers/orders.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Your cart'),
        ),
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total: ', style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      width: 10,
                    ),
                    Chip(
                      label: Text(
                        'R\$ ${cart.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        OrdersController.handleNewOrder(
                          context,
                          cartItemsList: cart.items.values.toList(),
                          totalAmount: cart.totalAmount,
                          clearCart: cart.clear,
                        ).then((_) {
                          print('handleNewOrder finished!');
                        });

                        // .onError<FailedToToggleAsFavorite>((error, stackTrace) {
                        //   presentWarningFailToggleFavorites(context);
                        // }).whenComplete(() {
                        //   // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                        //   product.notifyListeners();
                        // });
                      },
                      child: Text(
                        'Order now',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cart.itemCount,
                itemBuilder: (ctx, index) {
                  final cartItem = cart.items.values.toList()[index];

                  return CartItem(
                    id: cartItem.id,
                    productId: cart.items.keys.toList()[index], // productId
                    price: cartItem.price,
                    title: cartItem.title,
                    quantity: cartItem.quantity,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
