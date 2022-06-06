import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          const _DrawerSection(
            title: 'Shop',
            icon: Icons.shop,
            route: '/',
          ),
          const _DrawerSection(
            title: 'Orders',
            icon: Icons.payment,
            route: OrdersScreen.route,
          ),
          const _DrawerSection(
            title: 'Manage Products',
            icon: Icons.edit,
            route: UserProductsScreen.route,
          ),
        ],
      ),
    );
  }
}

class _DrawerSection extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;

  const _DrawerSection(
      {Key? key, required this.title, required this.icon, required this.route})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        ListTile(
          leading: Icon(icon),
          title: Text(title),
          onTap: () {
            Navigator.of(context).pushReplacementNamed(route);
          },
        ),
      ],
    );
  }
}
