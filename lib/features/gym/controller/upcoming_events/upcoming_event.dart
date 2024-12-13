import 'package:fitness_scout/features/gym/model/upcoming_event/event_model.dart';
import 'package:fitness_scout/utils/helpers/loaders.dart';
import 'package:fitness_scout/utils/helpers/logger.dart';
import 'package:get/get.dart';

import '../../../../data/repositories/upcoming_event/upcoming_events_repository.dart';

class UpcomingEventsController extends GetxController {
  static UpcomingEventsController get instance => Get.find();
  final upcomingEvents = Get.put(UpcomingEventsRepository());
  RxList<GymEvent> gymEvents = <GymEvent>[].obs;
  RxBool isEventsLoading = true.obs;

  @override
  void onInit() {
    fetchUpcomingEventRecords();
  }

  Future<void> fetchUpcomingEventRecords() async {
    try {
      ZLogger.info('Fetching Upcoming Events');
      isEventsLoading.value = true;
      final events = await upcomingEvents.fetchEvents();
      this.gymEvents(events);
      ZLogger.info('Fetching Upcoming Events: ${events.length}');
    } catch (e) {
      ZLoaders.errorSnackBar(
          title: 'Something went wrong ',
          message: 'While fetching Upcoming Events');
    } finally {
      await Future.delayed(const Duration(seconds: 1));
      isEventsLoading.value = false;
    }
  }
}
