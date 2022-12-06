import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_yt/controller/firebase_services.dart';
import 'package:tiktok_yt/view/screens/comment_screen.dart';
import 'package:tiktok_yt/view/screens/planting_info.dart';
import 'package:tiktok_yt/view/screens/profile_screen.dart';
import 'package:tiktok_yt/view/screens/search_screen.dart';
import 'package:tiktok_yt/view/widgets/AlbumRotator.dart';
import 'package:tiktok_yt/view/widgets/ProfileButton.dart';
import 'package:tiktok_yt/view/widgets/TikTokVideoPlayer.dart';
import 'package:tiktok_yt/view/widgets/custom_widget.dart';
import 'package:video_player/video_player.dart';
import '../../controller/video_controller.dart';

class DisplayVideo_Screen extends StatefulWidget {
  DisplayVideo_Screen({Key? key}) : super(key: key);

  @override
  State<DisplayVideo_Screen> createState() => _DisplayVideo_ScreenState();
}

class _DisplayVideo_ScreenState extends State<DisplayVideo_Screen> {
  var firebaseService = FirebaseServices();

  // final VideoController videoController = Get.put(VideoController());
  // Future<void> share(String vidId) async {
  //   await FlutterShare.share(
  //     title: 'Download the Green Ghana App',
  //     text: 'Watch people plant seedlings on the Green Ghana Day',
  //   );
  //   // videoController.shareVideo(vidId);
  // }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Row(
            children: [
              GestureDetector(
                  onTap: (() {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: ((context) => SearchScreen())));
                  }),
                  child: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 27,
                  )),
              GestureDetector(
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => ProfileScreen(
                                uid: FirebaseAuth.instance.currentUser!.uid,
                              ))));
                }),
                child: const Padding(
                  padding: EdgeInsets.only(left: 30, right: 20),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 16,
                    child: Image(
                        image: AssetImage('assets/images/profilepic1.jpg')),
                  ),
                ),
              ),
            ],
          ),
        ],
        title: const Text(
          'Green Ghana',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: firebaseService.getVideos(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            ));
          }

          logger.d(snapshot.data!.docs.length);

          return ListView(
              padding: const EdgeInsets.all(10),
              children: snapshot.data!.docs.map((DocumentSnapshot doc) {
                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;

                final videoPlayerController = VideoPlayerController.network(
                  data['videoUrl'],
                );

                final chewieController = ChewieController(
                  aspectRatio: 16 / 9,
                  videoPlayerController: videoPlayerController,
                  autoPlay: false,
                  looping: false,
                );

                final playerWidget = Chewie(
                  controller: chewieController,
                );
                return Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(data['profilePic']),
                          ),
                          Text(data['username']),
                        ],
                      ),
                      Container(
                        height: 450,
                        width: double.infinity,
                        child: data['videoUrl'] == ''
                            ? Image(
                                image: NetworkImage(
                                  data['thumbnail'],
                                ),
                                // fit: BoxFit.fill,
                              )
                            : TikTokVideoPlayer(
                                videoUrl:
                                    data['videoUrl']),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              firebaseService.likedVideo(data['id']);
                            },
                            icon: data['likes'].contains(auth.currentUser!.uid)
                                ? Icon(Icons.favorite)
                                : Icon(FontAwesomeIcons.heart),
                            color: data['likes'].contains(auth.currentUser!.uid)
                                ? Colors.red
                                : Colors.black,
                          ),
                          IconButton(
                              onPressed: () {
                                try {
                                  showModalBottomSheet(
                                    // shape: const RoundedRectangleBorder(
                                    //     borderRadius: BorderRadius.vertical(
                                    //         top: Radius.circular(20))),
                                    // enableDrag: true,
                                    // isScrollControlled: true,
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            child: Container(height: 150,)
                                                // CommentScreen(id: data['id'])
                                                ),
                                      );
                                    },
                                  );
                                } catch (error) {
                                  logger.d(error);
                                }
                                // logger.d('Comment Btn Pressed');
                              },
                              icon: const Icon(FontAwesomeIcons.comment)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(FontAwesomeIcons.reply)),
                        ],
                      ),
                      Text('${data['likes'].length} likes'),
                      Text('${data['commentsCount']} comments'),
                    ],
                  ),
                );
              }).toList());
        },
      ),

      // Obx(() {
      //   return PageView.builder(
      //       scrollDirection: Axis.vertical,
      //       controller: PageController(initialPage: 0, viewportFraction: 1),
      //       itemCount: videoController.videoList.length,
      //       itemBuilder: (context, index) {
      //         final data = videoController.videoList[index];
      //         return InkWell(
      //           onDoubleTap: () {
      //             videoController.likedVideo(data.id);
      //           },
      //           child: Stack(
      //             children: [
      //               data.videoUrl == ''
      //                   ? Image.network(
      //                       data.thumbnail,
      //                       fit: BoxFit.fill,
      //                     )
      //                   : TikTokVideoPlayer(
      //                       videoUrl: data.videoUrl,
      //                     ),
      //               Container(
      //                 margin: const EdgeInsets.only(bottom: 10, left: 15),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.end,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Row(
      //                       children: [
      //                         const Text(
      //                           '@',
      //                           style: TextStyle(color: Colors.white),
      //                         ),
      //                         Text(
      //                           data.username,
      //                           style: const TextStyle(
      //                               fontWeight: FontWeight.w500,
      //                               fontSize: 17,
      //                               color: Colors.white),
      //                         ),
      //                       ],
      //                     ),
      //                     const SizedBox(
      //                       height: 5,
      //                     ),
      //                     Text(
      //                       data.caption,
      //                       style: const TextStyle(color: Colors.white),
      //                     ),
      //                     const SizedBox(
      //                       height: 5,
      //                     ),
      //                     Row(
      //                       children: [
      //                         const Icon(
      //                           Icons.location_pin,
      //                           color: Colors.white,
      //                           size: 15,
      //                         ),
      //                         Text(
      //                           //chnage to locationName
      //                           data.songName,
      //                           style: const TextStyle(
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.white),
      //                         ),
      //                       ],
      //                     )
      //                   ],
      //                 ),
      //               ),
      //               Positioned(
      //                 right: 0,
      //                 child: Container(
      //                   height: MediaQuery.of(context).size.height - 400,
      //                   margin: EdgeInsets.only(
      //                       top: MediaQuery.of(context).size.height / 3,
      //                       right: 10),
      //                   child: Column(
      //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                     children: [
      //                       InkWell(
      //                         onTap: () {
      //                           Navigator.push(
      //                               context,
      //                               MaterialPageRoute(
      //                                   builder: (context) => ProfileScreen(
      //                                         uid: data.uid,
      //                                       )));
      //                         },
      //                         child: ProfileButton(
      //                           profilePhotoUrl: data.profilePic,
      //                         ),
      //                       ),
      //                       InkWell(
      //                         onTap: () {
      //                           videoController.likedVideo(data.id);
      //                         },
      //                         child: Column(
      //                           children: [
      //                             Icon(
      //                               Icons.favorite,
      //                               size: 45,
      //                               color: data.likes.contains(FirebaseAuth
      //                                       .instance.currentUser!.uid)
      //                                   ? Colors.pinkAccent
      //                                   : Colors.white,
      //                             ),
      //                             Text(
      //                               data.likes.length.toString(),
      //                               style: const TextStyle(
      //                                   fontSize: 15, color: Colors.white),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                       InkWell(
      //                         onTap: () {
      //                           share(data.id);
      //                         },
      //                         child: Column(
      //                           children: [
      //                             const Icon(
      //                               Icons.reply,
      //                               size: 45,
      //                               color: Colors.white,
      //                             ),
      //                             Text(
      //                               data.shareCount.toString(),
      //                               style: const TextStyle(
      //                                   fontSize: 15, color: Colors.white),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                       InkWell(
      //                         onTap: () {
      //                           // Navigator.push(
      //                           //     context,
      //                           //     MaterialPageRoute(
      //                           //         builder: (context) =>
      //                           //             CommentScreen(id: data.id)));
      //                           showModalBottomSheet(
      //                             shape: const RoundedRectangleBorder(
      //                                 borderRadius: BorderRadius.vertical(
      //                                     top: Radius.circular(20))),
      //                             enableDrag: true,
      //                             isScrollControlled: true,
      //                             context: context,
      //                             builder: (context) {
      //                               return Padding(
      //                                 padding: EdgeInsets.only(
      //                                     top: 10,
      //                                     bottom: MediaQuery.of(context)
      //                                         .viewInsets
      //                                         .bottom),
      //                                 child: Container(
      //                                     height: MediaQuery.of(context)
      //                                             .size
      //                                             .height *
      //                                         0.5,
      //                                     child: CommentScreen(id: data.id)),
      //                               );
      //                             },
      //                           );
      //                         },
      //                         child: Column(
      //                           children: [
      //                             const Icon(
      //                               Icons.comment,
      //                               size: 45,
      //                               color: Colors.white,
      //                             ),
      //                             Text(
      //                               data.commentsCount.toString(),
      //                               style: const TextStyle(
      //                                   fontSize: 15, color: Colors.white),
      //                             ),
      //                             const SizedBox(
      //                               height: 20,
      //                             ),
      //                             // Column(
      //                             //   children: [
      //                             //     AlbumRotator(
      //                             //         profilePicUrl: data.profilePic)
      //                             //   ],
      //                             // ),
      //                           ],
      //                         ),
      //                       ),
      //                       // InkWell(
      //                       //   onTap: () {
      //                       //     Navigator.push(
      //                       //         context,
      //                       //         MaterialPageRoute(
      //                       //             builder: (context) =>const PlantingInfo()));
      //                       //   },
      //                       //   child: ProfileButton(
      //                       //     profilePhotoUrl: data.profilePic,
      //                       //   ),
      //                       // ),
      //                     ],
      //                   ),
      //                 ),
      //               )
      //             ],
      //           ),
      //         );
      //       });
      // }),
    );
  }
}
