import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SSD Results'),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with app logo
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Icon(Icons.school, size: 64, color: Colors.deepPurple),
                  const SizedBox(height: 16),
                  const Text(
                    'South Sudan Results',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Check PLE, S4 & S8 Results',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                ],
              ),
            ),
            // Feature cards
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _FeatureCard(
                    icon: Icons.assessment,
                    title: 'Check Results',
                    description: 'Get your exam results instantly',
                    onTap: () => Navigator.pushNamed(context, '/results'),
                  ),
                  const SizedBox(height: 12),
                  _FeatureCard(
                    icon: Icons.leaderboard,
                    title: 'Leaderboard',
                    description: 'See top performers',
                    onTap: () => Navigator.pushNamed(context, '/leaderboard'),
                  ),
                  const SizedBox(height: 12),
                  _FeatureCard(
                    icon: Icons.timer,
                    title: 'Countdown',
                    description: 'Next exam countdown',
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Coming soon!')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 32, color: Colors.deepPurple),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(description, style: TextStyle(color: Colors.grey[400], fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
