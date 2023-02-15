import 'dart:convert';

import 'package:shop_app_flutter_course/external/rest_operations/request_get_all_is_favorite_status.dart';

import '../domain/entities/product.dart';
import '../external/rest_operations/request_all_products.dart';

Future<List<Product>> fetchAllProductsFromRemoteDatasource(String? authToken, String userId) async {
  final List<Product> loadedProducts = [];
  final response = await requestAllProductsFromFirebase(authToken, userId);

  final favoriteStateResponse = await requestGetAllIsFavoriteStatus(userId, authToken!);
  final Map<String, dynamic>? favoriteStateData = json.decode(favoriteStateResponse.body);

  response.forEach((key, prodData) {
    loadedProducts.add(Product(
      id: key,
      title: prodData['title'],
      description: prodData['description'],
      price: prodData['price'],
      imageUrl: prodData['imageUrl'],
      isFavorite: favoriteStateData == null ? false : favoriteStateData[key]['isFavorite'] as bool,
    ));
  });

  return loadedProducts;
}
