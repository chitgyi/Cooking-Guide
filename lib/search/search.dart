import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_guide/components/home_list_item.dart';
import 'package:cooking_guide/models/post.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final _searchController = TextEditingController();
  final _firestore = Firestore.instance;
  List<Post> posts = [];
  search() async {
    List<Post> post = [];
    var docs = await _firestore
        .collection("posts")
        .orderBy("title")
        .startAt([_searchController.text]).endAt(
            [_searchController.text + '\uf8ff']).getDocuments();
    post = docs.documents.map((f) => Post.fromData(f)).toList();
    setState(() {
      posts = post;
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            onChanged: (str) {
              if (str.isNotEmpty) {
                search();
              }
            },
            autofocus: true,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: this.posts.length > 0
            ? ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return FoodItem(posts[index], width);
                },
              )
            : Center(child: Text("Not Found!")));
  }
}
