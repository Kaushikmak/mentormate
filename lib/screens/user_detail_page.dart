import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({Key? key}) : super(key: key);

  @override
  _UserDetailPageState createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  bool isLoading = true;
  String? error;
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('Auth UID: ${user.uid}');
      print('Auth Email: ${user.email}');
      await _fetchMergedUserData();
      _initRealTimeUpdates();
    } else {
      setState(() {
        error = "Not authenticated";
        isLoading = false;
      });
    }
  }

  Future<void> _fetchMergedUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        print('Authentication Error: No user logged in');
        setState(() => error = "Not authenticated");
        return;
      }

      // Use numeric ID directly (30447) instead of auth.uid
      const userId = "30447"; // Replace this with dynamic fetching logic if needed

      // Fetch user data from 'users' node
      final usersPath = "users/$userId";
      print("Fetching from users node: $usersPath");

      final userRef = FirebaseDatabase.instance.ref(usersPath);
      final userSnapshot = await userRef.get();

      if (!userSnapshot.exists) {
        print('❌ User data not found at path: $usersPath');
        setState(() => error = "User data not found");
        return;
      }

      final userData = userSnapshot.value as Map<dynamic, dynamic>;
      print('✅ User data found: ${userData.toString()}');

      // Fetch additional data from 'default_user_data' node
      final defaultDataPath = "default_user_data/$userId";
      print("Fetching from default data node: $defaultDataPath");

      final defaultRef = FirebaseDatabase.instance.ref(defaultDataPath);
      final defaultSnapshot = await defaultRef.get();

      if (!defaultSnapshot.exists) {
        print('❌ Default data not found at path: $defaultDataPath');
        setState(() => error = "Additional data not found");
        return;
      }

      print('✅ Default data found: ${defaultSnapshot.value.toString()}');

      // Merge both datasets
      setState(() {
        this.userData = {
          ...Map<String, dynamic>.from(userData),
          ...Map<String, dynamic>.from(defaultSnapshot.value as Map)
        };
        isLoading = false;
      });

    } catch (e) {
      print('🔥 Error fetching data: ${e.toString()}');
      setState(() => error = "Data loading failed");
    }
  }

  void _initRealTimeUpdates() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

        FirebaseDatabase.instance.ref("users/$userId").onValue.listen((event) {
      if (event.snapshot.exists) {
        _mergeData(event.snapshot);
      }
    });

    FirebaseDatabase.instance.ref("default_user_data/$userId").onValue.listen((event) {
      if (event.snapshot.exists) {
        _mergeData(event.snapshot);
      }
    });
  }

  void _mergeData(DataSnapshot snapshot) {
    try {
      final newData = Map<String, dynamic>.from(userData);
      newData.addAll(Map<String, dynamic>.from(snapshot.value as Map<dynamic, dynamic>));
      setState(() => userData = newData);
    } catch (e) {
      print('Merge error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : error != null
          ? Center(child: Text(error!, style: TextStyle(color: Colors.red)))
          : SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[200],
              backgroundImage: userData['avatarUrl'] != null
                  ? NetworkImage(userData['avatarUrl'])
                  : null,
              child: userData['avatarUrl'] == null
                  ? Icon(Icons.person, size: 60, color: Colors.grey[800])
                  : null,
            ),
            SizedBox(height: 24),
            Text(
              userData['Name'] ?? 'No Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            _buildInfoCard('Email', userData['Email address']),
            _buildInfoCard('Enrollment Number', userData['Enrollment Number']),
            _buildInfoCard('Contact Number', userData['Contact Number']),
            _buildInfoCard('Official E-mail ID', userData['Official E-mail ID (College email ID)']),
            _buildInfoCard('Department', _getDepartment()),
            _buildInfoCard('Year of Study', _getYearOfStudy()),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Navigate to edit profile page
                // Implement navigation logic here
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }

  String _getYearOfStudy() {
    final rollNumber = userData['Enrollment Number']?.toString() ?? ''; // Use Roll Number
    final currentYear = DateTime.now().year; // Current year (e.g., 2025)

    // Extract last two digits after "bt" in roll number
    final btIndex = rollNumber.toLowerCase().indexOf("bt");
    if (btIndex != -1 && btIndex + 2 < rollNumber.length) {
      final yearDigits = rollNumber.substring(btIndex + 2, btIndex + 4); // Extract digits
      final admissionYear = int.tryParse("20$yearDigits"); // Convert to full year
      if (admissionYear != null) {
        return "$admissionYear - ${admissionYear+4}";
      }
    }

    return 'Not provided';
  }


  String _getDepartment() {
    final rollNumber = userData['Enrollment Number']?.toString() ?? '';
    if (rollNumber.toLowerCase().contains('eee')) {
      return 'Electrical and Electronics Engineering (EEE)';
    }
    return userData['Department'] ?? 'Not provided';
  }

  Widget _buildInfoCard(String label, String? value) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                '$label:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                value ?? 'Not provided',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
