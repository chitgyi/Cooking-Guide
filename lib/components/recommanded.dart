import 'package:cooking_guide/components/FoodGroup.dart';
import 'package:cooking_guide/components/home_list_item.dart';
import 'package:cooking_guide/models/foodtype.dart';
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext cxt) => FoodGroup(FoodMenu(
                              foodType: FoodType.Type8,
                              title: "Recommanded Food"))));
                },
                color: Colors.pink,
              )
            ],
          ),
          FutureBuilder(
            future: _data.getRecom(),
            builder: (BuildContext context, AsyncSnapshot<List<Post>> posts) {
              if (posts.connectionState == ConnectionState.waiting) {
                return Center(child: Text("Loading.."));
              }
              if (posts.hasData) {
                return Container(
                  height: 145,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: posts.data
                        .map((value) => FoodItem(value, 340.0))
                        .toList(),
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
