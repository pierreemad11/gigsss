import 'package:flutter/material.dart';
import '../services/task_service.dart'; // Import the task service
import 'task_details_entry_screen.dart'; // Import the new screen

class PostTaskScreen extends StatefulWidget {
  const PostTaskScreen({super.key});

  @override
  State<PostTaskScreen> createState() => _PostTaskScreenState();
}

class _PostTaskScreenState extends State<PostTaskScreen> {
  // These will be used in the new TaskDetailsEntryScreen, but declared here for now
  // to demonstrate the flow.
  // final _formKey = GlobalKey<FormState>();
  // final TextEditingController _titleController = TextEditingController();
  // final TextEditingController _descriptionController = TextEditingController();
  // final TaskService _taskService = TaskService(); // Instantiate TaskService

  @override
  void dispose() {
    // _titleController.dispose();
    // _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 350,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/job.jpg'), // Use your local asset path
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                // Semi-transparent overlay for contrast
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                  ),
                ),
                // Search bar at the top
                Positioned(
                  top: 24,
                  left: 16,
                  right: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.grey, size: 22),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "What's next on your to-do list?",
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: Color(0xFFF48FB1),
                          child: Text(
                            'P', // Replace with user's initial if available
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Centered overlay text and button
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Describe your task.',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(blurRadius: 8, color: Colors.black26)],
                        ),
                      ),
                      const Text(
                        'Review your offers.',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(blurRadius: 8, color: Colors.black26)],
                        ),
                      ),
                      const Text(
                        'Get things done.',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [Shadow(blurRadius: 8, color: Colors.black26)],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: 180,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5B6BFE),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                            elevation: 0,
                          ),
                          child: const Text('Post a Task', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextButton(
                        onPressed: () {},
                        child: const Text('How does it work?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Post any task in seconds',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildCategoryButton(context, Icons.delivery_dining, 'Delivery'),
                  _buildCategoryButton(context, Icons.format_paint, 'Painting'),
                  _buildCategoryButton(context, Icons.cleaning_services, 'Cleaning'),
                  _buildCategoryButton(context, Icons.local_shipping, 'Hauling'),
                  _buildCategoryButton(context, Icons.computer, 'Computer'),
                  _buildCategoryButton(context, Icons.handyman, 'Handyman'),
                  _buildCategoryButton(context, Icons.fitness_center, 'Heavy Lifting'),
                  _buildCategoryButton(context, Icons.camera_alt, 'Photography'),
                  _buildCategoryButton(context, Icons.people, 'Event Staffing'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(BuildContext context, IconData icon, String label) {
    // Color mapping for icons
    final Map<String, Color> iconColors = {
      'Hauling': Color(0xFF1976D2), // blue
      'Computer': Color(0xFF1976D2), // blue
      'Cleaning': Color(0xFF388E3C), // green
      'Delivery': Color(0xFFF9A825), // amber/orange
      'Handyman': Color(0xFFFB8C00), // deep orange
      'Painting': Color(0xFF8E24AA), // purple
      'Heavy Lifting': Color(0xFF00897B), // teal
      'Photography': Color(0xFFD81B60), // pink
      'Event Staffing': Color(0xFF3949AB), // indigo
    };
    return OutlinedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskDetailsEntryScreen(category: label),
          ),
        );
      },
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Color(0xFFE0E0E0)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: iconColors[label] ?? Colors.blueGrey),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontSize: 12, color: Colors.black87)),
        ],
      ),
    );
  }
} 