import 'package:flutter/material.dart';
import '../models/cart_item.dart'; // Ensure this import
import '../screens/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product)));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(
            children: [
              Column(
                children: [
                  Image.network(product.imageUrl, height: 100, fit: BoxFit.cover),
                  const SizedBox(height: 10),
                  Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text("\$${product.price}"),
                ],
              ),
              const Positioned(right: 0, child: Icon(Icons.favorite_border, color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}