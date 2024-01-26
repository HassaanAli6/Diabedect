import 'dart:async';
import 'package:dr_detection/screens/universal/user_type_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MailVerificationController extends GetxController{

  final _auth = FirebaseAuth.instance;

  late Timer _timer;


  @override
  void onReady() {
    super.onReady();
    sendVerification();
    setTimerForAutoCheck();
  }
  Future<void> sendVerification() async{
    try{
      await _auth.currentUser!.sendEmailVerification();

    }catch(e){
      Get.snackbar("Error", "Failed to send verification mail: $e", backgroundColor: Colors.white);
    }
  }

  Future<void> setTimerForAutoCheck() async{
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;

      if(user!.emailVerified){
        Get.to(()=> UserTypeSelectionScreen());
        timer.cancel();
      }
    });
  }
}