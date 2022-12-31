import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../../external/providers/auth_provider.dart';
import '../../usecases/signup_user.dart';

class AuthController {
  static Future<void> handleUserSignUp(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    signupUser(SignUpRequest(email, password));
  }
}
