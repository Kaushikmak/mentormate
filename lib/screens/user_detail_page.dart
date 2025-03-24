import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import 'package:firebase_database/firebase_database.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final user = authProvider.user;

      if (user == null) {
        setState(() {
          error = "User not authenticated";
          isLoading = false;
        });
        return;
      }

      // Query the database to find the user by their UID
      final databaseRef = FirebaseDatabase.instance.ref("users");
      final query = databaseRef.orderByChild("uid").equalTo(user.uid);
      final snapshot = await query.get();

      if (snapshot.exists) {
        // Convert the data to a Map
        final data = snapshot.value as Map<dynamic, dynamic>;
        // Get the first entry (there should only be one)
        final userKey = data.keys.first;
        final userInfo = data[userKey] as Map<dynamic, dynamic>;

        // Convert to Map<String, dynamic>
        final userDataMap = Map<String, dynamic>.from(userInfo);

        setState(() {
          userData = userDataMap;
          isLoading = false;
        });
      } else {
        setState(() {
          error = "User data not found";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = "Error fetching user data: $e";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text(error!, style: const TextStyle(color: Colors.red)))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage("https://via.placeholder.com/150"),
            ),
            const SizedBox(height: 24),
            Text(
              userData?['email'] ?? 'No Email',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildInfoCard('ID Number', userData?['idNumber'] ?? 'Not provided'),
            _buildInfoCard('Enrollment Number', userData?['enrollmentNumber'] ?? 'Not provided'),
            _buildInfoCard('Account Created', _formatTimestamp(userData?['createdAt'])),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Add functionality to edit profile
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit profile functionality coming soon')),
                );
              },
              child: const Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(dynamic timestamp) {
    if (timestamp == null) return 'Unknown';

    try {
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp as int);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return 'Invalid date';
    }
  }
}
