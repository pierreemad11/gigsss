import '../models/task.dart';

class TaskService {
  List<Task> getDummyTasks() {
    return [
      Task(
        taskId: 'task_001',
        taskPoster: 'user_A',
        title: 'Grocery Shopping',
        description: 'Need someone to pick up groceries from Walmart. List will be provided.',
        type: 'Shopping',
        status: 'Available',
        longitude: -74.0060,
        latitude: 40.7128,
        additionalRequirements: 'Must have a car.',
        questions: [],
        offers: [],
      ),
      Task(
        taskId: 'task_002',
        taskPoster: 'user_B',
        title: 'Furniture Assembly',
        description: 'Help needed to assemble a new bookshelf. Tools will be provided.',
        type: 'Handyman',
        status: 'Available',
        longitude: -73.935242,
        latitude: 40.730610,
        additionalRequirements: 'Experience with IKEA furniture preferred.',
        questions: [],
        offers: [],
      ),
      Task(
        taskId: 'task_003',
        taskPoster: 'user_C',
        title: 'Dog Walking',
        description: 'Looking for someone to walk my dog twice a day for a week.',
        type: 'Pet Care',
        status: 'Available',
        longitude: -73.9990,
        latitude: 40.7300,
        additionalRequirements: 'Must love dogs.',
        questions: [],
        offers: [],
      ),
      Task(
        taskId: 'task_004',
        taskPoster: 'user_D',
        title: 'Moving Help',
        description: 'Need help moving boxes from apartment to new house.',
        type: 'Moving',
        status: 'Available',
        longitude: -74.0582,
        latitude: 40.6360,
        additionalRequirements: 'Need strong individuals, heavy lifting involved.',
        questions: [],
        offers: [],
      ),
      Task(
        taskId: 'task_005',
        taskPoster: 'user_E',
        title: 'Garden Maintenance',
        description: 'Help needed with weeding and planting new flowers.',
        type: 'Gardening',
        status: 'Available',
        longitude: -73.9500,
        latitude: 40.7800,
        additionalRequirements: 'Bring your own gloves.',
        questions: [],
        offers: [],
      ),
      Task(
        taskId: 'task_006',
        taskPoster: 'user_F',
        title: 'Computer Setup',
        description: 'Need help setting up a new computer and transferring data.',
        type: 'Technology',
        status: 'Available',
        longitude: -73.9800,
        latitude: 40.7600,
        additionalRequirements: 'Knowledge of Windows and macOS.',
        questions: [],
        offers: [],
      ),
      Task(
        taskId: 'task_007',
        taskPoster: 'user_G',
        title: 'House Cleaning',
        description: 'Deep cleaning needed for 2-bedroom apartment.',
        type: 'Cleaning',
        status: 'Available',
        longitude: -74.0100,
        latitude: 40.7000,
        additionalRequirements: 'Provide your own cleaning supplies.',
        questions: [],
        offers: [],
      ),
      Task(
        taskId: 'task_008',
        taskPoster: 'user_H',
        title: 'Package Delivery',
        description: 'Need someone to pick up and deliver a package across town.',
        type: 'Delivery',
        status: 'Available',
        longitude: -73.9700,
        latitude: 40.7500,
        additionalRequirements: 'Must have a bicycle or car.',
        questions: [],
        offers: [],
      ),
    ];
  }

  // Placeholder for a method to create a new task
  void createTask({
    required String title,
    required String description,
    required String type,
    double? price,
    String? duration,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    // In a real application, this would interact with a backend service (e.g., Firebase, REST API)
    // to save the task data. For now, we just print it.
    print('Creating Task:');
    print('  Title: $title');
    print('  Description: $description');
    print('  Type: $type');
    if (price != null) print('  Price: $price');
    if (duration != null) print('  Duration: $duration');
    if (startTime != null) print('  Start Time: $startTime');
    if (endTime != null) print('  End Time: $endTime');
    // You might also want to add this to a local list or state management for immediate UI updates
  }
}