import 'package:fitness_scout/utils/constants/colors.dart';
import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/helpers/helper_functions.dart';
import 'package:fitness_scout/utils/loaders/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../common/widgets/custom_card.dart';
import '../../controller/gym_attendance_controller/gym_attendance_controller.dart';

class TrackAttendance extends StatelessWidget {
  const TrackAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    GymAttendanceController controller = Get.put(GymAttendanceController());
    final dark = ZHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Attendance',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: ZHelperFunction.isDarkMode(context)
                  ? Colors.white
                  : Colors.black),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => controller.loadUserAttendance(),
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(ZSizes.defaultSpace),
            child: controller.userGYMAttendance == null ||
                    controller.userGYMAttendance.isEmpty
                ? const Column(
                    children: [Icon(Icons.dangerous)],
                  )
                : controller.isLoading.value
                    ? ListView.builder(
                        itemCount: 3,
                        shrinkWrap: true,
                        itemBuilder: (_, __) => Card(
                          margin:
                              const EdgeInsets.symmetric(vertical: ZSizes.sm),
                          color: dark ? ZColor.darkGrey : ZColor.lightContainer,
                          child: const ListTile(
                            contentPadding: EdgeInsets.all(1),
                            title: ZShimmerEffect(width: 30, height: 10),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ZShimmerEffect(
                                    width: double.infinity, height: 10),
                                ZShimmerEffect(
                                    width: double.infinity, height: 10),
                              ],
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.userGYMAttendance.length,
                        itemBuilder: (_, index) {
                          final singleAttendance =
                              controller.userGYMAttendance[index];
                          DateTime checkOutTime = singleAttendance.checkOutTime;
                          bool isOnGoing = checkOutTime.isAfter(DateTime.now());
                          return ZCustomCard(
                            gymName: singleAttendance.name,
                            gymPhoneNo: singleAttendance.phoneNo,
                            gymLocation: singleAttendance.location,
                            gymCheckInDate: DateFormat('dd-MM-yyyy')
                                .format(singleAttendance.checkInTime),
                            gymCheckInTime: DateFormat('HH:mm a')
                                .format(singleAttendance.checkInTime),
                            selectedAddress: isOnGoing,
                          );
                        },
                      ),
          ),
        ),
      ),
    );
  }
}
