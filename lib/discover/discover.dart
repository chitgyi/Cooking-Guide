import 'package:cooking_guide/models/vegetables.dart';
import 'package:flutter/material.dart';

class Discover extends StatelessWidget {
  const Discover({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ListView.builder(
      itemCount: vegetables.length,
      itemBuilder: (context, index) {
        return _vegetableItem(index);
      },
    ));
  }
// https://img.icons8.com/wired/100/000000/ingredients.png
// https://i.ibb.co/1nzK4V6/harvest.png
  _vegetableItem(int index) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Image.network(
              vegetables[index]['url'],
              width: 100,
              height: 100,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Text(
                  "${vegetables[index]['title']}\n${vegetables[index]['calories']}"),
            )
          ],
        ),
      ),
    );
  }
}
