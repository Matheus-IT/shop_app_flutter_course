import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../usecases/toggle_product_favorite_state.dart';

class ProductsController {
  static Future<bool> handleToggleFavoriteState(String productId, BuildContext context) async {
    final productsProvider = Provider.of<Products>(context, listen: false);
    final product = productsProvider.findById(productId);

    final newFavoriteState = await toggleProductFavoriteState(product);
    return newFavoriteState;
  }
}
