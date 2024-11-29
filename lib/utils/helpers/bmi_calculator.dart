import 'package:fitness_scout/utils/helpers/logger.dart';

class BmiCalculator {
  static double calculateBMI(
      double heightFeet, double heightInches, double weightKg) {
    // Ensure height and weight are positive values
    if (heightFeet > 0.0 && weightKg > 0.0) {
      double totalHeightInches = (heightFeet * 12) + heightInches;

      // Convert height from inches to meters (1 inch = 0.0254 meters)
      double heightInMeters = totalHeightInches * 0.0254;

      // BMI formula: weight (kg) / height (m)²
      double bmi = weightKg / (heightInMeters * heightInMeters);
      ZLogger.info('BMI : $bmi');
      return bmi;
    } else {
      print("Please enter valid height and weight.");
      return 0.0;
    }
  }

  static String getBmiMessage(double bmi) {
    if (bmi < 16.0) {
      return "Very Underweight";
    } else if (bmi >= 16.0 && bmi < 17.0) {
      return "Underweight";
    } else if (bmi >= 17.0 && bmi < 18.5) {
      return "Slightly Underweight";
    } else if (bmi >= 18.5 && bmi < 22.0) {
      return "Healthy";
    } else if (bmi >= 22.0 && bmi < 24.9) {
      return "Very Healthy";
    } else if (bmi >= 25.0 && bmi < 27.0) {
      return "Slightly Overweight";
    } else if (bmi >= 27.0 && bmi < 29.9) {
      return "Overweight";
    } else if (bmi >= 30.0 && bmi < 32.5) {
      return "A Little Obese";
    } else if (bmi >= 32.5 && bmi < 34.9) {
      return "Obese";
    } else if (bmi >= 35.0 && bmi < 37.5) {
      return "Quite Obese";
    } else if (bmi >= 37.5 && bmi < 39.9) {
      return "Very Obese";
    } else if (bmi >= 40.0 && bmi < 45.0) {
      return "Extremely Obese";
    } else if (bmi >= 45.0 && bmi < 50.0) {
      return "Highly Obese";
    } else if (bmi >= 50.0 && bmi < 60.0) {
      return "Severely Obese";
    } else if (bmi >= 60.0) {
      return "Dangerously Obese";
    } else {
      return "Invalid BMI";
    }
  }

  static String getAppMessage(double bmi) {
    if (bmi < 15.0) {
      return "Your BMI is critically low. Immediate medical attention is advised.";
    } else if (bmi >= 15.0 && bmi < 16.0) {
      return "We're very concerned about your low weight. Please seek urgent medical advice.";
    } else if (bmi >= 16.0 && bmi < 17.0) {
      return "Your weight is quite low. Professional guidance on nutrition could be beneficial.";
    } else if (bmi >= 17.0 && bmi < 18.5) {
      return "You're underweight. A nutritionist might help you reach a healthier weight.";
    } else if (bmi >= 18.5 && bmi < 22.0) {
      return "Your weight is within a healthy range. Continue maintaining a balanced diet.";
    } else if (bmi >= 22.0 && bmi < 24.9) {
      return "Excellent! Your BMI indicates a healthy weight. Keep up with your healthy lifestyle.";
    } else if (bmi >= 25.0 && bmi < 27.5) {
      return "You are slightly overweight. A combination of regular exercise and healthy eating can help.";
    } else if (bmi >= 27.5 && bmi < 29.9) {
      return "You're on the heavier side of overweight. Consider a structured fitness and diet plan.";
    } else if (bmi >= 30.0 && bmi < 32.5) {
      return "Your weight falls into the obese category. It might be time to take serious action for your health.";
    } else if (bmi >= 32.5 && bmi < 34.9) {
      return "Your BMI is quite high. Consult a healthcare provider for personalized advice.";
    } else if (bmi >= 35.0 && bmi < 37.5) {
      return "You're in Obese Class I. A tailored plan from a healthcare professional could help you improve your health.";
    } else if (bmi >= 37.5 && bmi < 39.9) {
      return "You're in Obese Class II. Consider seeking specialized medical advice for weight management.";
    } else if (bmi >= 40.0 && bmi < 45.0) {
      return "You are in Obese Class III. It is crucial to get immediate medical guidance.";
    } else if (bmi >= 45.0 && bmi < 50.0) {
      return "Your BMI is dangerously high. Intensive medical intervention is highly recommended.";
    } else if (bmi >= 50.0) {
      return "You are in a critical condition due to severe obesity. Immediate and comprehensive medical care is necessary.";
    } else {
      return "Unable to calculate your BMI. Please ensure your data is accurate.";
    }
  }
}
