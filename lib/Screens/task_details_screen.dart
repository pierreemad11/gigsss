import 'package:flutter/material.dart';
import '../widgets/task_poster_nav_bar.dart';

class TaskDetailsScreen extends StatelessWidget {
  final String title;
  final String details;
  const TaskDetailsScreen({super.key, required this.title, required this.details});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(details)),
      bottomNavigationBar: Navbar(
        selectedIndex: 0,
        onItemTapped: (index) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
} 