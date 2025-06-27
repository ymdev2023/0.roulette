import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Records'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Our Experiments',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier New',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Expanded(
                child: ListView(
                  children: [
                    _buildWeekRecord('Week 1', 'Experimental Website'),
                    const SizedBox(height: 20),
                    _buildWeekRecord('Week 2', 'Chaotic TouchDesigner Project'),
                    const SizedBox(height: 20),
                    _buildWeekRecord('Week 3', '?'),
                    const SizedBox(height: 20),
                    _buildWeekRecord('Week 4', '?'),
                    const SizedBox(height: 20),
                    _buildWeekRecord('Week 5', '?'),
                    const SizedBox(height: 20),
                    _buildWeekRecord('Week 6', '?'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeekRecord(String week, String project) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                week.split(' ')[1], // "Week 1" -> "1"
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier New',
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  week,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontFamily: 'Courier New',
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  project,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: project == '?' ? Colors.grey : Colors.black87,
                    fontFamily: 'Courier New',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
