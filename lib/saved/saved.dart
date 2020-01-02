import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_guide/components/home_list_item.dart';
import 'package:cooking_guide/models/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cooking_guide/models/user.dart';

class Saved extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context);
    return SavedPost(user);
  }
}

class SavedPost extends StatefulWidget {
  final User user;
  SavedPost(this.user);

  @override
  _SavedPostState createState() => _SavedPostState();
}

class _SavedPostState extends State<SavedPost> {
  final firestore = Firestore.instance;
  List<Post> docs = [];

  @override
  void initState() {
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        getPost();
      },
      child: Container(
        child: docs.length > 0
            ? ListView.builder(
                itemCount: docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return FoodItem(
                      docs[index], MediaQuery.of(context).size.width);
                },
              )
            : Text("No Saved Posts!"),
      ),
    );
  }

  void getPost() async {
    var saves = await firestore
        .collection("saved")
        .where(widget.user.uid, isEqualTo: "true")
        .getDocuments();

    if (saves.documents.length > 0) {
      List<Post> post = [];
      saves.documents.forEach((f) async {
        var doc =
            await firestore.collection("posts").document(f.documentID).get();
        post.add(Post.fromData(doc));
        setState(() {
          docs = post;
        });
      });
      // print(post.length);
    }
  }
}
