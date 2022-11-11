import 'package:flutter/material.dart';
import 'package:tiktok_yt/model/plant_list.dart';
import 'package:tiktok_yt/view/screens/Home.dart';

class PlantingInfo extends StatelessWidget {
  const PlantingInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'How to Plant Seedlings',
          style: TextStyle(fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 0.75),
                  itemBuilder: ((context, index) => const ItemCard())))
        ],
      ),
    );
  }
}
