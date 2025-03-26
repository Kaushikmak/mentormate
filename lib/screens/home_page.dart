import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_drawer.dart';
import 'mentors_page.dart';
import 'settings_page.dart';
import 'resources_page.dart';
import 'department_page.dart';
import 'extracurricular_activities_page.dart';
import 'schedule_page.dart';
import 'faq_page.dart';
import '../map/map_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const Center(child: Text('Home Page', style: TextStyle(fontSize: 24))),
      const MentorsPage(),
      const SchedulePage(),
      const ResourcesPage(),
      const DepartmentPage(),
      const ExtracurricularActivitiesPage(),
      const MapPage(),
      const SettingsPage(),
    ];
  }

  void onNavigationItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }

        // Show a confirmation dialog
        final shouldExit =
            await showDialog<bool>(
              context: context,
              builder:
                  (context) => AlertDialog(
                    title: const Text(
                      'Exit App',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                      'Are you sure you want to exit?',
                      style: TextStyle(fontWeight: FontWeight.normal),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        child: const Text('Exit'),
                      ),
                    ],
                  ),
            ) ??
            false;

        // If user confirms, exit the app
        if (shouldExit) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Mentor",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Mate",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        drawer: CustomDrawer(
          selectedIndex: _selectedIndex,
          onItemSelected: onNavigationItemSelected,
        ),
        body: Stack(
          children: [
            _pages[_selectedIndex],
            Positioned(
              right: 16,
              bottom: 16,
              child: Opacity(
                opacity: _selectedIndex == 0 ? 1.0 : 0.0,
                child: IgnorePointer(
                  ignoring: _selectedIndex != 0,
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>FAQPage()));
                    },
                    child: Icon(Icons.question_answer),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
