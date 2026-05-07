import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Manages user authentication state using Cloud Firestore.
/// Concepts: Firestore CRUD, password hashing, session management.
class AuthProvider with ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  String? _userId;
  String? _userName;
  String? _userEmail;
  bool _isLoading = false;

  /// Current user's Firestore document ID.
  String? get userId => _userId;

  /// Current user's display name.
  String? get userName => _userName;

  /// Current user's email.
  String? get userEmail => _userEmail;

  /// Whether an auth operation is in progress.
  bool get isLoading => _isLoading;

  /// Whether a user is currently logged in.
  bool get isLoggedIn => _userId != null;

  // ── Helpers ──

  /// Hashes a plain-text password using SHA-256.
  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  // ── Register ──

  /// Creates a new user document in the `users` collection.
  /// Returns `null` on success, or an error message string.
  Future<String?> register(String name, String email, String password) async {
    debugPrint('AuthProvider: Starting registration for $email');
    _isLoading = true;
    notifyListeners();

    try {
      debugPrint('AuthProvider: Checking for existing email...');
      final snapshot = await _db
          .collection('users')
          .where('email', isEqualTo: email.toLowerCase().trim())
          .get()
          .timeout(const Duration(seconds: 10));

      if (snapshot.docs.isNotEmpty) {
        debugPrint('AuthProvider: Email already exists');
        _isLoading = false;
        notifyListeners();
        return 'An account with this email already exists';
      }

      debugPrint('AuthProvider: Creating user document...');
      await _db.collection('users').add({
        'name': name.trim(),
        'email': email.toLowerCase().trim(),
        'password': _hashPassword(password),
        'createdAt': DateTime.now().toIso8601String(), // Use local ISO string for now
      });

      debugPrint('AuthProvider: Registration successful');
      _isLoading = false;
      notifyListeners();
      return null; // success
    } catch (e) {
      debugPrint('AuthProvider: Registration error: $e');
      _isLoading = false;
      notifyListeners();
      return 'Registration failed: ${e.toString()}';
    }
  }

  // ── Login ──

  /// Authenticates a user by querying Firestore for matching email & password.
  /// Returns `null` on success, or an error message string.
  Future<String?> login(String email, String password) async {
    debugPrint('AuthProvider: Starting login for $email');
    _isLoading = true;
    notifyListeners();

    try {
      debugPrint('AuthProvider: Fetching user document...');
      final snapshot = await _db
          .collection('users')
          .where('email', isEqualTo: email.toLowerCase().trim())
          .get()
          .timeout(const Duration(seconds: 10));

      if (snapshot.docs.isEmpty) {
        debugPrint('AuthProvider: No account found for $email');
        _isLoading = false;
        notifyListeners();
        return 'No account found with this email';
      }

      final userDoc = snapshot.docs.first;
      final storedHash = userDoc.data()['password'] as String;

      if (storedHash != _hashPassword(password)) {
        debugPrint('AuthProvider: Incorrect password');
        _isLoading = false;
        notifyListeners();
        return 'Incorrect password';
      }

      // Credentials match — set session
      debugPrint('AuthProvider: Login success for ${userDoc.data()['name']}');
      _userId = userDoc.id;
      _userName = userDoc.data()['name'] as String;
      _userEmail = userDoc.data()['email'] as String;
      _isLoading = false;
      notifyListeners();
      return null; // success
    } catch (e) {
      debugPrint('AuthProvider: Login error: $e');
      _isLoading = false;
      notifyListeners();
      return 'Login failed: ${e.toString()}';
    }
  }

  // ── Logout ──

  /// Clears the current user session.
  void logout() {
    _userId = null;
    _userName = null;
    _userEmail = null;
    notifyListeners();
  }
}
