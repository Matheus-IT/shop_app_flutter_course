import 'package:flutter/widgets.dart';
import '../forms_payloads/auth_form_payload.dart';
import '../../../../adapters/controllers/auth_controller.dart';

class SignInFormHandler {
  final GlobalKey<FormState> _formKey;
  final BuildContext context;

  SignInFormHandler(this._formKey, this.context);

  Future<void> handle(AuthFormPayload payload) async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState!.save();

    AuthController.handleUserSignIn(
      context,
      email: payload.email,
      password: payload.password,
    ).then((_) => print('user just signed in!!!'));
  }
}
