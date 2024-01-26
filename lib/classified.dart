import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:dr_detection/controllers/signin_signup_controller.dart';
import 'package:dr_detection/controllers/user_profile_controller.dart';
import 'package:dr_detection/screens/doctor/doctor_home_screen.dart';
import 'package:dr_detection/widgets/functions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'Hscreen.dart';
import 'package:http/http.dart' as http;

class RetinaClassified extends StatefulWidget {
  final File image;
  final String confidence;
  final String drType;
  final String patientName;
  final String uid;
  final String patientDOB;
  final String patientEmail;
  final String gender;
  const RetinaClassified(
      {super.key,
      required this.image,
      required this.confidence,
      required this.drType, required this.patientName, required this.uid, required this.patientDOB, required this.patientEmail, required this.gender});

  @override
  State<RetinaClassified> createState() => _RetinaClassifiedState();
}

class _RetinaClassifiedState extends State<RetinaClassified> {

  final controller = Get.put(UserController());
  final controller2 = Get.put(SigninSignupController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // ignore: prefer_const_constructors
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
              onPressed: ()=> Get.back()
          ),
          title: Text('DR Classification',
              style: const TextStyle(color: Colors.white)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height / 2),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: FileImage(
                          widget.image,
                        ),
                        fit: BoxFit.cover),
                    border: Border.all(),
                  ),

                  //child: _imageWidget,
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              Text(
                widget.drType,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Confidence: ${widget.confidence}',
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Get.back();
                    Get.back();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(20)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 14, color: Colors.white))),
                  child: Text("Classify Another",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  )),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () async {
                    showProgressDialog(context, 'Saving Report');
                    await controller.createReport(
                      doctorName: '${controller2.firstName} ${controller2.lastName}',
                      dob: widget.patientDOB,
                      email: widget.patientEmail,
                      result: widget.drType,
                      gender: widget.gender,
                      patientName: widget.patientName,
                      patientUid: widget.uid
                    );
                    Get.offAll(()=> DoctorHomeScreen());
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      padding:
                      MaterialStateProperty.all(const EdgeInsets.all(20)),
                      textStyle: MaterialStateProperty.all(const TextStyle(
                          fontSize: 14, color: Colors.white))),
                  child: Text("Send Report to Patient",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  )),

            ],
          ),
        ));
  }
}
