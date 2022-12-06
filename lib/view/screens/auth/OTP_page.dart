import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tiktok_yt/constants.dart';
import 'package:tiktok_yt/controller/firebase_services.dart';
import 'package:tiktok_yt/view/screens/auth/profile_setter.dart';
import 'package:tiktok_yt/view/widgets/custom_widget.dart';

class OTP_Page extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const OTP_Page({Key? key, required this.phoneNumber, required this.verificationId,}) : super(key: key);

  @override
  State<OTP_Page> createState() => _OTP_PageState();
}

class _OTP_PageState extends State<OTP_Page> {
  var firebaseServices = FirebaseServices();
  // var pin = '';
  TextEditingController pin = TextEditingController();
  bool load = false;
  bool hasError = false;
  late String pinCode;
  onChange(value) {
    setState(() {
      pinCode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('OPT'),
        ),
        body: ListView(children: [
          const Text(
              'Enter PIN code \nsent to your number',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.18,
            ),
            opt(context, hasError, pin, onChange),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    // style: buttonStyle1,
                    onPressed: () async {
                      setState(() {
                        load = true;
                      });
                      if (pinCode.isNotEmpty) {
                        logger.d(pinCode);
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: pinCode,
                        );
                        try {
                          await auth
                              .signInWithCredential(credential)
                              .then((userCredential) {
                            if (userCredential.user != null) {
                              logger.d(userCredential.user!.uid);
                              firebaseServices.createUser(
                                  widget.phoneNumber, userCredential.user!.uid);
                              nextNavRemoveHistory(context, ProfileSetter());
                            }
                          });
                        } catch (error) {
                          pin.clear();
                          setState(() {
                            load = false;
                          });
                          logger.d(error);
                        }
                      }
                    },
                    child: Row(
                      children: [
                        const Text(
                          'Verify PIN',
                        ),
                        Visibility(
                          visible: load,
                          child: const SizedBox(
                            width: 18,
                          ),
                        ),
                        Visibility(
                          visible: load,
                          child: const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.5,
                              )),
                        )
                      ],
                    )),
              ],
            ),
        ]),
        );
  }
}
