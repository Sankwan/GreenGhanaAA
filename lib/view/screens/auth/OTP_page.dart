import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTP_Page extends StatefulWidget {
  final String number;
  const OTP_Page({Key? key, required this.number}) : super(key: key);

  @override
  State<OTP_Page> createState() => _OTP_PageState();
}

class _OTP_PageState extends State<OTP_Page> {
  var pin = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('OPT'),
        ),
        body: Center(
          child: PinCodeTextField(
            appContext: context,
            length: 6,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 50,
              fieldWidth: 40,
              activeFillColor: Colors.white,
            ),
            onChanged: (value) {
              print(value);
              setState(() {
                pin = value;
              });
            },
          ),
        ));
  }
}
