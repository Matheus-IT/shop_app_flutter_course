import 'package:shop_app_flutter_course/external/ui/screens/auth_screen.dart';

import '../ui/screens/cart_screen.dart';
import '../ui/screens/edit_product_screen.dart';
import '../ui/screens/orders_screen.dart';
import '../ui/screens/product_detail_screen.dart';
import '../ui/screens/products_management_screen.dart';
import '../ui/screens/products_overview_screen.dart';

import './app_routes.dart';

class NavigationMapper {
  static getMappedRoutes() => {
        AppRoutes.auth: (context) => const AuthScreen(),
        AppRoutes.productsOverview: (context) => const ProductsOverviewScreen(),
        AppRoutes.productDetail: (context) => const ProductDetailScreen(),
        AppRoutes.cart: (context) => const CartScreen(),
        AppRoutes.orders: (context) => const OrdersScreen(),
        AppRoutes.managementScreen: (context) => const ProductsManagementScreen(),
        AppRoutes.editProduct: (context) => const EditProductScreen(),
      };
}
