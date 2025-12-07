import 'package:flutter/material.dart';
import 'screens.dart' as screens;
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const screens.Dashboard(),
      const screens.Courses(),
      const screens.Profile(),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: _pageController,
        children: pages,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      bottomNavigationBar: StylishBottomBar(
        items: [
          BottomBarItem(
            icon: const Icon(Icons.dashboard_outlined),
            selectedIcon: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.school_outlined),
            selectedIcon: const Icon(Icons.school),
            title: const Text('Courses'),
          ),
          BottomBarItem(
            icon: const Icon(Icons.person_outline),
            selectedIcon: const Icon(Icons.person),
            title: const Text('Profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
        option: DotBarOptions(
          dotStyle: DotStyle.tile,
        ),
        backgroundColor: Colors.black,
        
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}