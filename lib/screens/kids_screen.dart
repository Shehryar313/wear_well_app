import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

/// Kids' products screen.
class KidsScreen extends StatelessWidget {
  const KidsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = sampleProducts.where((p) => p.category == 'Kids').toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Kids\' Collection')),
      body: AnimationLimiter(
        child: GridView.builder(
          padding: const EdgeInsets.all(12),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: products.length,
          itemBuilder: (ctx, i) => AnimationConfiguration.staggeredGrid(
            position: i,
            columnCount: 2,
            duration: const Duration(milliseconds: 500),
            child: ScaleAnimation(child: FadeInAnimation(child: ProductCard(product: products[i]))),
          ),
        ),
      ),
    );
  }
}