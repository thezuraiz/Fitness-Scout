import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../features/gym/model/upcoming_event/event_model.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/format_exception.dart';
import '../../../utils/helpers/logger.dart';

class UpcomingEventsRepository extends GetxController {
  static UpcomingEventsRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<GymEvent>> fetchEvents() async {
    try {
      final documentSnapshot = await _db.collection('upcoming_events').get();
      if (documentSnapshot.docs.isNotEmpty) {
        ZLogger.info('Upcoming Events Found');
        final gymEvents = documentSnapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          return GymEvent.fromJson(data);
        }).toList();
        return gymEvents;
      } else {
        ZLogger.error('Events Not Found');
        return [];
      }
    } on FirebaseException catch (e) {
      throw ZFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw ZFormatException();
    } on PlatformException catch (e) {
      throw ZFormatException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }
}
