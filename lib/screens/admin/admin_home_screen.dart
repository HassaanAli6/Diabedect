import 'package:dr_detection/screens/admin/admin_doctor_screen.dart';
import 'package:dr_detection/screens/admin/all_patients_list_screen.dart';
import 'package:dr_detection/screens/patient/patient_home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/signin_signup_controller.dart';
import '../universal/login_screen.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final controller = Get.put(SigninSignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Admin Panel',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.power_settings_new, color: Colors.white,),
            onPressed: ()async{
              try {
                await _auth.signOut().whenComplete(() => Get.offAll(()=> LoginScreen()));
                controller.firstName = '';
                controller.lastName = '';
                controller.emailAddress = '';
                controller.dob = '';
                controller.uid = '';
                controller.gender = '';
                controller.isDoc = false;
                controller.speciality = '';
                controller.clinicName = '';
                // Clear stored user data, such as UID and authentication state
              } catch (e) {
                print('Error signing out: $e');
              }
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Eye.PNG', // Replace with your image path
              width: 150, // Adjust width as needed
              height: 150, // Adjust height as needed
              // You can add more properties to customize the image display
            ),
            CustomizeButton(title: 'View Doctors', onPressed: (){
              Get.to(()=> AdminDoctorListScreen());
            },),
            SizedBox(height: 15,),
            CustomizeButton(title: 'View Patients', onPressed: (){
              Get.to(()=> AllPatientsListScreen());
            },),
          ],
        ),
      ),
    );
  }
}
