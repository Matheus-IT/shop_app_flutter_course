import 'package:shop_app_flutter_course/external/firebase_operations/request_patch_product_firebase.dart';
import 'package:shop_app_flutter_course/providers/product.dart';

Future<bool> toggleProductFavoriteState(Product product) async {
  product.toggleFavoriteStatus();
  bool newFavoriteState = product.isFavorite;

  await requestPatchProductFirebase(product.id, {'isFavorite': newFavoriteState});

  return newFavoriteState;
}
