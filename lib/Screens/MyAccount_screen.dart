import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/task_poster_nav_bar.dart';
import 'runner_home_screen.dart';
import 'support_chat_screen.dart';
import 'banks_cards_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();
      setState(() {
        userData = doc.data();
        isLoading = false;
      });
    }
  }

  void _showEditDialog() {
    final TextEditingController firstNameController = TextEditingController(text: userData?['firstName'] ?? '');
    final TextEditingController lastNameController = TextEditingController(text: userData?['lastName'] ?? '');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(labelText: 'Last Name'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
                'firstName': firstNameController.text,
                'lastName': lastNameController.text,
              });
              Navigator.of(context).pop();
              _fetchUserData();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/auth');
    }
  }

  @override
  Widget build(BuildContext context) {
    final String initials = ((userData?['firstName'] ?? '') + (userData?['lastName'] ?? ''))
        .trim()
        .split(' ')
        .map((e) => e.isNotEmpty ? e[0] : '')
        .join()
        .toUpperCase();
    return Scaffold(
      appBar: AppBar(title: const Text('My Account')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : userData == null
              ? const Center(child: Text('No user data found.'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 32),
                      Center(
                        child: CircleAvatar(
                          radius: 48,
                          backgroundColor: const Color(0xFFF48FB1), // pinkish
                          child: Text(
                            initials.isNotEmpty ? initials : '?',
                            style: const TextStyle(fontSize: 36, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text(
                        '${userData!['firstName'] ?? ''} ${userData!['lastName'] ?? ''}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        userData!['email'] ?? '',
                        style: const TextStyle(fontSize: 15, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      // View Public Profile button removed
                      const SizedBox(height: 24),
                      // Action cards
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            _buildProfileActionCard([
                              _ProfileAction(
                                icon: Icons.directions_run,
                                label: 'Become a runner',
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => RunnerHomeScreen(
                                        profileImagePath: userData?['profileImageUrl'] ?? '',
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ]),
                            const SizedBox(height: 12),
                            _buildProfileActionCard([
                              _ProfileAction(
                                icon: Icons.edit,
                                label: 'Edit Profile',
                                onTap: _showEditDialog,
                              ),
                              _ProfileAction(
                                icon: Icons.credit_card,
                                label: 'Banks & Cards',
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const BanksCardsScreen(),
                                    ),
                                  );
                                },
                              ),
                              _ProfileAction(
                                icon: Icons.history,
                                label: 'Payment History',
                                onTap: () {},
                              ),
                            ]),
                            const SizedBox(height: 12),
                            _buildProfileActionCard([
                              _ProfileAction(
                                icon: Icons.support_agent,
                                label: 'Support',
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => const SupportChatScreen(),
                                    ),
                                  );
                                },
                              ),
                              _ProfileAction(
                                icon: Icons.logout,
                                label: 'Logout',
                                onTap: _logout,
                                color: Colors.red,
                              ),
                            ]),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
    );
  }

  Widget _buildProfileActionCard(List<_ProfileAction> actions) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          children: actions
              .map((action) => ListTile(
                    leading: Icon(action.icon, color: action.color ?? Colors.deepPurple, size: 26),
                    title: Text(
                      action.label,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: action.color ?? Colors.black87,
                      ),
                    ),
                    onTap: action.onTap,
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _ProfileAction {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  _ProfileAction({required this.icon, required this.label, required this.onTap, this.color});
} 