import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'cart_item.dart';

/// Enum representing the stages of order fulfillment.
enum OrderStatus { processing, shipped, outForDelivery, delivered }

/// Model for a placed order.
class Order {
  final String id;
  final List<CartItem> items;
  final double total;
  final OrderStatus status;
  final DateTime date;
  final String address;
  final String phone;
  final String paymentMethod;

  Order({
    required this.id,
    required this.items,
    required this.total,
    this.status = OrderStatus.processing,
    required this.date,
    this.address = '',
    this.phone = '',
    this.paymentMethod = 'Cash on Delivery',
  });

  /// Human-readable label for the order status.
  String get statusLabel {
    switch (status) {
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.outForDelivery:
        return 'Out for Delivery';
      case OrderStatus.delivered:
        return 'Delivered';
    }
  }

  /// Converts the OrderStatus enum to a string for Firestore.
  static String _statusToString(OrderStatus status) {
    switch (status) {
      case OrderStatus.processing:
        return 'processing';
      case OrderStatus.shipped:
        return 'shipped';
      case OrderStatus.outForDelivery:
        return 'outForDelivery';
      case OrderStatus.delivered:
        return 'delivered';
    }
  }

  /// Converts a Firestore string back to an OrderStatus enum.
  static OrderStatus _statusFromString(String s) {
    switch (s) {
      case 'shipped':
        return OrderStatus.shipped;
      case 'outForDelivery':
        return OrderStatus.outForDelivery;
      case 'delivered':
        return OrderStatus.delivered;
      default:
        return OrderStatus.processing;
    }
  }

  /// Converts this order to a Firestore-compatible map.
  Map<String, dynamic> toMap() {
    return {
      'items': items.map((item) => item.toMap()).toList(),
      'total': total,
      'status': _statusToString(status),
      'date': Timestamp.fromDate(date),
      'address': address,
      'phone': phone,
      'paymentMethod': paymentMethod,
    };
  }

  /// Creates an Order from a Firestore document snapshot.
  factory Order.fromMap(Map<String, dynamic> map, String docId) {
    return Order(
      id: docId,
      items: (map['items'] as List<dynamic>? ?? [])
          .map((item) => CartItem.fromMap(Map<String, dynamic>.from(item)))
          .toList(),
      total: (map['total'] ?? 0).toDouble(),
      status: _statusFromString(map['status'] ?? 'processing'),
      date: (map['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      address: map['address'] ?? '',
      phone: map['phone'] ?? '',
      paymentMethod: map['paymentMethod'] ?? 'Cash on Delivery',
    );
  }
}
