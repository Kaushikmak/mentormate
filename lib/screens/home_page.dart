import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_drawer.dart';
import 'mentors_page.dart';
import 'settings_page.dart';
import 'resources_page.dart';
import 'department_page.dart';
import 'extracurricular_activities_page.dart';
import 'schedule_page.dart';

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
    return GestureDetector(
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          _scaffoldKey.currentState?.openDrawer();
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
                    fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Mate",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),

        ),
        drawer: CustomDrawer(
          selectedIndex: _selectedIndex,
          onItemSelected: onNavigationItemSelected,
        ),
        body: _pages[_selectedIndex],
      ),
    );
  }
}
