import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_yt/controller/firebase_services.dart';
import 'package:tiktok_yt/model/video.dart';
import 'package:tiktok_yt/view/screens/Home.dart';
import 'package:tiktok_yt/view/widgets/custom_widget.dart';
import 'package:uuid/uuid.dart';
import 'package:video_compress/video_compress.dart';

var firebaseService = FirebaseServices();

var uuid = Uuid();

class VidController {
  List<Video> videoList = [];

  _compressVideo(String videoPath) async {
    final compressedVideo = await VideoCompress.compressVideo(videoPath,
        quality: VideoQuality.LowQuality);
    return compressedVideo!.file;
  }

  Future<String> _uploadVideoToStorage(String videoID, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("videos").child(videoID);
    UploadTask uploadTask = reference.putFile(await _compressVideo(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<String> _uploadVideoThumbToStorage(String id, String videoPath) async {
    Reference reference =
        FirebaseStorage.instance.ref().child("thumbnail").child(id);
    UploadTask uploadTask = reference.putFile(await _getThumb(videoPath));
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future<File> _getThumb(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  uploadVideo(BuildContext context, String songName, String caption, String videoPath) async {
    try {
      String uid = auth.currentUser!.uid;

      DocumentSnapshot userDoc =
          await firebaseFireStore.collection("users").doc(uid).get();
      //videoID - uuid
      String id = uuid.v1();
      String videoUrl = await _uploadVideoToStorage(id, videoPath);

      String thumbnail = await _uploadVideoThumbToStorage(id, videoPath);
      //IDHAR SE
      print((userDoc.data()! as Map<String, dynamic>).toString());
      Video video = Video(
          uid: uid,
          username: (userDoc.data()! as Map<String, dynamic>)['name'],
          videoUrl: videoUrl,
          thumbnail: thumbnail,
          songName: songName,
          shareCount: 0,
          commentsCount: 0,
          likes: [],
          profilePic: (userDoc.data()! as Map<String, dynamic>)['profilePic'],
          caption: caption,
          id: id);
      await firebaseFireStore.collection("videos").doc(id).set(video.toJson());
      snackBar(context,
          "Video Uploaded Successfully\nThank You Sharing Your Content");
      nextNav( context, HomeScreen());
    } catch (e) {
      print(e);
      snackBar(context, "Error Uploading Video, ${e.toString()}");
    }
  }
}
