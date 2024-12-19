import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CustomAmenitiesContainer extends StatelessWidget {
  const CustomAmenitiesContainer({super.key, required this.amenityName});

  final String amenityName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(ZSizes.sm / 2),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: ZColor.primary,
        borderRadius: const BorderRadius.all(
          Radius.circular(ZSizes.sm),
        ),
        border: Border.all(
          color: Colors.white, // Border color
          width: 1.5, // Border width
        ),
      ),
      child: Text(
        amenityName,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: Colors.white),
      ),
    );
  }
}
