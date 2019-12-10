import 'package:cooking_guide/models/post.dart';
import 'package:flutter/material.dart';

class ItemView extends StatelessWidget {
  final Post post;
  
  ItemView(this.post);
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Toolbar(
            postId: "123",
            url: post.url,
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

class Toolbar extends StatelessWidget {
  final String url, postId;
  Toolbar({this.url, this.postId});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.network(
          url,
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
                        onTap: () {},
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Material(
                      shape: CircleBorder(),
                      color: Colors.black.withOpacity(0.3),
                      child: InkWell(
                        splashColor: Colors.black,
                        borderRadius: BorderRadius.circular(25.0),
                        onTap: () {},
                        child: Container(
                          width: 50,
                          height: 50,
                          child: Icon(
                            Icons.feedback,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
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
