import 'package:dr_detection/controllers/signin_signup_controller.dart';
import 'package:dr_detection/screens/universal/login_screen.dart';
import 'package:dr_detection/screens/universal/main_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:flutter_easyloading/flutter_easyloading.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  final controller = Get.put(SigninSignupController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getCurrentUserData();
  }
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Retinal Image Classification',
      initialBinding: BindingsBuilder(() {
      }),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.active){
            if(snapshot.hasData){
              return MainHomePage();
            }else if(snapshot.hasError){
              return Center(
                  child: Text('${snapshot.error}')
              );
            }
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
          return LoginScreen();
        },
      ),
      builder: EasyLoading.init(),
    );
  }
}
