import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter_course/app_routes.dart';
import 'package:shop_app_flutter_course/providers/products_provider.dart';
import 'package:shop_app_flutter_course/widgets/app_drawer.dart';
import 'package:shop_app_flutter_course/widgets/product_management_item.dart';

class ProductsManagementScreen extends StatelessWidget {
  const ProductsManagementScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductProvider>(context, listen: false).fetchAllProductsFromRemoteDatasource();
  }

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.editProduct);
            },
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemBuilder: (_, index) => ProductManagementItem(
              id: productsProvider.items[index].id,
              title: productsProvider.items[index].title,
              imageURL: productsProvider.items[index].imageUrl,
            ),
            itemCount: productsProvider.items.length,
          ),
        ),
      )),
    );
  }
}
