import 'package:equatable/equatable.dart';

class ExistingEmail extends Equatable implements Exception {
  final String message = 'The provided email already exists!';

  @override
  String toString() {
    return message;
  }

  @override
  List<Object?> get props => [message];
}

class NonExistingEmail extends Equatable implements Exception {
  final String message = 'The provided email does not exist!';

  @override
  String toString() {
    return message;
  }

  @override
  List<Object?> get props => [message];
}

class WrongPassword extends Equatable implements Exception {
  final String message = 'The provided password is incorrect!';

  @override
  String toString() {
    return message;
  }

  @override
  List<Object?> get props => [message];
}
