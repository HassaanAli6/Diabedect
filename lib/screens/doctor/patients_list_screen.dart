import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_detection/Hscreen.dart';
import 'package:dr_detection/controllers/user_profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PatientListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.blue,
        title: Text(
          'Select Patient',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }

            var currentUserData = snapshot.data!;
            var patientsList = currentUserData['patients'] ?? [];

            return ListView.builder(
              itemCount: patientsList.length,
              itemBuilder: (context, index) {
                var patientData = patientsList[index];
                var patientUid = patientData['patient_uid'];
                var patientName = patientData['patient_name'];
                var gender = patientData['gender'];
                var dob = patientData['dob'];
                var email = patientData['email'];

                return GestureDetector(
                  onTap: () {
                    Get.to(() => MyHomePage(
                      uid: patientUid,
                      patientName: patientName,
                      gender: gender,
                      dob: dob,
                      email: email,
                    ));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black12,
                    ),
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      patientName,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
