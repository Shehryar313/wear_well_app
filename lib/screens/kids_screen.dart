import 'package:flutter/material.dart';
import '../models/cart_item.dart'; // Ensure this import
import '../widgets/product_card.dart';

class KidsScreen extends StatelessWidget {
  const KidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final kidsProducts = sampleProducts.where((p) => p.category == 'Kids').toList();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75),
      padding: const EdgeInsets.all(10),
      itemCount: kidsProducts.length,
      itemBuilder: (ctx, i) => ProductCard(product: kidsProducts[i]),
    );
  }
}