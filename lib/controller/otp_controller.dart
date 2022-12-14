import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_yt/view/screens/auth/OTP_page.dart';
import 'package:tiktok_yt/view/widgets/custom_widget.dart';

class AuthControlla {
  Future<void> phoneSignIn(BuildContext context, String phoneNumber) async {
    final auth = FirebaseAuth.instance;
    TextEditingController codeController = TextEditingController();
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          //  Automatic handling of the SMS code
          verificationCompleted: (PhoneAuthCredential credential) async {
            // !!! works only on android !!!
            await auth.signInWithCredential(credential);
          },
          // Displays a message when verification fails
          verificationFailed: (e) {
            logger.d(e.message);
            // showSnackBar(context, e.message!);
          },
          // Displays a dialog box when OTP is sent
          codeSent: ((String verificationId, int? resendToken) async {
            nextNav(
                context,
                OTP_Page(
                  verificationId: verificationId,
                  phoneNumber: phoneNumber,
                ));
          }),
          codeAutoRetrievalTimeout: (String verificationId) {
            // Auto-resolution timed out...
          },
          timeout: Duration(seconds: 120));
    } catch (error) {
      logger.d(error);
      FirebaseAuthException(code: error.toString());
    }
  }
  // }
}
