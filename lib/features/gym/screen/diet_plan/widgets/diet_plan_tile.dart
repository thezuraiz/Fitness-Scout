import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class DietPlanTile extends StatelessWidget {
  const DietPlanTile({
    super.key,
    required this.image,
    required this.textTitle,
    required this.protein,
    required this.fat,
    required this.carbs,
  });

  final String image, textTitle, protein, fat, carbs;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.only(left: ZSizes.md,right: ZSizes.md,top: ZSizes.md),
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 33,
        child: ClipOval(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      ),
      title: Text(
        textTitle,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Colories_Column(
            circleColor: Colors.purple,
            text: 'Proteins',
            amount: protein,
          ),
          Colories_Column(
            circleColor: Colors.pink,
            text: 'Fat',
            amount: fat,
          ),
          Colories_Column(
            circleColor: Colors.yellow,
            text: 'Carbs',
            amount: carbs,
          ),
        ],
      ),
    );
  }
}

class Colories_Column extends StatelessWidget {
  const Colories_Column({
    super.key,
    required this.text,
    required this.amount,
    required this.circleColor,
  });

  final String text, amount;
  final Color circleColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: ZSizes.sm,
        ),
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                  color: circleColor, borderRadius: BorderRadius.circular(100)),
            ),
            const SizedBox(width: 5),
            Text(text,style: Theme.of(context).textTheme.labelSmall,),
          ],
        ),
        Text(
          amount,
          style: Theme.of(context).textTheme.bodyLarge,
        )
      ],
    );
  }
}
