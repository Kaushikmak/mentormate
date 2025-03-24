import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  String selectedYear = 'first_year';
  String selectedBatch = 'batch_1';
  Map<String, dynamic> timetableData = {};
  bool isLoading = true;

  final Map<String, String> yearLabels = {
    'first_year': '1st Year',
    'second_year': '2nd Year',
    'third_year': '3rd Year',
    'fourth_year': '4th Year',
  };

  @override
  void initState() {
    super.initState();
    loadTimetableData();
  }

  Future<void> loadTimetableData() async {
    try {
      final years = ['first_year', 'second_year', 'third_year', 'fourth_year'];
      for (var year in years) {
        final jsonString = await rootBundle.loadString('assets/$year\_timetable.json');
        timetableData[year] = json.decode(jsonString);
      }
      setState(() {
        isLoading = false;
        // Initialize with the first batch of the selected year
        if (timetableData.isNotEmpty && timetableData[selectedYear] != null) {
          final batches = (timetableData[selectedYear] as Map<String, dynamic>).keys.toList();
          if (batches.isNotEmpty) {
            selectedBatch = batches.first;
          }
        }
      });
    } catch (e) {
      print('Error loading timetable data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          _buildYearSelector(),
          if (timetableData.isNotEmpty && timetableData[selectedYear] != null)
            _buildBatchSelector(),
          Expanded(
            child: _buildTimetable(),
          ),
        ],
      ),
    );
  }

  Widget _buildYearSelector() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildYearButton('first_year', '1'),
          _buildYearButton('second_year', '2'),
          _buildYearButton('third_year', '3'),
          _buildYearButton('fourth_year', '4'),
        ],
      ),
    );
  }

  Widget _buildYearButton(String year, String label) {
    final isSelected = selectedYear == year;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedYear = year;
          // Update selected batch when year changes
          if (timetableData.containsKey(year) && timetableData[year] != null) {
            final yearData = timetableData[year] as Map<String, dynamic>;
            if (yearData.isNotEmpty) {
              selectedBatch = yearData.keys.first;
            }
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: isSelected ? Theme.of(context).primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Year',
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.white70 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBatchSelector() {
    // Safely get the year data and handle null
    final yearData = timetableData[selectedYear];
    if (yearData == null) return const SizedBox.shrink();

    final batches = (yearData as Map<String, dynamic>).keys.toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            '${yearLabels[selectedYear]} Batches:',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: batches.map((batch) {
                  final isSelected = selectedBatch == batch;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedBatch = batch;
                        });
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          batch.toUpperCase(),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimetable() {
    // Safely get the year data and batch data, handling nulls
    final yearData = timetableData[selectedYear];
    if (yearData == null) {
      return const Center(child: Text('No data available for this year'));
    }

    final yearMap = yearData as Map<String, dynamic>;
    final batchData = yearMap[selectedBatch];
    if (batchData == null) {
      return const Center(child: Text('No data available for this batch'));
    }

    final schedule = batchData as List<dynamic>;

    return Container(
      color: Colors.grey[50],
      child: ListView.builder(
        itemCount: schedule.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final session = schedule[index] as Map<String, dynamic>;
          final timeSlot = session['time'] as String;
          final subject = session['subject'] as String;
          final location = session['location'] as String;

          // Extract start and end time for better display
          final times = timeSlot.split(' - ');
          final startTime = times[0];
          final endTime = times.length > 1 ? times[1] : '';

          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time column
                  Container(
                    width: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          startTime,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          endTime,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Vertical divider
                  Container(
                    height: 50,
                    width: 1,
                    color: Colors.grey[300],
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                  ),

                  // Subject and location
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              location,
                              style: TextStyle(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}