import 'package:flutter/widgets.dart';
import '../authentication/auth_response.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;
  DateTime? _expireDate;
  String? _userId;

  String? get userId => _userId;

  bool get isAuthenticated {
    return token != null;
  }

  String? get token {
    if (_tokenIsStillValid()) {
      return _token;
    }
    return null;
  }

  bool _tokenIsStillValid() {
    return _expireDate?.isAfter(DateTime.now()) ?? false;
  }

  void receive(AuthResponse authResponse) {
    _token = authResponse.token;
    _expireDate = authResponse.expiryDate;
    _userId = authResponse.userId;
    notifyListeners();
  }
}
