import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../models/order.dart' as model;
import '../theme/app_theme.dart';
import '../providers/auth_provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  Map<String, int> stock = {for (var p in sampleProducts) p.id: 10};

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Dashboard'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.dashboard), text: 'Overview'),
              Tab(icon: Icon(Icons.people), text: 'Users & Orders'),
              Tab(icon: Icon(Icons.inventory), text: 'Products'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DashboardTab(),
            UsersOrdersTab(),
            ProductsTab(),
          ],
        ),
      ),
    );
  }
}

class DashboardTab extends StatelessWidget {
  const DashboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final users = userSnapshot.data?.docs ?? [];
        
        return FutureBuilder<Map<String, dynamic>>(
          future: _calculateStats(users),
          builder: (context, statsSnapshot) {
            final stats = statsSnapshot.data ?? {'totalOrders': 0, 'totalSales': 0.0};
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      _statCard('Total Users', '${users.length}', Icons.people_rounded),
                      const SizedBox(width: 12),
                      _statCard('Total Products', '${sampleProducts.length}', Icons.inventory_2_rounded),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _statCard('Total Orders', '${stats['totalOrders']}', Icons.shopping_bag_rounded),
                      const SizedBox(width: 12),
                      _statCard('Total Sales', 'Rs. ${stats['totalSales'].toStringAsFixed(0)}', Icons.attach_money_rounded),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<Map<String, dynamic>> _calculateStats(List<QueryDocumentSnapshot> users) async {
    int totalOrders = 0;
    double totalSales = 0.0;

    for (var user in users) {
      final ordersSnapshot = await user.reference.collection('orders').get();
      totalOrders += ordersSnapshot.docs.length;
      for (var orderDoc in ordersSnapshot.docs) {
        totalSales += (orderDoc.data()['total'] ?? 0.0).toDouble();
      }
    }

    return {'totalOrders': totalOrders, 'totalSales': totalSales};
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
            Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class UsersOrdersTab extends StatelessWidget {
  const UsersOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        
        final users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            final userData = user.data() as Map<String, dynamic>;

            return ExpansionTile(
              leading: const CircleAvatar(
                backgroundColor: AppColors.gold,
                child: Icon(Icons.person, color: Colors.black),
              ),
              title: Text(userData['name'] ?? 'No Name'),
              subtitle: Text(userData['email'] ?? 'No Email'),
              children: [
                UserOrdersList(userId: user.id),
              ],
            );
          },
        );
      },
    );
  }
}

class UserOrdersList extends StatelessWidget {
  final String userId;
  const UserOrdersList({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orders')
          .orderBy('date', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        );

        final orders = snapshot.data!.docs;
        if (orders.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('No orders found for this user.', style: TextStyle(color: Colors.white54)),
          );
        }

        return Column(
          children: orders.map((doc) {
            final order = model.Order.fromMap(doc.data() as Map<String, dynamic>, doc.id);
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Order ID: ${order.id}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        _buildStatusBadge(order.status),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...order.items.map((item) => Text('• ${item.product.name} x${item.quantity}')),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total: Rs. ${order.total.toStringAsFixed(0)}', style: const TextStyle(color: AppColors.gold)),
                        DropdownButton<model.OrderStatus>(
                          value: order.status,
                          dropdownColor: AppColors.darkCard,
                          items: model.OrderStatus.values.map((status) {
                            return DropdownMenuItem(
                              value: status,
                              child: Text(_statusLabel(status), style: const TextStyle(fontSize: 12)),
                            );
                          }).toList(),
                          onChanged: (newStatus) {
                            if (newStatus != null) {
                              _updateOrderStatus(userId, order.id, newStatus);
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  String _statusLabel(model.OrderStatus status) {
    switch (status) {
      case model.OrderStatus.processing: return 'Processing';
      case model.OrderStatus.shipped: return 'Shipped';
      case model.OrderStatus.outForDelivery: return 'Out for Delivery';
      case model.OrderStatus.delivered: return 'Delivered';
    }
  }

  Widget _buildStatusBadge(model.OrderStatus status) {
    Color color;
    switch (status) {
      case model.OrderStatus.processing: color = Colors.orange; break;
      case model.OrderStatus.shipped: color = Colors.blue; break;
      case model.OrderStatus.outForDelivery: color = Colors.purple; break;
      case model.OrderStatus.delivered: color = Colors.green; break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color),
      ),
      child: Text(
        _statusLabel(status).toUpperCase(),
        style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Future<void> _updateOrderStatus(String userId, String orderId, model.OrderStatus status) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .update({'status': _statusToString(status)});
  }

  String _statusToString(model.OrderStatus status) {
    switch (status) {
      case model.OrderStatus.processing: return 'processing';
      case model.OrderStatus.shipped: return 'shipped';
      case model.OrderStatus.outForDelivery: return 'outForDelivery';
      case model.OrderStatus.delivered: return 'delivered';
    }
  }
}

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.gold,
        onPressed: _showAddProductDialog,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sampleProducts.length,
        itemBuilder: (context, index) {
          final p = sampleProducts[index];
          return Card(
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
          );
        },
      ),
    );
  }
}