import 'package:flutter/widgets.dart';

class AuthProvider extends ChangeNotifier {
  late String _token;
  late DateTime _expireDate;
  late String _userId;
}
