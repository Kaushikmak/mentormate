import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../services/userdata.dart';

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
    try {
      final mergedData = await FirebaseUserService().getMergedUserData();
      setState(() {
        userData = mergedData;
        isLoading = false;
      });
        } catch (e) {
      setState(() {
        error = "An error occurred while fetching user data.";
        isLoading = false;
      });
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
            CachedNetworkImage(
              imageUrl: userData['avatarUrl'] ?? '',
              imageBuilder: (context, imageProvider) => CircleAvatar(
                radius: 60,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.person, size: 60, color: Colors.grey[800]),
            ),
            SizedBox(height: 24),
            Text(
              userData['Name'] ?? 'No Name',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            _buildInfoCard('Email', userData['Email address']),
            _buildInfoCard('Enrollment Number', userData['Enrollment Number'].toString().toUpperCase()),
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
