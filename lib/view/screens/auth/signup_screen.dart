import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_yt/constants.dart';
import 'package:tiktok_yt/controller/auth_controller.dart';
import 'package:tiktok_yt/controller/firebase_services.dart';
import 'package:tiktok_yt/controller/otp_controller.dart';
import 'package:tiktok_yt/view/screens/Home.dart';
import 'package:tiktok_yt/view/screens/auth/OTP_page.dart';
import 'package:tiktok_yt/view/screens/auth/verification_page.dart';
import 'package:tiktok_yt/view/widgets/custom_widget.dart';
import 'package:tiktok_yt/view/widgets/glitch.dart';

import '../../widgets/text_input.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _numberController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  authStatus() {
    if (auth.currentUser != null) {
      nextNavRemoveHistory(context, HomeScreen());
    }
  }

  @override
  void initState() {
    authStatus();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlithEffect(
                  child: const Text(
                "Welcome To Ghana \nGreen App",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              )),
              const SizedBox(
                height: 150,
              ),

              // Select Profile Image
              // InkWell(
              //   onTap: () {
              //     AuthController.instance.pickImage();
              //   },
              //   child: Stack(
              //     children: [
              //       const CircleAvatar(
              //         backgroundImage: NetworkImage(
              //             "https://st3.depositphotos.com/1767687/16607/v/450/depositphotos_166074422-stock-illustration-default-avatar-profile-icon-grey.jpg"),
              //         radius: 60,
              //       ),
              //       Positioned(
              //           bottom: 0,
              //           right: 0,
              //           child: Container(
              //               padding: const EdgeInsets.all(5),
              //               decoration: BoxDecoration(
              //                   color: Colors.white,
              //                   borderRadius: BorderRadius.circular(50)),
              //               child: const Icon(
              //                 Icons.edit,
              //                 size: 20,
              //                 color: Colors.black,
              //               )))
              //     ],
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                    key: _formKey, child: numberFormField(_numberController)),
              ),
              const SizedBox(
                height: 70,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      logger.d(_numberController.text);
                      var numVerify = AuthControlla();
                      numVerify.phoneSignIn(
                          context, '+233${_numberController.text}');
                    }
                  },
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 10),
                      child: const Text("Sign Up")))
            ],
          ),
        ),
      ),
    );
  }
}
