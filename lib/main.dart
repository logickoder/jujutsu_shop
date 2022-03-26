import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './utils/strings.dart';
import './screens/product_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './models/products_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
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
        },
      ),
    );
  }
}
