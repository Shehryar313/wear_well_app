import 'package:flutter/material.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  // Hardcoded dummy orders
  static const List<Map<String, String>> orders = [
    {'id': '001', 'date': '2026-03-01', 'amount': '\$100', 'status': 'Delivered'},
    {'id': '002', 'date': '2026-03-05', 'amount': '\$50', 'status': 'Pending'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order History")),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (ctx, i) => ListTile(
          title: Text("Order #${orders[i]['id']}"),
          subtitle: Text("Date: ${orders[i]['date']} | Amount: ${orders[i]['amount']} | Status: ${orders[i]['status']}"),
        ),
      ),
    );
  }
}