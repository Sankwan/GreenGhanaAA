import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_yt/controller/comment_controller.dart';
import 'package:tiktok_yt/view/widgets/text_input.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentScreen extends StatelessWidget {
  final String id;
  CommentScreen({required this.id});
  final TextEditingController _commentController = TextEditingController();

  CommentController commentController = Get.put(CommentController());

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
          Obx(() {
            return Container(
              height: MediaQuery.of(context).size.height * 0.38,
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: commentController.comments.length,
                    itemBuilder: (context, index) {
                      final comment = commentController.comments[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(comment.profilePic),
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.username,
                              style:const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.redAccent,
                              ),
                            ),
                           const SizedBox(
                              width: 5,
                            ),
                            Text(
                              comment.comment,
                              style:const TextStyle(
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
                              tago.format(comment.datePub.toDate()),
                              style:const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                           const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${comment.likes.length} Likes",
                              style:const TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        trailing: InkWell(
                            onTap: () {
                              commentController.likeComment(comment.id);
                            },
                            child: Icon(Icons.favorite,
                                color: comment.likes.contains(
                                        FirebaseAuth.instance.currentUser!.uid)
                                    ? Colors.red
                                    : Colors.white)),
                      );
                    }),
              ),
            );
          }),
         const Divider(),
          ListTile(
            title: TextInputField(
                controller: _commentController,
                myIcon: Icons.comment,
                myLabelText: "Comment"),
            trailing: TextButton(
              onPressed: () {
                commentController.postComment(_commentController.text);
                _commentController.clear();
              },
              child:const Text("Send"),
            ),
          )
        ],
      ),
    );
  }
}
