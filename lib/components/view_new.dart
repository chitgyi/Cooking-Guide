import 'package:cooking_guide/models/post.dart';
import 'package:flutter/material.dart';

class ViewNew extends StatelessWidget {
  final Post post;
  ViewNew(this.post);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ကျန်မာရေးဆောင်းပါး",style: TextStyle(fontSize: 14),)),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                post.url,
                fit: BoxFit.fill,
              )),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              post.title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(post.body),
          )
        ],
      )),
    );
  }
}
