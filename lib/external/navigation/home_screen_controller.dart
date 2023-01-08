import 'package:flutter/widgets.dart';
import '../ui/screens/auth_screen.dart';
import '../ui/screens/products_overview_screen.dart';

class HomeScreenController {
  static Widget getHomeScreen(bool userIsStillAuthenticated) {
    if (userIsStillAuthenticated) {
      return const ProductsOverviewScreen();
    }
    return const AuthScreen();
  }
}
