import 'package:firebase_auth/firebase_auth.dart' as fba;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart' as local_auth; // Fix ambiguous import
import 'package:firebase_database/firebase_database.dart';
import 'package:mentormate/caching/avatar_cache_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:io';

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  CustomDrawer({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<local_auth.AuthProvider>(context);
    final userId = authProvider.user?.uid;

    return Drawer(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/user-profile');
            },
            child: FutureBuilder<Map<String, dynamic>?>(
              future: _getUserData(userId),
              builder: (context, snapshot) {
                String avatarUrl = "https://via.placeholder.com/150";
                String userName = "User";
                String email = authProvider.user?.email ?? "No email";

                if (snapshot.hasData && snapshot.data != null) {
                  avatarUrl = snapshot.data!['avatarUrl'] ?? avatarUrl;
                  userName = snapshot.data!['Name'] ?? "User";
                  email = snapshot.data!['email'] ?? email;
                }

                return UserAccountsDrawerHeader(
                  accountName: Text(
                    userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(email),
                  currentAccountPicture: FutureBuilder<String>(
                    future: AvatarCacheManager.getAvatarPath(
                      userId ?? '',
                      avatarUrl,
                    ),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                        return CircleAvatar(
                          backgroundImage: FileImage(File(snapshot.data!)),
                        );
                      } else {
                        return CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(avatarUrl),
                        );
                      }
                    },
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildNavItem(context, 'Home', Icons.home, 0),
                _buildNavItem(context, 'Mentors', Icons.people, 1),
                _buildNavItem(context, 'Schedule', Icons.calendar_today, 2),
                _buildNavItem(context, 'Resources', Icons.book, 3),
                _buildNavItem(context, 'Department', Icons.school, 4),
                _buildNavItem(context, 'Activities', Icons.sports_basketball, 5),
                _buildNavItem(context, 'VNIT Map', Icons.location_on, 6),

              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          _buildNavItem(context, 'Settings', Icons.settings, 7),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await authProvider.signOut();
                Navigator.of(context).pushReplacementNamed('/login');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String title, IconData icon, int index) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      selected: selectedIndex == index,
      onTap: () {
        onItemSelected(index);
        Navigator.pop(context);
      },
    );
  }

  Future<Map<String, dynamic>?> _getUserData(String? userId) async {
    if (userId == null) return null;

    try {
      final userRef = FirebaseDatabase.instance.ref("users/$userId");
      final defaultRef = FirebaseDatabase.instance.ref("default_user_data/$userId");

      final userSnapshot = await userRef.get();
      final defaultSnapshot = await defaultRef.get();

      if (!userSnapshot.exists && !defaultSnapshot.exists) return null;

      final userData = userSnapshot.exists ? Map<String, dynamic>.from(userSnapshot.value as Map) : {};
      final defaultData = defaultSnapshot.exists ? Map<String, dynamic>.from(defaultSnapshot.value as Map) : {};

      return {...userData, ...defaultData};
    } catch (e) {
      print('🔥 Error fetching user data: $e');
      return null;
    }
  }
}