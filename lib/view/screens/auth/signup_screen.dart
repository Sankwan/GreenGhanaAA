import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_yt/controller/auth_controller.dart';
import 'package:tiktok_yt/view/screens/auth/OTP_page.dart';
import 'package:tiktok_yt/view/screens/auth/verification_page.dart';
import 'package:tiktok_yt/view/widgets/custom_widget.dart';
import 'package:tiktok_yt/view/widgets/glitch.dart';

import '../../widgets/text_input.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _setpasswordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 100),
          alignment: Alignment.center,
          //const - Constant - Value - String , Int  - Fix Rahega  - Use Karna
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GlithEffect(
                  child: const Text(
                "Welcome To Ghana \nGreen App", textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
              )),
              const SizedBox(
                height: 25,
              ),

              // Select Profile Image
              InkWell(
                onTap: () {
                  AuthController.instance.pickImage();
                },
                child: Stack(
                  children: [
                    const CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://st3.depositphotos.com/1767687/16607/v/450/depositphotos_166074422-stock-illustration-default-avatar-profile-icon-grey.jpg"),
                      radius: 60,
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50)),
                            child: const Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.black,
                            )))
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _numberController,
                  myLabelText: "Phone Number",
                  myIcon: Icons.phone,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 20),
              //   child: TextInputField(
              //     controller: _setpasswordController,
              //     myLabelText: "Set Password",
              //     myIcon: Icons.lock,
              //     toHide: true,
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 20),
              //   child: TextInputField(
              //     controller: _confirmpasswordController,
              //     myLabelText: "Confirm Password",
              //     myIcon: Icons.lock,
              //     toHide: true,
              //   ),
              // ),
              // const SizedBox(
              //   height: 20,
              // ),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 20),
              //   child: TextInputField(
              //     controller: _usernameController,
              //     myLabelText: "Username",
              //     myIcon: Icons.person,
              //   ),
              // ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    nextNav(context, OTP_Page(number: _numberController.text,));
                    // AuthController.instance.SignUp(
                    //     _usernameController.text,
                    //     _numberController.text,
                    //     _setpasswordController.text,
                    //     AuthController.instance.proimg);
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
