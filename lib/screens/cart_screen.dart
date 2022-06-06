import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order.dart';
import '../utils/strings.dart';
import '../models/cart.dart' show Cart;
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const route = "/cart";

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(yourCart),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(total, style: TextStyle(fontSize: 20)),
                    const Spacer(),
                    Chip(
                      label: Text(
                        "\$${cart.total}",
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<Orders>(
                          context,
                          listen: false,
                        ).addOrder(
                          cart.items.values.toList(),
                          cart.total,
                        );
                        cart.clear();
                      },
                      child: Text(orderNow.toUpperCase()),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (_, i) => CartItem(
                  item: cart.items.values.toList()[i],
                  productId: cart.items.keys.toList()[i],
                ),
                itemCount: cart.items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
