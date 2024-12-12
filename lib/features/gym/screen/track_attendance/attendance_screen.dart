import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

import '../../../../common/widgets/custom_card.dart';

class TrackAttendance extends StatelessWidget {
  const TrackAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: ZHelperFunction.isDarkMode(context)
                  ? Colors.white
                  : Colors.black),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ZSizes.defaultSpace),
          child: Column(
            children: [
              ZCustomCard(selectedAddress: false),
              ZCustomCard(selectedAddress: false),
              ZCustomCard(selectedAddress: true),
              ZCustomCard(selectedAddress: false),
            ],
          ),
        ),
      ),
    );
  }
}
