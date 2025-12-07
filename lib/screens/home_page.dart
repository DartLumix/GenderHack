import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'screens.dart' as screens;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    // Add a listener to rebuild the widget when the tab changes.
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> buildScreens() {
      return [
        const screens.Dashboard(),
        const screens.Courses(),
        const screens.Profile(),
      ];
    }
    List<PersistentBottomNavBarItem> navBarsItems() {
      final titles = ["Dashboard", "Courses", "Profile"];
      final icons = [Icons.dashboard, Icons.school, Icons.person];

      return [
        for (int i = 0; i < titles.length; i++)
          PersistentBottomNavBarItem(
            icon: Icon(icons[i]),
            // Only show the title if the item's index matches the controller's index.
            title: _controller.index == i ? titles[i] : null,
            activeColorPrimary: Colors.blue,
            inactiveColorPrimary: Colors.grey,
            textStyle: const TextStyle(fontSize: 12),
          ),
      ];
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: PersistentTabView(
          backgroundColor: Colors.black,
          context,
          controller: _controller,
          screens: buildScreens(),
          items: navBarsItems(),
          navBarStyle: NavBarStyle.style6,
          padding: const EdgeInsets.only(bottom: 10, top: 5),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}