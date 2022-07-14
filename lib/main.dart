import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter_course/providers/orders.dart';

import 'app_routes.dart';
import 'providers/cart.dart';
import 'providers/products.dart';
import 'screens/cart_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider<Cart>(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider<Orders>(
          create: (_) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Shop App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
          ),
          accentColor: Colors.deepOrange,
          primaryColor: Colors.purple,
          fontFamily: 'Lato',
        ),
        home: const ProductsOverviewScreen(),
        routes: {
          AppRoutes.productsOverview: (context) =>
              const ProductsOverviewScreen(),
          AppRoutes.productDetail: (context) => const ProductDetailScreen(),
          AppRoutes.cart: (context) => const CartScreen(),
        },
      ),
    );
  }
}
