import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/screens.dart';
import 'course.dart';

/// The entry point of the application.
///
/// This function initializes the Flutter bindings, sets up Hive for local storage,
/// and runs the [MainApp] widget.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  
  runApp(const MainApp());
}

/// The root widget of the application.
///
/// This widget sets up the [MaterialApp] with the application title,
/// themes (implicitly via defaults), and named routes for navigation.
class MainApp extends StatelessWidget {
  /// Creates the [MainApp] widget.
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
