class BadRequest implements Exception {
  final String message;

  BadRequest(this.message);

  @override
  String toString() {
    return message;
  }
}
