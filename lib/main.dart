import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './utils/strings.dart';
import './screens/cart_screen.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';
import './models/product.dart';
import './models/order.dart';
import './models/cart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
        title: appName,
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Colors.purple,
            secondary: Colors.deepOrange,
          ),
          fontFamily: "Lato",
        ),
        routes: {
          "/": (_) => const ProductOverviewScreen(),
          ProductDetailScreen.route: (_) => const ProductDetailScreen(),
          CartScreen.route: (_) => const CartScreen(),
          OrdersScreen.route: (_) => const OrdersScreen(),
          UserProductsScreen.route: (_) => const UserProductsScreen(),
          EditProductScreen.route: (_) => const EditProductScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
