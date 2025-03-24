import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String _error = '';
  bool _isLoading = false;

  User? get user => _user;
  String get error => _error;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _user = _auth.currentUser;
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signIn(String email, String password) async {
    if (_isLoading) return false;
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).timeout(const Duration(seconds: 15));

      _user = userCredential.user;
    } catch (e) {
      _error = _handleAuthError(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    return _error.isEmpty;
  }

  Future<bool> register(String email, String password, String idNumber, String enrollmentNumber) async {
    if (_isLoading) return false;
    print("Starting registration process");
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();
      print("Set isLoading to true");

      // Check if a user with this ID already exists in the database
      final databaseRef = FirebaseDatabase.instance.ref('users/$idNumber');
      final snapshot = await databaseRef.get();
      print("Database check completed");

      if (snapshot.exists) {
        print("User ID already exists");
        _error = 'A user with this ID number already exists';
        return false;
      }

      print("Creating user with Firebase Auth");
      // Create user with email and password
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).timeout(const Duration(seconds: 15));

      _user = userCredential.user;
      print("User created successfully");

      // Store user data in Realtime Database
      print("Storing user data in database");
      await databaseRef.set({
        'uid': _user!.uid,
        'email': email,
        'idNumber': idNumber,
        'enrollmentNumber': enrollmentNumber,
        'createdAt': ServerValue.timestamp,
      });
      print("Registration complete");
      return true;
    } catch (e) {
      print("Error during registration: $e");
      _error = _handleAuthError(e);
      return false;
    } finally {
      _isLoading = false;
      print("Set isLoading to false in finally block");
      notifyListeners();
    }
  }

  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      return error.message ?? 'Authentication error occurred.';
    } else if (error.toString().contains('PegionUser')) {
      return 'Error with user data. Please try again.';
    } else {
      return error.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _user = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      notifyListeners();
    }
  }
}
