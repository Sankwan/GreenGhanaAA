import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_yt/constants.dart';
import 'package:tiktok_yt/controller/auth_controller.dart';
import 'package:tiktok_yt/view/screens/auth/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main()  async{
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp().then((value){
   Get.put(AuthController());

 });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Green Ghana',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(

        scaffoldBackgroundColor: backgroundColor
      ),
      home: SignUpScreen(),
    );
  }
}

