import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  List<dynamic> faqData = [];

  @override
  void initState() {
    super.initState();
    loadFAQData();
  }

  Future<void> loadFAQData() async {
    String jsonString = await rootBundle.loadString('assets/faqs.json');
    setState(() {
      faqData = json.decode(jsonString);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: faqData.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: faqData.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              faqData[index]['question'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(faqData[index]['answer']),
              ),
            ],
          );
        },
      ),
    );
  }
}
