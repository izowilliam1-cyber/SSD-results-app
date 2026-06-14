import 'package:flutter/material.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  String _selectedExam = 'S4';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Exam selector
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: ['PLE', 'S4', 'S8']
                  .map((exam) => Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedExam = exam),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedExam == exam
                              ? Colors.deepPurple
                              : Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          exam,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: _selectedExam == exam ? Colors.white : Colors.grey[400],
                          ),
                        ),
                      ),
                    ),
                  ))
                  .toList(),
            ),
          ),
          // Leaderboard list
          Expanded(
            child: ListView.builder(
              itemCount: 50,
              itemBuilder: (context, index) => _LeaderboardItem(rank: index + 1),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardItem extends StatelessWidget {
  final int rank;

  const _LeaderboardItem({required this.rank});

  @override
  Widget build(BuildContext context) {
    // Mock data
    final names = ['Alice Deng', 'James Kuany', 'Maria Nyok', 'Peter Deng', 'Sarah Mayen'];
    final schools = ['Juba High', 'Unity School', 'Khartoum', 'Nyala Secondary', 'El Fasher'];
    final scores = List.generate(50, (i) => 95 - i);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.deepPurple.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            // Rank badge
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: rank <= 3
                    ? (rank == 1
                        ? Colors.amber
                        : rank == 2
                            ? Colors.grey[500]
                            : Colors.orange)
                    : Colors.grey[800],
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '#$rank',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: rank <= 3 ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Student info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    names[rank % names.length],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    schools[rank % schools.length],
                    style: TextStyle(color: Colors.grey[400], fontSize: 12),
                  ),
                ],
              ),
            ),
            // Score
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${scores[rank - 1]}%',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Score',
                  style: TextStyle(color: Colors.grey[500], fontSize: 10),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
