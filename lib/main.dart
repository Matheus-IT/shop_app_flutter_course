import 'package:flutter/material.dart';
import 'package:shop_app_flutter_course/app_routes.dart';
import 'package:shop_app_flutter_course/screens/product_detail_screen.dart';
import 'package:shop_app_flutter_course/screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shop App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
        ),
        accentColor: Colors.deepOrange,
        fontFamily: 'Lato',
      ),
      home: const ProductsOverviewScreen(),
      routes: {
        AppRoutes.productsOverview: (context) => ProductsOverviewScreen(),
        AppRoutes.productDetail: (context) => ProductDetailScreen(),
      },
    );
  }
}
