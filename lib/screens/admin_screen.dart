import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  // Simulate stock management (hardcoded)
  Map<String, int> stock = { for (var p in sampleProducts) p.id: 10 };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),
      body: ListView(
        children: [
          ListTile(title: const Text("Add Product"), onTap: () {
            // Simulate add
            setState(() {
              sampleProducts.add(Product(id: '${sampleProducts.length + 1}', name: 'New Product', price: 20, category: 'Men', description: 'New item', sizes: ['M'], colors: ['Black']));
            });
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product Added")));
          }),
          ListTile(title: const Text("View Sales Report"), onTap: () {
            showDialog(context: context, builder: (ctx) => const AlertDialog(title: Text("Sales Report"), content: Text("Total Sales: \$500")));
          }),
          ExpansionTile(
            title: const Text("Manage Products"),
            children: sampleProducts.map((p) => ListTile(
              title: Text(p.name),
              subtitle: Text("Stock: ${stock[p.id]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(icon: const Icon(Icons.edit), onPressed: () {
                    // Simulate update
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated ${p.name}")));
                  }),
                  IconButton(icon: const Icon(Icons.delete), onPressed: () {
                    setState(() { sampleProducts.remove(p); });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Removed ${p.name}")));
                  }),
                ],
              ),
            )).toList(),
          ),
        ],
      ),
    );
  }
}