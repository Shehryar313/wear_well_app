import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import '../providers/wishlist_provider.dart';
import '../theme/app_theme.dart';

/// Product detail screen with Hero animation, chip selectors, and add-to-cart.
class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String selectedSize = '';
  String selectedColor = '';
  bool _addedToCart = false;

  @override
  void initState() {
    super.initState();
    if (widget.product.sizes.isNotEmpty) selectedSize = widget.product.sizes.first;
    if (widget.product.colors.isNotEmpty) selectedColor = widget.product.colors.first;
  }

  void _addToCart() {
    if (selectedSize.isEmpty && widget.product.sizes.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a size')),
      );
      return;
    }
    Provider.of<CartProvider>(context, listen: false)
        .addItem(widget.product, selectedSize, selectedColor);

    setState(() => _addedToCart = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) setState(() => _addedToCart = false);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to Cart ✓')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final wishlist = Provider.of<WishlistProvider>(context);
    final isWished = wishlist.isWishlisted(widget.product.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Collapsible Image Header ──
          SliverAppBar(
            expandedHeight: 350,
            pinned: true,
            backgroundColor: AppColors.darkSurface,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black45,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isWished ? Icons.favorite : Icons.favorite_border,
                    color: isWished ? AppColors.error : Colors.white,
                    size: 20,
                  ),
                ),
                onPressed: () => wishlist.toggleWishlist(widget.product),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product-${widget.product.id}',
                child: Image.network(
                  widget.product.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    color: AppColors.darkSurface,
                    child: const Icon(Icons.image, size: 60, color: Colors.white24),
                  ),
                ),
              ),
            ),
          ),

          // ── Product Details ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name & Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.name,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Rs. ${widget.product.price.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.gold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        return Icon(
                          index < widget.product.rating.floor()
                              ? Icons.star
                              : (index < widget.product.rating ? Icons.star_half : Icons.star_border),
                          color: AppColors.gold,
                          size: 20,
                        );
                      }),
                      const SizedBox(width: 8),
                      Text(
                        '${widget.product.rating}',
                        style: const TextStyle(color: Colors.white54, fontSize: 14),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Category badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.gold.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.product.category,
                      style: const TextStyle(color: AppColors.gold, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Description
                  const Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  Text(
                    widget.product.description,
                    style: const TextStyle(color: Colors.white60, height: 1.6),
                  ),
                  const SizedBox(height: 24),

                  // ── Size Selector (Chips) ──
                  if (widget.product.sizes.isNotEmpty) ...[
                    const Text('Size', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      children: widget.product.sizes.map((size) {
                        final isSelected = selectedSize == size;
                        return GestureDetector(
                          onTap: () => setState(() => selectedSize = size),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.gold : AppColors.darkCard,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? AppColors.gold : Colors.white12,
                              ),
                            ),
                            child: Text(
                              size,
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // ── Color Selector (Chips) ──
                  if (widget.product.colors.isNotEmpty) ...[
                    const Text('Color', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 10,
                      children: widget.product.colors.map((color) {
                        final isSelected = selectedColor == color;
                        return GestureDetector(
                          onTap: () => setState(() => selectedColor = color),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.gold : AppColors.darkCard,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected ? AppColors.gold : Colors.white12,
                              ),
                            ),
                            child: Text(
                              color,
                              style: TextStyle(
                                color: isSelected ? Colors.black : Colors.white70,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 30),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Floating Add to Cart Button ──
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkSurface,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: const Offset(0, -2))],
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          child: ElevatedButton.icon(
            onPressed: _addToCart,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                _addedToCart ? Icons.check : Icons.shopping_cart_rounded,
                key: ValueKey(_addedToCart),
                color: Colors.black,
              ),
            ),
            label: Text(_addedToCart ? 'ADDED!' : 'ADD TO CART'),
          ),
        ),
      ),
    );
  }
}