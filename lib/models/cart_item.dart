import 'product.dart';

/// Represents a product added to the shopping cart with selected options.
class CartItem {
  final Product product;
  int quantity;
  String selectedSize;
  String selectedColor;

  CartItem({
    required this.product,
    this.quantity = 1,
    required this.selectedSize,
    required this.selectedColor,
  });

  /// Converts this cart item to a Firestore-compatible map (for order storage).
  Map<String, dynamic> toMap() {
    return {
      'productId': product.id,
      'name': product.name,
      'price': product.price,
      'imageUrl': product.imageUrl,
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor,
    };
  }

  /// Creates a CartItem from a Firestore map.
  /// Uses [sampleProducts] to look up the full product; falls back to a
  /// minimal Product if the ID is no longer in the catalog.
  factory CartItem.fromMap(Map<String, dynamic> map) {
    // Try to find the full product from the catalog
    Product product;
    try {
      product = sampleProducts.firstWhere((p) => p.id == map['productId']);
    } catch (_) {
      // Product no longer in catalog — build a minimal placeholder
      product = Product(
        id: map['productId'] ?? '',
        name: map['name'] ?? 'Unknown Product',
        price: (map['price'] ?? 0).toDouble(),
        category: '',
        description: '',
        sizes: [],
        colors: [],
        imageUrl: map['imageUrl'] ?? '',
      );
    }

    return CartItem(
      product: product,
      quantity: map['quantity'] ?? 1,
      selectedSize: map['selectedSize'] ?? '',
      selectedColor: map['selectedColor'] ?? '',
    );
  }
}