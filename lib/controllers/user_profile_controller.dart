import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {


  Future<void> addPatientToDoctor(String doctorUid) async {
    try {
      // Get the current user's UID
      String currentUserUid = FirebaseAuth.instance.currentUser!.uid;

      // Retrieve the current user's name from the "users" collection
      DocumentSnapshot currentUserSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(currentUserUid).get();

      String currentUserName = '${currentUserSnapshot['first_name']} ${currentUserSnapshot['last_name']}';
      String dob = currentUserSnapshot['dob'];
      String gender = currentUserSnapshot['gender'];
      String email = currentUserSnapshot['email'];

      // Fetch the doctor's information using the provided doctorUid
      DocumentSnapshot doctorSnapshot =
      await FirebaseFirestore.instance.collection('users').doc(doctorUid).get();

      String doctorName = '${doctorSnapshot['first_name']} ${doctorSnapshot['last_name']}';

      // Create the doctor data
      Map<String, dynamic> doctorData = {
        'doctor_name': doctorName,
        'doctor_uid': doctorUid,
      };

      // Create the patient data
      Map<String, dynamic> patientData = {
        'patient_name': currentUserName,
        'patient_uid': currentUserUid,
        'dob': dob,
        'email': email,
        'gender': gender
      };

      // Update the doctor's document in the "users" collection
      await FirebaseFirestore.instance.collection('users').doc(doctorUid).update({
        'patients': FieldValue.arrayUnion([patientData]),
      });

      // Update the current user's document with the doctor information
      await FirebaseFirestore.instance.collection('users').doc(currentUserUid).update({
        'doctors': FieldValue.arrayUnion([doctorData]),
      });
      Get.snackbar("Patient added","Patient added to doctor successfully!");
    } catch (error) {
      print('Error adding patient to doctor: $error');
    }
  }

  Future<void> createReport({
    required String patientUid,
    required String patientName,
    required String dob,
    required String email,
    required String gender,
    required String result,
    required String doctorName,
  }) async {
    try {

      // Reference to the patient's document in the "users" collection
      DocumentReference patientRef =
      FirebaseFirestore.instance.collection('users').doc(patientUid);

      // Generate a random 3-digit report ID between 100 and 999
      int randomReportId = 100 + (Random().nextInt(900));

      // Reference to the "reports" collection inside the patient's document
      CollectionReference reportsRef = patientRef.collection('reports');

      // Create a new document in the "reports" collection with the random ID
      DocumentReference reportDocRef = reportsRef.doc('Report $randomReportId');

      // Create the report data
      Map<String, dynamic> reportData = {
        'patient_uid': patientUid,
        'patient_name': patientName,
        'dob': dob,
        'email': email,
        'gender': gender,
        'result': result,
        'doctor_name': doctorName,
        'report_id': randomReportId,
      };

      // Set the report data in the document
      await reportDocRef.set(reportData);

      Get.snackbar('Report sent', 'Report Sent to Patient successfully!', backgroundColor: Colors.white);
    } catch (error) {
      print('Error creating report: $error');
    }
  }

  Future<void> deleteUserAndDocument(String uid) async {
    try {
      // Delete user from authentication
      await FirebaseAuth.instance.currentUser!.delete();

      // Delete user document from "users" collection
      await FirebaseFirestore.instance.collection('users').doc(uid).delete();

      Get.snackbar('User Deleted', 'User and document deleted successfully!', backgroundColor: Colors.white);
    } catch (error) {
      Get.snackbar('Error', 'Error: $error', backgroundColor: Colors.white);
    }
  }

}
