import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cooking_guide/components/home_list_item.dart';
import 'package:flutter/material.dart';

class HomeList extends StatefulWidget {
  const HomeList({Key key}) : super(key: key);

  @override
  _HomeListState createState() => _HomeListState();
}

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class _HomeListState extends State<HomeList> {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.only(bottom: 10.0), children: <Widget>[
      CarouselSlider(
        height: 200.0,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlay: true,
        viewportFraction: 0.8,
        items: imgList.map(
          (url) {
            return Container(
              margin: EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                  width: 1000.0,
                ),
              ),
            );
          },
        ).toList(),
      ),
      // SizedBox(
      //   height: 20,
      // ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Text("Categories",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      Container(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: imgList
              .map((url) => _listItem(
                  title: "ကြက်သားကြော်နည်းနှင့် မုန့်မျိုးစုံ", url: url))
              .toList(),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
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
      ),
      Container(
        height: 130,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: imgList
              .map((url) => FoodItem(
                  title:
                      "ကြက်သားကြော်နည်းနှင့် မုန့်မျိုးစုံ၊ ၀က်သားကြော်နည်းနှင့် အကင်များ",
                  url: url))
              .toList(),
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        child: Row(
          children: <Widget>[
            Text(
              "Recent Posts",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Spacer(),
            RaisedButton(
              child: Text(
                "More",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {},
              color: Colors.indigo,
            )
          ],
        ),
      ),
      Container(
        height: 130,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: imgList
              .map((url) => FoodItem(
                  title:
                      "ကြက်သားကြော်နည်းနှင့် မုန့်မျိုးစုံ၊ ၀က်သားကြော်နည်းနှင့် အကင်များ",
                  url: url))
              .toList(),
        ),
      ),
    ]);
  }

  Widget _listItem({title, url}) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.accents[Random().nextInt(8)]),
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
