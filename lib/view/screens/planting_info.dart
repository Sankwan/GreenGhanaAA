import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok_yt/view/screens/Home.dart';

class PlantingInfo extends StatelessWidget {
  const PlantingInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          'How to Plant Seedlings',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
         const SizedBox(
            height: 30,
          ),
          Container(
            height: 200,
            width: 100,
            color: Colors.amber,
          ),
         const SizedBox(
            height: 30,
          ),
          Container(
            height: 200,
            width: 100,
            color: Colors.red,
          ),
         const SizedBox(
            height: 30,
          ),
          Container(
            height: 200,
            width: 100,
            color: Colors.green,
          ),
         const SizedBox(
            height: 30,
          ),
          Container(
            height: 200,
            width: 100,
            color: Colors.blue,
          ),
        ],
      ),
    );
  }
}
