import 'dart:math';
import 'package:flutter/material.dart';

class FoodItem extends StatelessWidget {
  final String title, url;
  FoodItem({this.title, this.url});
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
              return Scaffold(
                appBar: AppBar(
                  title: Text("New"),
                ),
              );
            }));
          },
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    bottomLeft: Radius.circular(5.0)),
                child: Image.network(
                  url,
                  fit: BoxFit.fill,
                  width: 150,
                  height: 130,
                ),
              ),
              Container(
                  width: 190,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
