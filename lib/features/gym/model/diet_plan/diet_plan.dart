import 'package:cloud_firestore/cloud_firestore.dart';

class DietPlan {
  List<FoodCategory>? breakfast;
  List<FoodCategory>? lunch;
  List<FoodCategory>? dinner;
  List<FoodCategory>? snacks;
  int? calories;
  String? dietaryPreference;

  DietPlan({
    this.breakfast,
    this.lunch,
    this.dinner,
    this.snacks,
    this.calories,
    this.dietaryPreference,
  });

  // Create a DietPlan object from a Firestore snapshot
  factory DietPlan.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    return DietPlan.fromJson(json);
  }

  // Convert JSON data from Firestore into a DietPlan
  factory DietPlan.fromJson(Map<String, dynamic> json) {
    return DietPlan(
      breakfast: (json['breakfast'] as List?)
          ?.map((item) => FoodCategory.fromJson(item))
          .toList(),
      lunch: (json['lunch'] as List?)
          ?.map((item) => FoodCategory.fromJson(item))
          .toList(),
      dinner: (json['dinner'] as List?)
          ?.map((item) => FoodCategory.fromJson(item))
          .toList(),
      snacks: (json['snacks'] as List?)
          ?.map((item) => FoodCategory.fromJson(item))
          .toList(),
      calories: json['calories'],
      dietaryPreference: json['dietaryPreference'],
    );
  }

  // Convert DietPlan object to JSON for saving to Firestore
  Map<String, dynamic> toJson() {
    return {
      'breakfast': breakfast?.map((v) => v.toJson()).toList(),
      'lunch': lunch?.map((v) => v.toJson()).toList(),
      'dinner': dinner?.map((v) => v.toJson()).toList(),
      'snacks': snacks?.map((v) => v.toJson()).toList(),
      'calories': calories,
      'dietaryPreference': dietaryPreference,
    };
  }

  // Factory constructor for an empty diet plan
  factory DietPlan.empty() {
    return DietPlan(
      breakfast: [],
      lunch: [],
      dinner: [],
      snacks: [],
      calories: 0,
      dietaryPreference: '',
    );
  }
}

class FoodCategory {
  final String name;
  final int calories;
  final String protein;
  final String fat;
  final String carbs;
  final String imageUrl;

  FoodCategory({
    required this.name,
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbs,
    required this.imageUrl,
  });

  // Convert JSON data from Firestore into a FoodCategory
  factory FoodCategory.fromJson(Map<String, dynamic> json) {
    return FoodCategory(
      name: json['name'],
      calories: json['calories'],
      protein: json['protein'],
      fat: json['fat'],
      carbs: json['carbs'],
      imageUrl: json['imageUrl'],
    );
  }

  // Convert FoodCategory object to JSON for saving to Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'calories': calories,
      'protein': protein,
      'fat': fat,
      'carbs': carbs,
      'imageUrl': imageUrl,
    };
  }
}
