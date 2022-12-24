import 'package:equatable/equatable.dart';

class NoOrdersToFetch extends Equatable implements Exception {
  final String message = 'No products available to fetch';

  @override
  String toString() {
    return message;
  }

  @override
  List<Object?> get props => [message];
}
