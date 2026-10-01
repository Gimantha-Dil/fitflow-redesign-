import 'package:flutter/material.dart';

class Exercise {
  final String id;
  final String name;
  int sets;
  int reps;
  bool isCompleted;

  Exercise({
    required this.id,
    required this.name,
    required this.sets,
    required this.reps,
    this.isCompleted = false,
  });
}

class Workout {
  final String id;
  final String title;
  final String durationMinutes;
  final String aiReason;
  final List<Exercise> exercises;

  Workout({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.aiReason,
    required this.exercises,
  });
}

class MealEntry {
  final String id;
  final String name;
  final String description;
  final int calories;
  final String timeFormatted;
  final String category;

  MealEntry({
    required this.id,
    required this.name,
    required this.description,
    required this.calories,
    required this.timeFormatted,
    required this.category,
  });
}

class CommunityPost {
  final String id;
  final String circleName;
  final String authorName;
  final String text;
  final String timeAgo;
  int cheerCount;
  final bool isPrivate;
  bool isCheered;

  CommunityPost({
    required this.id,
    required this.circleName,
    required this.authorName,
    required this.text,
    required this.timeAgo,
    required this.cheerCount,
    this.isPrivate = true,
    this.isCheered = false,
  });
}

class Milestone {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isUnlocked;

  Milestone({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.isUnlocked = true,
  });
}

class UserProfile {
  final String name;
  int streakDays;
  int caloriesBurned;
  int kcalLogged;
  int kcalGoal;

  UserProfile({
    required this.name,
    required this.streakDays,
    required this.caloriesBurned,
    required this.kcalLogged,
    required this.kcalGoal,
  });
}
