import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter_course/usecases/signin_user.dart';
import '../../external/providers/auth_provider.dart';
import '../../usecases/signup_user.dart';

class AuthController {
  static Future<void> handleUserSignUp(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final authProvider = _getProviderWithoutListening(context);
    signUpUser(SignUpRequest(email, password));
  }

  static Future<void> handleUserSignIn(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    final authProvider = _getProviderWithoutListening(context);
    signInUser(SignInRequest(email, password));
  }

  static AuthProvider _getProviderWithoutListening(BuildContext context) {
    return Provider.of<AuthProvider>(context, listen: false);
  }
}
