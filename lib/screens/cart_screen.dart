import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/buttons/order_now_button.dart';
import '../providers/cart_provider.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

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
                    OrderNowButton(cart: cart),
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
