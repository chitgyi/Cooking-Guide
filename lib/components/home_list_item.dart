import 'dart:math';
import 'package:cooking_guide/components/view_item.dart';
import 'package:cooking_guide/models/post.dart';
import 'package:flutter/material.dart';

class FoodItem extends StatelessWidget {
  final Post post;
  final double width;
  FoodItem(this.post, this.width);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 145,
      width: this.width,
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.primaries[Random().nextInt(8)],
        child: InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ItemView(post);
            }));
          },
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0)),
                child: Image.network(
                  post.url,
                  fit: BoxFit.fill,
                  width: this.width - (this.width * 0.6),
                  height: 145,
                ),
              ),
              Container(
                  width: this.width * 0.6 - 10.0,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${post.title}\n${post.body}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
