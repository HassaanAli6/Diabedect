
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/mail_verification_controller.dart';
import '../patient/user_info_screen.dart';

class EmailVerificationScreen extends StatelessWidget {
  EmailVerificationScreen({Key? key}) : super(key: key);

  final controller = Get.put(MailVerificationController());
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Email Verification',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: Colors.black
            ),
          ),
          SizedBox(height: 20,),
          Text(
            'We have sent a mail verification link to your email. Kindly click on the link to verifiy your email',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.black87
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(
            onPressed: (){
              if(_auth.currentUser!.emailVerified){
                Get.offAll(()=> UserInfoScreen());
              }else{
                Get.snackbar("Error", "Your email has not been verified", backgroundColor: Colors.white);
              }
            },
            child: Text("Continue"),
          ),
        ],
      ),
    );
  }
}
