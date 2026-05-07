import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';

/// Manages product data from Cloud Firestore.
class ProductProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  /// Fetches all products from the Firestore 'products' collection.
  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final snapshot = await _db.collection('products').get();
      _products = snapshot.docs.map((doc) {
        final data = doc.data();
        // Ensure the ID is the document ID if not present in the map
        if (data['id'] == null) data['id'] = doc.id;
        return Product.fromMap(data);
      }).toList();
    } catch (e) {
      debugPrint('Error fetching products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Returns products by category.
  List<Product> getProductsByCategory(String category) {
    return _products.where((p) => p.category == category).toList();
  }

  /// One-time seeding function to upload sampleProducts to Firestore.
  /// Call this once when the database is empty.
  Future<void> seedDatabase() async {
    try {
      final snapshot = await _db.collection('products').limit(1).get();
      if (snapshot.docs.isNotEmpty) {
        debugPrint('Database already seeded.');
        return;
      }

      debugPrint('Seeding database with sample products...');
      final batch = _db.batch();
      
      for (var product in sampleProducts) {
        final docRef = _db.collection('products').doc(product.id);
        batch.set(docRef, product.toMap());
      }

      await batch.commit();
      debugPrint('Database seeding complete!');
      await fetchProducts(); // Refresh local list
    } catch (e) {
      debugPrint('Error seeding database: $e');
    }
  }
}
