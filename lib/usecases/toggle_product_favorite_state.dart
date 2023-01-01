import '../domain/entities/product.dart';
import '../exceptions/products_exceptions.dart';
import '../external/rest_operations/request_patch_product.dart';

Future<bool> toggleProductFavoriteState(Product product) async {
  bool favoriteStateBackup = product.isFavorite;
  product.toggleFavoriteStatus();
  bool newFavoriteState = product.isFavorite;

  final response = await requestPatchProductFirebase(product.id, {'isFavorite': newFavoriteState});

  if (response.statusCode >= 400 && response.statusCode < 500) {
    product.isFavorite = favoriteStateBackup;
    throw FailedToToggleAsFavorite();
  }

  return newFavoriteState;
}
