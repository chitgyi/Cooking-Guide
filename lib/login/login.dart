import 'package:cooking_guide/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Login extends StatelessWidget {
  const Login({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[100],
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text(
                "Login With Email",
              ),
              onPressed: () async {
                await AuthService().signInWithEmail(
                    email: "chitye@gmail.com", password: "chitgyi98");
              },
            ),
            Material(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(25),
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                child: Container(
                  width: 50,
                  height: 50,
                  child: Icon(
                    FontAwesomeIcons.facebookF,
                    color: Colors.white,
                  ),
                ),
                onTap: () async {
                  print("loading>>>");
                  await AuthService().signInWithFb().catchError((onError) {
                    print("ERror");
                  });
                  print("complete>>>");
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
