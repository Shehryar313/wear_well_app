import 'package:flutter/material.dart';
import 'order_history_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            color: Colors.pink,
            child: const Column(
              children: [
                CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
                SizedBox(height: 10),
                Text("User Name", style: TextStyle(color: Colors.white, fontSize: 20)),
                Text("user@email.com", style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          ListTile(leading: const Icon(Icons.shopping_bag), title: const Text("My Orders"), onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryScreen())); }),
          ListTile(leading: const Icon(Icons.favorite), title: const Text("Wishlist"), onTap: () { /* Future: Implement wishlist */ ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wishlist coming soon"))); }),
          const ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
        ],
      ),
    );
  }
}