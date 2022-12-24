import 'package:flutter/material.dart';
import 'package:shop_app_flutter_course/controllers/orders_controller.dart';
import 'package:shop_app_flutter_course/providers/cart.dart';

class OrderNowButton extends StatefulWidget {
  final Cart cart;

  const OrderNowButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  State<OrderNowButton> createState() => _OrderNowButtonState();
}

class _OrderNowButtonState extends State<OrderNowButton> {
  bool isLoading = false;

  bool _shouldBlockButton() {
    return widget.cart.totalAmount == 0.0 || isLoading;
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: _shouldBlockButton()
          ? null
          : () {
              setState(() {
                isLoading = true;
              });

              OrdersController.handleNewOrder(
                context,
                cartItemsList: widget.cart.items.values.toList(),
                totalAmount: widget.cart.totalAmount,
                clearCart: widget.cart.clear,
              ).then((_) {
                setState(() {
                  isLoading = false;
                });
              }).catchError((error, stackTrace) {
                print(error);
              });
            },
      child: isLoading
          ? const CircularProgressIndicator()
          : Text(
              'Order now',
              style: TextStyle(
                color: _shouldBlockButton() ? Theme.of(context).disabledColor : Theme.of(context).primaryColor,
              ),
            ),
    );
  }
}
