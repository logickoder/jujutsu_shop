import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../utils/strings.dart';
import '../widgets/app_drawer.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../screens/cart_screen.dart';

enum FilterOptions {
  favorites,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              child: child!,
              value: cart.count.toString(),
            ),
            child: IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.route),
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions value) => setState(() {
              _showFavorites = value == FilterOptions.favorites;
            }),
            itemBuilder: (_) => const [
              PopupMenuItem(
                child: Text(onlyFavorites),
                value: FilterOptions.favorites,
              ),
              PopupMenuItem(
                child: Text(showAll),
                value: FilterOptions.all,
              ),
            ],
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: ProductsGrid(_showFavorites),
      ),
    );
  }
}
