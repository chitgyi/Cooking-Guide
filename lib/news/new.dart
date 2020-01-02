import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_guide/components/new_item.dart';
import 'package:cooking_guide/models/post.dart';
import 'package:flutter/material.dart';

class New extends StatelessWidget {
  const New({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("news").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Text("Loading..."),
          );
        } else if (snapshot.data.documents.length < 1) {
          return Center(
            child: Text("No Data Here!"),
          );
        }
        List<Post> posts =
            snapshot.data.documents.map((f) => Post.fromData(f)).toList();
        return ListView.builder(
          padding: EdgeInsets.all(5.0),
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return NewItem(posts[index]);
          },
        );
      },
    );
  }
}
