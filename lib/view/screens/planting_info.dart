import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:tiktok_yt/controller/fetch_apis.dart';
import 'package:tiktok_yt/model/plant_list.dart';
import 'package:tiktok_yt/view/screens/Home.dart';
import 'package:tiktok_yt/view/screens/full_plant_info.dart';
import 'package:tiktok_yt/view/widgets/custom_widget.dart';

class PlantingInfo extends StatefulWidget {
  const PlantingInfo({Key? key}) : super(key: key);

  @override
  State<PlantingInfo> createState() => _PlantingInfoState();
}

class _PlantingInfoState extends State<PlantingInfo> {
  List seedlingInfo = [];

  var dio = Dio();

  getItems() async {
    var response = await dio.get('https://fakestoreapi.com/products');
    var data = response.data;
    setState(() {
      seedlingInfo = data;
    });
    logger.d(seedlingInfo);
  }

  @override
  void initState() {
    getItems();
    // TODO: implement initState
    super.initState();
  }

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
        body:
            // Container(),
            seedlingInfo.length == 0
                ? Center(
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Column(
                    children: [
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: seedlingInfo.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            seedlingInfo[index]['image']))),
                              ),
                              title: Text(
                                seedlingInfo[index]['title'],
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                seedlingInfo[index]['description'],
                                overflow: TextOverflow.ellipsis,
                              ),
                              onTap: () {
                                nextNav(
                                  context,
                                  FullPlantingInfo(
                                    image: seedlingInfo[index]['image'],
                                    description: seedlingInfo[index]['description'],
                                    title: seedlingInfo[index]['title'],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ));
  }
}
