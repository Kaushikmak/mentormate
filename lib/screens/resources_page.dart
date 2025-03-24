// screens/resources_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesPage extends StatelessWidget {
  const ResourcesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Academic Resources',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 20),
              _buildSemesterResources(),
              SizedBox(height: 30),
              Text(
                'Additional Resources',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 10),
              _buildAdditionalResources(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSemesterResources() {
    return ExpansionPanelList.radio(
      children: [
        for (int i = 1; i <= 8; i++)
          ExpansionPanelRadio(
            value: i,
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text('Semester $i'),
              );
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildResourceLink('Lecture Notes', 'https://drive.google.com/semester$i/notes'),
                  _buildResourceLink('Assignments', 'https://drive.google.com/semester$i/assignments'),
                  _buildResourceLink('Past Papers', 'https://drive.google.com/semester$i/pastpapers'),
                  _buildResourceLink('Recommended Books', 'https://drive.google.com/semester$i/books'),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildResourceLink(String title, String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: InkWell(
        onTap: () => _launchURL(url),
        child: Row(
          children: [
            Icon(Icons.link, size: 20, color: Colors.blue),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalResources(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildResourceCard(
          context,
          'Internship Opportunities',
          'A curated list of internship openings and application tips.',
          Icons.work,
          'https://drive.google.com/internships',
        ),
        _buildResourceCard(
          context,
          'Project Ideas',
          'Innovative project suggestions from seniors to boost your portfolio.',
          Icons.lightbulb,
          'https://drive.google.com/projects',
        ),
        _buildResourceCard(
          context,
          'Study Techniques',
          'Effective study methods and time management strategies.',
          Icons.school,
          'https://drive.google.com/studytips',
        ),
        _buildResourceCard(
          context,
          'Career Guidance',
          'Insights on various career paths and industry trends.',
          Icons.trending_up,
          'https://drive.google.com/careers',
        ),
      ],
    );
  }

  Widget _buildResourceCard(BuildContext context, String title, String description, IconData icon, String url) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).primaryColor),
        title: Text(title),
        subtitle: Text(description),
        trailing: Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () => _launchURL(url),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
