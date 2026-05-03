import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get totalAmount {
    return _items.fold(0, (sum, item) => sum + (item.product.price * item.quantity));
  }

  void addItem(Product product, String size, String color) {
    final existingIndex = _items.indexWhere((item) => item.product.id == product.id && item.selectedSize == size && item.selectedColor == color);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(product: product, selectedSize: size, selectedColor: color));
    }
    notifyListeners();
  }

  void removeItem(String productId, String size, String color) {
    _items.removeWhere((item) => item.product.id == productId && item.selectedSize == size && item.selectedColor == color);
    notifyListeners();
  }

  void updateQuantity(String productId, int newQuantity, String size, String color) {
    final index = _items.indexWhere((item) => item.product.id == productId && item.selectedSize == size && item.selectedColor == color);
    if (index >= 0 && newQuantity > 0) {
      _items[index].quantity = newQuantity;
      notifyListeners();
    }
  }

  void clearCart() {
    _items = [];
    notifyListeners();
  }
}