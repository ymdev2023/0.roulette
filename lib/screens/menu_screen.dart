import 'package:flutter/material.dart';
import 'about_screen.dart';
import 'roulette_screen.dart';
import 'record_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('adjective Laboratory'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 40),

              // About 버튼
              _buildMenuButton(
                context,
                'About',
                '형용사 실험실 소개',
                Icons.info_outline,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutScreen()),
                ),
              ),

              const SizedBox(height: 20),

              // Roulette 버튼
              _buildMenuButton(
                context,
                'Roulette',
                '창작 주제 뽑기',
                Icons.casino,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RouletteScreen()),
                ),
              ),

              const SizedBox(height: 20),

              // Record 버튼
              _buildMenuButton(
                context,
                'Records',
                '기록 보기',
                Icons.history,
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecordScreen()),
                ),
              ),

              const SizedBox(height: 40),
              
              // 버전 정보
              Text(
                'v1.0',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[500],
                  fontFamily: 'Courier New',
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Container(
      width: double.infinity,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: Colors.grey[700],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontFamily: 'Courier New',
                        ),
                      ),
                      // Text(
                      //   subtitle,
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: Colors.grey[600],
                      //     fontFamily: 'Courier New',
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey[400],
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
