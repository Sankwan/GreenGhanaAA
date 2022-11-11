import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

nextNav(BuildContext context, intent) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: ((context) => intent),
    ),
  );
}

styleButton() {
  return ButtonStyle(
      minimumSize: MaterialStateProperty.all(
        const Size(10, 30),
      ),
      backgroundColor: MaterialStateProperty.all(Colors.green));
}

var logger = Logger();
