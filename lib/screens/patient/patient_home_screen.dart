import 'package:dr_detection/controllers/signin_signup_controller.dart';
import 'package:dr_detection/screens/patient/profile_screen.dart';
import 'package:dr_detection/screens/doctor/reports_list_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dr_detection/screens/patient/doctors_list_screen.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {

  final controller = Get.put(SigninSignupController());
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getCurrentUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Patient Panel',
            style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.person, size: 30, color: Colors.white,),
            onPressed: (){
              Get.to(()=>
                ProfileScreen()
              );
            },
          )
        ],
      ),
      body: controller.firstName==''? Center(
        child: CircularProgressIndicator(color: Colors.blue,),
      ): Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomizeButton(title: 'Find Doctor', onPressed: (){
              Get.to(()=> DoctorListScreen());
            },),
            SizedBox(height: 15,),
            CustomizeButton(title: 'View Reports', onPressed: (){
              Get.to(()=> ReportsListScreen(uid: uid));
            },),
          ],
        ),
      )
    );
  }
}

class CustomizeButton extends StatelessWidget {
  const CustomizeButton({
    super.key, required this.title, required this.onPressed,
  });

  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
        ),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
      ),
    );
  }
}
