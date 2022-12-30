import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shop_app_flutter_course/external/providers/auth_provider.dart';

import './external/navigation/navigation_mapper.dart';
import './external/providers/orders_provider.dart';
import './external/providers/cart_provider.dart';
import './external/providers/products_provider.dart';
import './external/ui/screens/products_overview_screen.dart';
import './external/ui/theming/theming.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
        ChangeNotifierProvider<ProductProvider>(
          create: (_) => ProductProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (_) => CartProvider(),
        ),
        ChangeNotifierProvider<OrderProvider>(
          create: (_) => OrderProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: Theming.getAppTheme(),
        home: const ProductsOverviewScreen(),
        routes: NavigationMapper.getMappedRoutes(),
      ),
    );
  }
}
