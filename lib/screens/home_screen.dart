import 'package:flutter/material.dart';
import 'home_tab.dart';
import 'categories_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'admin_screen.dart';
import 'login_screen.dart';
import '../models/cart_item.dart'; // Import for Product and sampleProducts
import 'product_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final List<Widget> screens = [
    HomeTab(),
    CategoriesScreen(),
    CartScreen(),
  ]; // Removed const from list to avoid issues if child constructors aren't const

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wear-Well"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ProductSearchDelegate());
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 30, child: Icon(Icons.person)),
                  SizedBox(height: 10),
                  Text("Welcome User", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            ListTile(leading: const Icon(Icons.person), title: const Text("Profile"), onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfileScreen())); }),
            ListTile(leading: const Icon(Icons.admin_panel_settings), title: const Text("Admin Panel"), onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => AdminScreen())); }),
            ListTile(leading: const Icon(Icons.logout), title: const Text("Logout"), onTap: () { Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen())); }),
          ],
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() { currentIndex = index; });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: "Category"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
        ],
      ),
    );
  }
}

// Search delegate for products
class ProductSearchDelegate extends SearchDelegate {
  @override
  Widget buildLeading(BuildContext context) => IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));

  @override
  List<Widget> buildActions(BuildContext context) => [IconButton(icon: const Icon(Icons.clear), onPressed: () { query = ''; })];

  @override
  Widget buildResults(BuildContext context) {
    final results = sampleProducts.where((p) => p.name.toLowerCase().contains(query.toLowerCase())).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (ctx, i) => ListTile(title: Text(results[i].name), onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: results[i])));
      }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) => buildResults(context);
}