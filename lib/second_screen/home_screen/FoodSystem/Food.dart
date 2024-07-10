class Food {
  final String name;
  final double calories;
  final double servingSizeG;
  final double fatTotalG;
  final double fatSaturatedG;
  final double proteinG;
  final double sodiumMg;
  final double potassiumMg;
  final double cholesterolMg;
  final double carbohydratesTotalG;
  final double fiberG;
  final double sugarG;

  Food({
    required this.name,
    required this.calories,
    required this.servingSizeG,
    required this.fatTotalG,
    required this.fatSaturatedG,
    required this.proteinG,
    required this.sodiumMg,
    required this.potassiumMg,
    required this.cholesterolMg,
    required this.carbohydratesTotalG,
    required this.fiberG,
    required this.sugarG,
  });

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(
      name: json['name'] ?? '',
      calories: parseDoubleOrZero(json['calories']),
      servingSizeG: parseDoubleOrZero(json['serving_size_g']),
      fatTotalG: parseDoubleOrZero(json['fat_total_g']),
      fatSaturatedG: parseDoubleOrZero(json['fat_saturated_g']),
      proteinG: parseDoubleOrZero(json['protein_g']),
      sodiumMg: parseDoubleOrZero(json['sodium_mg']),
      potassiumMg: parseDoubleOrZero(json['potassium_mg']),
      cholesterolMg: parseDoubleOrZero(json['cholesterol_mg']),
      carbohydratesTotalG: parseDoubleOrZero(json['carbohydrates_total_g']),
      fiberG: parseDoubleOrZero(json['fiber_g']),
      sugarG: parseDoubleOrZero(json['sugar_g']),
    );
  }

  static double parseDoubleOrZero(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else
    if (value is String && value == "Only available for premium subscribers.") {
      return 0.0; // أو أي قيمة تراها مناسبة
    } else {
      return 0.0; // أو يمكنك التعامل بطريقة أخرى حسب متطلبات تطبيقك
    }
  }
}
