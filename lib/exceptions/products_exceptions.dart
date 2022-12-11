import 'package:equatable/equatable.dart';

class NoProductsToFetch extends Equatable implements Exception {
  final String message = 'No products available to fetch';

  @override
  String toString() {
    return message;
  }

  @override
  List<Object?> get props => [message];
}

class FailedToToggleAsFavorite extends Equatable implements Exception {
  final String message = 'Failed when trying to toggle product as favorite';

  @override
  String toString() {
    return message;
  }

  @override
  List<Object?> get props => [message];
}
