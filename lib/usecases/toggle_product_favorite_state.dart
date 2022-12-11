import 'package:shop_app_flutter_course/exceptions/products_exceptions.dart';
import 'package:shop_app_flutter_course/external/firebase_operations/request_patch_product_firebase.dart';
import 'package:shop_app_flutter_course/providers/product.dart';

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
