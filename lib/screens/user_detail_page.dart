// screens/user_detail_page.dart
import 'package:flutter/material.dart';

class UserDetailPage extends StatelessWidget {
  final String userName;
  final String userEmail;
  final String userAvatar;

  const UserDetailPage({
    Key? key,
    required this.userName,
    required this.userEmail,
    required this.userAvatar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(userAvatar),
            ),
            SizedBox(height: 20),
            Text(
              userName,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 10),
            Text(
              userEmail,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 30),
            // Add more user details here
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
              onTap: () {
                // Implement edit profile functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('Security Settings'),
              onTap: () {
                // Implement security settings functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help & Support'),
              onTap: () {
                // Implement help & support functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
