import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dr_detection/controllers/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorListScreen extends StatefulWidget {
  @override
  _DoctorListScreenState createState() => _DoctorListScreenState();
}

class _DoctorListScreenState extends State<DoctorListScreen> {
  String selectedDoctor = '';
  final controller = Get.put(UserController());

  Future<void> showSelectionDialog(BuildContext context, String doctorUid) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Doctor'),
          content: Text('Are you sure you want to select this doctor?'),
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
                await controller.addPatientToDoctor(doctorUid);
                Navigator.of(context).pop(); // Close the dialog after selection
              },
              child: Text('Select'),
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
        title: const Text('Find a Doctor',
            style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('isDoc', isEqualTo: true)
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

            var doctors = snapshot.data!.docs;

            return Expanded(
              child: ListView.builder(
                itemCount: doctors.length,
                itemBuilder: (context, index) {
                  var doctor = doctors[index];
                  var doctorName = '${doctor['first_name']} ${doctor['last_name']}';
                  var speciality = doctor['speciality'];
                  String uid = doctor['uid'];
                  var isDoctorSelected = selectedDoctor == doctorName;

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorName,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Speciality: $speciality'),
                        ],
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