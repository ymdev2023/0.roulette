import 'package:flutter/material.dart';
import 'dart:math';
import '../word_lists.dart';

class RouletteScreen extends StatefulWidget {
  const RouletteScreen({super.key});

  @override
  State<RouletteScreen> createState() => _RouletteScreenState();
}

class _RouletteScreenState extends State<RouletteScreen>
    with TickerProviderStateMixin {
  late AnimationController _adjectiveController;
  late AnimationController _nounController;
  late AnimationController _presenterController;
  late Animation<double> _adjectiveRotation;
  late Animation<double> _nounRotation;
  late Animation<double> _presenterRotation;

  final Random _random = Random();

  String _selectedAdjective = '';
  String _selectedNoun = '';
  String _selectedPresenter = '';
  Map<String, String> _roleAssignments = {}; // 이름 -> 역할 매핑
  bool _isAdjectiveSpinning = false;
  bool _isNounSpinning = false;
  bool _isPresenterSpinning = false;
  bool _isRoleSpinning = false;
  bool _showResult = false;
  bool _showRoleResult = false;

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
    _presenterController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _adjectiveRotation = Tween<double>(begin: 0, end: 10 * 2 * pi).animate(
      CurvedAnimation(parent: _adjectiveController, curve: Curves.easeOut),
    );
    _nounRotation = Tween<double>(begin: 0, end: 10 * 2 * pi).animate(
      CurvedAnimation(parent: _nounController, curve: Curves.easeOut),
    );
    _presenterRotation = Tween<double>(begin: 0, end: 10 * 2 * pi).animate(
      CurvedAnimation(parent: _presenterController, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _adjectiveController.dispose();
    _nounController.dispose();
    _presenterController.dispose();
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
      _selectedAdjective =
          WordLists.adjectives[_random.nextInt(WordLists.adjectives.length)];
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
      _selectedNoun = WordLists.nouns[_random.nextInt(WordLists.nouns.length)];
      _isNounSpinning = false;
    });

    _nounController.reset();
    _checkShowResult();
  }

  void _spinPresenter() async {
    if (_isPresenterSpinning) return;

    setState(() {
      _isPresenterSpinning = true;
    });

    await _presenterController.forward();

    setState(() {
      _selectedPresenter =
          WordLists.presenters[_random.nextInt(WordLists.presenters.length)];
      _isPresenterSpinning = false;
    });

    _presenterController.reset();
  }

  void _assignRoles() async {
    if (_isRoleSpinning) return;

    setState(() {
      _isRoleSpinning = true;
      _showRoleResult = false;
    });

    // 시뮬레이션을 위한 딜레이
    await Future.delayed(const Duration(seconds: 2));

    List<String> people = List.from(WordLists.presenters);
    List<String> roles = ['기획', '개발', '아트'];
    Map<String, String> assignments = {};

    // 각 역할에 최소 1명씩 배정
    people.shuffle(_random);
    for (int i = 0; i < 3 && i < people.length; i++) {
      assignments[people[i]] = roles[i];
    }

    // 나머지 사람들에게 랜덤 역할 배정
    for (int i = 3; i < people.length; i++) {
      assignments[people[i]] = roles[_random.nextInt(roles.length)];
    }

    setState(() {
      _roleAssignments = assignments;
      _isRoleSpinning = false;
      _showRoleResult = true;
    });
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
      _selectedPresenter = '';
      _roleAssignments = {};
      _showResult = false;
      _showRoleResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Pick This Week's Theme!"),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // 룰렛 섹션들을 가로로 배치 (반응형)
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 600) {
                    // 넓은 화면에서는 가로로 배치
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 형용사 룰렛
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: _buildRouletteSection(
                              title: 'Step 1: Choose an Adjective',
                              items: WordLists.adjectives,
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
                              items: WordLists.nouns,
                              selected: _selectedNoun,
                              isSpinning: _isNounSpinning,
                              rotation: _nounRotation,
                              onSpin: _spinNoun,
                              color: Colors.grey[700]!,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // 좁은 화면에서는 세로로 배치
                    return Column(
                      children: [
                        // 형용사 룰렛
                        _buildRouletteSection(
                          title: 'Step 1: Choose an Adjective',
                          items: WordLists.adjectives,
                          selected: _selectedAdjective,
                          isSpinning: _isAdjectiveSpinning,
                          rotation: _adjectiveRotation,
                          onSpin: _spinAdjective,
                          color: Colors.grey[700]!,
                        ),

                        const SizedBox(height: 20),

                        // 명사 룰렛
                        _buildRouletteSection(
                          title: 'Step 2: Choose a Noun',
                          items: WordLists.nouns,
                          selected: _selectedNoun,
                          isSpinning: _isNounSpinning,
                          rotation: _nounRotation,
                          onSpin: _spinNoun,
                          color: Colors.grey[700]!,
                        ),
                      ],
                    );
                  }
                },
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

              const SizedBox(height: 40),

              // 발표자 뽑기 섹션
              Container(
                width: double.infinity,
                child: _buildRouletteSection(
                  title: 'Who\'s gonna be a presenter?',
                  items: WordLists.presenters,
                  selected: _selectedPresenter,
                  isSpinning: _isPresenterSpinning,
                  rotation: _presenterRotation,
                  onSpin: _spinPresenter,
                  color: Colors.grey[700]!,
                ),
              ),

              const SizedBox(height: 40),

              // 결과 표시 - Today's Creative Challenge
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

              if (_showResult) const SizedBox(height: 40),

              // 역할 배정 섹션
              Container(
                width: double.infinity,
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
                      'Role Assignment',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[700],
                        fontFamily: 'Courier New',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (_showRoleResult && _roleAssignments.isNotEmpty) ...[
                      // 역할별로 그룹화해서 표시
                      _buildRoleGroup('기획', Icons.lightbulb, Colors.grey[600]!),
                      const SizedBox(height: 15),
                      _buildRoleGroup('개발', Icons.code, Colors.grey[600]!),
                      const SizedBox(height: 15),
                      _buildRoleGroup('아트', Icons.palette, Colors.grey[600]!),
                    ] else ...[
                      Icon(
                        Icons.group,
                        size: 60,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isRoleSpinning ? null : _assignRoles,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[700],
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          _isRoleSpinning
                              ? 'Assigning Roles...'
                              : 'Assign Roles!',
                          style: const TextStyle(
                            fontSize: 16,
                            fontFamily: 'Courier New',
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 다시 하기 버튼
              ElevatedButton(
                onPressed: _reset,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
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
    // 발표자 섹션인지 확인
    bool isPresenterSection = items == WordLists.presenters;

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
              fontSize: isPresenterSection ? 20 : 16,
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
                    width: isPresenterSection ? 140 : 120,
                    height: isPresenterSection ? 140 : 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: color.withOpacity(0.1),
                      border: Border.all(color: color, width: 3),
                    ),
                    child: Center(
                      child: Icon(
                        isPresenterSection ? Icons.person : Icons.casino,
                        size: isPresenterSection ? 50 : 40,
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
              padding: EdgeInsets.symmetric(
                  horizontal: isPresenterSection ? 20 : 15,
                  vertical: isPresenterSection ? 15 : 10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: color),
              ),
              child: isPresenterSection
                  ? Column(
                      children: [
                        Text(
                          'Today\'s Presenter',
                          style: TextStyle(
                            fontSize: 14,
                            color: color.withOpacity(0.8),
                            fontFamily: 'Courier New',
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          selected,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: color,
                            fontFamily: 'Courier New',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )
                  : Text(
                      selected,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color,
                        fontFamily: 'Courier New',
                      ),
                      textAlign: TextAlign.center,
                    ),
            )
          else
            ElevatedButton(
              onPressed: isSpinning ? null : onSpin,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                isSpinning
                    ? (isPresenterSection ? 'Selecting...' : 'Spinning...')
                    : (isPresenterSection ? 'Pick Presenter!' : 'Spin!'),
                style: TextStyle(
                  fontSize: isPresenterSection ? 16 : 14,
                  fontFamily: 'Courier New',
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildRoleGroup(String role, IconData icon, Color color) {
    List<String> peopleInRole = _roleAssignments.entries
        .where((entry) => entry.value == role)
        .map((entry) => entry.key)
        .toList();

    if (peopleInRole.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 10),
          Text(
            role,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
              fontFamily: 'Courier New',
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Wrap(
              spacing: 8,
              children: peopleInRole
                  .map((person) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          person,
                          style: TextStyle(
                            fontSize: 14,
                            color: color.withOpacity(0.8),
                            fontFamily: 'Courier New',
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
