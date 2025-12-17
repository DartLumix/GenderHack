import 'package:flutter/material.dart';
import 'screens.dart' as screens;
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';

/// The main home screen of the application.
///
/// Contains a bottom navigation bar to switch between the Dashboard and Profile screens,
/// and an expandable floating action button for quick actions.
class HomePage extends StatefulWidget {
  /// Creates a [HomePage] widget.
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
          margin: const EdgeInsets.only(bottom: -35),
          fanAngle: 130,
          openButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(Icons.school, color: Colors.white, ),
              backgroundColor: Colors.purple),
          closeButtonBuilder: RotateFloatingActionButtonBuilder(
              child: const Icon(Icons.close, color: Colors.white),
              backgroundColor: Colors.purple),
          children: [
            FloatingActionButton(
              onPressed: () {},
              heroTag: null,
              child: const Icon(Icons.lock),
            ),
            FloatingActionButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => screens.Courses(),
                ), 
              ),
              heroTag: null,
              child: const Icon(Icons.school),
            ),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => screens.Outcome(),
                  ), 
                );
              },
              heroTag: null,
              child: const Icon(Icons.search),
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
