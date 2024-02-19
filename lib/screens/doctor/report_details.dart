import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportInfoScreen extends StatelessWidget {
  final int reportId;
  final String patientId;

  ReportInfoScreen({required this.reportId, required this.patientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
            onPressed: ()=> Get.back()
        ),
        backgroundColor: Colors.blue,
        title: Text('Report',
          style: TextStyle(
              color: Colors.white
          ),),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(patientId)
            .collection('reports')
            .doc('Report $reportId')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError || !snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Text('Error or Report not found'),
            );
          }

          var reportData = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'assets/Eye.PNG', // Replace with your image path
                    width: 150, // Adjust width as needed
                    height: 150, // Adjust height as needed
                    // You can add more properties to customize the image display
                  ),
                ),
                Center(
                  child: Text(
                    'DIABEDECT',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 10,),
                Divider(),
                SizedBox(height: 30,),
                Text(
                  'Doc Name: ${reportData['doctor_name']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30,),
                Text(
                  'Patient Name: ${reportData['patient_name']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30,),
                Text(
                  'Gender: ${reportData['gender']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30,),
                Text(
                  'DOB: ${reportData['dob']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30,),
                Text(
                  'Email: ${reportData['email']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30,),
                Text(
                  'Result: ${reportData['result']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
