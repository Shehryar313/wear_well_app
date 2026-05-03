import 'package:flutter/material.dart';
import '../models/product.dart';
import '../theme/app_theme.dart';

/// Admin panel for managing products.
class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  Map<String, int> stock = {for (var p in sampleProducts) p.id: 10};

  void _showAddProductDialog() {
    final formKey = GlobalKey<FormState>();
    final nameCtrl = TextEditingController();
    final priceCtrl = TextEditingController();
    String selectedCategory = 'Men';

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkCard,
        title: const Text('Add Product'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Product Name'),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: priceCtrl,
                  keyboardType: TextInputType.number,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(labelText: 'Price'),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Required';
                    if (double.tryParse(v) == null) return 'Enter a valid number';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                StatefulBuilder(
                  builder: (context, setDialogState) {
                    return DropdownButtonFormField<String>(
                      value: selectedCategory,
                      dropdownColor: AppColors.darkCard,
                      decoration: const InputDecoration(labelText: 'Category'),
                      items: ['Men', 'Women', 'Kids', 'Accessories']
                          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                          .toList(),
                      onChanged: (val) => setDialogState(() => selectedCategory = val!),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(minimumSize: const Size(80, 40)),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                setState(() {
                  sampleProducts.add(Product(
                    id: '${sampleProducts.length + 1}',
                    name: nameCtrl.text,
                    price: double.parse(priceCtrl.text),
                    category: selectedCategory,
                    description: 'New product added by admin',
                    sizes: ['M', 'L'],
                    colors: ['Black'],
                    imageUrl: 'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=400&fit=crop',
                  ));
                  stock[sampleProducts.last.id] = 10;
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Product Added ✓')),
                );
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Panel')),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gold,
        onPressed: _showAddProductDialog,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Stats Cards ──
            Row(
              children: [
                _statCard('Products', '${sampleProducts.length}', Icons.inventory_2_rounded),
                const SizedBox(width: 12),
                _statCard('Categories', '4', Icons.category_rounded),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _statCard('Total Sales', 'Rs. 245,000', Icons.attach_money_rounded),
                const SizedBox(width: 12),
                _statCard('Orders', '24', Icons.shopping_bag_rounded),
              ],
            ),
            const SizedBox(height: 24),

            // ── Product List ──
            const Text('Manage Products', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...sampleProducts.map((p) => Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    p.imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 50, height: 50,
                      color: AppColors.darkSurface,
                      child: const Icon(Icons.image, color: Colors.white24, size: 20),
                    ),
                  ),
                ),
                title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
                subtitle: Text(
                  'Rs. ${p.price.toStringAsFixed(0)} • Stock: ${stock[p.id] ?? 0}',
                  style: const TextStyle(fontSize: 12, color: AppColors.gold),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                  onPressed: () {
                    setState(() => sampleProducts.remove(p));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Removed ${p.name}')),
                    );
                  },
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.darkCard,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.gold, size: 24),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}