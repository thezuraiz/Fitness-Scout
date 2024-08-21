import 'package:fitness_scout/common/widgets/custom_shapes/circular_container.dart';
import 'package:fitness_scout/common/widgets/custom_shapes/custom_curved_edges.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class ZPrimaryHeaderContainer extends StatelessWidget {
  const ZPrimaryHeaderContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ZCurvedEdges(
      child: Container(
        color: ZColor.primary,
        padding: const EdgeInsets.only(bottom: 0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -170,
              child: ZCircularContainer(
                backgroundColor: ZColor.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: ZCircularContainer(
                backgroundColor: ZColor.white.withOpacity(0.1),
              ),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
