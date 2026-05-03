import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Providers
import 'providers/cart_provider.dart';
import 'providers/wishlist_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/order_provider.dart';

// Theme
import 'theme/app_theme.dart';

// Entry screen
import 'screens/splash_screen.dart';

void main() {
  runApp(const WearWellApp());
}

/// Root widget with MultiProvider for state management.
/// Concepts used: MultiProvider, ChangeNotifierProvider, ThemeMode.
class WearWellApp extends StatelessWidget {
  const WearWellApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => OrderProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Wear-Well',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}