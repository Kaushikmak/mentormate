import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/mentor.dart';
import '../widgets/mentor_card.dart';
import 'mentor_detail_page.dart';

class MentorsPage extends StatefulWidget {
  const MentorsPage({Key? key}) : super(key: key);

  @override
  State<MentorsPage> createState() => _MentorsPageState();
}

class _MentorsPageState extends State<MentorsPage> {
  List<Mentor> mentors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMentors();
  }

  Future<void> loadMentors() async {
    try {
      final String jsonString = await rootBundle.loadString('assets/mentor_details.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      setState(() {
        mentors = (jsonData['mentors'] as List)
            .map((mentorJson) => Mentor(
          id: mentorJson['id'],
          name: mentorJson['name'],
          imageUrl: mentorJson['imageUrl'],
          specialization: mentorJson['specialization'],
          bio: mentorJson['bio'],
          rating: mentorJson['rating'],
        ))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      print('Error loading mentors: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: mentors.length,
        itemBuilder: (context, index) {
          return MentorCard(
            mentor: mentors[index],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MentorDetailPage(mentor: mentors[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
