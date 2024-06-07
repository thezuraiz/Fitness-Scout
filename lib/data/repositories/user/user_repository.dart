import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController{
  // --- Variables
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// --- Function to save user data to Firestore
  saveUserRecord(Map<String,String> user)async{
    try{
      await _db.collection('users').doc(user.values.first).set(user);
    }on FirebaseAuth catch(e){
      throw e.toString();
    }

  }






}