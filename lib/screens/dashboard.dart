import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:gender_hack/models/enrollment_data.dart';

class Dashboard extends StatefulWidget {
  final bool isPrimary;
  const Dashboard({
    super.key,
    this.isPrimary = true,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

enum DataView { table, bar, pie }
enum Grouping { year, region, gender, courseType, facoulty }

class _DashboardState extends State<Dashboard> {
  List<EnrollmentData> _allEnrollments = [];
  List<EnrollmentData> _filteredEnrollments = [];

  Set<DataView> _selectedView = {DataView.table};
  Grouping _selectedGrouping = Grouping.gender;

  String? _selectedYear;
  String? _selectedRegion;
  String? _selectedGender;
  String? _selectedCourseType;
  String? _selectedFacoulty;

  final List<String> _years = [];
  final List<String> _regions = [];
  final List<String> _genders = [];
  final List<String> _courseTypes = [];
  final List<String> _facoulties = [];

  @override
  void initState() {
    super.initState();
    if (widget.isPrimary) {
      _loadJsonData();
    }
  }

  @override
  void didUpdateWidget(covariant Dashboard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPrimary && !oldWidget.isPrimary && _allEnrollments.isEmpty) {
      // Reload data if we are coming back to this tab and data is not loaded.
      _loadJsonData();
    }
  }

  Future<void> _loadJsonData() async {
    final String rawData =
        await rootBundle.loadString("assets/data/uni_subsbho.json");
    final List<dynamic> listData = json.decode(rawData) as List<dynamic>;
    final enrollments =
        listData.map((item) => EnrollmentData.fromJson(item)).toList();

    _years.addAll(
        enrollments.map((e) => e.academicYear).toSet().toList()..sort());
    _regions.addAll(enrollments.map((e) => e.region).toSet().toList()..sort());
    _genders.addAll(enrollments.map((e) => e.gender).toSet().toList()..sort());
    _courseTypes
        .addAll(enrollments.map((e) => e.courseType).toSet().toList()..sort());
    _facoulties
        .addAll(enrollments.map((e) => e.facoulty).toSet().toList()..sort());

    setState(() {
      _allEnrollments = enrollments;
      _filteredEnrollments = enrollments;
      _selectedFacoulty = null;
    });
  }

  void _applyFilters() {
    List<EnrollmentData> filtered = _allEnrollments;

    if (_selectedYear != null) {
      filtered =
          filtered.where((e) => e.academicYear == _selectedYear).toList();
    }
    if (_selectedRegion != null) {
      filtered = filtered.where((e) => e.region == _selectedRegion).toList();
    }
    if (_selectedGender != null) {
      filtered = filtered.where((e) => e.gender == _selectedGender).toList();
    }
    if (_selectedCourseType != null) {
      filtered =
          filtered.where((e) => e.courseType == _selectedCourseType).toList();
    }
    if (_selectedFacoulty != null) {
      filtered =
          filtered.where((e) => e.facoulty == _selectedFacoulty).toList();
    }
    setState(() => _filteredEnrollments = filtered);
  }

  Map<String, int> _getGroupedData() {
    final Map<String, int> groupedData = {};

    for (var entry in _filteredEnrollments) {
      String key;
      switch (_selectedGrouping) {
        case Grouping.year:
          key = entry.academicYear;
          break;
        case Grouping.region:
          key = entry.region;
          break;
        case Grouping.gender:
          key = entry.gender;
          break;
        case Grouping.courseType:
          key = entry.courseType;
          break;
        case Grouping.facoulty:
          key = entry.facoulty;
          break;
      }
      groupedData.update(key, (value) => value + entry.enrolled,
          ifAbsent: () => entry.enrolled);
    }
    return groupedData;
  }

  String _getGroupingName(Grouping grouping) {
    final name = grouping.toString().split('.').last;
    return name.replaceAllMapped(
        RegExp(r'([A-Z])'), (match) => ' ${match.group(1)}').trimLeft();
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
                      width: width * 0.9,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromRGBO(156, 39, 176, 0.3),
                            const Color.fromRGBO(0, 0, 0, 0.4),
                          ],
                        ),
                        border: Border.all(
                            color: const Color.fromRGBO(156, 39, 176, 0.5)),
                      ),
                      child: Column(
                        children: [
                          const Text('Filter Enrollments',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 16),
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: [
                              _buildFilterDropdown(
                                  _years,
                                  'Year',
                                  _selectedYear,
                                  (val) => setState(() => _selectedYear = val)),
                              _buildFilterDropdown(
                                  _regions,
                                  'Region',
                                  _selectedRegion,
                                  (val) =>
                                      setState(() => _selectedRegion = val)),
                              _buildFilterDropdown(
                                  _genders,
                                  'Gender',
                                  _selectedGender,
                                  (val) =>
                                      setState(() => _selectedGender = val)),
                              _buildFilterDropdown(
                                  _courseTypes,
                                  'Course Type',
                                  _selectedCourseType,
                                  (val) => setState(
                                      () => _selectedCourseType = val)),
                              _buildFilterDropdown(
                                  _facoulties,
                                  'Facoulty',
                                  _selectedFacoulty,
                                  (val) =>
                                      setState(() => _selectedFacoulty = val)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _applyFilters,
                            icon: const Icon(Icons.search, color: Colors.white),
                            label: const Text('Apply Filters',
                                style: TextStyle(color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedYear = null;
                                _selectedRegion = null;
                                _selectedGender = null;
                                _selectedCourseType = null;
                                _selectedFacoulty = null;
                                _filteredEnrollments = _allEnrollments;
                              });
                            },
                            child: const Text(
                              'Clear Filters',
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 13),
                            ),
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  if (_filteredEnrollments.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    const Text(
                      'Enrollment Data',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                        'Showing ${_filteredEnrollments.length} of ${_allEnrollments.length} records',
                        style: TextStyle(color: Colors.white70)),
                    const SizedBox(height: 16),
                    SegmentedButton<DataView>(
                      segments: const <ButtonSegment<DataView>>[
                        ButtonSegment<DataView>(
                            value: DataView.table,
                            label: Text('Table'),
                            icon: Icon(Icons.table_rows)),
                        ButtonSegment<DataView>(
                            value: DataView.bar,
                            label: Text('Bar Chart'),
                            icon: Icon(Icons.bar_chart)),
                        ButtonSegment<DataView>(
                            value: DataView.pie,
                            label: Text('Pie Chart'),
                            icon: Icon(Icons.pie_chart)),
                      ],
                      selected: _selectedView,
                      onSelectionChanged: (Set<DataView> newSelection) {
                        setState(() {
                          _selectedView = newSelection;
                        });
                      },
                      style: SegmentedButton.styleFrom(
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                        selectedForegroundColor: Colors.white,
                        selectedBackgroundColor: Colors.purple,
                      ),
                    ),
                    const SizedBox(height: 16),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      child: _buildDataView(),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SizeTransition(
                            sizeFactor: animation,
                            axis: Axis.vertical,
                            child: child,
                          ),
                        );
                      },
                    ),
                    if (_selectedView.first != DataView.table) ...[
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Group by: ',
                              style: TextStyle(color: Colors.white)),
                          Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Grouping>(
                                value: _selectedGrouping,
                                dropdownColor: Colors.grey[850],
                                style: const TextStyle(color: Colors.white),
                                icon: const Icon(Icons.arrow_drop_down,
                                    color: Colors.white),
                                items: Grouping.values
                                    .map((group) => DropdownMenuItem(
                                        value: group,
                                        child: Text(_getGroupingName(group))))
                                    .toList(),
                                onChanged: (val) =>
                                    setState(() => _selectedGrouping = val!),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 100),
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
                                    duration:
                                        const Duration(milliseconds: 1000),
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
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataView() {
    final view = _selectedView.first;
    Widget child;

    switch (view) {
      case DataView.table:
        child = SingleChildScrollView(
            key: const ValueKey('datatable'),
            scrollDirection: Axis.horizontal,
            child: _buildDataTable());
        break;
      case DataView.bar:
        child = SizedBox(
            key: const ValueKey('barchart'),
            height: 300,
            child: _buildBarChart());
        break;
      case DataView.pie:
        child = SizedBox(
            key: const ValueKey('piechart'),
            height: 300,
            child: _buildPieChart());
        break;
    }

    if (view == DataView.table) {
      return child;
    } else {
      return Stack(
        children: [
          child,
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.fullscreen, color: Colors.white),
              onPressed: () {
                _openChartFullscreen();
              },
            ),
          ),
        ],
      );
    }
  }

  Widget _buildFilterDropdown(List<String> items, String hint, String? value,
      void Function(String?)? onChanged) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      width: width * 0.3,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          isDense: true,
          hint: Text(hint,
              style: const TextStyle(
                  color: Colors.white70, overflow: TextOverflow.fade)),
          dropdownColor: Colors.grey[850],
          style: const TextStyle(
              color: Colors.white, overflow: TextOverflow.fade, fontSize: 13),
          icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    return DataTable(
      headingRowColor: WidgetStateColor.resolveWith(
          (states) => Colors.purple.withOpacity(0.3)),
      columns: [
        'Academic Year',
        'Region',
        'Gender',
        'Course Type',
        'Facoulty',
        'Enrolled'
      ]
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
      rows: _filteredEnrollments
          .map((row) => DataRow(
                cells: [
                  DataCell(Text(row.academicYear,
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Text(row.region,
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Text(row.gender,
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Text(row.courseType,
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Text(row.facoulty,
                      style: const TextStyle(color: Colors.white))),
                  DataCell(Text(row.enrolled.toString(),
                      style: const TextStyle(color: Colors.white))),
                ],
              ))
          .toList(),
    );
  }

  Widget _buildBarChart() {
    if (_filteredEnrollments.isEmpty) {
      return const Center(
          child: Text('No data to display for the selected filters.',
              style: TextStyle(color: Colors.white70)));
    }

    final groupedData = _getGroupedData();

    final List<BarChartGroupData> barGroups = [];
    int i = 0;
    groupedData.forEach((key, total) {
      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: total.toDouble(),
              gradient: const LinearGradient(
                colors: [Colors.purpleAccent, Colors.deepPurpleAccent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              width: 20,
              borderRadius: BorderRadius.circular(4),
            ),
          ],
        ),
      );
      i++;
    });

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        barTouchData: BarTouchData(
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              if (groupedData.length > 5) {
                final key = groupedData.keys.elementAt(group.x);
                final value = rod.toY.toInt();
                return BarTooltipItem(
                  '$key\n$value',
                  const TextStyle(color: Colors.white),
                );
              }
              return null;
            },
          ),
        ),
        barGroups: barGroups,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: groupedData.length <= 5,
              getTitlesWidget: (double value, TitleMeta meta) {
                final index = value.toInt();
                if (index >= 0 && index < groupedData.keys.length) {
                  return SideTitleWidget(
                    meta: meta,
                    child: Text(groupedData.keys.elementAt(index), style: const TextStyle(
                                color: Colors.white, fontSize: 14, overflow: TextOverflow.fade)),
                  );
                }
                return Container();
              },
              reservedSize: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPieChart() {
    if (_filteredEnrollments.isEmpty) {
      return const Center(
          child: Text('No data to display for the selected filters.',
              style: TextStyle(color: Colors.white70)));
    }

    final groupedData = _getGroupedData();
    final totalEnrollment =
        groupedData.values.fold(0, (sum, item) => sum + item);

    final List<PieChartSectionData> sections = [];
    int i = 0;
    final List<Color> colors = [
      Colors.purple,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.teal,
      Colors.pink,
      Colors.amber,
    ];

    groupedData.forEach((key, value) {
      final isTouched = false; 
      final fontSize = isTouched ? 18.0 : 14.0;
      final radius = isTouched ? 110.0 : 100.0;
      final percentage = (value / totalEnrollment * 100);

      sections.add(PieChartSectionData(
        color: colors[i % colors.length],
        value: value.toDouble(),
        title: '${percentage.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: const [Shadow(color: Colors.black, blurRadius: 2)],
        ),
        badgeWidget: _ChartBadge(key, color: colors[i % colors.length]),
        badgePositionPercentageOffset: .98,
      ));
      i++;
    });

    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            // Here you could handle touch events to show more details
          },
        ),
        borderData: FlBorderData(show: false),
        sectionsSpace: 2,
        centerSpaceRadius: 40,
        sections: sections,
      ),
    );
  }

  void _openChartFullscreen() {
    final view = _selectedView.first;
    if (view == DataView.table) return;

    final String title =
        view == DataView.bar ? 'Bar Chart' : 'Pie Chart';
    final Widget chart =
        view == DataView.bar ? _buildBarChart() : _buildPieChart();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullscreenChartPage(
          title: title,
          chart: chart,
        ),
      ),
    );
  }
}

class FullscreenChartPage extends StatelessWidget {
  final String title;
  final Widget chart;

  const FullscreenChartPage({super.key, required this.title, required this.chart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text(title), backgroundColor: Colors.purple),
      body: Center(child: Padding(padding: const EdgeInsets.fromLTRB(16, 200, 16, 16), child: chart)),
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

class _ChartBadge extends StatelessWidget {
  const _ChartBadge(
    this.label, {
    required this.color,
  });
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.4),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: const EdgeInsets.all(5),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
