import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart' as local_auth;
import 'package:cached_network_image/cached_network_image.dart';
import '../services/userdata.dart';
import 'package:logger/logger.dart';

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;
  final Logger _logger = Logger();

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
              future: _fetchUserData(),
              builder: (context, snapshot) {
                String avatarUrl = "https://via.placeholder.com/150";
                String userName = "User";
                String email = authProvider.user?.email ?? "No email";

                if (snapshot.hasData && snapshot.data != null) {
                  avatarUrl = snapshot.data!['avatarUrl'] ?? avatarUrl;
                  userName = snapshot.data!['Name'] ?? "User";
                  email = snapshot.data!['email'] ?? email;
                }

                return Container(
                  color: Colors.blue,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: _buildAvatar(userId, avatarUrl),

                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Center(
                            child: Text(
                              email,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
              onTap: () => _handleLogout(context, authProvider),
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>?> _fetchUserData() async {
    try {
      return await FirebaseUserService().getMergedUserData();
    } catch (e) {
      _logger.e('Error fetching user data');
      return null;
    }
  }

  Widget _buildAvatar(String? userId, String avatarUrl) {
    return Center(
      child: CachedNetworkImage(

        imageUrl: avatarUrl,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: 40,
          backgroundImage: imageProvider,
        ),
        placeholder: (context, url) => CircleAvatar(
          backgroundColor: Colors.grey[200],
          child: CircularProgressIndicator(),
        ),
        errorWidget: (context, url, error) => CircleAvatar(
          backgroundImage: AssetImage('assets/user.png'),
        ),
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

  void _handleLogout(BuildContext context, local_auth.AuthProvider authProvider) async {
    try {
      await authProvider.signOut();
      Navigator.of(context).pushReplacementNamed('/login');
    } catch (e) {
      _logger.e('Error during logout');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to logout. Please try again.')),
      );
    }
  }
}
