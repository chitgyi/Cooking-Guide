import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_guide/models/foodtype.dart';
import 'package:cooking_guide/models/post.dart';

class PostData {
  Firestore _firestore = Firestore.instance;
  Future<List<Post>> getRecom() async {
    List<Post> post;
    await _firestore
        .collection("posts")
        .orderBy("body")
        .limit(8)
        .getDocuments()
        .then((onValue) {
      post = onValue.documents.map((f) => Post.fromData(f)).toList();
    });
    return post;
  }

  Future<List<Post>> getRecent() async {
    List<Post> post;
    await _firestore
        .collection("posts")
        .orderBy("date", descending: true)
        .limit(8)
        .getDocuments()
        .then((onValue) {
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

  Future<List<Post>> getByRecent() async {
    List<Post> post;
    await _firestore
        .collection("posts")
        .orderBy("date", descending: true)
        .getDocuments()
        .then((onValue) {
      post = onValue.documents.map((f) => Post.fromData(f)).toList();
    });
    return post;
  }

  Future<List<Post>> getByRecom() async {
    List<Post> post;
    await _firestore
        .collection("posts")
        .orderBy("body")
        .getDocuments()
        .then((onValue) {
      post = onValue.documents.map((f) => Post.fromData(f)).toList();
    });
    return post;
  }
}
