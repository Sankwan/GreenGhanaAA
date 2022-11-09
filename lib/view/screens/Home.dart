import 'package:flutter/material.dart';
import 'package:tiktok_yt/constants.dart';
import 'package:tiktok_yt/view/widgets/customAddIcon.dart';

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
                Icons.home,
                size: 25,
              ),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.nature, size: 25), label: 'Requests'),
          BottomNavigationBarItem(icon: Icon(Icons.camera, size: 25,) , label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.map, size: 25), label: 'Map'),
          BottomNavigationBarItem(
              icon: Icon(Icons.check, size: 25), label: 'Progress'),
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
