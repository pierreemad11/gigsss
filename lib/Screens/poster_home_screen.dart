import 'package:flutter/material.dart';
import '../widgets/task_poster_nav_bar.dart';
import 'post_task_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import 'task_details_screen.dart';
import 'edit_task_screen.dart';
import 'category_tasks_screen.dart';
import 'Chat_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PosterHomeScreen extends StatefulWidget {
  const PosterHomeScreen({super.key});

  @override
  State<PosterHomeScreen> createState() => _PosterHomeScreenState();
}

class _PosterHomeScreenState extends State<PosterHomeScreen> with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late final TabController _tasksTabController;
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _tasksTabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    _tasksTabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildDashboardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting and progress
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good evening, Sherif!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    SizedBox(height: 4),
                    Text('Ready to earn more today?', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Progress
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: CircularProgressIndicator(
                      value: 0.24,
                      strokeWidth: 6,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1DBF73)),
                    ),
                  ),
                  Text('24%', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Silver Poster Progress', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Complete 8 more tasks to unlock Silver benefits', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Status summary
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildStatusChip('First Task', Colors.yellow[700]!, Colors.white),
              _buildStatusChip('5 Offers', Color(0xFF1DBF73), Colors.white),
              _buildStatusChip('Top Rated', Colors.blue[300]!, Colors.white),
            ],
          ),
          SizedBox(height: 20),
          // Task status numbers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatusCount('Active', 1, Colors.blue),
              _buildStatusCount('Pending', 3, Colors.orange),
              _buildStatusCount('Completed', 0, Colors.green),
              _buildStatusCount('Canceled', 0, Colors.red),
            ],
          ),
          SizedBox(height: 20),
          // Quick Categories
          Text('Quick Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryButton(Icons.local_shipping, 'Moving'),
              _buildCategoryButton(Icons.cleaning_services, 'Cleaning'),
              _buildCategoryButton(Icons.shopping_cart, 'Grocery'),
              _buildCategoryButton(Icons.delivery_dining, 'Delivery'),
              _buildCategoryButton(Icons.add, 'Custom'),
            ],
          ),
          SizedBox(height: 20),
          // Current Task in Progress
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[100]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Current Task in Progress', style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text('Help move furniture to new apartment'),
                SizedBox(height: 4),
                Text('Runner: Mike Johnson', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: LinearProgressIndicator(
                        value: 0.6,
                        backgroundColor: Colors.grey[200],
                        color: Color(0xFF1DBF73),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('60%'),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ChatMessagesScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Message'),
                    ),
                    SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TaskDetailsScreen(
                              title: 'Current Task in Progress',
                              details: 'Help move furniture to new apartment\nRunner: Mike Johnson',
                            ),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text('Details'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // Unassigned Tasks
          Text('Unassigned Tasks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 10),
          _buildUnassignedTask('Clean 2-bedroom apartment thoroughly', '3 offers received', 'about 2 hours ago'),
          _buildUnassignedTask('Grocery shopping for weekly supplies', '7 offers received', 'about 5 hours ago'),
          _buildUnassignedTask('Pick up dry cleaning downtown', 'No offers yet', '1 day ago'),
          SizedBox(height: 20),
          // Tip of the Day
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.yellow[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.lightbulb, color: Colors.orange[700]),
                SizedBox(width: 10),
                Expanded(child: Text('Tip of the Day\nAdd photos to boost offers by 30%')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, Color color, Color textColor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildStatusCount(String label, int count, Color color) {
    return Column(
      children: [
        Text('$count', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
        SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
      ],
    );
  }

  Widget _buildCategoryButton(IconData icon, String label) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => CategoryTasksScreen(category: label),
          ),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[200],
            child: Icon(icon, color: Colors.blue),
          ),
          SizedBox(height: 6),
          Text(label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildUnassignedTask(String title, String offers, String time) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('$offers\n$time'),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.grey[600]),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditTaskScreen(title: title),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red[400]),
              onPressed: () {
                // TODO: Implement delete logic (show dialog for now)
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Task'),
                    content: const Text('Are you sure you want to delete this task?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          // TODO: Remove the task from the list/database
                        },
                        child: const Text('Delete', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TaskDetailsScreen(
                title: title,
                details: '$offers\n$time',
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildDashboardTab();
      case 1:
        return const PostTaskScreen();
      case 2:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Analytics Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              _buildMetricCard(context, 'Total Tasks Posted', '150', Icons.assignment),
              _buildMetricCard(context, 'Total Hired', '85', Icons.people),
              _buildMetricCard(context, 'Total Spent', '\$12,500', Icons.attach_money),
              _buildMetricCard(context, 'Hiring Rate', '85%', Icons.trending_up),
              _buildMetricCard(context, 'Successful Jobs', '80', Icons.check_circle),
              _buildMetricCard(context, 'Average Rating', '4.7/5', Icons.star),
              const SizedBox(height: 20),
              // You can add charts or more detailed analytics here
              Text(
                'Detailed Insights',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              // Example: A simple progress bar for successful jobs
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Successful Jobs Progress', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: 0.8,
                        backgroundColor: Colors.grey.shade300,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('80% Completed', style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case 3:
        return const ChatMessagesScreen();
      default:
        return const Center(child: Text('Unknown tab'));
    }
  }

  Widget _buildMetricCard(BuildContext context, String title, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, size: 36, color: Theme.of(context).colorScheme.primary),
        title: Text(title, style: Theme.of(context).textTheme.titleMedium),
        trailing: Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.secondary,
        )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Poster Dashboard'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: PopupMenuButton<String>(
              icon: const CircleAvatar(
                backgroundColor: Color(0xFFD0F5E8),
                radius: 22,
                child: Icon(Icons.person, color: Colors.blue, size: 28),
              ),
              onSelected: (String result) async {
                if (result == 'logout') {
                  await _authService.signOut();
                  if (mounted) {
                    Navigator.of(context).pushReplacementNamed('/auth');
                  }
                } else if (result == 'profile') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                } else if (result == 'settings') {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SettingsScreen()),
                  );
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('Profile'),
                ),
                const PopupMenuItem<String>(
                  value: 'settings',
                  child: Text('Settings'),
                ),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user?.uid).get(),
        builder: (context, snapshot) {
          String firstName = 'there';
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            firstName = 'there';
          } else if (snapshot.hasData && snapshot.data != null && snapshot.data!.data() != null) {
            final data = snapshot.data!.data() as Map<String, dynamic>;
            firstName = data['firstName'] ?? 'there';
          }
          return _buildBodyWithName(firstName);
        },
      ),
      bottomNavigationBar: Navbar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  Widget _buildBodyWithName(String firstName) {
    switch (_selectedIndex) {
      case 0:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting and progress
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Good evening, $firstName!', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text('Ready to earn more today?', style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Progress
              Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 56,
                        height: 56,
                        child: CircularProgressIndicator(
                          value: 0.24,
                          strokeWidth: 6,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1DBF73)),
                        ),
                      ),
                      Text('24%', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Silver Poster Progress', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Complete 8 more tasks to unlock Silver benefits', style: TextStyle(fontSize: 13, color: Colors.grey[700])),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Status summary
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatusChip('First Task', Colors.yellow[700]!, Colors.white),
                  _buildStatusChip('5 Offers', Color(0xFF1DBF73), Colors.white),
                  _buildStatusChip('Top Rated', Colors.blue[300]!, Colors.white),
                ],
              ),
              SizedBox(height: 20),
              // Task status numbers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatusCount('Active', 1, Colors.blue),
                  _buildStatusCount('Pending', 3, Colors.orange),
                  _buildStatusCount('Completed', 0, Colors.green),
                  _buildStatusCount('Canceled', 0, Colors.red),
                ],
              ),
              SizedBox(height: 20),
              // Quick Categories
              Text('Quick Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryButton(Icons.local_shipping, 'Moving'),
                  _buildCategoryButton(Icons.cleaning_services, 'Cleaning'),
                  _buildCategoryButton(Icons.shopping_cart, 'Grocery'),
                  _buildCategoryButton(Icons.delivery_dining, 'Delivery'),
                  _buildCategoryButton(Icons.add, 'Custom'),
                ],
              ),
              SizedBox(height: 20),
              // Current Task in Progress
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.blue[100]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Current Task in Progress', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text('Help move furniture to new apartment'),
                    SizedBox(height: 4),
                    Text('Runner: Mike Johnson', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: 0.6,
                            backgroundColor: Colors.grey[200],
                            color: Color(0xFF1DBF73),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text('60%'),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const ChatMessagesScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text('Message'),
                        ),
                        SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const TaskDetailsScreen(
                                  title: 'Current Task in Progress',
                                  details: 'Help move furniture to new apartment\nRunner: Mike Johnson',
                                ),
                              ),
                            );
                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: Text('Details'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Unassigned Tasks
              Text('Unassigned Tasks', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 10),
              _buildUnassignedTask('Clean 2-bedroom apartment thoroughly', '3 offers received', 'about 2 hours ago'),
              _buildUnassignedTask('Grocery shopping for weekly supplies', '7 offers received', 'about 5 hours ago'),
              _buildUnassignedTask('Pick up dry cleaning downtown', 'No offers yet', '1 day ago'),
              SizedBox(height: 20),
              // Tip of the Day
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.yellow[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb, color: Colors.orange[700]),
                    SizedBox(width: 10),
                    Expanded(child: Text('Tip of the Day\nAdd photos to boost offers by 30%')),
                  ],
                ),
              ),
            ],
          ),
        );
      case 1:
        return const PostTaskScreen();
      case 2:
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Analytics Overview',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              _buildMetricCard(context, 'Total Tasks Posted', '150', Icons.assignment),
              _buildMetricCard(context, 'Total Hired', '85', Icons.people),
              _buildMetricCard(context, 'Total Spent', '\$12,500', Icons.attach_money),
              _buildMetricCard(context, 'Hiring Rate', '85%', Icons.trending_up),
              _buildMetricCard(context, 'Successful Jobs', '80', Icons.check_circle),
              _buildMetricCard(context, 'Average Rating', '4.7/5', Icons.star),
              const SizedBox(height: 20),
              // You can add charts or more detailed analytics here
              Text(
                'Detailed Insights',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 10),
              // Example: A simple progress bar for successful jobs
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Successful Jobs Progress', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 10),
                      LinearProgressIndicator(
                        value: 0.8,
                        backgroundColor: Colors.grey.shade300,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 5),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('80% Completed', style: Theme.of(context).textTheme.bodySmall),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      case 3:
        return const ChatMessagesScreen();
      default:
        return const Center(child: Text('Unknown tab'));
    }
  }
} 