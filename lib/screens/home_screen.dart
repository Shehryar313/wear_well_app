import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../providers/auth_provider.dart';
import '../providers/wishlist_provider.dart';
import '../providers/order_provider.dart';
import '../theme/app_theme.dart';
import '../utils/app_animations.dart';
import 'home_tab.dart';
import 'categories_screen.dart';
import 'cart_screen.dart';
import 'profile_screen.dart';
import 'admin_screen.dart';
import 'login_screen.dart';
import 'wishlist_screen.dart';
import '../models/product.dart';
import 'product_details_screen.dart';

/// Main home screen with bottom navigation.
/// Concepts: BottomNavigationBar, IndexedStack, Drawer, Badge.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeTab(),
    CategoriesScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_bag_rounded, color: AppColors.gold, size: 24),
            const SizedBox(width: 8),
            const Text('WEAR-WELL'),
          ],
        ),
        actions: [
          // Search
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: ProductSearchDelegate());
            },
          ),
          // Wishlist
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () => Navigator.push(context, fadeRoute(const WishlistScreen())),
          ),
        ],
      ),
      drawer: _buildDrawer(context, auth),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Categories'),
          BottomNavigationBarItem(
            icon: Badge(
              isLabelVisible: cart.itemCount > 0,
              label: Text('${cart.itemCount}', style: const TextStyle(fontSize: 10)),
              backgroundColor: AppColors.gold,
              textColor: Colors.black,
              child: const Icon(Icons.shopping_cart_rounded),
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context, AuthProvider auth) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.darkCard, AppColors.gold.withOpacity(0.3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.gold,
                  child: Icon(Icons.person, size: 32, color: Colors.black),
                ),
                const SizedBox(height: 12),
                Text(
                  'Welcome ${auth.userName ?? 'User'}',
                  style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                ),
                Text(
                  auth.userEmail ?? 'user@email.com',
                  style: const TextStyle(color: Colors.white54, fontSize: 13),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_rounded, color: AppColors.gold),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              setState(() => _currentIndex = 0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite_rounded, color: AppColors.gold),
            title: const Text('Wishlist'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, fadeRoute(const WishlistScreen()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.admin_panel_settings_rounded, color: AppColors.gold),
            title: const Text('Admin Panel'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, fadeRoute(const AdminScreen()));
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: AppColors.error),
            title: const Text('Logout'),
            onTap: () {
              // Clear all user-specific data
              auth.logout();
              Provider.of<WishlistProvider>(context, listen: false).clearUser();
              Provider.of<OrderProvider>(context, listen: false).clearUser();
              Provider.of<CartProvider>(context, listen: false).clearCart();
              Navigator.pushReplacement(context, fadeRoute(const LoginScreen()));
            },
          ),
        ],
      ),
    );
  }
}

/// Search delegate for finding products.
class ProductSearchDelegate extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white38),
      ),
      textTheme: theme.textTheme.copyWith(
        titleLarge: const TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  @override
  Widget buildLeading(BuildContext context) =>
      IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, null));

  @override
  List<Widget> buildActions(BuildContext context) =>
      [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults();

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults();

  Widget _buildSearchResults() {
    final results = sampleProducts
        .where((p) => p.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (query.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search, size: 60, color: Colors.white24),
            SizedBox(height: 12),
            Text('Search for products...', style: TextStyle(color: Colors.white38)),
          ],
        ),
      );
    }

    if (results.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 60, color: Colors.white24),
            SizedBox(height: 12),
            Text('No products found', style: TextStyle(color: Colors.white38)),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (ctx, i) {
        final product = results[i];
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              product.imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 50,
                height: 50,
                color: AppColors.darkCard,
                child: const Icon(Icons.image, color: Colors.white24),
              ),
            ),
          ),
          title: Text(product.name),
          subtitle: Text('Rs. ${product.price.toStringAsFixed(0)}', style: const TextStyle(color: AppColors.gold)),
          onTap: () {
            Navigator.push(ctx, fadeRoute(ProductDetailsScreen(product: product)));
          },
        );
      },
    );
  }
}