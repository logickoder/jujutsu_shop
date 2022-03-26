import 'package:flutter/material.dart';

import '../utils/strings.dart';
import '../widgets/products_grid.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
      ),
      body: const SafeArea(
        child: ProductsGrid(),
      ),
    );
  }
}
