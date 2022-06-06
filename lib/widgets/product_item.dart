import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/product_detail_screen.dart';
import '../models/product.dart';
import '../models/cart.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(ProductDetailScreen.route, arguments: product);
          },
        ),
        footer: GridTileBar(
          leading: IconButton(
            onPressed: () {
              product.toggleFavorite();
            },
            icon: Consumer<Product>(
              builder: (_, product, __) => Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_outline,
                color: theme.colorScheme.secondary,
              ),
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black87,
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product);
              final scaffold = ScaffoldMessenger.of(context);
              scaffold.hideCurrentSnackBar();
              scaffold.showSnackBar(
                SnackBar(
                  content: const Text('Added item to cart'),
                  action: SnackBarAction(
                    label: 'Undo',
                    onPressed: () => cart.removeSingleItem(product.id),
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
            color: theme.colorScheme.secondary,
          ),
        ),
      ),
    );
  }
}
