import 'package:flutter/material.dart';
import '../widgets/task_poster_nav_bar.dart';
import 'post_task_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import 'MyAccount_screen.dart';
import 'settings_screen.dart';
import 'task_details_screen.dart';
import 'edit_task_screen.dart';
import 'category_tasks_screen.dart';
import 'Chat_messages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task_details_entry_screen.dart';

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
              _buildStatusChip('First Task', Color(0xFFF9A825), Colors.black87),
              _buildStatusChip('5 Offers', Color(0xFF81C784), Colors.black87),
              _buildStatusChip('Top Rated', Color(0xFF64B5F6), Colors.black87),
            ],
          ),
          SizedBox(height: 20),
          // Task status numbers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatusCount('Active', 1, Color(0xFF1976D2)),
              _buildStatusCount('Pending', 3, Color(0xFFF9A825)),
              _buildStatusCount('Completed', 0, Color(0xFF388E3C)),
              _buildStatusCount('Canceled', 0, Color(0xFFD32F2F)),
            ],
          ),
          SizedBox(height: 20),
          // Quick Categories
          Text('Quick Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCategoryButton(Icons.local_shipping, 'Hauling'),
              _buildCategoryButton(Icons.computer, 'Computer'),
              _buildCategoryButton(Icons.cleaning_services, 'Cleaning'),
              _buildCategoryButton(Icons.delivery_dining, 'Delivery'),
            ],
          ),
          SizedBox(height: 20),
          // Current Task in Progress
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFF1976D2), width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.06),
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(0xFFE3EAFD),
                      child: Icon(Icons.person, color: Color(0xFF1976D2)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Help move furniture to new apartment',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                          ),
                          const SizedBox(height: 2),
                          Text('Runner: Mike Johnson', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('Progress', style: TextStyle(fontSize: 14, color: Colors.black87)),
                    const Spacer(),
                    Text('60%', style: TextStyle(fontSize: 14, color: Color(0xFF1976D2), fontWeight: FontWeight.w600)),
                  ],
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: 0.6,
                    minHeight: 6,
                    backgroundColor: Colors.grey[200],
                    color: Color(0xFF1976D2),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const ChatMessagesScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.white),
                        label: const Text('Message', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1976D2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
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
                        icon: const Icon(Icons.info_outline, size: 18, color: Colors.black87),
                        label: const Text('Details', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                          side: const BorderSide(color: Color(0xFFE0E0E0)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
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
              color: Color(0xFFF9A825),
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
    // Use a solid background color for a bold look
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildStatusCount(String label, int count, Color color) {
    // White card background, colored number, subtle border/shadow
    return Container(
      width: 70,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE0E0E0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.06),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('$count', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(color: Colors.black87, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(IconData icon, String label) {
    // Consistent color codes for all cards and icons
    final Map<String, Color> baseColors = {
      'Hauling': Color(0xFF1976D2), // blue
      'Computer': Color(0xFF1976D2), // blue
      'Cleaning': Color(0xFF388E3C), // green
      'Delivery': Color(0xFFF9A825), // amber/orange
    };
    final Map<String, Color> iconBgColors = {
      'Hauling': Color(0xFF1976D2).withOpacity(0.12),
      'Computer': Color(0xFF1976D2).withOpacity(0.12),
      'Cleaning': Color(0xFF388E3C).withOpacity(0.12),
      'Delivery': Color(0xFFF9A825).withOpacity(0.12),
    };
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TaskDetailsEntryScreen(category: label),
          ),
        );
      },
      child: Container(
        width: 70,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xFFE0E0E0), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.08),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: iconBgColors[label] ?? Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(icon, color: baseColors[label] ?? Colors.black87, size: 22),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87)),
          ],
        ),
      ),
    );
  }

  Widget _buildUnassignedTask(String title, String offers, String time) {
    // Parse offers to determine color
    final bool hasOffers = offers.toLowerCase().contains('offer');
    final bool noOffers = offers.toLowerCase().contains('no offer');
    final Color offersColor = hasOffers && !noOffers ? Color(0xFF388E3C) : Colors.grey;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE0E0E0), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.06),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black87)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(offers, style: TextStyle(color: offersColor, fontSize: 14, fontWeight: FontWeight.w500)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 13), textAlign: TextAlign.right),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Column(
              children: [
                SizedBox(
                  width: 36,
                  height: 36,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditTaskScreen(title: title),
                        ),
                      );
                    },
                    child: Icon(Icons.edit, color: Colors.grey[600], size: 20),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: 36,
                  height: 36,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      side: BorderSide(color: Colors.red.shade100),
                    ),
                    onPressed: () {
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
                    child: Icon(Icons.delete, color: Colors.red[400], size: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
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
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfileScreen()),
                );
              },
              child: const CircleAvatar(
                backgroundColor: Color(0xFFD0F5E8),
                radius: 22,
                child: Icon(Icons.person, color: Colors.blue, size: 28),
              ),
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
                  _buildStatusChip('First Task', Color(0xFFFFD54F), Colors.black87),
                  _buildStatusChip('5 Offers', Color(0xFF81C784), Colors.black87),
                  _buildStatusChip('Top Rated', Color(0xFF64B5F6), Colors.black87),
                ],
              ),
              SizedBox(height: 20),
              // Task status numbers
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStatusCount('Active', 1, Color(0xFF1976D2)),
                  _buildStatusCount('Pending', 3, Color(0xFFF9A825)),
                  _buildStatusCount('Completed', 0, Color(0xFF388E3C)),
                  _buildStatusCount('Canceled', 0, Color(0xFFD32F2F)),
                ],
              ),
              SizedBox(height: 20),
              // Quick Categories
              Text('Quick Categories', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCategoryButton(Icons.local_shipping, 'Hauling'),
                  _buildCategoryButton(Icons.computer, 'Computer'),
                  _buildCategoryButton(Icons.cleaning_services, 'Cleaning'),
                  _buildCategoryButton(Icons.delivery_dining, 'Delivery'),
                ],
              ),
              SizedBox(height: 20),
              // Current Task in Progress
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Color(0xFF1976D2), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.06),
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Color(0xFFE3EAFD),
                          child: Icon(Icons.person, color: Color(0xFF1976D2)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Help move furniture to new apartment',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                              ),
                              const SizedBox(height: 2),
                              Text('Runner: Mike Johnson', style: TextStyle(color: Colors.grey[700], fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('Progress', style: TextStyle(fontSize: 14, color: Colors.black87)),
                        const Spacer(),
                        Text('60%', style: TextStyle(fontSize: 14, color: Color(0xFF1976D2), fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: 0.6,
                        minHeight: 6,
                        backgroundColor: Colors.grey[200],
                        color: Color(0xFF1976D2),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const ChatMessagesScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.chat_bubble_outline, size: 18, color: Colors.white),
                            label: const Text('Message', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF1976D2),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              elevation: 0,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
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
                            icon: const Icon(Icons.info_outline, size: 18, color: Colors.black87),
                            label: const Text('Details', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600)),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                              side: const BorderSide(color: Color(0xFFE0E0E0)),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
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
                  color: Color(0xFFFFD54F),
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