import 'package:flutter/material.dart';
import 'package:tiktok_yt/constants.dart';
import 'package:tiktok_yt/view/widgets/customAddIcon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 12,
        unselectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        backgroundColor: pageIdx == 0? Colors.black : Colors.white,
        onTap: (index) {
          setState(() {
            pageIdx = index;
          });
        },
        currentIndex: pageIdx,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.dashboard_rounded,
                size: 20,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.seedling, size: 20), label: 'Requests'),
          BottomNavigationBarItem(icon: Icon(Icons.camera, size: 27,) , label: ''),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.mapPin, size: 20), label: 'Map'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.chartSimple, size: 20), label: 'Progress'),
        ],
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        unselectedLabelStyle: TextStyle(color: Colors.brown),
      ),
      body: Center(
        child: pageindex[pageIdx],
      ),
    );
  }
}
