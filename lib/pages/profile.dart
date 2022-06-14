import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialchat/models/user.dart';
import 'package:socialchat/pages/edit_profile.dart';

import 'package:socialchat/pages/home.dart';
import 'package:socialchat/widgets/header.dart';
import 'package:socialchat/widgets/progress.dart';
// import 'package:socialchat/widgets/posts.dart';
import 'package:socialchat/widgets/progress.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Profile extends StatefulWidget {
  final String? profileId;
  Profile({this.profileId});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final String currentUserId = currentUser?.id;
  String postView = "grid";
  bool isLoading = false;
  int postCount = 0;
  // List<Post> posts = [];

  BuildCount(String name, String count) {
    return Column(
      children: <Widget>[
        new Text(
          count,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        new Text(
          name,
          style: TextStyle(fontSize: 16.0, color: Colors.grey),
        ),
      ],
    );
  }

  editProfileButton() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditProfile(currentUserId: currentUserId,);
    }));
  }

  BuildButton() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: FlatButton(
          onPressed: () {
            editProfileButton();
          },
          child: Container(
            width: 250.0,
            height: 30.0,
            alignment: Alignment.center,
            child: Text(
              "Edit Profile",
              style: TextStyle(color: Colors.white),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20.0)),
          )),
    );
  }

  BuildProfileHeader() async{
    DocumentSnapshot<dynamic> documentSnapshot = await usersRef.doc(id).get();
    return FutureBuilder(
        future: usersRef.doc(widget.profileId).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData ||
          snapshot.data == null ||
              snapshot.hasError) {
            return circularProgress();
          }
          User user = User.fromDocument(snapshot.data);
          return Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          CachedNetworkImageProvider(user.photoUrl),
                      radius: 40.0,
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                BuildCount("Posts", postCount.toString()),
                                BuildCount("Followers", "0"),
                                BuildCount("Following", "0"),
                              ],
                            ),
                            BuildButton(),
                          ],
                        ))
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    user.displayName,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    user.username,
                    style: TextStyle(color: Colors.grey, fontSize: 18.0),
                  ),
                )
              ],
            ),
          );
        });
  }

  getProfilePost() async {
    setState(() {
      isLoading = true;
    });
    // QuerySnapshot snapshot = await postsRef
    //     .document(widget.profileId)
    //     .collection("usersPosts")
    //     .orderBy("timestamp", descending: true)
    //     .getDocuments();
    setState(() {
      isLoading = false;
      // postCount = snapshot.documents.length;
      // posts = snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    });
  }

  BuildToggleViewPost() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconButton(
            icon: Icon(
              Icons.grid_on,
              color: postView == "grid"
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
            onPressed: () {
              setBuildTogglePost("grid");
            }),
        IconButton(
            icon: Icon(
              Icons.list,
              color: postView == "list"
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
            onPressed: () {
              setBuildTogglePost("list");
            }),
      ],
    );
  }

  setBuildTogglePost(String view) {
    setState(() {
      postView = view;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: header(context, titleText: "Profile"),
        body: ListView(
          children: <Widget>[
            BuildProfileHeader(),
            Divider(
              height: 2.0,
            ),
            BuildToggleViewPost(),
            Divider(
              height: 2.0,
            ),
          ],
        ));
  }
}
