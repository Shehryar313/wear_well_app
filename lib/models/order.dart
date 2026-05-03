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

  Order({
    required this.id,
    required this.items,
    required this.total,
    this.status = OrderStatus.processing,
    required this.date,
    this.address = '',
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
}
