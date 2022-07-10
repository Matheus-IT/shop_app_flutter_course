import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/products_grid.dart';

enum OptionsFilter {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatelessWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (OptionsFilter value) {
              if (value == OptionsFilter.Favorites) {
                products.setShowFavoritesOnly();
              } else {
                products.setShowAll();
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                  child: Text('Only favorites'),
                  value: OptionsFilter.Favorites),
              PopupMenuItem(child: Text('Show all'), value: OptionsFilter.All),
            ],
          ),
        ],
      ),
      body: const ProductsGrid(),
    );
  }
}
