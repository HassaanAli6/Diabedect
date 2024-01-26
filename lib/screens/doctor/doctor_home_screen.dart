import 'package:dr_detection/screens/doctor/doctor_profile_screen.dart';
import 'package:dr_detection/screens/doctor/patients_list_screen.dart';
import 'package:dr_detection/screens/doctor/view_report_patient_list_screen.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/signin_signup_controller.dart';
import '../patient/patient_home_screen.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
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
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Doctor Panel',
              style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: Icon(Icons.person, size: 30, color: Colors.white,),
              onPressed: (){
                Get.to(()=>
                    DoctorProfileScreen()
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
              CustomizeButton(title: 'Generate Report', onPressed: (){
                Get.to(()=> PatientListScreen());
              },),
              SizedBox(height: 15,),
              CustomizeButton(title: 'View Reports', onPressed: (){
                Get.to(()=> ViewReportPatientListScreen());
              },),
            ],
          ),
        )
    );
  }
}


