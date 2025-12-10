import 'package:flutter/material.dart';
import 'package:gender_hack/screens/settings_page.dart';
import 'package:fl_chart/fl_chart.dart';

/// A screen displaying the user's profile information.
///
/// Includes user avatar, bio, weekly progress chart, and goal progress.
class Profile extends StatefulWidget {
  /// Creates a [Profile] widget.
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String _currentAvatar = 'assets/Ada.png'; // Default avatar
  final String _username = 'Ada Lovelace';
  final String _bio =
      'An English mathematician and writer, chiefly known for her work on Charles Babbage\'s proposed mechanical general-purpose computer, the Analytical Engine.';

  // In a real app, these would come from your assets or a server
  final List<String> _avatars = [
    'assets/Ada.png',
    'assets/avatar2.png', // Placeholder, add your assets
    'assets/avatar3.png', // Placeholder, add your assets
  ];

  void _showAvatarChooser(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      builder: (BuildContext context) {
        return SafeArea(
          child: GridView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _avatars.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _currentAvatar = _avatars[index];
                  });
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage(_avatars[index]),
                  radius: 40,
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final List<Goal> goals = [
      Goal(title: 'Complete "Intro to Programming"', progress: 0.75),
      Goal(title: 'Learn about Ada Lovelace', progress: 0.5),
      Goal(title: 'Finish "Women in Tech" module', progress: 0.2),
    ];

    final List<FlSpot> chartData = [
      for (int i = 0; i < 7; i++)
        FlSpot(
          i.toDouble(),
          (i * 0.5) + (i % 2 == 0 ? 1 : -0.5) * (i * 0.2) + 1,
        ),
    ];
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(_currentAvatar),
                    backgroundColor: Colors.grey[800],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => _showAvatarChooser(context),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.edit, color: Colors.white, size: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                _username,
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                _bio,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[400], fontSize: 16),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16.0),
                width: width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(156, 39, 176, 0.3),
                      const Color.fromRGBO(0, 0, 0, 0.4),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                      color: const Color.fromRGBO(156, 39, 176, 0.5)),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Weekly Progress',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: height * 0.25,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                              spots: chartData,
                              isCurved: true,
                              color: Colors.purpleAccent,
                              barWidth: 4,
                              isStrokeCapRound: true,
                              dotData: FlDotData(show: false),
                              belowBarData: BarAreaData(
                                show: true,
                                color: const Color.fromRGBO(
                                    156, 39, 176, 0.3),
                              ),
                            ),
                          ],
                          lineTouchData: LineTouchData(
                            enabled: true,
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots.map((spot) {
                                  return LineTooltipItem(
                                    '${spot.y.toStringAsFixed(1)} points',
                                    const TextStyle(
                                        color: Colors.white),
                                  );
                                }).toList();
                              },
                            ),
                          ),
                        ),
                        duration:
                            const Duration(milliseconds: 1000),
                        curve: Curves.easeInOut,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Your Goals',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 16),
              ...goals.map((goal) => GoalProgressTile(goal: goal)),
            ],
          ),
        ),
      ),
    );
  }
}

/// Represents a user goal with its progress.
class Goal {
  /// The title of the goal.
  final String title;

  /// The progress of the goal (0.0 to 1.0).
  final double progress;

  /// Creates a [Goal].
  ///
  /// * [title]: The goal description.
  /// * [progress]: The completion percentage.
  Goal({required this.title, required this.progress});
}

/// A tile widget displaying a single goal and its progress bar.
class GoalProgressTile extends StatelessWidget {
  /// The goal to display.
  final Goal goal;

  /// Creates a [GoalProgressTile].
  ///
  /// * [goal]: The goal data object.
  const GoalProgressTile({super.key, required this.goal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          colors: [
            const Color.fromRGBO(66, 66, 66, 0.5),
            const Color.fromRGBO(33, 33, 33, 0.6),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        border: Border.all(color: Colors.grey.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            goal.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: goal.progress,
                    backgroundColor: Colors.grey.shade700,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Colors.purpleAccent,
                    ),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${(goal.progress * 100).toInt()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
