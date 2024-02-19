import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_detection/screens/admin/admin_home_screen.dart';
import 'package:dr_detection/screens/patient/patient_home_screen.dart';
import 'package:dr_detection/screens/patient/user_info_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../screens/universal/mail_verification_screen.dart';
import 'package:dr_detection/screens/doctor/doctor_home_screen.dart';

class SigninSignupController extends GetxController{
  final GetStorage _box = GetStorage();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Global variable to store the user's UID
  String? uid;
  final currentUser = FirebaseAuth.instance.currentUser;
  String firstName = '';
  String lastName = '';
  String gender = '';
  String dob = '';
  String emailAddress = '';
  String speciality = '';
  String clinicName = '';
  bool isDoc = false;

  @override
  void onReady(){
    super.onReady();
    getCurrentUserData();
  }




  Future<void> signupUserWithEmailAndPassword(String email, String password, String confirmPassword) async {

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(!userCredential.isNull){

        Get.back();
        _auth.currentUser!.emailVerified? UserInfoScreen():
        Get.to(()=> EmailVerificationScreen());
      }

      // Show a success snackbar
      Get.snackbar('Success', 'Email Sent', backgroundColor: Colors.white);


      // You can add additional logic here, such as navigating to a new screen after signup
    } catch (e) {
      // Show an error snackbar with the error message
      Get.back();
      Get.snackbar('Error', 'Failed to sign up user: $e', backgroundColor: Colors.white);
    }
  }
  Future<void> signinUserWithEmailAndPassword(String email, String password,) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(userCredential.user!.uid == 'AXqFbwIarucPS2srt3ydphaVkOl1'){
        Get.offAll(()=> AdminHomeScreen());

      }else{
        DocumentSnapshot currentUserDocument = await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).get();
        if(currentUserDocument != null){
          firstName = (currentUserDocument.data() as dynamic)['first_name'] ?? '';
          lastName = (currentUserDocument.data() as dynamic)['last_name'] ?? '';
          gender = (currentUserDocument.data() as dynamic)['gender'] ?? '';
          dob = (currentUserDocument.data() as dynamic)['dob'] ?? '';
          emailAddress = (currentUserDocument.data() as dynamic)['email'] ?? '';
          speciality = (currentUserDocument.data() as dynamic)['speciality'] ?? '';
          clinicName = (currentUserDocument.data() as dynamic)['clinic_name'] ?? '';
          isDoc = await (currentUserDocument.data() as dynamic)['isDoc'] ?? false;
          isDoc? Get.offAll(()=> DoctorHomeScreen()) : Get.offAll(()=> PatientHomeScreen());
        }
      }


      // await getCurrentUserData();




      // Show a success snackbar
      Get.snackbar('Success', 'Logged in successfully', backgroundColor: Colors.white);


      // You can add additional logic here, such as navigating to a new screen after signup
    } catch (e) {
      Get.back();
      // Show an error snackbar with the error message
      Get.snackbar('Error', 'Failed to  Login in user: $e');
    }
  }

  Future<void> savePatientProfileData(
  {required String firstName,
    required String lastName,
    required String emailAddress,
    required String gender,
    required String dob,
    required bool isDoc
    
}) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      User user = FirebaseAuth.instance.currentUser!;

      // Save profile picture to Firebase Storage and get the download URL

      // Save user information to Firestore
      DocumentReference userRef = firestore.collection('users').doc(user.uid);
      await userRef.set({
        "first_name": firstName,
        "last_name": lastName,
        "email": emailAddress,
        "gender": gender,
        "dob": dob,
        "uid": user.uid,
        "isDoc": isDoc

      });

      Get.snackbar('Success', 'Patient Profile created successfully', backgroundColor: Colors.white);

      Get.offAll(() => PatientHomeScreen());
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Failed to create profile: $e', backgroundColor: Colors.white);
    }
  }

  Future<void> saveDoctorProfileData(
      {required String firstName,
        required String lastName,
        required String emailAddress,
        required String gender,
        required String dob,
        required String speciality,
        required String clinicName,
        required bool isDoc,


      }) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      User user = FirebaseAuth.instance.currentUser!;

      // Save profile picture to Firebase Storage and get the download URL

      // Save user information to Firestore
      DocumentReference userRef = firestore.collection('users').doc(user.uid);
      await userRef.set({
        "first_name": firstName,
        "last_name": lastName,
        "email": emailAddress,
        "gender": gender,
        "dob": dob,
        "uid": user.uid,
        "speciality": speciality,
        "clinic_name": clinicName,
        "isDoc": isDoc

      });

      Get.snackbar('Success', 'Profile created successfully', backgroundColor: Colors.white);

      Get.offAll(() => DoctorHomeScreen());
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Failed to create profile: $e', backgroundColor: Colors.white);
    }
  }
  Future<void> editDoctorProfileData(
      {required String firstName,
        required String lastName,
        required String emailAddress,
        required String gender,
        required String dob,
        required String speciality,
        required String clinicName,
        required bool isDoc,


      }) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      User user = FirebaseAuth.instance.currentUser!;

      // Save profile picture to Firebase Storage and get the download URL

      // Save user information to Firestore
      DocumentReference userRef = firestore.collection('users').doc(user.uid);
      await userRef.update({
        "first_name": firstName,
        "last_name": lastName,
        "email": emailAddress,
        "gender": gender,
        "dob": dob,
        "uid": user.uid,
        "speciality": speciality,
        "clinic_name": clinicName,
        "isDoc": isDoc

      });

      Get.snackbar('Success', 'Profile updated successfully', backgroundColor: Colors.white);

      Get.offAll(() => DoctorHomeScreen());
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Failed to update profile: $e', backgroundColor: Colors.white);
    }
  }


  Future<void> getCurrentUserData()async{
    DocumentSnapshot currentUserDocument = await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
    if(currentUserDocument!=null){
      firstName = (currentUserDocument.data() as dynamic)['first_name'] ?? '';
      lastName = (currentUserDocument.data() as dynamic)['last_name'] ?? '';
      gender = (currentUserDocument.data() as dynamic)['gender'] ?? '';
      dob = (currentUserDocument.data() as dynamic)['dob'] ?? '';
      emailAddress = (currentUserDocument.data() as dynamic)['email'] ?? '';
      speciality = (currentUserDocument.data() as dynamic)['speciality'] ?? '';
      clinicName = (currentUserDocument.data() as dynamic)['clinic_name'] ?? '';
      isDoc = (currentUserDocument.data() as dynamic)['isDoc'] ?? false;
      uid = currentUser!.uid ?? '';
    }
  }
  Future<void> editProfileData(
      {required String firstName,
        required String lastName,
        required String emailAddress,
        required String gender,
        required String dob

      }) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      User user = FirebaseAuth.instance.currentUser!;

      // Save profile picture to Firebase Storage and get the download URL

      // Save user information to Firestore
      DocumentReference userRef = firestore.collection('users').doc(user.uid);
      await userRef.update({
        "first_name": firstName,
        "last_name": lastName,
        "email": emailAddress,
        "gender": gender,
        "dob": dob,
        "uid": user.uid,

      });

      Get.snackbar('Success', 'Profile updated successfully', backgroundColor: Colors.white);

      Get.offAll(() => PatientHomeScreen());
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Failed to updated profile: $e', backgroundColor: Colors.white);
    }
  }
}
