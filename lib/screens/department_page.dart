// screens/department_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DepartmentMember {
  final String id;
  final String name;
  final String position;
  final String details;
  final String photoUrl; // This will be a Firebase Storage URL in the future
  final String profileUrl;

  DepartmentMember({
    required this.id,
    required this.name,
    required this.position,
    required this.details,
    required this.photoUrl,
    required this.profileUrl,
  });
}

class DepartmentPage extends StatelessWidget {
  const DepartmentPage({Key? key}) : super(key: key);

  // In the future, this will be fetched from Firebase
  List<DepartmentMember> getLeadership() {
    return [
      DepartmentMember(
        id: 'vc001',
        name: 'Dr. Sarah Johnson',
        position: 'Vice Chancellor',
        details: 'Ph.D. in Computer Science from MIT',
        photoUrl: 'assets/images/vc.jpg', // Will be Firebase URL later
        profileUrl: 'https://university.edu/faculty/sarahjohnson',
      ),
      DepartmentMember(
        id: 'dir001',
        name: 'Dr. Michael Chen',
        position: 'Director',
        details: 'Ph.D. in Information Systems from Stanford',
        photoUrl: 'assets/images/director.jpg',
        profileUrl: 'https://university.edu/faculty/michaelchen',
      ),
      DepartmentMember(
        id: 'hod001',
        name: 'Dr. Emily Rodriguez',
        position: 'Head of Department',
        details: 'Ph.D. in Artificial Intelligence from Berkeley',
        photoUrl: 'assets/images/hod.jpg',
        profileUrl: 'https://university.edu/faculty/emilyrodriguez',
      ),
    ];
  }

  // In the future, this will be fetched from Firebase
  List<DepartmentMember> getFaculty() {
    return [
      DepartmentMember(
        id: 'fac001',
        name: 'Dr. Robert Wilson',
        position: 'Professor',
        details: 'Artificial Intelligence',
        photoUrl: 'assets/images/faculty1.jpg',
        profileUrl: 'https://university.edu/faculty/robertwilson',
      ),
      DepartmentMember(
        id: 'fac002',
        name: 'Dr. Lisa Wang',
        position: 'Associate Professor',
        details: 'Data Science',
        photoUrl: 'assets/images/faculty2.jpg',
        profileUrl: 'https://university.edu/faculty/lisawang',
      ),
      // Add more faculty members...
    ];
  }

  // In the future, this will be fetched from Firebase
  List<DepartmentMember> getStudentCouncil() {
    return [
      DepartmentMember(
        id: 'sc001',
        name: 'Alex Thompson',
        position: 'President',
        details: 'Final Year, B.Tech Computer Science',
        photoUrl: 'assets/images/council1.jpg',
        profileUrl: 'mailto:alex.thompson@university.edu',
      ),
      DepartmentMember(
        id: 'sc002',
        name: 'Priya Sharma',
        position: 'Vice President',
        details: 'Third Year, B.Tech Computer Science',
        photoUrl: 'assets/images/council2.jpg',
        profileUrl: 'mailto:priya.sharma@university.edu',
      ),
      // Add more council members...
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDepartmentHeader(context),
            _buildDepartmentInfo(context),
            _buildLeadershipSection(context),
            _buildFacultySection(context),
            _buildStudentCouncilSection(context),
            _buildDepartmentResources(context),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartmentHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // This will be replaced with a Firebase Storage image in the future
          Image.asset(
            'assets/images/departmentlogo.jpeg',
            height: 80,
            width: 80,
            color: Colors.white,
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Department of Electrical Engineering',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Established 1970',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About Our Department',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 12),
          Text(
            'The Department of Electrical Engineering is dedicated to fostering excellence in education, research, and innovation. Our comprehensive programs are designed to equip students with the skills and knowledge needed for thriving careers in the dynamic and evolving field of electrical engineering. We are committed to pushing the boundaries of knowledge through cutting-edge research and preparing our graduates to tackle the challenges of tomorrows technology landscape.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          SizedBox(height: 16),
          Text(
            'Our department is recognized for its cutting-edge research in artificial intelligence, data science, cybersecurity, and software engineering. We maintain strong partnerships with industry leaders to ensure our curriculum remains relevant and our students gain practical experience.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          SizedBox(height: 20),
          // Using a Row with Expanded to prevent overflow
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: _buildStatCard(context, '25+', 'Faculty Members'),
              ),
              Expanded(child: _buildStatCard(context, '1000+', 'Students')),
              Expanded(
                child: _buildStatCard(context, '50+', 'Research Projects'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String number, String label) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        child: Column(
          children: [
            Text(
              number,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeadershipSection(BuildContext context) {
    final leadershipMembers = getLeadership();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Leadership', style: Theme.of(context).textTheme.headlineSmall),
          SizedBox(height: 16),
          ...leadershipMembers
              .map(
                (member) => _buildMemberCard(context, member, imageRadius: 40),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildFacultySection(BuildContext context) {
    final facultyMembers = getFaculty();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Faculty Members',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: facultyMembers.length,
            itemBuilder: (context, index) {
              return _buildFacultyCard(context, facultyMembers[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCouncilSection(BuildContext context) {
    final councilMembers = getStudentCouncil();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Student Council',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          ...councilMembers
              .map(
                (member) => _buildMemberCard(context, member, imageRadius: 30),
              )
              .toList(),
        ],
      ),
    );
  }

  Widget _buildMemberCard(
    BuildContext context,
    DepartmentMember member, {
    required double imageRadius,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        onTap: () => _launchURL(member.profileUrl),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: imageRadius,
                // This will be changed to NetworkImage with Firebase URL later
                backgroundImage: AssetImage(member.photoUrl),
              ),
              SizedBox(width: 16),
              // Wrap the text content in Expanded to prevent overflow
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      member.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      member.position,
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4),
                    Text(
                      member.details,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFacultyCard(BuildContext context, DepartmentMember faculty) {
    return Card(
      child: InkWell(
        onTap: () => _launchURL(faculty.profileUrl),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                // This will be changed to NetworkImage with Firebase URL later
                backgroundImage: AssetImage(faculty.photoUrl),
              ),
              SizedBox(height: 12),
              Text(
                faculty.name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 4),
              Text(
                faculty.details,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDepartmentResources(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Department Resources',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 16),
          _buildResourceCard(
            context,
            'Department Website',
            'Visit our official department website for more information',
            Icons.language,
            'https://university.edu/cs-department',
          ),
          _buildResourceCard(
            context,
            'Research Publications',
            'Explore our faculty and student research publications',
            Icons.article,
            'https://university.edu/cs-department/research',
          ),
          _buildResourceCard(
            context,
            'Department Events',
            'Stay updated with upcoming seminars, workshops, and conferences',
            Icons.event,
            'https://university.edu/cs-department/events',
          ),
          _buildResourceCard(
            context,
            'Alumni Network',
            'Connect with our department alumni',
            Icons.people,
            'https://university.edu/cs-department/alumni',
          ),
        ],
      ),
    );
  }

  Widget _buildResourceCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    String url,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title, maxLines: 1, overflow: TextOverflow.ellipsis),
        subtitle: Text(
          description,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _launchURL(url),
      ),
    );
  }

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }
}
