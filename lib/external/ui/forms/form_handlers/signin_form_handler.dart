import 'package:flutter/widgets.dart';
import 'package:shop_app_flutter_course/exceptions/auth_exceptions.dart';
import 'package:shop_app_flutter_course/external/ui/warning_presenters/present_warning_dialog.dart';
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

    try {
      await AuthController.handleUserSignIn(
        context,
        email: payload.email,
        password: payload.password,
      );

      print('user just signed in!!!');
    } on NonExistingEmail catch (_) {
      presentWarningDialog(
        context: context,
        content: 'The provided email does not exist',
      );
    } on WrongPassword catch (_) {
      presentWarningDialog(
        context: context,
        title: 'Wrong password',
        content: 'The provided password is wrong',
      );
    }
  }
}
