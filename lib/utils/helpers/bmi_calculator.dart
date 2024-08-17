import 'package:fitness_scout/utils/helpers/logger.dart';

class BmiCalculator {
  static double calculateBMI(double height, double weight) {
    // Ensure height and weight are positive values
    if (height > 0.0 && weight > 0.0) {
      // Convert height from feet to meters
      double heightInMeters = height * 0.3048;

      // Calculate BMI
      double bmi = weight / (heightInMeters * heightInMeters);
      return bmi;
    } else {
      ZLogger.error("Please enter valid height and weight.");
      return 0.0;
    }
  }
}
