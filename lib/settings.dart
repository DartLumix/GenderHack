import 'package:flutter/material.dart';

/// A placeholder settings widget.
///
/// This widget is currently a placeholder for future settings configuration.
/// See [SettingsPage] for the active settings screen used in the profile.
class Settings extends StatelessWidget {
  /// Creates a [Settings] widget.
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
