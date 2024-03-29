import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../external/ui/warning_presenters/present_warning_auth_expired.dart';
import '../../exceptions/auth_exceptions.dart';
import '../../external/providers/auth_provider.dart';
import '../../exceptions/products_exceptions.dart';
import '../../external/ui/warning_presenters/present_warning_no_products.dart';
import '../../usecases/fetch_all_products_from_remote_datasource.dart';
import '../../external/providers/products_provider.dart';
import '../../usecases/toggle_product_favorite_state.dart';

class ProductsController {
  static Future<bool> handleToggleFavoriteState(String productId, BuildContext context) async {
    final productsProvider = Provider.of<ProductProvider>(context, listen: false);
    final product = productsProvider.findById(productId);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userId = authProvider.userId;
    final authToken = authProvider.token;

    final newFavoriteState = await toggleProductFavoriteState(product, userId, authToken!);
    return newFavoriteState;
  }

  static Future<void> handleFetchAllFromRemoteDataSource(BuildContext context) async {
    try {
      final productsProvider = Provider.of<ProductProvider>(context);
      final authProvider = Provider.of<AuthProvider>(context);

      if (authProvider.token == null || authProvider.userId == null) {
        throw AuthTokenExpired();
      }

      final fetchedProducts = await fetchAllProductsFromRemoteDatasource(authProvider.token!, authProvider.userId!);

      productsProvider.updateItemsList(fetchedProducts);
    } on NoProductsToFetch catch (_) {
      presentWarningNoProducts(context);
    } on AuthTokenExpired catch (_) {
      presentWarningAuthExpired(context);
    }
  }
}
