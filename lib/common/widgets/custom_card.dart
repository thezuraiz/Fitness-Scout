import 'package:fitness_scout/common/widgets/custom_rounded_container.dart';
import 'package:flutter/material.dart';

import '../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class ZCustomCard extends StatelessWidget {
  const ZCustomCard(
      {super.key,
      required this.selectedAddress,
      this.gymName = 'GYM Name',
      this.gymCheckInDate = '',
      this.gymCheckInTime = '',
      this.gymPhoneNo = 'Phone No:',
      this.gymLocation = 'Location:'});

  final bool selectedAddress;
  final String gymName, gymPhoneNo, gymCheckInDate, gymCheckInTime, gymLocation;

  @override
  Widget build(BuildContext context) {
    final dark = ZHelperFunction.isDarkMode(context);
    return ZRoundedContainer(
      width: double.infinity,
      backgroundColor: selectedAddress ? ZColor.primary : Colors.transparent,
      showBorder: true,
      borderColor: selectedAddress
          ? Colors.transparent
          : dark
              ? ZColor.darkerGrey
              : ZColor.grey,
      margin: const EdgeInsets.only(bottom: ZSizes.spaceBtwItems),
      padding: const EdgeInsets.all(ZSizes.md),
      child: Stack(
        children: [
          Positioned(
            right: 5,
            top: 0,
            child: selectedAddress
                ? Container(
                    decoration: BoxDecoration(
                      color: dark ? ZColor.dark : ZColor.lightGrey,
                      borderRadius: BorderRadius.circular(
                        40,
                      ), // Makes the shape closer to a "stadium"
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: ZSizes.sm, vertical: ZSizes.sm / 2),
                    child: const Text('On Going'),
                  )
                : const Icon(null),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                gymName,
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: selectedAddress
                        ? Colors.white
                        : dark
                            ? Colors.white
                            : Colors.black),
              ),
              const SizedBox(
                height: ZSizes.sm / 2,
              ),
              Text(
                gymPhoneNo,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: selectedAddress
                        ? Colors.white
                        : dark
                            ? Colors.white
                            : Colors.black),
              ),
              const SizedBox(
                height: ZSizes.sm / 2,
              ),
              Text(
                gymLocation,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: selectedAddress
                        ? Colors.white
                        : dark
                            ? Colors.white
                            : Colors.black),
              ),
              const SizedBox(
                height: ZSizes.sm / 2,
              ),
              Text(
                "Check In Date: $gymCheckInDate",
                softWrap: true,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: selectedAddress
                        ? Colors.white
                        : dark
                            ? Colors.white
                            : Colors.black),
              ),
              const SizedBox(
                height: ZSizes.sm / 2,
              ),
              Text(
                "Check In Time: $gymCheckInTime",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: selectedAddress
                        ? Colors.white
                        : dark
                            ? Colors.white
                            : Colors.black),
              ),
            ],
          )
        ],
      ),
    );
  }
}
