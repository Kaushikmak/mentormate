import '../repositories/user_data_repository.dart';
import '../models/user_data.dart';
import 'package:firebase_database/firebase_database.dart';

class SyncService {
  final UserDataRepository _repository;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  SyncService(this._repository);

  Future<void> syncUserData(String userId) async {
    try {
      // Fetch data from local storage
      UserData? localData = _repository.getUserData();

      // Check if synchronization is needed
      if (localData == null || _shouldSync(localData.lastSyncTimestamp)) {
        // Fetch data from Firebase Realtime Database
        DatabaseReference userRef = _database.ref('users/$userId');
        DataSnapshot snapshot = await userRef.get();

        if (snapshot.exists) {
          Map<String, dynamic> remoteData = Map<String, dynamic>.from(snapshot.value as Map);
          UserData newUserData = UserData(
            name: remoteData['name'] ?? '',
            email: remoteData['email'] ?? '',
            avatarUrl: remoteData['avatarUrl'] ?? '',
            enrollmentNumber: remoteData['enrollmentNumber'] ?? '',
            lastSyncTimestamp: DateTime.now(),
          );

          // Save updated data locally
          await _repository.saveUserData(newUserData);
        }
      }
    } catch (e) {
      print('Error syncing user data: $e');
    }
  }

  bool _shouldSync(DateTime lastSync) {
    return DateTime.now().difference(lastSync).inHours > 1; // Sync every hour
  }
}
