import '../domain/entities/product.dart';
import '../external/rest_operations/request_all_products.dart';

Future<List<Product>> fetchAllProductsFromRemoteDatasource(String? authToken) async {
  final List<Product> loadedProducts = [];
  final response = await requestAllProductsFromFirebase(authToken);

  response.forEach((key, prodData) {
    loadedProducts.add(Product(
      id: key,
      title: prodData['title'],
      description: prodData['description'],
      price: prodData['price'],
      isFavorite: prodData['isFavorite'],
      imageUrl: prodData['imageUrl'],
    ));
  });

  return loadedProducts;
}
