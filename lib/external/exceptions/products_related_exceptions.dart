class NoProductsToFetch implements Exception {
  final String message;

  NoProductsToFetch(this.message);

  @override
  String toString() {
    return message;
  }
}
