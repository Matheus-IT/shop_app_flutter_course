import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter_course/app_routes.dart';
import 'package:shop_app_flutter_course/controllers/products_controller.dart';
import 'package:shop_app_flutter_course/providers/product.dart';
import 'package:shop_app_flutter_course/providers/cart.dart';
import 'package:shop_app_flutter_course/widgets/warningPresenters.dart/present_warning_fail_toggle_favorite.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    handlePressedFavoriteIcon(String productId, BuildContext context) {
      ProductsController.toggleFavoriteState(product.id, context).then((newFavoriteState) {
        print(newFavoriteState);
      }).catchError((error, stackTrace) {
        presentWarningFailToggleFavorites(context);
      }).whenComplete(() {
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        product.notifyListeners();
      });
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              icon: (product.isFavorite) ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
              color: Theme.of(context).accentColor,
              onPressed: () => handlePressedFavoriteIcon(product.id, context),
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: () {
              cart.addItem(product.id, product.title, product.price);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Added item to the cart!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productDetail,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
