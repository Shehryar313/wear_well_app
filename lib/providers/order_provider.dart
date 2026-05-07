import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart' hide Order;
import '../models/order.dart';
import '../models/cart_item.dart';

/// Manages placed orders using ChangeNotifier (Provider pattern).
/// Orders are persisted to Firestore under `users/{userId}/orders`.
class OrderProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final List<Order> _orders = [];
  String? _userId;

  /// All orders, newest first.
  List<Order> get orders => _orders;

  /// Sets the current user ID and loads their orders from Firestore.
  Future<void> setUser(String userId) async {
    _userId = userId;
    await loadOrders();
  }

  /// Clears orders when user logs out.
  void clearUser() {
    _userId = null;
    _orders.clear();
    notifyListeners();
  }

  /// Loads all orders for the current user from Firestore.
  Future<void> loadOrders() async {
    if (_userId == null) return;

    try {
      final snapshot = await _db
          .collection('users')
          .doc(_userId)
          .collection('orders')
          .orderBy('date', descending: true)
          .get();

      _orders.clear();
      for (final doc in snapshot.docs) {
        _orders.add(Order.fromMap(doc.data(), doc.id));
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading orders: $e');
    }
  }

  /// Creates a new order from the current cart items and saves it to Firestore.
  Future<void> placeOrder(
    List<CartItem> items,
    double total,
    String address, {
    String phone = '',
    String paymentMethod = 'Cash on Delivery',
  }) async {
    final order = Order(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch}',
      items: List.from(items),
      total: total,
      date: DateTime.now(),
      address: address,
      phone: phone,
      paymentMethod: paymentMethod,
    );

    // Add locally first for instant UI update
    _orders.insert(0, order);
    notifyListeners();

    // Persist to Firestore
    if (_userId != null) {
      try {
        await _db
            .collection('users')
            .doc(_userId)
            .collection('orders')
            .doc(order.id)
            .set(order.toMap());
      } catch (e) {
        debugPrint('Error saving order to Firestore: $e');
      }
    }
  }
}
