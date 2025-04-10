import 'package:fitness_scout/bindings/general_bindings.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FitnessScout extends StatelessWidget {
  const FitnessScout({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      home: const Scaffold(
        backgroundColor: ZColor.primary,
        body: Center(
          child: CircularProgressIndicator(
            color: ZColor.white,
          ),
        ),
      ),
    );
  }
}
