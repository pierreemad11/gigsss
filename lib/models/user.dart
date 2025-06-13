class UserModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String governmentId;
  final List<String> roles; // List of roles: can be both 'runner' and 'task_poster'
  final String? profileImageUrl;
  final double rating;
  final int completedTasks;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.governmentId,
    required this.roles,
    this.profileImageUrl,
    this.rating = 0.0,
    this.completedTasks = 0,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'governmentId': governmentId,
      'roles': roles,
      'profileImageUrl': profileImageUrl,
      'rating': rating,
      'completedTasks': completedTasks,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      governmentId: map['governmentId'] ?? '',
      roles: List<String>.from(map['roles'] ?? []),
      profileImageUrl: map['profileImageUrl'],
      rating: (map['rating'] ?? 0.0).toDouble(),
      completedTasks: map['completedTasks'] ?? 0,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  // Helper method to check if user has a specific role
  bool hasRole(String role) {
    return roles.contains(role);
  }
} 