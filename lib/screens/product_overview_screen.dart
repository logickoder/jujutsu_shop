import 'package:flutter/material.dart';

import '../utils/strings.dart';
import '../widgets/products_grid.dart';

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
      body: SafeArea(
        child: ProductsGrid(_showFavorites),
      ),
    );
  }
}
