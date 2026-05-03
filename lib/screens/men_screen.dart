import 'package:flutter/material.dart';
import '../models/cart_item.dart'; // Ensure this import
import '../widgets/product_card.dart';

class MenScreen extends StatelessWidget {
  const MenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menProducts = sampleProducts.where((p) => p.category == 'Men').toList();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75),
      padding: const EdgeInsets.all(10),
      itemCount: menProducts.length,
      itemBuilder: (ctx, i) => ProductCard(product: menProducts[i]),
    );
  }
}