import 'package:flutter/material.dart';
import 'package:shop_app_flutter_course/external/ui/forms/form_handlers/signin_form_handler.dart';
import 'package:shop_app_flutter_course/external/ui/forms/form_handlers/signup_form_handler.dart';
import 'package:shop_app_flutter_course/external/ui/forms/forms_payloads/auth_form_payload.dart';
import 'package:shop_app_flutter_course/external/ui/forms/validators/validate_confirmation_password.dart';
import 'package:shop_app_flutter_course/external/ui/forms/validators/validate_email.dart';
import 'package:shop_app_flutter_course/external/ui/forms/validators/validate_password.dart';

enum AuthMode { signup, login }

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  AuthCardState createState() => AuthCardState();
}

class AuthCardState extends State<AuthCard> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.login;
  final Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  final _passwordController = TextEditingController();

  void _submit() {
    setState(() => _isLoading = true);

    late Future<void> formHandlerFuture;
    final payload = AuthFormPayload(_authData['email']!, _authData['password']!);

    if (_authMode == AuthMode.login) {
      formHandlerFuture = SignInFormHandler(_formKey, context).handle(payload);
    } else {
      formHandlerFuture = SignUpFormHandler(_formKey, context).handle(payload);
    }

    formHandlerFuture.then((_) {
      setState(() => _isLoading = false);
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.login) {
      setState(() => _authMode = AuthMode.signup);
    } else {
      setState(() => _authMode = AuthMode.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.signup ? 320 : 260,
        constraints: BoxConstraints(minHeight: _authMode == AuthMode.signup ? 320 : 260),
        width: deviceSize.width * 0.75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                  onSaved: (value) {
                    if (value != null) {
                      _authData['email'] = value;
                    }
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  controller: _passwordController,
                  validator: validatePassword,
                  onSaved: (value) {
                    if (value != null) {
                      _authData['password'] = value;
                    }
                  },
                ),
                if (_authMode == AuthMode.signup)
                  TextFormField(
                    enabled: _authMode == AuthMode.signup,
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: _authMode == AuthMode.signup
                        ? (value) => validateConfirmationPassword(value, _passwordController.text)
                        : null,
                  ),
                const SizedBox(height: 20),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submit,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(30),
                    // ),
                    // padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                    // color: Theme.of(context).primaryColor,
                    // textColor: Theme.of(context).primaryTextTheme.tbutton.color,
                    style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 35)),
                    child: Text(_authMode == AuthMode.login ? 'LOGIN' : 'SIGN UP'),
                  ),
                TextButton(
                  onPressed: _switchAuthMode,
                  // padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 4),
                  // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  // textColor: Theme.of(context).primaryColor,
                  child: Text('${_authMode == AuthMode.login ? 'SIGNUP' : 'LOGIN'} INSTEAD'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
