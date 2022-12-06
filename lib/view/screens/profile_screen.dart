import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';
import 'package:tiktok_yt/controller/auth_controller.dart';
import 'package:tiktok_yt/controller/firebase_services.dart';
import 'package:tiktok_yt/controller/profile_controller.dart';
import 'package:tiktok_yt/view/screens/Home.dart';
import 'package:tiktok_yt/view/screens/auth/signout_screen.dart';
import 'package:tiktok_yt/view/screens/display_screen.dart';
import 'package:tiktok_yt/view/screens/uservideos_screen.dart';
import 'package:tiktok_yt/view/widgets/customAddIcon.dart';
import 'package:tiktok_yt/view/widgets/custom_widget.dart';

class ProfileScreen extends StatefulWidget {
  String uid;
  ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseServices profileController = FirebaseServices();
  // Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getVideos() async {
  //   var vidz = await FirebaseFirestore.instance
  //       .collection("videos")
  //       .where("uid", isEqualTo: authController.user.uid)
  //       .get();
  //   return vidz.docs;
  // }

  @override
  void initState() {
    // getVideos();
    // TODO: implement initState
    super.initState();

    // profileController.updateUseId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    var _straemList = [
      profileController.userData(widget.uid),
      profileController.follower(widget.uid),
      profileController.followering(widget.uid)
    ];
    return StreamBuilder(
      stream: profileController.userData(widget.uid),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: SizedBox(
                height: 50,
                width: 50,
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              ),
            ),
          );
        }

        if (snapshot.data == null) {
          logger.d('Null User');
        }
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey.shade50,
              foregroundColor: Colors.black,
              elevation: 0,
              title: Text(
                '@${snapshot.data!["name"]}',
                style: TextStyle(fontSize: 17),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignoutScreen()));
                    },
                    icon: Icon(Icons.more_vert)),
                // IconButton(
                //   onPressed: () {
                //     Get.snackbar("Green Ghana App", "Current Version 1.0",
                //         colorText: Colors.white,
                //         dismissDirection: DismissDirection.endToStart,
                //         backgroundColor: Colors.grey);
                //   },
                //   icon: Icon(Icons.info_outline_rounded),
                // ),
              ],
            ),
            body: SingleChildScrollView(
                    child: SafeArea(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!['profilePic'],
                                  fit: BoxFit.contain,
                                  height: 100,
                                  width: 100,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //  Followers, Likes and Following
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!['followers'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Followers",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!['following'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Following",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data!['likes'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Likes",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400))
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 35,
                          ),

                          //  Signout Button
                          InkWell(
                            onTap: () {
                              if (widget.uid ==
                                  FirebaseAuth.instance.currentUser!.uid) {
                                profileController.logout();
                              } else {
                                profileController.followUser(widget.uid);
                              }
                            },
                            child: Container(
                              width: 150,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  border: Border.all(
                                      color: Colors.green, width: 0.6),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                widget.uid ==
                                        FirebaseAuth.instance.currentUser!.uid
                                    ? "Sign Out"
                                    : snapshot.data!['isFollowing']
                                        ? "Following"
                                        : "Follow",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Divider(
                            indent: 30,
                            endIndent: 30,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 50,
                          ),

                          //  Videos
                          FutureBuilder<List<QueryDocumentSnapshot>>(
                            future: profileController.getVideos(),
                            builder: (context,
                                AsyncSnapshot<List<QueryDocumentSnapshot>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (snapshot.hasError) {
                                logger.d(snapshot.error);
                              }
                              logger.d(snapshot.data!.toList());
                              return GridView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          childAspectRatio: 1,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 5),
                                  itemCount:5,
                                      // snapshot.data!['thumbnails'].length,
                                  itemBuilder: (context, index) {
                                    String thumbnail =
                                        snapshot.data![index]['thumbnail'];
                                    String vidUrl =
                                        snapshot.data![index]['videoUrl'];
                                    return GestureDetector(
                                      onTap: () {
                                        nextNav(
                                          context,
                                          UservideosScreen(
                                            vidUrl: vidUrl,
                                            idx: index,
                                          ),
                                        );
                                      },
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: thumbnail,
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    );
                                  });
                            },
                          )
                        ],
                      ),
                    ),
                  ));
      },
    );
  }
}
