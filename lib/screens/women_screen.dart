import 'package:flutter/material.dart';
import '../models/cart_item.dart'; // Ensure this import
import '../widgets/product_card.dart';

class WomenScreen extends StatelessWidget {
  const WomenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final womenProducts = sampleProducts.where((p) => p.category == 'Women').toList();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75),
      padding: const EdgeInsets.all(10),
      itemCount: womenProducts.length,
      itemBuilder: (ctx, i) => ProductCard(product: womenProducts[i]),
    );
  }
}