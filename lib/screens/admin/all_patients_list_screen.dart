import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_detection/controllers/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllPatientsListScreen extends StatefulWidget {
  @override
  _AllPatientsListScreenState createState() => _AllPatientsListScreenState();
}

class _AllPatientsListScreenState extends State<AllPatientsListScreen> {
  final controller = Get.put(UserController());

  Future<void> showSelectionDialog(BuildContext context, String uid) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Patient'),
          content: Text('Are you sure you want to delete this patient?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Perform the selection logic here
                // You can add your logic to handle the selection action
                await controller.deleteUserAndDocument(uid);
                Navigator.of(context).pop(); // Close the dialog after selection
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
            onPressed: ()=> Get.back()
        ),
        backgroundColor: Colors.blue,
        title: const Text('Patients',
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('isDoc', isEqualTo: false)
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

            var patients = snapshot.data!.docs;

            return Expanded(
              child: ListView.builder(
                itemCount: patients.length,
                itemBuilder: (context, index) {
                  var patient = patients[index];
                  var patientName = '${patient['first_name']} ${patient['last_name']}';
                  String uid = patient['uid'];

                  return GestureDetector(
                    onTap: (){
                      showSelectionDialog(context, uid);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.black12
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
              ),
            );
          },
        ),
      ),
    );
  }
}