import 'package:flutter/foundation.dart';

import './product.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get count {
    return _items.length;
  }

  double get total {
    double total = 0.0;
    _items.forEach((_, item) => total += item.price * item.quantity);
    return total;
  }

  void addItem(Product product) {
    final key = product.id;
    if (_items.containsKey(key)) {
      _items.update(
        key,
        (item) => CartItem(
          id: item.id,
          title: item.title,
          quantity: item.quantity + 1,
          price: item.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        key,
        () => CartItem(
          id: DateTime.now().toString(),
          title: product.title,
          quantity: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.quantity > 1) {
        _items.update(
          productId,
          (item) => CartItem(
              id: item.id,
              title: item.title,
              quantity: item.quantity - 1,
              price: item.price),
        );
      } else {
        _items.remove(productId);
      }
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
