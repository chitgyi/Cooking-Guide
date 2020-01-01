import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_guide/models/foodtype.dart';
import 'package:cooking_guide/models/post.dart';
import 'package:cooking_guide/models/user.dart';

class PostData {
  Firestore _firestore = Firestore.instance;
  Future<List<Post>> getRecom() async {
    List<Post> post;
    await _firestore.collection("posts").getDocuments().then((onValue) {
      post = onValue.documents.map((f) => Post.fromData(f)).toList();
    });
    return post;
  }

  Future<List<Post>> getRecent() async {
    List<Post> post;
    await _firestore.collection("posts").getDocuments().then((onValue) {
      post = onValue.documents.map((f) => Post.fromData(f)).toList();
    });
    return post;
  }

  Future<List<Post>> getNews() async {
    List<Post> post;
    await _firestore.collection("news").limit(5).getDocuments().then((onValue) {
      post = onValue.documents.map((f) => Post.fromData(f)).toList();
    });
    return post;
  }

  Future<List<Post>> getByType(FoodMenu menu) async {
    List<Post> post;
    await _firestore
        .collection("posts")
        .where("foodType", isEqualTo: menu.foodType.toString())
        .getDocuments()
        .then((onValue) {
      post = onValue.documents.map((f) => Post.fromData(f)).toList();
    });
    return post;
  }

  Future<DocumentSnapshot> getSaved(User user) async {
    var docs = await _firestore
        .collection("saved")
        .where(user.uid, isEqualTo: "true")
        .getDocuments();

    for (int i = 0; i < docs.documents.length; i++) {
      _firestore
          .collection("posts")
          .document(docs.documents[i].documentID)
          .snapshots();
    }
  }
}
