import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_guide/home/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.deepPurpleAccent),
      home: Scaffold(
          appBar: AppBar(
            title: Text("Cooking Guide"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.add_to_photos),
                onPressed: () {},
              ),
            ],
          ),
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor: Colors.transparent,
            height: 60,
            color: Colors.deepPurple,
            onTap: (index) => {
              // Firestore.instance
              //     .collection("users")
              //     .getDocuments()
              //     .then((snap) => {
              //      print(snap.documents[1].data)
              //     })
              // FacebookLogin().logIn(['email', 'public_profile']).then((onValue){
              //   AuthCredential credential = FacebookAuthProvider.getCredential(accessToken: onValue.accessToken.token);
              //   FirebaseAuth.instance.signInWithCredential(credential).then((onValue){
              //     print(onValue.user.displayName);
              //   });
              // })
            },
            items: <Widget>[
              Icon(
                Icons.apps,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.location_on,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.favorite_border,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.list,
                size: 30,
                color: Colors.white,
              ),
              Icon(
                Icons.person_pin_circle,
                size: 30,
                color: Colors.white,
              ),
            ],
          ),
          body: Home()),
    );
  }
}
