import 'package:firebase_core/firebase_core.dart';
import 'package:fitness_scout/app.dart';
import 'package:fitness_scout/data/repositories/authentication/authentication_repository.dart';
import 'package:fitness_scout/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

void main() async {

  ///  Add Widget Binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  ///  Init Local Storage
  GetStorage.init();

  // TODO: Init Payment Method
  // TODO: Await Native Screen
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // TODO: Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const FitnessScout());
}
