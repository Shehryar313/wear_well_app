import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';
import '../utils/app_animations.dart';
import 'order_history_screen.dart';
import 'wishlist_screen.dart';

/// Profile screen with user info, theme toggle, and navigation links.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          // ── Profile Header ──
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(24, 40, 24, 30),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.darkCard, AppColors.gold.withOpacity(0.2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.gold, width: 2),
                  ),
                  child: const CircleAvatar(
                    radius: 45,
                    backgroundColor: AppColors.darkSurface,
                    child: Icon(Icons.person, size: 45, color: AppColors.gold),
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'User Name',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  'user@email.com',
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // ── Menu Items ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.shopping_bag_rounded,
                  title: 'My Orders',
                  subtitle: 'View order history & tracking',
                  onTap: () => Navigator.push(context, fadeRoute(const OrderHistoryScreen())),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.favorite_rounded,
                  title: 'Wishlist',
                  subtitle: 'Your saved items',
                  onTap: () => Navigator.push(context, fadeRoute(const WishlistScreen())),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.location_on_rounded,
                  title: 'Addresses',
                  subtitle: 'Manage delivery addresses',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coming soon in next phase')),
                    );
                  },
                ),

                // ── Theme Toggle ──
                Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.gold.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        themeProvider.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                        color: AppColors.gold,
                      ),
                    ),
                    title: const Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text(
                      themeProvider.isDarkMode ? 'Dark theme active' : 'Light theme active',
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: Switch(
                      value: themeProvider.isDarkMode,
                      activeColor: AppColors.gold,
                      onChanged: (_) => themeProvider.toggleTheme(),
                    ),
                  ),
                ),

                _buildMenuItem(
                  context,
                  icon: Icons.help_outline_rounded,
                  title: 'Help & Support',
                  subtitle: 'FAQs, contact us',
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Coming soon in next phase')),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.gold.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: AppColors.gold),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white38),
        onTap: onTap,
      ),
    );
  }
}