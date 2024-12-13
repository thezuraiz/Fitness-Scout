import 'package:fitness_scout/utils/constants/sizes.dart';
import 'package:fitness_scout/utils/helpers/helper_functions.dart';
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
      body: SingleChildScrollView(
        child: RefreshIndicator(
          onRefresh: () => controller.loadUserAttendance(),
          child: Padding(
            padding: const EdgeInsets.all(ZSizes.defaultSpace),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: controller.userGYMAttendance.length,
              itemBuilder: (_, index) {
                final singleAttendance =
                    controller.userGYMAttendance.value[index];
                DateTime checkOutTime = singleAttendance.checkOutTime;
                bool isOnGoing = checkOutTime.isAfter(DateTime.now());
                return ZCustomCard(
                    gymName: singleAttendance.name,
                    gymPhoneNo: singleAttendance.phoneNo,
                    gymLocation: singleAttendance.location,
                    gymCheckInDate: DateFormat('dd-MM-yyy')
                        .format(singleAttendance.checkInTime),
                    gymCheckInTime: DateFormat('HH:mm a')
                        .format(singleAttendance.checkInTime),
                    selectedAddress: isOnGoing ? true : false);
              },
            ),
          ),
        ),
      ),
    );
  }
}
