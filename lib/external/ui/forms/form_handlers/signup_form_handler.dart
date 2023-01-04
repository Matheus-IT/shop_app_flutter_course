import 'package:flutter/widgets.dart';

import '../forms_payloads/auth_form_payload.dart';
import '../../warning_presenters/present_warning_dialog.dart';
import '../../../../exceptions/auth_exceptions.dart';
import '../../../../adapters/controllers/auth_controller.dart';

class SignUpFormHandler {
  final GlobalKey<FormState> _formKey;
  final BuildContext context;

  SignUpFormHandler(this._formKey, this.context);

  Future<void> handle(AuthFormPayload payload) async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }

    _formKey.currentState!.save();

    try {
      await AuthController.handleUserSignUp(
        context,
        email: payload.email,
        password: payload.password,
      );
    } on ExistingEmail catch (_) {
      presentWarningDialog(
        context: context,
        content: 'The email already exists',
      );
    }
  }
}
