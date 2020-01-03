import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_guide/models/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cooking_guide/models/user.dart';

class ItemView extends StatelessWidget {
  final Post post;
  User user;
  ItemView(this.post);

  Widget build(BuildContext context) {
    user = Provider.of<User>(context);
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Toolbar(
            user: user,
            post: post,
          ),
          Text(
            post.title,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          Text(
            post.body,
            textAlign: TextAlign.left,
          ),
        ],
      )),
    );
  }
}

class Toolbar extends StatefulWidget {
  final User user;
  final Post post;
  Toolbar({this.user, this.post});

  @override
  _ToolbarState createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  final firestore = Firestore.instance;
  bool isSaved = false;
  isSavedPost() async {
    DocumentSnapshot snapshot =
        await firestore.collection("saved").document(widget.post.id).get();

    if (snapshot.data != null) {
      if (snapshot.data[widget.user.uid] == "true") {
        isSaved = true;
      }
    } else {
      isSaved = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    isSavedPost();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(
          widget.post.url,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        Container(
          margin: EdgeInsets.only(top: 30.0),
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: <Widget>[
              Material(
                shape: CircleBorder(),
                color: Colors.black.withOpacity(0.3),
                child: InkWell(
                  splashColor: Colors.black,
                  borderRadius: BorderRadius.circular(25.0),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Spacer(),
              Container(
                child: Row(
                  children: <Widget>[
                    Material(
                      shape: CircleBorder(),
                      color: Colors.black.withOpacity(0.3),
                      child: InkWell(
                        splashColor: Colors.black,
                        borderRadius: BorderRadius.circular(25.0),
                        onTap: () async {
                          bool tmp = isSaved;
                          setState(() {
                            isSaved = !tmp;
                          });

                          await firestore
                              .collection("saved")
                              .document(widget.post.id)
                              .setData(
                                  {widget.user.uid: isSaved.toString()},merge: true);
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Icon(
                            
                            isSaved ? Icons.favorite : Icons.favorite_border,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   width: 5.0,
                    // ),
                    // Material(
                    //   shape: CircleBorder(),
                    //   color: Colors.black.withOpacity(0.3),
                    //   child: InkWell(
                    //     splashColor: Colors.black,
                    //     borderRadius: BorderRadius.circular(25.0),
                    //     onTap: () {
                    //       firestore.collection('feedback').add({"feedback"})
                    //     },
                    //     child: Container(
                    //       width: 50,
                    //       height: 50,
                    //       child: Icon(
                    //         Icons.feedback,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
