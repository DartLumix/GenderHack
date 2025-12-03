import 'package:flutter/material.dart';
import 'courses.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gender Hack App',
      initialRoute: '/',
      routes: {
        // named routes
        '/': (context) => const HomeScreen(), 
        '/courses': (context) => Courses(), 
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(context, '/courses');
          },
          child: const Text('Courses'), 
        ),
      ),
    );
  }
}