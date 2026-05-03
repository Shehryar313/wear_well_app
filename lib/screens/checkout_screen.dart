import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  String paymentMethod = 'Cash on Delivery';
  String couponCode = '';
  double discount = 0;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    double total = cart.totalAmount - discount;

    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Total before discount: \$${cart.totalAmount.toStringAsFixed(2)}"),
            const SizedBox(height: 10),
            TextField(
              onChanged: (val) {
                couponCode = val;
                // Simulate coupon (e.g., 'DISCOUNT10' for 10%)
                setState(() {
                  discount = val == 'DISCOUNT10' ? cart.totalAmount * 0.1 : 0;
                });
              },
              decoration: const InputDecoration(labelText: "Coupon Code", border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            Text("Discount: \$${discount.toStringAsFixed(2)}"),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: paymentMethod,
              items: ['Online Payment', 'Cash on Delivery'].map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
              onChanged: (val) { setState(() { paymentMethod = val!; }); },
            ),
            const SizedBox(height: 20),
            Text("Final Total: \$${total.toStringAsFixed(2)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
              onPressed: () {
                // Simulate order placement
                cart.clearCart();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Order Placed!")));
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text("Place Order"),
            ),
          ],
        ),
      ),
    );
  }
}