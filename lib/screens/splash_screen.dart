import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'login_screen.dart';

/// Animated splash screen — app entry point.
/// Concepts: AnimatedOpacity, AnimatedScale (implicit animations), Future.delayed.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    // Start the entrance animation after a short delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) setState(() => _animate = true);
    });
    // Navigate to Login after 3 seconds
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LoginScreen(),
            transitionDuration: const Duration(milliseconds: 800),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.darkBg, AppColors.darkSurface, AppColors.darkBg],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated Logo
            AnimatedOpacity(
              opacity: _animate ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1000),
              child: AnimatedScale(
                scale: _animate ? 1.0 : 0.5,
                duration: const Duration(milliseconds: 1000),
                curve: Curves.easeOutBack,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.gold, AppColors.gold.withOpacity(0.6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gold.withOpacity(0.3),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.shopping_bag_rounded, size: 60, color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // Animated App Name
            AnimatedOpacity(
              opacity: _animate ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1200),
              child: AnimatedSlide(
                offset: _animate ? Offset.zero : const Offset(0, 0.5),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOut,
                child: const Column(
                  children: [
                    Text(
                      'WEAR-WELL',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 6,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Premium Fashion Store',
                      style: TextStyle(fontSize: 14, color: AppColors.gold, letterSpacing: 2),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            // Loading indicator
            AnimatedOpacity(
              opacity: _animate ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 1500),
              child: const SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.gold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
