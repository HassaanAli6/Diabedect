import 'package:dr_detection/Hscreen.dart';
import 'package:dr_detection/controllers/signin_signup_controller.dart';
import 'package:dr_detection/screens/admin/admin_home_screen.dart';
import 'package:dr_detection/screens/patient/patient_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_detection/screens/doctor/doctor_home_screen.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

  final controller = Get.put(SigninSignupController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getCurrentUserData();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: controller.currentUser!.uid == 'mpHrAx83p1RZ6TrV9XMywKBhwWr2'? AdminHomeScreen() : controller.isDoc? DoctorHomeScreen(): PatientHomeScreen(),
    );
  }
}
