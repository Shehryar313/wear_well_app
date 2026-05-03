import 'package:flutter/material.dart';
import '../models/order.dart';
import '../theme/app_theme.dart';

/// Order tracking screen with Stepper widget.
/// Concept: Stepper widget for showing order progress stages.
class OrderTrackingScreen extends StatelessWidget {
  final Order order;

  const OrderTrackingScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    // Determine current step based on order status
    int currentStep;
    switch (order.status) {
      case OrderStatus.processing:
        currentStep = 0;
        break;
      case OrderStatus.shipped:
        currentStep = 1;
        break;
      case OrderStatus.outForDelivery:
        currentStep = 2;
        break;
      case OrderStatus.delivered:
        currentStep = 3;
        break;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Track Order')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Order Info Card ──
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.darkCard,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Order ID', style: TextStyle(color: Colors.white54, fontSize: 13)),
                      Text(order.id, style: const TextStyle(fontWeight: FontWeight.w600)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total', style: TextStyle(color: Colors.white54, fontSize: 13)),
                      Text(
                        'Rs. ${order.total.toStringAsFixed(0)}',
                        style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Items', style: TextStyle(color: Colors.white54, fontSize: 13)),
                      Text('${order.items.length} products'),
                    ],
                  ),
                  if (order.address.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Deliver to', style: TextStyle(color: Colors.white54, fontSize: 13)),
                        Flexible(child: Text(order.address, textAlign: TextAlign.right)),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Tracking Stepper ──
            const Text('Order Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            Stepper(
              currentStep: currentStep,
              physics: const NeverScrollableScrollPhysics(),
              controlsBuilder: (context, details) => const SizedBox.shrink(),
              steps: [
                Step(
                  title: const Text('Order Placed'),
                  subtitle: Text('${order.date.day}/${order.date.month}/${order.date.year}'),
                  content: const Text('Your order has been confirmed and is being processed.'),
                  isActive: currentStep >= 0,
                  state: currentStep > 0 ? StepState.complete : StepState.indexed,
                ),
                Step(
                  title: const Text('Shipped'),
                  subtitle: const Text('Estimated 2-3 days'),
                  content: const Text('Your package has been handed over to the courier.'),
                  isActive: currentStep >= 1,
                  state: currentStep > 1 ? StepState.complete : (currentStep == 1 ? StepState.indexed : StepState.disabled),
                ),
                Step(
                  title: const Text('Out for Delivery'),
                  subtitle: const Text('Today'),
                  content: const Text('Your package is out for delivery. It will arrive soon!'),
                  isActive: currentStep >= 2,
                  state: currentStep > 2 ? StepState.complete : (currentStep == 2 ? StepState.indexed : StepState.disabled),
                ),
                Step(
                  title: const Text('Delivered'),
                  subtitle: const Text('Expected delivery'),
                  content: const Text('Your order has been delivered successfully. Enjoy!'),
                  isActive: currentStep >= 3,
                  state: currentStep >= 3 ? StepState.complete : StepState.disabled,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ── Order Items ──
            const Text('Items in this Order', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...order.items.map((item) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    item.product.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 50, height: 50,
                      color: AppColors.darkSurface,
                      child: const Icon(Icons.image, color: Colors.white24),
                    ),
                  ),
                ),
                title: Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                subtitle: Text('${item.selectedSize} • ${item.selectedColor} • Qty: ${item.quantity}', style: const TextStyle(fontSize: 12)),
                trailing: Text('Rs. ${(item.product.price * item.quantity).toStringAsFixed(0)}', style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w600)),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
