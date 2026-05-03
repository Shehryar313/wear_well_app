import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../providers/wishlist_provider.dart';
import '../widgets/product_card.dart';

/// Wishlist screen — displays all saved/wishlisted products.
class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishlistProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('My Wishlist')),
      body: wishlist.items.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.favorite_border_rounded, size: 80, color: Colors.white.withOpacity(0.1)),
                  const SizedBox(height: 16),
                  const Text('Your Wishlist is Empty', style: TextStyle(fontSize: 18, color: Colors.white38)),
                  const SizedBox(height: 8),
                  const Text('Tap the ♥ on any product to save it', style: TextStyle(color: Colors.white24, fontSize: 13)),
                ],
              ),
            )
          : AnimationLimiter(
              child: GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: wishlist.items.length,
                itemBuilder: (ctx, i) {
                  return AnimationConfiguration.staggeredGrid(
                    position: i,
                    columnCount: 2,
                    duration: const Duration(milliseconds: 500),
                    child: ScaleAnimation(
                      child: FadeInAnimation(
                        child: ProductCard(product: wishlist.items[i]),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
