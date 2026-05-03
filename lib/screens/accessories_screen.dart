import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../widgets/product_card.dart';

class AccessoriesScreen extends StatelessWidget {
  const AccessoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accProducts = sampleProducts.where((p) => p.category == 'Accessories').toList();
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.75),
      padding: const EdgeInsets.all(10),
      itemCount: accProducts.length,
      itemBuilder: (ctx, i) => ProductCard(product: accProducts[i]),
    );
  }
}