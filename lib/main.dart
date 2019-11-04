import 'package:cooking_guide/home/home.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
        appBar: AppBar(title: Text("Cooking Guide"), actions: <Widget>[IconButton(icon: Icon(Icons.search),onPressed: (){},),IconButton(icon: Icon(Icons.add_to_photos), onPressed: (){},), ],),
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          height: 60,
          color: Colors.deepPurple,
          onTap: (index)=> print(index),
          items: <Widget>[
            Icon(Icons.apps, size: 30, color: Colors.white,),
            Icon(Icons.location_on, size: 30, color: Colors.white,),
            Icon(Icons.favorite_border, size: 30,color: Colors.white,),
            Icon(Icons.list, size: 30, color: Colors.white,),
            Icon(Icons.person_pin_circle, size: 30, color: Colors.white,),
          ],
        ),
        body: Home()
      ),
    );
  }
}
