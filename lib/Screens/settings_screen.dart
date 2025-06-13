import 'package:flutter/material.dart';
import '../widgets/task_poster_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(child: Text('Settings Screen Placeholder')),
      bottomNavigationBar: Navbar(
        selectedIndex: 0, // Adjust as needed
        onItemTapped: (index) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
} 