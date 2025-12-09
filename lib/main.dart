import 'package:flutter/material.dart';
import 'screens/screens.dart';
import 'course.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gender Hack App',
      initialRoute: '/home_page',
      routes: {
        '/courses': (context) => const Courses(),
        '/course': (context) => Course(),
        '/home_page': (context) => const HomePage(),
      },
    );
  }
}