import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String id, url, title, body;
  Post({this.id, this.url, this.title, this.body});

  Post.fromData(DocumentSnapshot value)
      : id = value.documentID,
        url = value.data['url'],
        title = value.data['postTitle'],
        body = value.data['postBody'];
}
