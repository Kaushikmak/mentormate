import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
      return true;
    } catch (e) {
      _error = _handleAuthError(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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

  Future<bool> resetPassword(String email) async {
    if (_isLoading) return false;

    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      switch (e.code) {
        case 'user-not-found':
          _error = 'No user found with this email address.';
          break;
        case 'invalid-email':
          _error = 'Invalid email address format.';
          break;
        default:
          _error = 'Error: ${e.message}';
      }
      return false;
    } catch (e) {
      // Handle other errors
      _error = 'An unexpected error occurred: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _setError(String message) {
    _error = message;
    notifyListeners();
  }

  Future<bool> updateUserData(String userKey, Map<String, dynamic> data) async {
    if (_isLoading) return false;

    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      await FirebaseDatabase.instance.ref("users").child(userKey).update(data);
      return true;
    } catch (e) {
      _error = 'Failed to update user data: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> reauthenticateUser(String password) async {
    if (_isLoading) return false;

    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      if (_user == null || _user!.email == null) {
        _error = 'No user is logged in or email is missing';
        return false;
      }

      // Create credential
      AuthCredential credential = EmailAuthProvider.credential(
        email: _user!.email!,
        password: password,
      );

      // Reauthenticate
      await _user!.reauthenticateWithCredential(credential);
      return true;
    } catch (e) {
      _error = _handleAuthError(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteAccount() async {
    if (_isLoading) return false;

    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      if (_user == null) {
        _error = 'No user is logged in';
        return false;
      }

      // Find user data in database
      final databaseRef = FirebaseDatabase.instance.ref("users");
      final query = databaseRef.orderByChild("uid").equalTo(_user!.uid);
      final snapshot = await query.get();

      if (snapshot.exists) {
        // Get the user key
        final data = snapshot.value as Map;
        final key = data.keys.first;
        final userInfo = data[key] as Map;

        // Delete user avatar if exists
        if (userInfo['avatarUrl'] != null) {
          try {
            final storageRef = FirebaseStorage.instance
                .refFromURL(userInfo['avatarUrl']);
            await storageRef.delete();
          } catch (e) {
            print("Error deleting avatar: $e");
          }
        }

        // Delete user data from database
        await databaseRef.child(key.toString()).remove();
      }

      // Delete the user account
      await _user!.delete();
      _user = null;
      return true;

    } catch (e) {
      _error = _handleAuthError(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> changePassword(String currentPassword, String newPassword) async {
    if (_isLoading) return false;

    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      if (_user == null || _user!.email == null) {
        _error = 'No user is logged in or email is missing';
        return false;
      }

      // Reauthenticate first
      bool reauth = await reauthenticateUser(currentPassword);
      if (!reauth) {
        return false;
      }

      // Change password
      await _user!.updatePassword(newPassword);
      return true;
    } catch (e) {
      _error = _handleAuthError(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
