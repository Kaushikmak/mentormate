import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/user_data.dart';

class UserDataRepository {
  late Box<UserData> _userDataBox;

  Future<void> initializeHive() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserDataAdapter());
    _userDataBox = await Hive.openBox<UserData>('user_data');
  }

  Future<void> saveUserData(UserData userData) async {
    await _userDataBox.put('current_user', userData);
  }

  UserData? getUserData() {
    return _userDataBox.get('current_user');
  }

  Future<void> deleteUserData() async {
    await _userDataBox.delete('current_user');
  }
}
