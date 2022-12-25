import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../exceptions/products_exceptions.dart';
import '../providers/products_provider.dart';
import '../widgets/warningPresenters.dart/present_warning_no_products.dart';
import '../app_routes.dart';
import '../providers/cart_provider.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum OptionsFilter {
  favorites,
  all,
}

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;
  bool _isTheFirstTime = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isTheFirstTime) {
      performInitializationOfScreenDependencies();
    }
  }

  void performInitializationOfScreenDependencies() {
    setState(() => _isLoading = true);

    final productsProvider = Provider.of<ProductProvider>(context);

    productsProvider.fetchAllProductsFromRemoteDatasource().then((fetchedProducts) {
      productsProvider.updateItemsList(fetchedProducts);
    }).onError<NoProductsToFetch>((error, stackTrace) {
      presentWarningNoProducts(context);
    }).whenComplete(() {
      setState(() => _isLoading = false);
      _isTheFirstTime = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (OptionsFilter value) {
              setState(() {
                if (value == OptionsFilter.favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => const [
              PopupMenuItem(
                value: OptionsFilter.favorites,
                child: Text('Only favorites'),
              ),
              PopupMenuItem(
                value: OptionsFilter.all,
                child: Text('Show all'),
              ),
            ],
          ),
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              value: cart.itemCount.toString(),
              child: ch!,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cart);
              },
            ),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(onlyFavorites: _showOnlyFavorites),
    );
  }
}
