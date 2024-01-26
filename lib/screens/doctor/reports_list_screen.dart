import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_detection/Hscreen.dart';
import 'package:dr_detection/controllers/user_profile_controller.dart';
import 'package:dr_detection/screens/doctor/report_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReportsListScreen extends StatelessWidget {
  final String uid;

  const ReportsListScreen({super.key, required this.uid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
            onPressed: ()=> Get.back()
        ),
        backgroundColor: Colors.blue,
        title: Text('Select report to view',
          style: TextStyle(
              color: Colors.white
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('reports')
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
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text('No reports exist for this user'),
              );
            }

            var reports = snapshot.data!.docs;

            return ListView.builder(
              itemCount: reports.length,
              itemBuilder: (context, index) {
                var report = reports[index];
                var reportID = report['report_id'];

                return GestureDetector(
                  onTap: (){
                    Get.to(()=> ReportInfoScreen(reportId: reportID, patientId: uid));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12
                    ),
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Report $reportID',
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