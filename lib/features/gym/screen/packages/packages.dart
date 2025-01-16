import 'package:fitness_scout/features/gym/controller/packages/package_controller.dart';
import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/loaders/shimmer.dart';

class PackagesScreen extends StatelessWidget {
  const PackagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PackageController());
    final dark = ZHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Packages',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.reloadPackages(),
        child: Obx(
          () => controller.isPackageLoading.value
              ? ListView.builder(
                  itemCount: 3,
                  padding: const EdgeInsets.all(ZSizes.sm),
                  shrinkWrap: true,
                  itemBuilder: (_, __) => Card(
                    margin: const EdgeInsets.symmetric(vertical: ZSizes.sm),
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
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(ZSizes.sm),
                  itemCount: controller.packageHistory.value.length,
                  itemBuilder: (context, index) {
                    final package = controller.packageHistory.value[index];
                    return Card(
                      color: ZColor.lightContainer,
                      child: ListTile(
                        title: Text(
                          package.packageName,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 17),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomRow(
                                heading: 'Amount',
                                value:
                                    '${package.currency}. ${package.amount}'),
                            CustomRow(
                              heading: 'Date',
                              value: DateFormat('yyyy-MM-dd')
                                  .format(DateTime.parse(package.timestamp)),
                            ),
                            CustomRow(
                              heading: 'Time',
                              value: DateFormat('HH:mm:ss')
                                  .format(DateTime.parse(package.timestamp)),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
        ),
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.heading,
    required this.value,
  });

  final String heading, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Text(
            '$heading:',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        )
      ],
    );
  }
}
