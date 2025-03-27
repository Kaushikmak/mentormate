import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:async';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  Map<String, dynamic>? _userData;
  String _error = '';
  bool _isLoading = false;

  User? get user => _user;
  Map<String, dynamic>? get userData => _userData;
  String get error => _error;
  bool get isLoading => _isLoading;
  bool get isLoggedIn => _user != null;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    _user = _auth.currentUser;
    _fetchUserData();
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      _fetchUserData();
      notifyListeners();
    });
  }

  /// Fetch user data from Firebase Realtime Database
  Future<void> _fetchUserData() async {
    if (_user == null) return;

    try {
      final userId = _user!.uid;
      final userRef = FirebaseDatabase.instance.ref("users/$userId");
      final userSnapshot = await userRef.get();

      final defaultRef = FirebaseDatabase.instance.ref("default_user_data/$userId");
      final defaultSnapshot = await defaultRef.get();

      final userDataMap = userSnapshot.exists
          ? Map<String, dynamic>.from(userSnapshot.value as Map)
          : {};

      final defaultDataMap = defaultSnapshot.exists
          ? Map<String, dynamic>.from(defaultSnapshot.value as Map)
          : {};

      _userData = {...userDataMap, ...defaultDataMap};
    } catch (e) {
      _error = '🔥 Error fetching user data: $e';
      _userData = null;
    } finally {
      notifyListeners();
    }
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
      await _fetchUserData();
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
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final databaseRef = FirebaseDatabase.instance.ref('users/$idNumber');
      final snapshot = await databaseRef.get();

      if (snapshot.exists) {
        _error = 'A user with this ID number already exists';
        return false;
      }

      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      ).timeout(const Duration(seconds: 15));

      _user = userCredential.user;

      await databaseRef.set({
        'uid': _user!.uid,
        'email': email,
        'idNumber': idNumber,
        'enrollmentNumber': enrollmentNumber,
        'createdAt': ServerValue.timestamp,
      });

      await _fetchUserData();
      return true;
    } catch (e) {
      _error = _handleAuthError(e);
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _handleAuthError(dynamic error) {
    if (error is FirebaseAuthException) {
      return error.message ?? 'Authentication error occurred.';
    } else {
      return error.toString();
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _user = null;
      _userData = null;
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
      _error = 'An unexpected error occurred: ${e.toString()}';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> updateUserData(String userKey, Map<String, dynamic> data) async {
    if (_isLoading) return false;

    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      await FirebaseDatabase.instance.ref("users").child(userKey).update(data);
      await _fetchUserData();
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

      AuthCredential credential = EmailAuthProvider.credential(
        email: _user!.email!,
        password: password,
      );

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

      final databaseRef = FirebaseDatabase.instance.ref("users");
      final query = databaseRef.orderByChild("uid").equalTo(_user!.uid);
      final snapshot = await query.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map;
        final key = data.keys.first;
        final userInfo = data[key] as Map;

        if (userInfo['avatarUrl'] != null) {
          try {
            final storageRef = FirebaseStorage.instance.refFromURL(userInfo['avatarUrl']);
            await storageRef.delete();
          } catch (e) {
            print("Error deleting avatar: $e");
          }
        }

        await databaseRef.child(key.toString()).remove();
      }

      await _user!.delete();
      _user = null;
      _userData = null;
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
