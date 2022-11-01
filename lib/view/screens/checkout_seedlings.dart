import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CheckoutSeedlings extends StatelessWidget {
  const CheckoutSeedlings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seedling checkout',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
    );
  }
}
