import 'package:flutter/material.dart';
import '../models/models.dart';

class FitnessProvider extends ChangeNotifier {
  int _selectedTabIndex = 0;
  int get selectedTabIndex => _selectedTabIndex;

  void setSelectedTab(int index) {
    _selectedTabIndex = index;
    notifyListeners();
  }

  // User Profile
  final UserProfile _userProfile = UserProfile(
    name: 'Alex',
    streakDays: 6,
    caloriesBurned: 1850,
    kcalLogged: 1240,
    kcalGoal: 2000,
  );
  UserProfile get userProfile => _userProfile;

  // AI Workout Plan
  late Workout _todayWorkout;
  Workout get todayWorkout => _todayWorkout;

  // Meal Entries
  final List<MealEntry> _meals = [
    MealEntry(
      id: 'm1',
      name: 'Breakfast',
      description: 'Oats, chia seeds & fresh berries',
      calories: 380,
      timeFormatted: '8:30 AM',
      category: 'Breakfast',
    ),
    MealEntry(
      id: 'm2',
      name: 'Lunch',
      description: 'Grilled chicken salad with olive oil',
      calories: 520,
      timeFormatted: '1:15 PM',
      category: 'Lunch',
    ),
    MealEntry(
      id: 'm3',
      name: 'Afternoon Snack',
      description: 'Greek yogurt & almonds',
      calories: 340,
      timeFormatted: '4:45 PM',
      category: 'Snack',
    ),
  ];
  List<MealEntry> get meals => List.unmodifiable(_meals);

  // Community Posts
  final List<CommunityPost> _communityPosts = [
    CommunityPost(
      id: 'p1',
      circleName: 'Morning Movers Circle',
      authorName: 'Sarah Jenkins',
      text: 'Crushed a 5km morning run in 24 mins! Feeling energized for the day 🔥',
      timeAgo: '2h ago',
      cheerCount: 12,
      isPrivate: true,
    ),
    CommunityPost(
      id: 'p2',
      circleName: 'HIIT Squad',
      authorName: 'Marcus Chen',
      text: 'Completed the AI Adaptive Workout. The leg extension set was intense!',
      timeAgo: '4h ago',
      cheerCount: 8,
      isPrivate: true,
    ),
    CommunityPost(
      id: 'p3',
      circleName: 'Mindful Fitness',
      authorName: 'Elena Rostova',
      text: 'Hit my 7-day nutrition logging milestone! Consistency is key 🥑',
      timeAgo: '6h ago',
      cheerCount: 15,
      isPrivate: true,
    ),
  ];
  List<CommunityPost> get communityPosts => List.unmodifiable(_communityPosts);

  // Milestones
  final List<Milestone> _milestones = [
    Milestone(
      id: 'b1',
      title: '6-Day Streak',
      description: 'Consistent activity for 6 consecutive days',
      icon: Icons.local_fire_department_rounded,
      color: const Color(0xFFF59E0B),
      isUnlocked: true,
    ),
    Milestone(
      id: 'b2',
      title: '10 Workouts Logged',
      description: 'Completed 10 AI recommended workouts',
      icon: Icons.fitness_center_rounded,
      color: const Color(0xFF4F46E5),
      isUnlocked: true,
    ),
    Milestone(
      id: 'b3',
      title: 'First 5K Completed',
      description: 'Ran 5km distance in a single session',
      icon: Icons.directions_run_rounded,
      color: const Color(0xFF22C55E),
      isUnlocked: true,
    ),
    Milestone(
      id: 'b4',
      title: 'Nutrition Master',
      description: 'Log meals for 14 days straight',
      icon: Icons.restaurant_rounded,
      color: const Color(0xFFEC4899),
      isUnlocked: false,
    ),
  ];
  List<Milestone> get milestones => List.unmodifiable(_milestones);

  FitnessProvider() {
    _initSampleData();
  }

  void _initSampleData() {
    _todayWorkout = Workout(
      id: 'w1',
      title: '20-min Adaptive HIIT',
      durationMinutes: '20 mins',
      aiReason: 'Adjusted for your schedule & recovery score today',
      exercises: [
        Exercise(id: 'e1', name: 'Bodyweight Squats', sets: 3, reps: 15),
        Exercise(id: 'e2', name: 'Push-ups', sets: 3, reps: 12),
        Exercise(id: 'e3', name: 'Dumbbell Rows', sets: 3, reps: 12),
        Exercise(id: 'e4', name: 'Plank Hold', sets: 3, reps: 45), // 45 seconds
        Exercise(id: 'e5', name: 'Jumping Jacks', sets: 2, reps: 30),
      ],
    );
  }

  void reorderExercises(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = _todayWorkout.exercises.removeAt(oldIndex);
    _todayWorkout.exercises.insert(newIndex, item);
    notifyListeners();
  }

  void updateExercise(String id, int sets, int reps) {
    final index = _todayWorkout.exercises.indexWhere((e) => e.id == id);
    if (index != -1) {
      _todayWorkout.exercises[index].sets = sets;
      _todayWorkout.exercises[index].reps = reps;
      notifyListeners();
    }
  }

  void toggleCheer(String postId) {
    final index = _communityPosts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      final post = _communityPosts[index];
      if (post.isCheered) {
        post.cheerCount -= 1;
        post.isCheered = false;
      } else {
        post.cheerCount += 1;
        post.isCheered = true;
      }
      notifyListeners();
    }
  }

  bool _isAnalyzingCamera = false;
  bool get isAnalyzingCamera => _isAnalyzingCamera;

  Future<void> simulateCameraScanMeal() async {
    _isAnalyzingCamera = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 1500));

    _isAnalyzingCamera = false;
    final newMeal = MealEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: 'Avocado Toast & Eggs',
      description: 'AI detected: Whole grain toast, poached egg, sliced avocado',
      calories: 420,
      timeFormatted: 'Just now',
      category: 'Snack/Meal',
    );

    _meals.add(newMeal);
    _userProfile.kcalLogged += 420;
    notifyListeners();
  }
}
