import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

/// Manages the shopping cart state using ChangeNotifier (Provider pattern).
class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];

  /// All items currently in the cart.
  List<CartItem> get items => _items;

  /// Total number of individual items (accounting for quantities).
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  /// Sum of (price × quantity) for every cart item.
  double get totalAmount {
    return _items.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  /// Adds a product to the cart. If the same product+size+color already
  /// exists, increments the quantity instead.
  void addItem(Product product, String size, String color) {
    final existingIndex = _items.indexWhere(
      (item) =>
          item.product.id == product.id &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );

    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(
        CartItem(product: product, selectedSize: size, selectedColor: color),
      );
    }
    notifyListeners();
  }

  /// Removes a specific item variant from the cart.
  void removeItem(String productId, String size, String color) {
    _items.removeWhere(
      (item) =>
          item.product.id == productId &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );
    notifyListeners();
  }

  /// Updates the quantity of a specific item variant.
  void updateQuantity(
    String productId,
    int newQuantity,
    String size,
    String color,
  ) {
    final index = _items.indexWhere(
      (item) =>
          item.product.id == productId &&
          item.selectedSize == size &&
          item.selectedColor == color,
    );
    if (index >= 0 && newQuantity > 0) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  /// Empties the entire cart.
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}