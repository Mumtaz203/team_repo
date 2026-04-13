import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Team Profile App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const TeamProfilePage(),
    );
  }
}

class TeamProfilePage extends StatefulWidget {
  const TeamProfilePage({super.key});

  @override
  State<TeamProfilePage> createState() => _TeamProfilePageState();
}

class _TeamProfilePageState extends State<TeamProfilePage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<TeamMember> _members = const [
    TeamMember(
      name: 'Mumtaz',
      country: 'Germany',
      role: 'Flutter Developer',
      hobbies: 'UI design, football, photography',
      motto: 'Build simple, build useful.',
      imagePath: 'assets/images/image.png',
    ),
    TeamMember(
      name: 'Martin',
      country: 'Finland',
      role: 'Backend Integrator',
      hobbies: 'Reading, gaming, hiking',
      motto: 'Clean code wins.',
      imagePath: 'assets/images/image_copy 2.png',
    ),
    TeamMember(
      name: 'Abdul',
      country: 'Finland',
      role: 'QA & Testing',
      hobbies: 'Travel, music, chess',
      motto: 'Quality is everyone\'s job.',
      imagePath: 'assets/images/image_copy.png',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextMember() {
    if (_currentIndex < _members.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousMember() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Team Profile App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Team: Group 2',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('We build clean and user-friendly mobile apps with Flutter.'),
                ],
              ),
            ),
          ),
          Wrap(
            spacing: 8,
            children: const [
              Chip(label: Text('Flutter')),
              Chip(label: Text('Dart')),
              Chip(label: Text('Material UI')),
            ],
          ),
          const SizedBox(height: 8),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _members.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return MemberCard(member: _members[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _currentIndex == 0 ? null : _previousMember,
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Previous'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed:
                        _currentIndex == _members.length - 1 ? null : _nextMember,
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Next'),
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

class MemberCard extends StatelessWidget {
  final TeamMember member;

  const MemberCard({super.key, required this.member});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Center(
              child: CircleAvatar(
                radius: 56,
                child: ClipOval(
                  child: Image.asset(
                    member.imagePath,
                    width: 112,
                    height: 112,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const SizedBox(
                        width: 112,
                        height: 112,
                        child: Icon(Icons.person, size: 48),
                      );
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                member.name,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.flag),
              title: const Text('Country'),
              subtitle: Text(member.country),
            ),
            ListTile(
              leading: const Icon(Icons.work_outline),
              title: const Text('Role'),
              subtitle: Text(member.role),
            ),
            ListTile(
              leading: const Icon(Icons.interests_outlined),
              title: const Text('Hobbies'),
              subtitle: Text(member.hobbies),
            ),
            ListTile(
              leading: const Icon(Icons.format_quote),
              title: const Text('Motto'),
              subtitle: Text(member.motto),
            ),
          ],
        ),
      ),
    );
  }
}

class TeamMember {
  final String name;
  final String country;
  final String role;
  final String hobbies;
  final String motto;
  final String imagePath;

  const TeamMember({
    required this.name,
    required this.country,
    required this.role,
    required this.hobbies,
    required this.motto,
    required this.imagePath,
  });
}

