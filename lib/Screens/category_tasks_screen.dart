import 'package:flutter/material.dart';
import '../widgets/task_poster_nav_bar.dart';

class CategoryTasksScreen extends StatelessWidget {
  final String category;
  const CategoryTasksScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$category Tasks')),
      body: Center(child: Text('Tasks for $category')),
      bottomNavigationBar: Navbar(
        selectedIndex: 0,
        onItemTapped: (index) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
    );
  }
} 