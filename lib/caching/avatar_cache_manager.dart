import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

class AvatarCacheManager {
  static Future<String> getAvatarPath(String userId, String avatarUrl) async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/avatar_$userId.jpg';
    final file = File(path);

    if (await file.exists()) {
      return path;
    } else {
      // Download and save the avatar
      final response = await http.get(Uri.parse(avatarUrl));
      await file.writeAsBytes(response.bodyBytes);
      return path;
    }
  }
}
