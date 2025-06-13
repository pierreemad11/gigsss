import 'package:flutter/material.dart';
import '../widgets/task_poster_nav_bar.dart';

class EditTaskScreen extends StatelessWidget {
  final String title;
  const EditTaskScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Task')),
      body: Center(child: Text('Edit Task: $title')),
      bottomNavigationBar: Navbar(
        selectedIndex: 0,
        onItemTapped: (index) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
} 