import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import '../providers/auth_provider.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  Map<String, dynamic>? userData;
  bool isLoading = true;
  String? error;
  String? userKey; // Store the user's key in the database

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
        final key = data.keys.first;
        final userInfo = data[key] as Map<dynamic, dynamic>;

        // Convert to Map<String, dynamic>
        final userDataMap = Map<String, dynamic>.from(userInfo);

        setState(() {
          userKey = key.toString(); // Save the user key for later use
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

  // Add this method to pick an image from gallery
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );

    if (image != null) {
      _uploadImage(File(image.path));
    }
  }

  // Add this method to upload the image to Firebase Storage
  Future<void> _uploadImage(File imageFile) async {
    setState(() {
      isLoading = true;
    });

    try {
      // Use the ID number as the unique identifier for the image
      final String idNumber = userData?['idNumber'] ?? 'unknown';

      // Create a reference to the file location in Firebase Storage
      final storageRef = FirebaseStorage.instance.ref()
          .child('user_avatars')
          .child('$idNumber.jpg');

      // Upload the file
      await storageRef.putFile(imageFile);

      // Get the download URL
      final downloadUrl = await storageRef.getDownloadURL();

      // Update the user's data in the Realtime Database
      if (userKey != null) {
        await FirebaseDatabase.instance
            .ref("users")
            .child(userKey!)
            .update({'avatarUrl': downloadUrl});

        // Update local state
        setState(() {
          userData = {...userData!, 'avatarUrl': downloadUrl};
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = "Error uploading image: $e";
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
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Replace the CircleAvatar with this Stack to add edit functionality
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: userData?['avatarUrl'] != null
                          ? NetworkImage(userData!['avatarUrl'])
                          : const NetworkImage("https://via.placeholder.com/150"),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, color: Colors.white),
                          onPressed: _pickImage,
                        ),
                      ),
                    ),
                  ],
                ),
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
