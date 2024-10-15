class DietPlan {
  final String id; // Assuming you want to keep the document ID
  final String name; // Name of the diet plan
  final String description; // Description of the diet plan
  final int calories; // Total calories
  final double protein; // Protein content
  final double carbohydrates; // Carbohydrates content
  final double fats; // Fats content
  final List<FoodItem> foods; // List of food items

  DietPlan({
    required this.id,
    required this.name,
    required this.description,
    required this.calories,
    required this.protein,
    required this.carbohydrates,
    required this.fats,
    required this.foods,
  });

  factory DietPlan.fromJson(Map<String, dynamic> json) {
    return DietPlan(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      calories: json['calories'],
      protein: json['protein'],
      carbohydrates: json['carbohydrates'],
      fats: json['fats'],
      foods: (json['foods'] as List<dynamic>)
          .map((foodJson) => FoodItem.fromJson(foodJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'calories': calories,
      'protein': protein,
      'carbohydrates': carbohydrates,
      'fats': fats,
      'foods': foods.map((food) => food.toJson()).toList(),
    };
  }
}

class FoodItem {
  final String name; // Name of the food item
  final double servingSize; // Serving size of the food item
  final double calories; // Calories in the food item
  final double protein; // Protein in the food item

  FoodItem({
    required this.name,
    required this.servingSize,
    required this.calories,
    required this.protein,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      name: json['name'],
      servingSize: json['servingSize'],
      calories: json['calories'],
      protein: json['protein'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'servingSize': servingSize,
      'calories': calories,
      'protein': protein,
    };
  }
}
