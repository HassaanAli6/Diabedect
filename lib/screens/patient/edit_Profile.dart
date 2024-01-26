import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_detection/Hscreen.dart';
import 'package:dr_detection/controllers/signin_signup_controller.dart';
import 'package:dr_detection/widgets/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dr_detection/controllers/user_profile_controller.dart';

class editprofilescreen extends StatefulWidget {
  @override
  State<editprofilescreen> createState() => _editprofilescreenState();
}

class _editprofilescreenState extends State<editprofilescreen> {


  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dobController = TextEditingController();

  final userProfileController = Get.put(UserController());
  final controller = Get.put(SigninSignupController());
  String gender = 'Male';




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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
              'Edit Patient Profile',
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            buildShadowedTextField(
              controller: firstNameController,
              hintText: 'Enter your first name',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16.0),
            buildShadowedTextField(
              controller: lastNameController,
              hintText: 'Enter your last name',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 16.0),
            buildShadowedTextField(
              controller: emailAddressController,
              hintText: 'Enter your email address',
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField(
                    value: 'Male', // Default value
                    onChanged: (value) {
                      gender = value!;
                    },
                    items: ['Male', 'Female', 'Other'].map<DropdownMenuItem<String>>(
                          (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      },
                    ).toList(),
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: buildShadowedTextField(
                    controller: dobController,
                    hintText: 'DOB',
                    keyboardType: TextInputType.text,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: ()async{
                  if(firstNameController.text.isNotEmpty && lastNameController.text.isNotEmpty && dobController.text.isNotEmpty
                      && emailAddressController.text.isNotEmpty && gender!=null){

                    controller.firstName = firstNameController.text;
                    controller.lastName = lastNameController.text;
                    controller.emailAddress = emailAddressController.text;
                    controller.gender = gender;
                    controller.dob = dobController.text;
                    showProgressDialog(context, "Saving data");
                    await controller.editProfileData(
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        emailAddress: emailAddressController.text,
                        dob: dobController.text,
                        gender: gender
                    );
                  }else{
                    Get.snackbar("Empty fields", "Enter all fields", backgroundColor: Colors.white);
                  }

                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text(
                  'Save',
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

  Widget buildShadowedTextField({
    required TextEditingController controller,
    required String hintText,
    required TextInputType keyboardType,
    bool isPassword = false,
    onChanged(val)?
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        obscureText: isPassword,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}