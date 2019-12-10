import 'dart:math';
import 'package:cooking_guide/components/view_itme.dart';
import 'package:cooking_guide/models/post.dart';
import 'package:flutter/material.dart';

class FoodItem extends StatelessWidget {
  final Post post;
  FoodItem(this.post);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: 340,
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      child: Material(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.primaries[Random().nextInt(8)],
        child: InkWell(
          onTap: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) {
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
                  width: 150,
                  height: 130,
                ),
              ),
              Container(
                  width: 190,
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        post.title,
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
