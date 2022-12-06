import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_yt/controller/firebase_services.dart';
import 'package:tiktok_yt/controller/vid_controller.dart';
import 'package:tiktok_yt/view/screens/comment_screen.dart';
import 'package:tiktok_yt/view/screens/profile_screen.dart';
import 'package:tiktok_yt/view/widgets/ProfileButton.dart';
import 'package:tiktok_yt/view/widgets/TikTokVideoPlayer.dart';
import '../../controller/video_controller.dart';
import 'package:flutter_share/flutter_share.dart';

class UservideosScreen extends StatefulWidget {
  final String vidUrl;
  int idx;
  UservideosScreen({Key? key, required this.vidUrl, required this.idx}) : super(key: key);

  @override
  State<UservideosScreen> createState() => _UservideosScreenState();
}

class _UservideosScreenState extends State<UservideosScreen> {
  final FirebaseServices videoController = FirebaseServices();

  Future<void> share(String vidId) async {
    await FlutterShare.share(
      title: 'Download the Green Ghana App',
      text: 'Watch people plant seedlings on the Green Ghana Day',
    );
    videoController.shareVideo(vidId);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: PageController(initialPage: 0, viewportFraction: 1),
        itemCount: videoController.getVideos(),
        itemBuilder: (context, index) {
          final data = videoController.getVideos()[widget.idx];
          return InkWell(
            onDoubleTap: () {
              videoController.likedVideo(data.id);
            },
            child: Stack(children: [
              TikTokVideoPlayer(
                videoUrl: widget.vidUrl,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10, left: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          '@',
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          data.username,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      data.caption,
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          color: Colors.white,
                          size: 15,
                        ),
                        Text(
                          //chnage to locationName
                          data.songName,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height - 400,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 3, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                        uid: data.uid,
                                      )));
                        },
                        child: ProfileButton(
                          profilePhotoUrl: data.profilePic,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          videoController.likedVideo(data.id);
                        },
                        child: Column(
                          children: [
                            Icon(
                              Icons.favorite,
                              size: 45,
                              color: data.likes.contains(
                                      FirebaseAuth.instance.currentUser!.uid)
                                  ? Colors.pinkAccent
                                  : Colors.white,
                            ),
                            Text(
                              data.likes.length.toString(),
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          share(data.id);
                        },
                        child: Column(
                          children: [
                            const Icon(
                              Icons.reply,
                              size: 45,
                              color: Colors.white,
                            ),
                            Text(
                              data.shareCount.toString(),
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) =>
                          //             CommentScreen(id: data.id)));
                          showModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))),
                            enableDrag: true,
                            isScrollControlled: true,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: EdgeInsets.only(
                                    top: 10,
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
                                child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: CommentScreen(id: data.id)),
                              );
                            },
                          );
                        },
                        child: Column(
                          children: [
                            const Icon(
                              Icons.comment,
                              size: 45,
                              color: Colors.white,
                            ),
                            Text(
                              data.commentsCount.toString(),
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Column(
                            //   children: [
                            //     AlbumRotator(
                            //         profilePicUrl: data.profilePic)
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>const PlantingInfo()));
                      //   },
                      //   child: ProfileButton(
                      //     profilePhotoUrl: data.profilePic,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              )
            ]),
          );
        },
      ),
    );
  }
}
