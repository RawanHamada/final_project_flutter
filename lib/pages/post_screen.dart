import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialchat/pages/home.dart';
import 'package:socialchat/widgets/header.dart';
// import 'package:socialchat/widgets/posts.dart';
import 'package:socialchat/widgets/progress.dart';

class PostScreen extends StatelessWidget {
  final String postId;
  final String userId;


  PostScreen({required this.postId, required this.userId});
  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder(
      future: postsRef
          .doc(userId)
          .collection("usersPosts")
          .doc(postId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        if (snapshot.data != null) {
          // Post post = Post.fromDocument(snapshot.data);
          return Scaffold(
            // appBar: header(context, titleText: post.description),
            body: ListView(
              children: <Widget>[
                Container(
                  // child: post,
                )
              ],
            ),
          );
        } else {
          return Text("");
        }
      },
    );
  }
}
