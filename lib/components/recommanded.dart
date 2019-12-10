import 'package:cooking_guide/components/home_list_item.dart';
import 'package:cooking_guide/models/post.dart';
import 'package:cooking_guide/services/data.dart';
import 'package:flutter/material.dart';

class Recommded extends StatelessWidget {
  final PostData _data = PostData();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                "Recommanded For You",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Spacer(),
              RaisedButton(
                child: Text(
                  "More",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
                color: Colors.pink,
              )
            ],
          ),
          FutureBuilder(
            future: _data.getRecom(),
            builder: (BuildContext context, AsyncSnapshot<List<Post>> posts) {
              if (posts.connectionState == ConnectionState.waiting) {
                return Text("Waiting");
              }
              if (posts.hasData) {
                return Container(
                  height: 130,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                        posts.data.map((value) => FoodItem(value)).toList(),
                  ),
                );
              } else {
                return Text("no Data");
              }
            },
          )
        ],
      ),
    );
  }
}
