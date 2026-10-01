import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/fitness_provider.dart';
import '../theme/app_theme.dart';

class NutritionLoggerScreen extends StatefulWidget {
  const NutritionLoggerScreen({super.key});

  @override
  State<NutritionLoggerScreen> createState() => _NutritionLoggerScreenState();
}

class _NutritionLoggerScreenState extends State<NutritionLoggerScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _handleCameraTap(FitnessProvider provider) async {
    try {
      // Try launching camera
      await _picker.pickImage(source: ImageSource.camera);
    } catch (_) {
      // If camera not supported or web/emulator without physical camera, proceed to mock flow smoothly
    }

    // Show analyzing progress overlay / trigger provider scan simulation
    if (mounted) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: AppColors.primary),
                  SizedBox(height: 20),
                  Text(
                    'AI Computer Vision Analyzing...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Detecting food items & estimating calories',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      );

      await provider.simulateCameraScanMeal();

      if (mounted) {
        Navigator.pop(context); // Close loading dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✨ AI recognized: Avocado Toast & Eggs (+420 kcal)'),
            backgroundColor: AppColors.accent,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FitnessProvider>(context);
    final user = provider.userProfile;
    final meals = provider.meals;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Header & Tabs
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.only(top: 12, left: 18, right: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nutrition Logger',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                TabBar(
                  controller: _tabController,
                  indicatorColor: AppColors.primary,
                  labelColor: AppColors.primary,
                  unselectedLabelColor: AppColors.textSecondary,
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  tabs: const [
                    Tab(text: 'Today\'s Meals'),
                    Tab(text: 'History'),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // 1. Today's Meals Tab
                SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Calorie Progress Bar
                      FFCard(
                        padding: const EdgeInsets.all(18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Daily Intake Goal',
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 12,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${user.kcalLogged} / ${user.kcalGoal} kcal',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: const BoxDecoration(
                                    color: AppColors.accentLight,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.restaurant_rounded,
                                    color: AppColors.accent,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: (user.kcalLogged / user.kcalGoal).clamp(0.0, 1.0),
                                backgroundColor: Colors.grey.shade200,
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.accent,
                                ),
                                minHeight: 10,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${((user.kcalLogged / user.kcalGoal) * 100).toInt()}% completed',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.accent,
                                  ),
                                ),
                                Text(
                                  '${user.kcalGoal - user.kcalLogged} kcal remaining',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Logged Meals',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),

                      // List of Meals
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: meals.length,
                        itemBuilder: (context, index) {
                          final meal = meals[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: FFCard(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryLight,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      Icons.fastfood_rounded,
                                      color: AppColors.primary,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              meal.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            Text(
                                              '${meal.calories} kcal',
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primary,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          meal.description,
                                          style: const TextStyle(
                                            color: AppColors.textSecondary,
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          meal.timeFormatted,
                                          style: TextStyle(
                                            color: Colors.grey.shade400,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // 2. History Tab
                const Center(
                  child: Text(
                    'Historical meal records will appear here',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Large circular camera-button FAB (bottom right)
      floatingActionButton: FloatingActionButton.large(
        onPressed: () => _handleCameraTap(provider),
        backgroundColor: AppColors.primary,
        tooltip: 'Scan meal with AI camera',
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.camera_alt_rounded, color: Colors.white, size: 28),
            SizedBox(height: 2),
            Text(
              'AI Log',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
