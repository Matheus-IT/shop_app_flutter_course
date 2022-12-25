import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'providers/orders_provider.dart';
import '../screens/edit_product_screen.dart';
import '../screens/orders_screen.dart';
import '../screens/products_management_screen.dart';
import './app_routes.dart';
import 'providers/cart_provider.dart';
import 'providers/products_provider.dart';
import './screens/cart_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';

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
          AppRoutes.productsOverview: (context) => const ProductsOverviewScreen(),
          AppRoutes.productDetail: (context) => const ProductDetailScreen(),
          AppRoutes.cart: (context) => const CartScreen(),
          AppRoutes.orders: (context) => const OrdersScreen(),
          AppRoutes.managementScreen: (context) => const ProductsManagementScreen(),
          AppRoutes.editProduct: (context) => const EditProductScreen(),
        },
      ),
    );
  }
}
