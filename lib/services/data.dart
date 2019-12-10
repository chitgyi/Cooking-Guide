import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_guide/models/post.dart';

class PostData {
  Firestore _firestore = Firestore.instance;
  Future<List<Post>> getRecom() async {
    List<Post> post;
    await _firestore.collection("posts").getDocuments().then((onValue) {
      post = onValue.documents.map((f)=> Post.fromData(f)).toList();
    });
    return post;
  }

  Future<List<Post>> getRecent() {
    _firestore.collection("posts").getDocuments().then((onValue) {
      return onValue.documents.map((value) => Post.fromData(value)).toList();
    });
    return null;
  }
}
