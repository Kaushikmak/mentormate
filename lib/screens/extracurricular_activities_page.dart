// screens/extracurricular_activities_page.dart
import 'package:flutter/material.dart';

class Activity {
  final String name;
  final String description;
  final IconData icon;
  final List<String> examples;

  Activity({
    required this.name,
    required this.description,
    required this.icon,
    required this.examples,
  });
}

class ActivityCategory {
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final List<Activity> activities;

  ActivityCategory({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.activities,
  });
}

class ExtracurricularActivitiesPage extends StatefulWidget {
  const ExtracurricularActivitiesPage({Key? key}) : super(key: key);

  @override
  State<ExtracurricularActivitiesPage> createState() => _ExtracurricularActivitiesPageState();
}

class _ExtracurricularActivitiesPageState extends State<ExtracurricularActivitiesPage> {
  final List<ActivityCategory> _categories = [
    ActivityCategory(
      name: 'Academic Activities',
      description: 'Enhance your knowledge and intellectual skills',
      icon: Icons.school,
      color: Colors.blue,
      activities: [
        Activity(
          name: 'Academic Clubs',
          description: 'Join subject-specific clubs to deepen your knowledge',
          icon: Icons.science,
          examples: ['Math Club', 'Physics Club', 'Engineering Club', 'Computer Science Society'],
        ),
        Activity(
          name: 'Competitive Teams',
          description: 'Participate in competitions to challenge yourself',
          icon: Icons.emoji_events,
          examples: ['Academic Decathlon', 'Science Olympiad', 'Quiz Bowl', 'Hackathons'],
        ),
        Activity(
          name: 'Peer Tutoring',
          description: 'Help fellow students while reinforcing your own understanding',
          icon: Icons.people,
          examples: ['Math Tutoring', 'Writing Center', 'Language Partners', 'Study Groups'],
        ),
        Activity(
          name: 'Robotics Club',
          description: 'Design, build, and program robots',
          icon: Icons.smart_toy,
          examples: ['Robot Competitions', 'Drone Building', 'AI Development', 'Electronics Workshop'],
        ),
      ],
    ),
    ActivityCategory(
      name: 'Arts & Creative Pursuits',
      description: 'Express yourself through various art forms',
      icon: Icons.palette,
      color: Colors.purple,
      activities: [
        Activity(
          name: 'Art Club',
          description: 'Express yourself through visual arts',
          icon: Icons.brush,
          examples: ['Painting', 'Drawing', 'Sculpture', 'Digital Art'],
        ),
        Activity(
          name: 'Drama Club',
          description: 'Explore acting, directing, or backstage production',
          icon: Icons.theater_comedy,
          examples: ['College Plays', 'Improv Group', 'Scriptwriting', 'Stage Management'],
        ),
        Activity(
          name: 'Music Groups',
          description: 'Join musical ensembles or start your own band',
          icon: Icons.music_note,
          examples: ['College Choir', 'Orchestra', 'Jazz Band', 'A Cappella Group'],
        ),
        Activity(
          name: 'Dance Team',
          description: 'Express yourself through movement',
          icon: Icons.nightlife,
          examples: ['Classical Dance', 'Contemporary', 'Hip-Hop', 'Folk Dance'],
        ),
      ],
    ),
    ActivityCategory(
      name: 'Community Service',
      description: 'Give back to the community and make a difference',
      icon: Icons.volunteer_activism,
      color: Colors.green,
      activities: [
        Activity(
          name: 'Volunteer Work',
          description: 'Offer your time to help those in need',
          icon: Icons.favorite,
          examples: ['Hospitals', 'Shelters', 'Food Banks', 'Elderly Care'],
        ),
        Activity(
          name: 'Environmental Club',
          description: 'Work on sustainability initiatives',
          icon: Icons.eco,
          examples: ['Campus Cleanup', 'Tree Planting', 'Recycling Programs', 'Awareness Campaigns'],
        ),
        Activity(
          name: 'Mentoring Programs',
          description: 'Guide younger students through challenges',
          icon: Icons.person,
          examples: ['Freshman Orientation', 'High School Outreach', 'Peer Counseling', 'Career Guidance'],
        ),
        Activity(
          name: 'Fundraising Campaigns',
          description: 'Raise money for important causes',
          icon: Icons.attach_money,
          examples: ['Charity Runs', 'Auctions', 'Benefit Concerts', 'Crowdfunding Projects'],
        ),
      ],
    ),
    ActivityCategory(
      name: 'Leadership Opportunities',
      description: 'Develop your leadership skills and make an impact',
      icon: Icons.trending_up,
      color: Colors.orange,
      activities: [
        Activity(
          name: 'Student Government',
          description: 'Represent your peers and influence campus policies',
          icon: Icons.gavel,
          examples: ['Student Council', 'Senate', 'Executive Board', 'Committee Chair'],
        ),
        Activity(
          name: 'Club Leadership',
          description: 'Take on roles in club management',
          icon: Icons.groups,
          examples: ['President', 'Treasurer', 'Event Coordinator', 'Secretary'],
        ),
        Activity(
          name: 'Class Representative',
          description: 'Advocate for your classmates\' interests',
          icon: Icons.record_voice_over,
          examples: ['Department Rep', 'Batch Coordinator', 'Academic Council', 'Grievance Committee'],
        ),
        Activity(
          name: 'Peer Leadership Group',
          description: 'Develop leadership skills while helping others',
          icon: Icons.psychology,
          examples: ['Resident Advisors', 'Orientation Leaders', 'Wellness Ambassadors', 'Campus Guides'],
        ),
      ],
    ),
    ActivityCategory(
      name: 'Sports & Recreation',
      description: 'Stay active and build teamwork skills',
      icon: Icons.sports_basketball,
      color: Colors.red,
      activities: [
        Activity(
          name: 'Intramural Sports',
          description: 'Join casual teams for various sports',
          icon: Icons.sports,
          examples: ['Basketball', 'Soccer', 'Volleyball', 'Badminton'],
        ),
        Activity(
          name: 'Club Sports',
          description: 'Compete against other colleges',
          icon: Icons.emoji_events,
          examples: ['Cricket', 'Football', 'Tennis', 'Swimming'],
        ),
        Activity(
          name: 'Fitness Classes',
          description: 'Participate in group exercise activities',
          icon: Icons.fitness_center,
          examples: ['Yoga', 'Zumba', 'Aerobics', 'CrossFit'],
        ),
        Activity(
          name: 'Outdoor Adventure Club',
          description: 'Explore nature and outdoor activities',
          icon: Icons.terrain,
          examples: ['Hiking', 'Camping', 'Rock Climbing', 'Cycling'],
        ),
      ],
    ),
    ActivityCategory(
      name: 'Cultural & Language Activities',
      description: 'Celebrate diversity and expand your worldview',
      icon: Icons.language,
      color: Colors.teal,
      activities: [
        Activity(
          name: 'International Student Association',
          description: 'Connect with students from around the world',
          icon: Icons.public,
          examples: ['Cultural Exchange', 'International Food Festival', 'Global Awareness Events', 'Language Partners'],
        ),
        Activity(
          name: 'Language Clubs',
          description: 'Practice speaking different languages',
          icon: Icons.translate,
          examples: ['French Club', 'Spanish Club', 'Chinese Club', 'German Club'],
        ),
        Activity(
          name: 'Cultural Celebration Committees',
          description: 'Help organize cultural awareness events',
          icon: Icons.celebration,
          examples: ['Diwali Festival', 'Lunar New Year', 'Holi Celebration', 'Cultural Nights'],
        ),
        Activity(
          name: 'International Food Club',
          description: 'Share and learn about cuisines from different countries',
          icon: Icons.restaurant,
          examples: ['Cooking Workshops', 'Food Tastings', 'Recipe Exchange', 'Culinary Tours'],
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Extra-Curricular Activities'),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/campus_activities.jpeg',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Discover activities to enrich your college experience beyond academics. Get involved, make friends, and develop new skills!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return _buildCategoryCard(_categories[index]);
              },
              childCount: _categories.length,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Benefits of Participation',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 12),
                      _buildBenefitItem('Develops valuable skills like teamwork and leadership'),
                      _buildBenefitItem('Provides opportunities to make friends with similar interests'),
                      _buildBenefitItem('Helps you discover new passions and potential career paths'),
                      _buildBenefitItem('Creates a well-rounded college experience'),
                      _buildBenefitItem('Offers stress relief from academic pressures'),
                      _buildBenefitItem('Builds a stronger resume for future job applications'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(ActivityCategory category) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          leading: CircleAvatar(
            backgroundColor: category.color,
            child: Icon(category.icon, color: Colors.white),
          ),
          title: Text(
            category.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          subtitle: Text(category.description),
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: category.activities.length,
              itemBuilder: (context, index) {
                return _buildActivityItem(category.activities[index]);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityItem(Activity activity) {
    return ExpansionTile(
      leading: Icon(activity.icon),
      title: Text(
        activity.name,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(activity.description),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Examples:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: activity.examples.map((example) {
                  return Chip(
                    label: Text(example),
                    backgroundColor: Colors.grey[200],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green, size: 20),
          SizedBox(width: 8),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
