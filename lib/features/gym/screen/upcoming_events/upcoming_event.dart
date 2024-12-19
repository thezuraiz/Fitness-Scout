import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/helpers/loaders.dart';
import '../../../../utils/loaders/shimmer.dart';
import '../../controller/upcoming_events/upcoming_event.dart';

class UpcomingEventsScreen extends StatelessWidget {
  const UpcomingEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UpcomingEventsController.instance.fetchUpcomingEventRecords();
    final dark = ZHelperFunction.isDarkMode(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UpComing Events',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            UpcomingEventsController.instance.fetchUpcomingEventRecords(),
        child: Obx(() {
          /// Todo: Is After Krna hn!
          final isValidEvent = UpcomingEventsController.instance.gymEvents.value
              .where((event) =>
                  DateTime.parse(event.startTime).isBefore(DateTime.now()))
              .toList();

          if (UpcomingEventsController.instance.isEventsLoading.value) {
            return ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (_, __) => Card(
                margin: const EdgeInsets.symmetric(
                    vertical: ZSizes.sm, horizontal: ZSizes.md / 1.2),
                color: dark ? ZColor.darkGrey : ZColor.lightContainer,
                child: const ListTile(
                  contentPadding: EdgeInsets.all(1),
                  title: ZShimmerEffect(width: 30, height: 10),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ZShimmerEffect(width: double.infinity, height: 10),
                      ZShimmerEffect(width: double.infinity, height: 10),
                    ],
                  ),
                ),
              ),
            );
          }
          if (isValidEvent.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: CircleAvatar(
                      backgroundColor: ZColor.primary,
                      child: Icon(
                        Iconsax.slash,
                        size: ZSizes.iconLg * 3,
                        color: dark ? ZColor.white : ZColor.darkerGrey,
                      ),
                    ),
                  ),
                  const SizedBox(height: ZSizes.spaceBtwSections),
                  Text(
                    'No Upcoming Events',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (_, __) => Container(
                height: ZSizes.spaceBtwItems,
                width: 20,
                color: Colors.red,
              ),
              shrinkWrap: true,
              itemCount: isValidEvent.length,
              itemBuilder: (_, index) {
                final event = isValidEvent[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ZSizes.borderRadiusMd),
                  ),
                  color: dark
                      ? ZColor.darkerGrey
                      : ZColor.lightContainer.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(event.title,
                            style: Theme.of(context).textTheme.headlineMedium!),
                        const SizedBox(height: 8.0),

                        // Description
                        Text(
                          event.description,
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 5,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8.0),
                        // Date and Time
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Iconsax.calendar,
                                color: dark ? ZColor.white : ZColor.darkerGrey),
                            const SizedBox(width: 6),
                            Text(
                              'Date: ${DateFormat.yMMMd().format(DateTime.parse(event.startTime))}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Iconsax.clock_1,
                                color: dark ? ZColor.white : ZColor.darkerGrey),
                            const SizedBox(width: 6),
                            Text(
                              'Time: ${DateFormat.jm().format(DateTime.parse(event.startTime))}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Iconsax.location,
                                color: dark ? ZColor.white : ZColor.darkerGrey),
                            const SizedBox(width: 6),
                            Text(
                              event.location,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),

                        if (event.isFree)
                          const Chip(
                            label: Text('Free Event'),
                            backgroundColor: ZColor.primary,
                            elevation: 9,
                            labelStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: ZColor.white),
                            side: BorderSide(width: 0),
                          ),

                        const SizedBox(
                          height: ZSizes.spaceBtwItems / 1.8,
                        ),
                        Divider(
                          color: dark ? ZColor.white : ZColor.darkerGrey,
                        ),

                        // Contact Details
                        Row(
                          children: [
                            Icon(Iconsax.call,
                                color: dark ? ZColor.white : ZColor.darkerGrey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                event.contactNumber,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: event.contactNumber));
                                ZLoaders.successSnackBar(
                                    title: 'Contact number copied!',
                                    message: event.contactNumber);
                              },
                              icon: Icon(Iconsax.copy,
                                  color:
                                      dark ? ZColor.white : ZColor.darkerGrey),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Iconsax.direct_right,
                                color: dark ? ZColor.white : ZColor.darkerGrey),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                event.email,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Clipboard.setData(
                                    ClipboardData(text: event.email));
                                ZLoaders.successSnackBar(
                                    title: 'Email copied!',
                                    message: event.email);
                              },
                              icon: Icon(Iconsax.copy,
                                  color:
                                      dark ? ZColor.white : ZColor.darkerGrey),
                            ),
                          ],
                        ),
                        if (event.eventLink != null &&
                            event.eventLink != '') ...[
                          const SizedBox(
                            height: ZSizes.spaceBtwItems,
                          ),
                          SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    try {
                                      await launchUrl(Uri.parse(
                                        event.eventLink.toString(),
                                      ));
                                    } catch (e) {
                                      ZLoaders.errorSnackBar(
                                          title: 'Invalid Link $e');
                                    }
                                  },
                                  child: const Text('Register Now')))
                        ]
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
    );
  }
}
