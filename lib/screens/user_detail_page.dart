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
  State createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  Map<dynamic, dynamic>? userData;
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
        final data = snapshot.value as Map;
        // Get the first entry (there should only be one)
        final key = data.keys.first;
        final userInfo = data[key] as Map;
        // Convert to Map
        final userDataMap = Map<dynamic, dynamic>.from(userInfo);
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
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('user_avatars')
          .child('$idNumber.jpg');
      // Upload the file
      await storageRef.putFile(imageFile);
      // Get the download URL
      final downloadUrl = await storageRef.getDownloadURL();
      // Update the user's data in the Realtime Database
      if (userKey != null) {
        await FirebaseDatabase.instance.ref("users").child(userKey!).update({
          'avatarUrl': downloadUrl,
        });
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

  void _editProfile() {
    // Create controllers pre-filled with current data
    final emailController = TextEditingController(text: userData?['email']);
    final enrollmentController = TextEditingController(text: userData?['enrollmentNumber']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                enabled: false, // Email shouldn't be editable directly
              ),
              TextField(
                controller: enrollmentController,
                decoration: const InputDecoration(labelText: 'Enrollment Number'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              // Update data in Firebase
              if (userKey != null) {
                setState(() => isLoading = true);
                try {
                  await FirebaseDatabase.instance.ref("users").child(userKey!).update({
                    'enrollmentNumber': enrollmentController.text,
                  });
                  // Update local state
                  setState(() {
                    userData = {...userData!, 'enrollmentNumber': enrollmentController.text};
                    isLoading = false;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile updated successfully')),
                  );
                } catch (e) {
                  setState(() {
                    error = "Error updating profile: $e";
                    isLoading = false;
                  });
                  Navigator.pop(context);
                }
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Change Password'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                decoration: const InputDecoration(labelText: 'Current Password'),
                obscureText: true,
              ),
              TextField(
                controller: newPasswordController,
                decoration: const InputDecoration(labelText: 'New Password'),
                obscureText: true,
              ),
              TextField(
                controller: confirmPasswordController,
                decoration: const InputDecoration(labelText: 'Confirm New Password'),
                obscureText: true,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (newPasswordController.text != confirmPasswordController.text) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('New passwords do not match')),
                );
                return;
              }

              Navigator.pop(context);
              setState(() => isLoading = true);

              final authProvider = Provider.of<AuthProvider>(context, listen: false);
              final success = await authProvider.changePassword(
                  currentPasswordController.text,
                  newPasswordController.text
              );

              setState(() => isLoading = false);

              if (success) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password changed successfully')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(authProvider.error)),
                );
              }
            },
            child: const Text('Change Password'),
          ),
        ],
      ),
    );
  }

  void _showDeleteAccountDialog() {
    final passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Account'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure you want to delete your account? This action cannot be undone and all your data will be permanently removed.',
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Enter your password to confirm'),
              obscureText: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              setState(() => isLoading = true);

              final authProvider = Provider.of<AuthProvider>(context, listen: false);

              // First reauthenticate
              final reauth = await authProvider.reauthenticateUser(passwordController.text);

              if (!reauth) {
                setState(() {
                  error = authProvider.error;
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error ?? 'Failed to authenticate')),
                );
                return;
              }

              // Then delete account
              final success = await authProvider.deleteAccount();

              if (success) {
                // Navigate to login screen
                Navigator.of(context).pushReplacementNamed('/login');
              } else {
                setState(() {
                  error = authProvider.error;
                  isLoading = false;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(error ?? 'Failed to delete account')),
                );
              }
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
          ? Center(
        child: Text(error!, style: const TextStyle(color: Colors.red)),
      )
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
                          : const NetworkImage(
                        "https://via.placeholder.com/150",
                      ),
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
                          icon: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
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
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildInfoCard(
                'ID Number',
                userData?['idNumber'] ?? 'Not provided',
              ),
              _buildInfoCard(
                'Enrollment Number',
                userData?['enrollmentNumber'] ?? 'Not provided',
              ),
              _buildInfoCard(
                'Account Created',
                _formatTimestamp(userData?['createdAt']),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _editProfile,
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: _showChangePasswordDialog,
                child: const Text('Change Password'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _showDeleteAccountDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Delete Account'),
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
            Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
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
