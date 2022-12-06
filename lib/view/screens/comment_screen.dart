import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_yt/controller/comment_controller.dart';
import 'package:tiktok_yt/controller/firebase_services.dart';
import 'package:tiktok_yt/view/widgets/text_input.dart';
// import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({required this.id});
  final TextEditingController _commentController = TextEditingController();

  FirebaseServices commentController = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    commentController.updatePostID(id);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          StreamBuilder(
            stream: commentController.getComment(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: Colors.green,
                    ),
                  ),
                );
              }

              if (snapshot.data == null) {
                throw Exception('Null Data');
              }

              return SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.38,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final comment = snapshot.data!.docs[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(comment['profilePic']),
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment['username'],
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.redAccent,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                comment['comment'],
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              )
                            ],
                          ),
                          subtitle: Row(
                            children: [
                              Text(
                                tago.format(comment['datePub'].toDate()),
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${comment['likes'].length} Likes",
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          trailing: InkWell(
                              onTap: () {
                                commentController.likeComment(comment.id);
                              },
                              child: Icon(Icons.favorite,
                                  color: comment['likes'].contains(FirebaseAuth
                                          .instance.currentUser!.uid)
                                      ? Colors.red
                                      : Colors.grey.shade300)),
                        );
                      }),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: TextInputField(
                controller: _commentController,
                myIcon: Icons.comment,
                myLabelText: "Comment"),
            trailing: TextButton(
              onPressed: () {
                commentController.postComment(context, _commentController.text);
                _commentController.clear();
              },
              child: const Text("Send"),
            ),
          )
        ],
      ),
    );
  }
}
