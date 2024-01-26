import 'package:dr_detection/screens/doctor/doctor_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../patient/user_info_screen.dart';

class UserTypeSelectionScreen extends StatefulWidget {
  @override
  _UserTypeSelectionScreenState createState() => _UserTypeSelectionScreenState();
}

class _UserTypeSelectionScreenState extends State<UserTypeSelectionScreen> {
  String userType = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Eye.PNG', // Replace with your image path
              width: 150, // Adjust width as needed
              height: 150, // Adjust height as needed
              // You can add more properties to customize the image display
            ),
            buildUserTypeContainer('Patient'),
            SizedBox(height: 16),
            buildUserTypeContainer('Doctor'),
          ],
        ),
      ),
    );
  }

  Widget buildUserTypeContainer(String type) {
    return GestureDetector(
      onTap: () {
        setState(() {
          userType = type;
        });
        if(type=="Patient"){
          Get.to(()=> UserInfoScreen());
        }else{
          Get.to(()=> Doctorinfoscreen());
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: BoxDecoration(
          border: Border.all(
            color: userType == type ? Colors.blue : Colors.blue,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Text(
            type,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}