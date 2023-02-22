import 'package:flutter/widgets.dart';
import 'package:shop_app_flutter_course/external/providers/auth_provider.dart';
import 'package:shop_app_flutter_course/external/ui/screens/splash_screen.dart';
import 'package:shop_app_flutter_course/usecases/signin_user.dart';
import '../ui/screens/auth_screen.dart';
import '../ui/screens/products_overview_screen.dart';

class HomeScreenController {
  static Widget getHomeScreen(AuthProvider authProvider) {
    final userIsStillAuthenticated = authProvider.isAuthenticated;
    // if (userIsStillAuthenticated) {
    //   return const ProductsOverviewScreen();
    // }
    // return FutureBuilder(
    //   future: tryAutoLogin(authProvider),
    //   builder: (ctx, snapshot) =>
    //       snapshot.connectionState == ConnectionState.waiting ? SplashScreen() : const AuthScreen(),
    // );

    if (userIsStillAuthenticated) {
      return const ProductsOverviewScreen();
    }
    return const AuthScreen();
  }
}
