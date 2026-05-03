import 'package:flutter/foundation.dart';
import '../models/product.dart';

/// Manages the user's wishlist using ChangeNotifier (Provider pattern).
class WishlistProvider with ChangeNotifier {
  final List<Product> _items = [];

  /// All wishlisted products.
  List<Product> get items => _items;

  /// Checks whether a product is already in the wishlist.
  bool isWishlisted(String productId) {
    return _items.any((p) => p.id == productId);
  }

  /// Toggles a product in/out of the wishlist.
  void toggleWishlist(Product product) {
    if (isWishlisted(product.id)) {
      _items.removeWhere((p) => p.id == product.id);
    } else {
      _items.add(product);
    }
    notifyListeners();
  }
}
