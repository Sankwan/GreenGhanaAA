import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:tiktok_yt/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_yt/view/screens/addcaption_screen.dart';

class addVideoScreen extends StatelessWidget {
  addVideoScreen({Key? key}) : super(key: key);
  videoPick(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Get.snackbar(
        "Video Selected",
        video.path,
        colorText: Colors.white,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => addCaption_Screen(
                  videoFile: File(video.path), videoPath: video.path)));
    } else {
      Get.snackbar(
          "Error In Selecting Video", "Please Choose A Different Video File");
    }
  }

  showDialogOpt(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              children: [
                SimpleDialogOption(
                  onPressed: () => videoPick(ImageSource.gallery, context),
                  child: Text("Gallery"),
                ),
                SimpleDialogOption(
                  onPressed: () => videoPick(ImageSource.camera, context),
                  child: Text("Camera"),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close"),
                )
              ],
            ));
  }

  floatingButtonVid(BuildContext context) {
    return FloatingActionButton.large(
      onPressed: () {
        () => videoPick(ImageSource.camera, context);
      },
      backgroundColor: Colors.green.shade300,
      child: Icon(Icons.video_camera_back_outlined),
    );
  }

  floatingButtonCam(BuildContext context) {
    return FloatingActionButton.large(
      onPressed: () {
        () => videoPick(ImageSource.gallery, context);
      },
      backgroundColor: Colors.brown,
      child: Icon(Icons.linked_camera_outlined),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () => showDialogOpt(context),
          child: Container(
            width: 190,
            height: 50,
            decoration: BoxDecoration(color: buttonColor),
            child: Center(
              child: Text(
                "Add Video",
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Wrap(
        //will break to another line on overflow
        direction: Axis.vertical, //use vertical to show  on vertical axis
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(bottom: 40),
              child: floatingButtonVid(context),), // button second

          Container(
              margin: EdgeInsets.only(bottom: 40),
              child: floatingButtonCam(context)), // button third

          // Add more buttons here
        ],
      ),
    );
  }
}
