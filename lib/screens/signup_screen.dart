import 'package:dr_detection/controllers/signin_signup_controller.dart';
import 'package:dr_detection/widgets/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);


  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final controller = Get.put(SigninSignupController());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/Eye.PNG', // Replace with your image path
              width: 150, // Adjust width as needed
              height: 150, // Adjust height as needed
              // You can add more properties to customize the image display
            ),
            Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            buildTextField(
              hintText: "Enter your email",
              controller: emailController,
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16.0),
            buildTextField(
              hintText: "Enter password",
              controller: passwordController,
              keyboardType: TextInputType.text,
              isPassword: true,
            ),
            SizedBox(height: 16.0),
            buildTextField(
              hintText: "Confirm password",
              controller: confirmPasswordController,
              keyboardType: TextInputType.text,
              isPassword: true,
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()async{

                  if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty){
                    if(passwordController.text == confirmPasswordController.text){
                      showProgressDialog(context, 'Signing up');
                      await controller.signupUserWithEmailAndPassword(
                          emailController.text,
                          passwordController.text, confirmPasswordController.text
                      );
                    }else{
                      Get.snackbar('Error', 'Password does not match', backgroundColor: Colors.white);
                    }
                  }else{
                    Get.snackbar('Empty fields', 'Please enter all fields', backgroundColor: Colors.white);
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
