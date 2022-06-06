import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/order.dart' show Orders;
import '../utils/strings.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const route = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(yourOrders),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: ListView.builder(
          itemBuilder: (_, i) => OrderItem(data.orders[i]),
          itemCount: data.orders.length,
        ),
      ),
    );
  }
}
