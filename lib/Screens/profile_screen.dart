import 'package:flutter/material.dart';
import '../widgets/task_poster_nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: const Center(child: Text('Profile Screen Placeholder')),
      bottomNavigationBar: Navbar(
        selectedIndex: 0, // You can adjust this as needed
        onItemTapped: (index) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
} 