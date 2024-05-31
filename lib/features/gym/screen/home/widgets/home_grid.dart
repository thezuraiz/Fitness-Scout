import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ZExercisesGrid extends StatelessWidget {
  const ZExercisesGrid({
    super.key, required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.count(
          padding: const EdgeInsets.all(ZSizes.defaultSpace * 0.7),
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: children,
        ),
      ],
    );
  }
}