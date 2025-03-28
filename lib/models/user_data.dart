import 'package:hive/hive.dart';

part 'user_data.g.dart'; // Hive will generate this file automatically

@HiveType(typeId: 0)
class UserData {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String avatarUrl;

  @HiveField(3)
  final String enrollmentNumber;

  @HiveField(4)
  final DateTime lastSyncTimestamp;

  UserData({
    required this.name,
    required this.email,
    required this.avatarUrl,
    required this.enrollmentNumber,
    required this.lastSyncTimestamp,
  });
}
