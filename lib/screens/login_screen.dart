import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/wishlist_provider.dart';
import '../providers/order_provider.dart';
import '../theme/app_theme.dart';
import '../utils/app_animations.dart';
import 'register_screen.dart';
import 'home_screen.dart';
import 'forgot_password_screen.dart';

/// Login screen with Form validation and Firestore authentication.
/// Concepts: GlobalKey<FormState>, TextFormField, validator, StatefulWidget,
/// Firestore query for login comparison.
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Form key for validation
  final _formKey = GlobalKey<FormState>();

  // Controllers (properly managed in StatefulWidget)
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // Validate the form before proceeding
    if (!_formKey.currentState!.validate()) return;

    debugPrint('LoginScreen: Starting login for ${_emailController.text}');
    final auth = Provider.of<AuthProvider>(context, listen: false);
    final error = await auth.login(
      _emailController.text,
      _passController.text,
    );

    if (!mounted) return;

    if (error != null) {
      debugPrint('LoginScreen: Login failed with error: $error');
      // Show error from Firestore
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error), backgroundColor: AppColors.error),
      );
    } else {
      debugPrint('LoginScreen: Login successful, initializing providers...');
      // Login successful — load user-specific data
      final userId = auth.userId!;
      await Provider.of<WishlistProvider>(context, listen: false).setUser(userId);
      await Provider.of<OrderProvider>(context, listen: false).setUser(userId);

      if (!mounted) return;

      debugPrint('LoginScreen: All ready, navigating to HomeScreen');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login Successful ✓')),
      );
      Navigator.pushReplacement(context, fadeRoute(const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.darkBg, AppColors.darkSurface],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // ── Logo ──
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.gold.withOpacity(0.1),
                        border: Border.all(color: AppColors.gold.withOpacity(0.3)),
                      ),
                      child: const Icon(Icons.shopping_bag_rounded, size: 50, color: AppColors.gold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'WEAR-WELL',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 4, color: Colors.white),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Sign in to continue',
                      style: TextStyle(color: Colors.white54, fontSize: 14),
                    ),
                    const SizedBox(height: 40),

                    // ── Email Field ──
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 18),

                    // ── Password Field ──
                    TextFormField(
                      controller: _passController,
                      obscureText: _obscurePassword,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword ? Icons.visibility_off : Icons.visibility,
                            color: Colors.white38,
                          ),
                          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),

                    // ── Forgot Password ──
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.push(context, fadeRoute(const ForgotPasswordScreen())),
                        child: const Text('Forgot Password?'),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // ── Login Button ──
                    auth.isLoading
                        ? const CircularProgressIndicator(color: AppColors.gold)
                        : ElevatedButton(
                            onPressed: _login,
                            child: const Text('LOGIN'),
                          ),
                    const SizedBox(height: 20),

                    // ── Register Link ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?", style: TextStyle(color: Colors.white54)),
                        TextButton(
                          onPressed: () => Navigator.push(context, fadeRoute(const RegisterScreen())),
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}