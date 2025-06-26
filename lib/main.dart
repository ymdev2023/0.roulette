import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(const DailyThemeRouletteApp());
}

class DailyThemeRouletteApp extends StatelessWidget {
  const DailyThemeRouletteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'adjective Laboratory',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        useMaterial3: true,
        fontFamily: 'Courier New',
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Courier New'),
          displayMedium: TextStyle(fontFamily: 'Courier New'),
          displaySmall: TextStyle(fontFamily: 'Courier New'),
          headlineLarge: TextStyle(fontFamily: 'Courier New'),
          headlineMedium: TextStyle(fontFamily: 'Courier New'),
          headlineSmall: TextStyle(fontFamily: 'Courier New'),
          titleLarge: TextStyle(fontFamily: 'Courier New'),
          titleMedium: TextStyle(fontFamily: 'Courier New'),
          titleSmall: TextStyle(fontFamily: 'Courier New'),
          bodyLarge: TextStyle(fontFamily: 'Courier New'),
          bodyMedium: TextStyle(fontFamily: 'Courier New'),
          bodySmall: TextStyle(fontFamily: 'Courier New'),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();

    // 3초 후 메인 스크린으로 이동
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/alablogo.jpg',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              const Text(
                'adjective Laboratory',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  fontFamily: 'Courier New',
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late AnimationController _adjectiveController;
  late AnimationController _nounController;
  late Animation<double> _adjectiveRotation;
  late Animation<double> _nounRotation;

  final Random _random = Random();

  final List<String> _adjectives = [
    // Tech & New Media
    'interactive',
    'generative',
    'kinetic',
    'immersive',
    'experimental',
    'responsive',
    'procedural',
    'data-driven',
    'algorithmic',
    'bio-inspired',
    'AI-powered',
    'sensor-based',
    'glitchy',
    'pixel-perfect',
    'real-time',
    'crowd-sourced',
    'augmented',
    'networked',
    'open-source',
    'sustainable',
    // Classic Artistic
    'mysterious',
    'vibrant',
    'minimalist',
    'abstract',
    'surreal',
    'cosmic',
    'nostalgic',
    'futuristic',
    'organic',
    'geometric',
    'dreamy',
    'dramatic',
    'peaceful',
    'chaotic',
    'elegant',
    'bold',
    'subtle',
    'vintage',
    'modern'
  ];

  final List<String> _nouns = [
    'media installation',
    'Arduino project',
    'IoT device',
    'mobile app',
    'VR experience',
    'AR filter',
    'interactive website',
    'generative art',
    'sound visualization',
    'LED matrix',
    'motion sensor',
    'chatbot',
    'data visualization',
    'NFT collection',
    'game prototype',
    'neural network',
    'blockchain app',
    'drone performance',
    'smart mirror',
    'wearable tech'
  ];

  String _selectedAdjective = '';
  String _selectedNoun = '';
  bool _isAdjectiveSpinning = false;
  bool _isNounSpinning = false;
  bool _showResult = false;

  @override
  void initState() {
    super.initState();
    _adjectiveController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _nounController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _adjectiveRotation = Tween<double>(begin: 0, end: 10 * 2 * pi).animate(
      CurvedAnimation(parent: _adjectiveController, curve: Curves.easeOut),
    );
    _nounRotation = Tween<double>(begin: 0, end: 10 * 2 * pi).animate(
      CurvedAnimation(parent: _nounController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _adjectiveController.dispose();
    _nounController.dispose();
    super.dispose();
  }

  void _spinAdjective() async {
    if (_isAdjectiveSpinning) return;

    setState(() {
      _isAdjectiveSpinning = true;
      _showResult = false;
    });

    await _adjectiveController.forward();

    setState(() {
      _selectedAdjective = _adjectives[_random.nextInt(_adjectives.length)];
      _isAdjectiveSpinning = false;
    });

    _adjectiveController.reset();
    _checkShowResult();
  }

  void _spinNoun() async {
    if (_isNounSpinning) return;

    setState(() {
      _isNounSpinning = true;
      _showResult = false;
    });

    await _nounController.forward();

    setState(() {
      _selectedNoun = _nouns[_random.nextInt(_nouns.length)];
      _isNounSpinning = false;
    });

    _nounController.reset();
    _checkShowResult();
  }

  void _checkShowResult() {
    if (_selectedAdjective.isNotEmpty && _selectedNoun.isNotEmpty) {
      setState(() {
        _showResult = true;
      });
    }
  }

  void _reset() {
    setState(() {
      _selectedAdjective = '';
      _selectedNoun = '';
      _showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('adjective Laboratory v1.2'),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // 룰렛 섹션들을 가로로 배치
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 형용사 룰렛
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: _buildRouletteSection(
                      title: 'Step 1: Choose an Adjective',
                      items: _adjectives,
                      selected: _selectedAdjective,
                      isSpinning: _isAdjectiveSpinning,
                      rotation: _adjectiveRotation,
                      onSpin: _spinAdjective,
                      color: Colors.grey[700]!,
                    ),
                  ),
                ),

                // 명사 룰렛
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: _buildRouletteSection(
                      title: 'Step 2: Choose a Noun',
                      items: _nouns,
                      selected: _selectedNoun,
                      isSpinning: _isNounSpinning,
                      rotation: _nounRotation,
                      onSpin: _spinNoun,
                      color: Colors.grey[600]!,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // 결과 표시
            if (_showResult)
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Text(
                      "Today's Creative Challenge:",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Courier New',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '"$_selectedAdjective $_selectedNoun"',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontFamily: 'Courier New',
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 30),

            // 다시 하기 버튼
            ElevatedButton(
              onPressed: _reset,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[600],
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: const Text(
                'Start Over',
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Courier New',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRouletteSection({
    required String title,
    required List<String> items,
    required String selected,
    required bool isSpinning,
    required Animation<double> rotation,
    required VoidCallback onSpin,
    required Color color,
  }) {
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
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'Courier New',
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),

          // 룰렛 휠
          GestureDetector(
            onTap: onSpin,
            child: AnimatedBuilder(
              animation: rotation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: isSpinning ? rotation.value : 0,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withOpacity(0.1),
                      border: Border.all(color: color, width: 3),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.casino,
                        size: 40,
                        color: color,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          // 선택된 결과
          if (selected.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color),
              ),
              child: Text(
                selected,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontFamily: 'Courier New',
                ),
              ),
            )
          else
            ElevatedButton(
              onPressed: isSpinning ? null : onSpin,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                isSpinning ? 'Spinning...' : 'Spin!',
                style: const TextStyle(
                  fontFamily: 'Courier New',
                ),
              ),
            ),
        ],
      ),
    );
  }
}
