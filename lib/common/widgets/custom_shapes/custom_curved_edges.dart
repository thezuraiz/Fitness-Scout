import 'package:fitness_scout/common/widgets/custom_shapes/custom_curved_path.dart';
import 'package:flutter/material.dart';


class ZCurvedEdges extends StatelessWidget {
  const ZCurvedEdges({
    super.key,
    required this.child
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ZCustomCurvedEdges(),
      child: child,
    );
  }
}