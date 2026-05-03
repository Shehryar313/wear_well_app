import 'package:flutter/foundation.dart';
import '../models/order.dart';
import '../models/cart_item.dart';

/// Manages placed orders using ChangeNotifier (Provider pattern).
class OrderProvider with ChangeNotifier {
  final List<Order> _orders = [];

  /// All orders, newest first.
  List<Order> get orders => _orders;

  /// Creates a new order from the current cart items and adds it to history.
  void placeOrder(List<CartItem> items, double total, String address) {
    _orders.insert(
      0,
      Order(
        id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
        items: List.from(items),
        total: total,
        date: DateTime.now(),
        address: address,
      ),
    );
    notifyListeners();
  }
}
