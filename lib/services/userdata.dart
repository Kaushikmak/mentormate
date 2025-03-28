import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logger/logger.dart';

// Custom exceptions
class UserDataException implements Exception {
  final String message;
  UserDataException(this.message);

  @override
  String toString() => 'UserDataException: $message';
}

class UserNotFoundException extends UserDataException {
  UserNotFoundException(super.message);
}

class DataNotFoundException extends UserDataException {
  DataNotFoundException(super.message);
}

class FirebaseUserService {
  final FirebaseAuth _auth;
  final FirebaseDatabase _database;
  final Logger _logger;

  FirebaseUserService({
    FirebaseAuth? auth,
    FirebaseDatabase? database,
    Logger? logger,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _database = database ?? FirebaseDatabase.instance,
        _logger = logger ?? Logger();

  Future<Map<String, dynamic>> getMergedUserData() async {
    try {
      // 1. Authentication check
      final user = _auth.currentUser;
      if (user == null) {
        throw UserNotFoundException('No authenticated user found');
      }

      // 2. Query user reference
      final usersQuery = _database.ref('users').orderByChild('uid').equalTo(user.uid);
      final usersSnapshot = await usersQuery.get().timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('User data query timed out');
        },
      );

      // 3. Handle user not found
      if (!usersSnapshot.exists || usersSnapshot.children.isEmpty) {
        throw UserNotFoundException('No user data found for UID: ${user.uid}');
      }

      // 4. Get numeric user ID
      final userDataSnapshot = usersSnapshot.children.first;
      final numericUserId = userDataSnapshot.key;
      if (numericUserId == null || numericUserId.isEmpty) {
        throw UserDataException('Invalid numeric user ID format');
      }

      // 5. Fetch data from both nodes in parallel
      final userRef = _database.ref('users/$numericUserId');
      final defaultRef = _database.ref('default_user_data/$numericUserId');

      final results = await Future.wait(
        [userRef.get(), defaultRef.get()],
        eagerError: true,
      );

      // 6. Process snapshots
      final userSnapshot = results[0];
      final defaultSnapshot = results[1];

      final mergedData = <String, dynamic>{};

      if (userSnapshot.exists) {
        _mergeData(mergedData, userSnapshot, 'users');
      }

      if (defaultSnapshot.exists) {
        _mergeData(mergedData, defaultSnapshot, 'default_user_data');
      }

      // 7. Validate merged data
      if (mergedData.isEmpty) {
        throw DataNotFoundException(
            'No data found in either node for user $numericUserId'
        );
      }

      _logger.i('Successfully merged data for user $numericUserId');
      return mergedData;

    } on FirebaseException catch (e, stack) {
      _logger.e('Firebase error: ${e.message}', error: e, stackTrace: stack);
      throw UserDataException(_getFirebaseErrorMessage(e));
    } on TimeoutException catch (e, stack) {
      _logger.e('Timeout: ${e.message}', error: e, stackTrace: stack);
      throw UserDataException('Request timed out. Please check your connection');
    } on UserDataException catch (e, stack) {
      _logger.e('Data error: ${e.message}', error: e, stackTrace: stack);
      rethrow;
    } catch (e, stack) {
      _logger.e('Unexpected error: $e', error: e, stackTrace: stack);
      throw UserDataException('An unexpected error occurred');
    }
  }

  void _mergeData(
      Map<String, dynamic> target,
      DataSnapshot snapshot,
      String sourceName,
      ) {
    try {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      target.addAll(data);
      _logger.d('Merged $sourceName data: ${data.keys}');
    } catch (e, stack) {
      _logger.e('Failed to parse $sourceName data', error: e, stackTrace: stack);
      throw UserDataException('Invalid data format in $sourceName node');
    }
  }

  String _getFirebaseErrorMessage(FirebaseException e) {
    switch (e.code) {
      case 'PERMISSION_DENIED':
        return 'You don\'t have permission to access this data';
      case 'DATA_STALE':
      case 'UNAVAILABLE':
        return 'Network error. Please check your connection';
      default:
        return 'Database error: ${e.message ?? 'Unknown error'}';
    }
  }
}
