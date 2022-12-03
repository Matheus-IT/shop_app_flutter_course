import '../../providers/product.dart';

Product useIdentificationFieldFromFirebase({required Product newProduct, required Map responseBody}) {
  // getting the identification, in this case 'name', generated from firebase
  return Product(
    id: responseBody['name'],
    title: newProduct.title,
    description: newProduct.description,
    imageUrl: newProduct.imageUrl,
    price: newProduct.price,
    isFavorite: newProduct.isFavorite,
  );
}
