import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final Product _product;

  const UserProductItem(this._product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: Text(_product.title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_product.imageUrl),
      ),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.route, arguments: _product);
              },
              icon: Icon(
                Icons.edit,
                color: theme.colorScheme.primary,
              ),
            ),
            Consumer<Products>(
              builder: (_, products, __) => IconButton(
                onPressed: () {
                  products.delete(_product.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: theme.colorScheme.error,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
