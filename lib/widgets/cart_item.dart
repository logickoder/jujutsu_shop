import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart.dart' as model;
import '../models/cart.dart';

class CartItem extends StatelessWidget {
  final model.CartItem item;
  final String productId;

  const CartItem({required this.item, required this.productId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: ValueKey(productId),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        padding: const EdgeInsets.only(right: 15),
        color: theme.colorScheme.error,
        child: Icon(
          Icons.delete,
          color: theme.colorScheme.onError,
        ),
      ),
      confirmDismiss: (_) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text(
              'Do you want to remove the item from the cart',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(true);
                },
                child: const Text('Yes'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: const Text('No'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 15,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: theme.colorScheme.primary,
              child: FittedBox(
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Text('\$${item.price}',
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                      )),
                ),
              ),
            ),
            title: Text(item.title),
            subtitle: Text('Total: \$${(item.price * item.quantity)}'),
            trailing: Text('${item.quantity} x'),
          ),
        ),
      ),
    );
  }
}
