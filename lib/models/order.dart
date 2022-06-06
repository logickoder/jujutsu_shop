import 'package:flutter/foundation.dart';
import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  const OrderItem(
      {required this.id,
      required this.amount,
      required this.products,
      required this.dateTime});
}

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> products, double amount) {
    final now = DateTime.now();
    _orders.insert(
      0,
      OrderItem(
          id: now.toString(),
          amount: amount,
          products: products,
          dateTime: now),
    );
    notifyListeners();
  }
}
