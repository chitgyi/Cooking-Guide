import 'package:cooking_guide/models/drager_drawn.dart';
import 'package:flutter/material.dart';

class Guide extends StatefulWidget {
  @override
  _GuideState createState() => _GuideState();
}

class _GuideState extends State<Guide> {
  List<String> result = data;
  var search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          TextField(
            onChanged: (str) {
              var tmp = data.where((v) => v.contains(str)).toList();
              setState(() {
                result = tmp;
              });
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(15),
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: result.length,
                itemBuilder: (BuildContext cxt, int index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[Item(result[index]), Divider()],
                    )),
          ),
        ],
      ),
    );
  }
}

class Item extends StatelessWidget {
  final String text;
  Item(this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Text(text),
    );
  }
}
