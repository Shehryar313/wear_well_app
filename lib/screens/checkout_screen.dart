import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import '../theme/app_theme.dart';

/// Checkout screen with address form validation, coupon, payment selection.
/// Orders are saved to Firestore under the logged-in user.
class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _phoneController = TextEditingController();
  String paymentMethod = 'Cash on Delivery';
  String couponCode = '';
  double discount = 0;
  bool _orderPlaced = false;

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;

    final cart = Provider.of<CartProvider>(context, listen: false);
    final orderProvider = Provider.of<OrderProvider>(context, listen: false);
    final total = cart.totalAmount - discount;
    final address = '${_addressController.text}, ${_cityController.text}';

    // Save order to Firestore under the logged-in user
    await orderProvider.placeOrder(
      cart.items,
      total,
      address,
      phone: _phoneController.text,
      paymentMethod: paymentMethod,
    );
    cart.clearCart();

    setState(() => _orderPlaced = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final total = cart.totalAmount - discount;

    if (_orderPlaced) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedScale(
                scale: _orderPlaced ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 600),
                curve: Curves.elasticOut,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.success,
                  ),
                  child: const Icon(Icons.check_rounded, color: Colors.white, size: 50),
                ),
              ),
              const SizedBox(height: 24),
              const Text('Order Placed!', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('Thank you for shopping with Wear-Well', style: TextStyle(color: Colors.white54)),
              const SizedBox(height: 4),
              const Text('Your order has been saved to your account', style: TextStyle(color: AppColors.gold, fontSize: 12)),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Delivery Address Section ──
              const Text('Delivery Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 14),
              TextFormField(
                controller: _addressController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Street Address',
                  prefixIcon: Icon(Icons.location_on_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Address is required';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _cityController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'City',
                  prefixIcon: Icon(Icons.location_city_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'City is required';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Phone number is required';
                  return null;
                },
              ),
              const SizedBox(height: 28),

              // ── Coupon Code ──
              const Text('Coupon Code', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Enter coupon code',
                        hintStyle: TextStyle(color: Colors.white24),
                        prefixIcon: Icon(Icons.local_offer_outlined),
                      ),
                      onChanged: (val) {
                        couponCode = val;
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(minimumSize: const Size(80, 52)),
                    onPressed: () {
                      setState(() {
                        discount = couponCode == 'DISCOUNT10' ? cart.totalAmount * 0.1 : 0;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(discount > 0 ? 'Coupon applied! 10% off' : 'Invalid coupon code'),
                        ),
                      );
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
              if (discount > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Discount: -Rs. ${discount.toStringAsFixed(0)}',
                    style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w600),
                  ),
                ),
              const SizedBox(height: 28),

              // ── Payment Method ──
              const Text('Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 10),
              ...['Cash on Delivery', 'Online Payment'].map((method) {
                return RadioListTile<String>(
                  value: method,
                  groupValue: paymentMethod,
                  activeColor: AppColors.gold,
                  title: Text(method),
                  onChanged: (val) => setState(() => paymentMethod = val!),
                  contentPadding: EdgeInsets.zero,
                );
              }),
              const SizedBox(height: 20),

              // ── Order Summary ──
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    _summaryRow('Subtotal', 'Rs. ${cart.totalAmount.toStringAsFixed(0)}'),
                    if (discount > 0) _summaryRow('Discount', '-Rs. ${discount.toStringAsFixed(0)}'),
                    _summaryRow('Delivery', 'Free'),
                    const Divider(color: Colors.white12),
                    _summaryRow('Total', 'Rs. ${total.toStringAsFixed(0)}', isBold: true),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ── Place Order Button ──
              ElevatedButton(
                onPressed: _placeOrder,
                child: const Text('PLACE ORDER'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.white54, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(
            value,
            style: TextStyle(
              color: isBold ? AppColors.gold : Colors.white,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
              fontSize: isBold ? 18 : 14,
            ),
          ),
        ],
      ),
    );
  }
}