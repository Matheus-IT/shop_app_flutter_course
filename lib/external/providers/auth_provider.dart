import 'package:flutter/widgets.dart';
import '../firebase_operations/request_signup.dart';

class AuthProvider extends ChangeNotifier {
  late String _token;
  late DateTime _expireDate;
  late String _userId;
}
