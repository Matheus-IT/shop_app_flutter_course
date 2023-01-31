import 'package:shop_app_flutter_course/external/rest_operations/request_patch_is_favorite_status.dart';

import '../domain/entities/product.dart';
import '../exceptions/products_exceptions.dart';

Future<bool> toggleProductFavoriteState(Product product, String? userId, String authToken) async {
  if (userId == null) {
    throw FailedToToggleAsFavorite();
  }

  final backupFavoriteState = product.isFavorite;

  product.toggleFavoriteStatus();
  final newFavoriteState = product.isFavorite;

  final response = await requestPutIsFavoriteStatus(product.id, userId, authToken, {'isFavorite': newFavoriteState});

  if (response.statusCode >= 400 && response.statusCode < 500) {
    product.isFavorite = backupFavoriteState;
    throw FailedToToggleAsFavorite();
  }

  return newFavoriteState;
}
