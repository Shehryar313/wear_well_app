import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

/// Manages the user's wishlist using ChangeNotifier (Provider pattern).
/// Wishlist items are persisted to Firestore under `users/{userId}/wishlist`.
class WishlistProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final List<Product> _items = [];
  String? _userId;

  /// All wishlisted products.
  List<Product> get items => _items;

  /// Sets the current user ID and loads their wishlist from Firestore.
  Future<void> setUser(String userId) async {
    _userId = userId;
    await loadWishlist();
  }

  /// Clears wishlist when user logs out.
  void clearUser() {
    _userId = null;
    _items.clear();
    notifyListeners();
  }

  /// Loads the wishlist for the current user from Firestore.
  Future<void> loadWishlist() async {
    if (_userId == null) return;

    try {
      final snapshot = await _db
          .collection('users')
          .doc(_userId)
          .collection('wishlist')
          .get();

      _items.clear();
      for (final doc in snapshot.docs) {
        final productId = doc.id;
        // Look up the full product from the sample catalog
        try {
          final product = sampleProducts.firstWhere((p) => p.id == productId);
          _items.add(product);
        } catch (_) {
          // Product no longer in catalog — skip it
        }
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading wishlist: $e');
    }
  }

  /// Checks whether a product is already in the wishlist.
  bool isWishlisted(String productId) {
    return _items.any((p) => p.id == productId);
  }

  /// Toggles a product in/out of the wishlist and syncs to Firestore.
  void toggleWishlist(Product product) {
    if (isWishlisted(product.id)) {
      _items.removeWhere((p) => p.id == product.id);
      // Remove from Firestore
      if (_userId != null) {
        _db
            .collection('users')
            .doc(_userId)
            .collection('wishlist')
            .doc(product.id)
            .delete()
            .catchError((e) => debugPrint('Error removing from wishlist: $e'));
      }
    } else {
      _items.add(product);
      // Add to Firestore
      if (_userId != null) {
        _db
            .collection('users')
            .doc(_userId)
            .collection('wishlist')
            .doc(product.id)
            .set({
              'addedAt': FieldValue.serverTimestamp(),
            })
            .catchError((e) => debugPrint('Error adding to wishlist: $e'));
      }
    }
    notifyListeners();
  }
}
