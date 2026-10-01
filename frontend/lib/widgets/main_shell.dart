import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/fitness_provider.dart';
import '../screens/home_dashboard_screen.dart';
import '../screens/workout_planner_screen.dart';
import '../screens/progress_screen.dart';
import '../screens/community_feed_screen.dart';
import '../screens/nutrition_logger_screen.dart';

class MainShell extends StatelessWidget {
  const MainShell({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FitnessProvider>(context);

    final List<Widget> screens = const [
      HomeDashboardScreen(),
      WorkoutPlannerScreen(),
      ProgressScreen(),
      CommunityFeedScreen(),
      NutritionLoggerScreen(),
    ];

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: IndexedStack(
              index: provider.selectedTabIndex,
              children: screens,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Center(
        heightFactor: 1.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: BottomNavigationBar(
            currentIndex: provider.selectedTabIndex,
            onTap: (index) => provider.setSelectedTab(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fitness_center_rounded),
                label: 'Workout',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_rounded),
                label: 'Progress',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.groups_rounded),
                label: 'Community',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_rounded),
                label: 'Nutrition',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
