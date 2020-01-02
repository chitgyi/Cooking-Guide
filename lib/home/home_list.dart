import 'package:carousel_slider/carousel_slider.dart';
import 'package:cooking_guide/components/recent.dart';
import 'package:cooking_guide/components/recommanded.dart';
import 'package:cooking_guide/components/view_new.dart';
import 'package:cooking_guide/home/catego_list.dart';
import 'package:cooking_guide/models/foodtype.dart';
import 'package:cooking_guide/models/post.dart';
import 'package:cooking_guide/services/data.dart';
import 'package:flutter/material.dart';

class HomeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: EdgeInsets.only(bottom: 10.0), children: <Widget>[
      FutureBuilder(
          future: PostData().getNews(),
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return CarouselSlider(
                height: 200.0,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlay: true,
                viewportFraction: 0.8,
                items: snapshot.data.map(
                  (news) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Stack(
                        children: <Widget>[
                          Ink(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    image: NetworkImage(news.url, scale: 2),
                                    fit: BoxFit.cover)),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(5.0),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (cxt) => ViewNew(news)));
                              },
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            alignment: Alignment.bottomLeft,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      bottomRight: Radius.circular(10.0))),
                              padding: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                news.title,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ).toList(),
              );
            }
            return Text("Loading...");
          }),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
        child: Text("Categories",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      ),
      Container(
        height: 50,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: foodMenu.map((menu) => CategoryItem(menu)).toList()),
      ),
      SizedBox(
        height: 5.0,
      ),
      Recommded(),
      Recent()
    ]);
  }
}
