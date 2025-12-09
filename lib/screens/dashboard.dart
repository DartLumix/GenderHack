import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:multiselect_field/multiselect_field.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import 'dart:convert';

class Car {
  final int id;
  final double price;
  final int year;

  Car(this.id, this.price, this.year);
}

class Dashboard extends StatefulWidget {
  final bool isPrimary;
  const Dashboard({
    super.key,
    this.isPrimary = true, // Default to true for standalone usage
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List<Map<String, dynamic>> _jsonData = [];

  @override
  void initState() {
    super.initState();
    if (widget.isPrimary) {
      _loadJsonData();
    }
  }

  Future<void> _loadJsonData() async {
    // Assuming your json file is in the same directory and has the same name, with a .json extension
    final String rawData =
        await rootBundle.loadString("assets/data/uni_subsbho.json");
    final List<dynamic> listData = json.decode(rawData) as List<dynamic>;
    setState(() {
      _jsonData = listData.map((item) {
        return item as Map<String, dynamic>;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
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

    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(width * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      padding: const EdgeInsets.all(16.0),
                      width: width * 0.9,
                      height: height * 0.25,
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
                      child: MultiSelectField<Car>(
                          data: () => [
                                Choice<Car>('Ferrari', '488 GTB',
                                    metadata: Car(101, 25.000, 2020)),
                                Choice<Car>('2', '488 GTB',
                                    metadata: Car(103, 27.500, 2015)),
                                Choice<Car>('3', '458 Italia',
                                    metadata: Car(99, 22.000, 2009)),
                                Choice<Car>('4', 'Portofino',
                                    metadata: Car(105, 31.000, 2017)),
                                Choice<Car>('5', 'California T',
                                    metadata: Car(102, 25.000, 2016)),
                                Choice<Car>('6', 'F8 Tributo',
                                    metadata: Car(104, 30.000, 2019)),
                              ],
                              defaultData: [],
                          useTextFilter:
                              true, // Enables real-time text filtering
                          onSelect: (List<Choice<Car>> selectedItems,
                              isFromDefaulData) {
                            // You can handle the selected items here.
                            // For example, print the metadata of the selected cars.
                            for (var item in selectedItems) {
                              if (item.metadata != null) {
                                print(
                                    'Selected Car: ${item.metadata!.id} - ${item.metadata!.price} - ${item.metadata!.year}');
                              }
                            }
                          })),
                          SizedBox(height: 20,),
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
                          child: widget.isPrimary
                              ? LineChart(
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
                                  duration: const Duration(milliseconds: 1000),
                                  curve: Curves.easeInOut,
                                )
                              : const Center(
                                  child: Icon(Icons.show_chart,
                                      color: Colors.purpleAccent, size: 48)),
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
                  if (_jsonData.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'Pioneers in Tech',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 16),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: WidgetStateColor.resolveWith(
                            (states) => Colors.purple.withOpacity(0.3)),
                        columns: _jsonData[0]
                            .keys
                            .map((key) => DataColumn(
                                  label: Text(
                                    key,
                                    style: const TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                            .toList(),
                        rows: _jsonData
                            .map((row) => DataRow(
                                  cells: row
                                      .values
                                      .map((cell) => DataCell(Text(
                                          cell.toString(),
                                          style: const TextStyle(
                                              color: Colors.white))))
                                      .toList(),
                                ))
                            .toList(),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Goal {
  final String title;
  final double progress;

  Goal({required this.title, required this.progress});
}

class GoalProgressTile extends StatelessWidget {
  final Goal goal;
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
