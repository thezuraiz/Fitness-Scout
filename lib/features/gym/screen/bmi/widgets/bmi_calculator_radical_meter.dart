import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../../utils/constants/colors.dart';

class RadicalMeter extends StatelessWidget{

  const RadicalMeter({super.key, required this.bmiMessage, required this.bmi});

  final String bmiMessage;
  final double bmi;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          minimum: 10,
          maximum: 34.001,
          ranges: [
            GaugeRange(
              startValue: 10,
              endValue: 18.5,
              color: ZColor.primary,
            ),
            GaugeRange(
              startValue: 18.5,
              endValue: 25,
              color: Colors.greenAccent,
            ),
            GaugeRange(
              startValue: 25,
              endValue: 34,
              color: Colors.red,
            )
          ],
          pointers: [
            NeedlePointer(
              value: bmi,
              enableAnimation: true,
            )
          ],
          annotations: [
            GaugeAnnotation(
              widget: Text(
                " ${bmi.toStringAsFixed(3)}\n${bmiMessage}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              positionFactor: 0.5,
              angle: 90,
            ),
          ],
        ),
      ],
    );
  }
}