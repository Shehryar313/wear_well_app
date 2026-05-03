import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import 'checkout_screen.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return cart.items.isEmpty
        ? const Center(child: Text("Your Cart is Empty", style: TextStyle(fontSize: 20)))
        : Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.items.length,
                  itemBuilder: (ctx, i) {
                    final item = cart.items[i];
                    return ListTile(
                      leading: const Icon(Icons.shopping_bag),
                      title: Text(item.product.name),
                      subtitle: Text("Qty: ${item.quantity} | Size: ${item.selectedSize} | Color: ${item.selectedColor} | \$${item.product.price * item.quantity}"),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: const Icon(Icons.remove), onPressed: () {
                            if (item.quantity > 1) {
                              cart.updateQuantity(item.product.id, item.quantity - 1, item.selectedSize, item.selectedColor);
                            } else {
                              cart.removeItem(item.product.id, item.selectedSize, item.selectedColor);
                            }
                          }),
                          IconButton(icon: const Icon(Icons.add), onPressed: () {
                            cart.updateQuantity(item.product.id, item.quantity + 1, item.selectedSize, item.selectedColor);
                          }),
                          IconButton(icon: const Icon(Icons.delete), onPressed: () {
                            cart.removeItem(item.product.id, item.selectedSize, item.selectedColor);
                          }),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total: \$${cart.totalAmount.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutScreen()));
                      },
                      child: const Text("Checkout"),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}