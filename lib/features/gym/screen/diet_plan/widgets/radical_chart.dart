import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadicalChart extends StatelessWidget {
  const RadicalChart({
    super.key,
    this.carbs = 35,
    this.fat = 35,
    this.protiens = 40,
  });

  final double carbs, fat, protiens;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ZSizes.defaultSpace * 1.3),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 280,
              child: SfCircularChart(
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: [
                      ChartData('Carbs', carbs, Colors.pink),
                      ChartData('Fat', fat, Colors.purple),
                      ChartData('Protein', protiens, ZColor.primary),
                    ],
                    pointRadiusMapper: (ChartData data, _) => '100%',
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    pointColorMapper: (ChartData data, _) => data.color,
                    innerRadius: '85%',
                    radius: '100%',
                    startAngle: 40,
                    endAngle: 400,
                    cornerStyle: CornerStyle.bothCurve,
                  ),
                ],
                annotations: <CircularChartAnnotation>[
                  CircularChartAnnotation(
                    widget: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Calories',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                        Text(
                          '~2500',
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'Daily energy goal',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: ZSizes.defaultSpace),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(width: 10),
                LegendItem(color: Colors.purple, text: 'Protein'),
                SizedBox(width: 10),
                LegendItem(color: Colors.pink, text: 'Fat'),
                SizedBox(width: 10),
                LegendItem(color: Colors.orange, text: 'Carbs'),
                SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  const LegendItem({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(100)),
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}
