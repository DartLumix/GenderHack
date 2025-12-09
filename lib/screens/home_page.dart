import 'package:flutter/material.dart';
import 'screens.dart' as screens;
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
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
      floatingActionButton: ExpandableFab(
          type: ExpandableFabType.fan,
          pos: ExpandableFabPos.center,
          margin: const EdgeInsets.only(bottom: -35), // This is no longer needed
          fanAngle: 180,
          openButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(Icons.school, color: Colors.white),
              backgroundColor: Colors.purple),
          closeButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(Icons.close, color: Colors.white),
              backgroundColor: Colors.purple),
          children: [
            FloatingActionButton.small(
              child: const Icon(Icons.edit),
              onPressed: () {},
            ),
            FloatingActionButton.small(
              child: const Icon(Icons.edit),
              onPressed: () {},
            ),
            FloatingActionButton.small(
              child: const Icon(Icons.edit),
              onPressed: () {},
            ),
          ]),
      floatingActionButtonLocation: ExpandableFab.location,
      bottomNavigationBar: StylishBottomBar(
        items: [
          BottomBarItem(
              icon: const Icon(Icons.dashboard_outlined),
              selectedIcon: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              selectedColor: Colors.purple),
          BottomBarItem(
              icon: const Icon(Icons.person_outline),
              selectedIcon: const Icon(Icons.person),
              title: const Text('Profile'),
              selectedColor: Colors.purple),
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

  List<Widget> get pages => [
        screens.Dashboard(
          isPrimary: _selectedIndex == 0,
        ),
        const screens.Profile(),
      ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
