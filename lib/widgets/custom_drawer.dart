import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
// Import the UserDetailPage

class CustomDrawer extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  // Mock user data - in a real app, this would come from your auth system
  final String userName = "John Doe";
  final String userEmail = "john.doe@example.com";
  final String userAvatar = "https://via.placeholder.com/150";

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
            child: UserAccountsDrawerHeader(
              accountName: Text(
                userName,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                Provider.of<AuthProvider>(context).user?.email ?? "No email",
              ),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(userAvatar),
              ),
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),

            ),
          ),

          const Divider(height: 1, thickness: 1),

          // Rest of your drawer code remains the same
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

          // Settings section at the bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: _buildNavItem(context, 'Settings', Icons.settings, 6),
          ),

          // Logout option
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
        Navigator.pop(context); // Close the drawer after selection
      },
    );
  }
}
