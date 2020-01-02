import 'package:cooking_guide/models/post.dart';
import 'package:flutter/material.dart';

class NewItem extends StatefulWidget {
  final Post post;

  NewItem(this.post);

  @override
  _NewItemState createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  bool isShowText = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.network(
                widget.post.url,
                fit: BoxFit.fill,
              )),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              widget.post.title,
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          isShowText
              ? Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    child: Text(widget.post.body),
                    onTap: () {
                      setState(() {
                        isShowText = !isShowText;
                      });
                    },
                  ),
                )
              : Text(""),
          Container(
              alignment: Alignment.bottomRight,
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    isShowText = !isShowText;
                  });
                },
                child: Text(
                  isShowText ? "Show Less" : "Show More",
                  style: TextStyle(color: Colors.blue),
                ),
              ))
        ],
      ),
    );
  }
}
