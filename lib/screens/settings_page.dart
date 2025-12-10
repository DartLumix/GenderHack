import 'package:flutter/material.dart';

/// The settings page of the application.
///
/// Currently serves as a placeholder for app configuration options.
class SettingsPage extends StatelessWidget {
  /// Creates a [SettingsPage] widget.
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: const Center(child: Text('Settings Page', style: TextStyle(color: Colors.white),)),
    );
  }
}
