import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: const SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 80,
                  color: Colors.grey,
                ),
                SizedBox(height: 20),
                Text(
                  '소개 페이지 준비 중',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Courier New',
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '곧 업데이트 예정입니다!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'Courier New',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
