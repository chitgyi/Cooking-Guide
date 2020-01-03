import 'package:cooking_guide/components/home_list_item.dart';
import 'package:cooking_guide/models/foodtype.dart';
import 'package:cooking_guide/models/post.dart';
import 'package:cooking_guide/services/data.dart';
import 'package:flutter/material.dart';

class FoodGroup extends StatelessWidget {
  final FoodMenu menu;
  final PostData _data = PostData();
  FoodGroup(this.menu);

  _retriveData(){
    if(menu.foodType == FoodType.Type8){
      return _data.getByRecom();
    }else if(menu.foodType == FoodType.Type9){
      return _data.getByRecent();
    }
    return _data.getByType(menu);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(menu.title),
      ),
      body: Container(
        child: FutureBuilder(
          future: _retriveData(),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> posts) {
            if (posts.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            if (posts.hasData && posts.data.length > 0) {
              return Container(
                child: ListView(
                  children: posts.data
                      .map((value) =>
                          FoodItem(value, MediaQuery.of(context).size.width))
                      .toList(),
                ),
              );
            }
            return Text("no Data");
          },
        ),
      ),
    );
  }
}
