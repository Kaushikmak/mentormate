import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
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
    return Drawer(
      child: Column(
        children: [
          // User profile section with GestureDetector to make it clickable
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/user-profile');
            },
            child: FutureBuilder<Map<String, dynamic>?>(
              future: _getUserData(Provider.of<AuthProvider>(context).user?.uid),
              builder: (context, AsyncSnapshot<Map<String, dynamic>?> snapshot) {
                String avatarUrl = "https://via.placeholder.com/150";
                String userName = "User";

                if (snapshot.hasData && snapshot.data != null) {
                  avatarUrl = snapshot.data!['avatarUrl'] ?? avatarUrl;
                  userName = snapshot.data!['email'] ?? "User";
                }

                return UserAccountsDrawerHeader(
                  accountName: Text(
                    userName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(
                    Provider.of<AuthProvider>(context).user?.email ?? "No email",
                  ),
                  currentAccountPicture: FutureBuilder<String>(
                    future: AvatarCacheManager.getAvatarPath(
                        Provider.of<AuthProvider>(context).user?.uid ?? '',
                        avatarUrl
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
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: _buildNavItem(context, 'Settings', Icons.settings, 6),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () async {
                await Provider.of<AuthProvider>(context, listen: false).signOut();
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
      final databaseRef = FirebaseDatabase.instance.ref("users");
      final query = databaseRef.orderByChild("uid").equalTo(userId);
      final snapshot = await query.get();

      if (snapshot.exists) {
        final data = snapshot.value as Map<dynamic, dynamic>;
        final userKey = data.keys.first;
        final userInfo = data[userKey] as Map<dynamic, dynamic>;
        return Map<String, dynamic>.from(userInfo);
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }

    return null;
  }
}
