import 'package:equatable/equatable.dart';

class BadRequest extends Equatable implements Exception {
  final String message = 'Bad request!';

  @override
  String toString() {
    return message;
  }

  @override
  List<Object?> get props => [message];
}
