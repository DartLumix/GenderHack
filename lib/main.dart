import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/screens.dart';
import 'course.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  
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