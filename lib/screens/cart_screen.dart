import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../theme/app_theme.dart';
import '../utils/app_animations.dart';
import 'checkout_screen.dart';

/// Cart screen with swipe-to-delete and animated total bar.
/// Concepts: Dismissible, Provider.of, ListView.builder.
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);

    if (cart.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.white.withOpacity(0.1)),
            const SizedBox(height: 16),
            const Text('Your Cart is Empty', style: TextStyle(fontSize: 18, color: Colors.white38)),
            const SizedBox(height: 8),
            const Text('Add some products to get started', style: TextStyle(color: Colors.white24, fontSize: 13)),
          ],
        ),
      );
    }

    return Column(
      children: [
        // ── Cart Items List ──
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: cart.items.length,
            itemBuilder: (ctx, i) {
              final item = cart.items[i];
              return Dismissible(
                key: ValueKey('${item.product.id}-${item.selectedSize}-${item.selectedColor}'),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 20),
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: AppColors.error.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.delete_rounded, color: AppColors.error, size: 28),
                ),
                onDismissed: (_) {
                  cart.removeItem(item.product.id, item.selectedSize, item.selectedColor);
                },
                child: Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // Product thumbnail
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            item.product.imageUrl,
                            width: 75,
                            height: 75,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 75,
                              height: 75,
                              color: AppColors.darkSurface,
                              child: const Icon(Icons.image, color: Colors.white24),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        // Product info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.product.name,
                                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${item.selectedSize} • ${item.selectedColor}',
                                style: const TextStyle(color: Colors.white38, fontSize: 12),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Rs. ${(item.product.price * item.quantity).toStringAsFixed(0)}',
                                style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ],
                          ),
                        ),
                        // Quantity controls
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.darkSurface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove, size: 18),
                                onPressed: () {
                                  if (item.quantity > 1) {
                                    cart.updateQuantity(item.product.id, item.quantity - 1, item.selectedSize, item.selectedColor);
                                  } else {
                                    cart.removeItem(item.product.id, item.selectedSize, item.selectedColor);
                                  }
                                },
                                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                                padding: EdgeInsets.zero,
                              ),
                              Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                              IconButton(
                                icon: const Icon(Icons.add, size: 18),
                                onPressed: () {
                                  cart.updateQuantity(item.product.id, item.quantity + 1, item.selectedSize, item.selectedColor);
                                },
                                constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                                padding: EdgeInsets.zero,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // ── Total Bar ──
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: const Offset(0, -2))],
          ),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Total', style: TextStyle(color: Colors.white54, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(
                    'Rs. ${cart.totalAmount.toStringAsFixed(0)}',
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.gold),
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.push(context, fadeRoute(const CheckoutScreen())),
                  child: const Text('CHECKOUT'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}