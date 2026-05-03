import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_item.dart'; // Ensure this import
import '../providers/cart_provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  String selectedSize = '';
  String selectedColor = '';

  @override
  void initState() {
    super.initState();
    if (widget.product.sizes.isNotEmpty) selectedSize = widget.product.sizes.first;
    if (widget.product.colors.isNotEmpty) selectedColor = widget.product.colors.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product.name)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(widget.product.imageUrl, height: 200, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.product.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text("\$${widget.product.price}", style: const TextStyle(fontSize: 20, color: Colors.pink)),
                  const SizedBox(height: 10),
                  Text(widget.product.description),
                  const SizedBox(height: 20),
                  if (widget.product.sizes.isNotEmpty)
                    DropdownButton<String>(
                      value: selectedSize,
                      items: widget.product.sizes.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                      onChanged: (val) { setState(() { selectedSize = val!; }); },
                    ),
                  if (widget.product.colors.isNotEmpty)
                    DropdownButton<String>(
                      value: selectedColor,
                      items: widget.product.colors.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                      onChanged: (val) { setState(() { selectedColor = val!; }); },
                    ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (selectedSize.isEmpty && widget.product.sizes.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select size")));
                        return;
                      }
                      if (selectedColor.isEmpty && widget.product.colors.isNotEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Select color")));
                        return;
                      }
                      Provider.of<CartProvider>(context, listen: false).addItem(widget.product, selectedSize, selectedColor);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added to Cart")));
                    },
                    child: const Text("Add to Cart"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}