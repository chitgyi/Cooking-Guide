import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cooking_guide/components/progress.dart';
import 'package:cooking_guide/login/forget.dart';
import 'package:cooking_guide/login/signup.dart';
import 'package:cooking_guide/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ProgressDialog loading = dialog(context);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.teal[100],
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Center(
              child: Container(
                child: Image.asset(
                  "images/logo.png",
                  width: 120,
                  height: 120,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Center(
                child: Text("Cooking Guide Admin",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
            SizedBox(
              height: 60,
            ),
            Text(
              "Login",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail,
                  ),
                  labelText: "E-mail",
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: _passController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                ),
                border: OutlineInputBorder(),
                labelText: "Password",
              ),
              obscureText: true,
            ),
            Container(
              width: double.infinity,
              height: 50,
              margin: EdgeInsets.only(top: 10),
              child: RaisedButton(
                color: Colors.teal,
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (!_isValided()) return;
                  loading.show();
                  var user = await AuthService().signInWithEmail(
                      email: _emailController.text,
                      password: _passController.text);
                  loading.hide();

                  if (user == null) {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.SCALE,
                            tittle: 'Error',
                            desc:
                                'Try again! Your email or password is incorrected.',
                            dismissOnTouchOutside: false,
                            btnOkOnPress: () {})
                        .show();
                  }
                },
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (cxt) => Forget()));
              },
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text(
                  "Forget password?",
                ),
              ),
            ),
            Center(child: Text("OR")),
            Container(
                width: double.infinity,
                height: 50,
                margin: EdgeInsets.only(top: 10),
                child: RaisedButton(
                    onPressed: () async {
                      await AuthService().signInWithFb();
                    },
                    color: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.white,
                          size: 30,
                        ),
                        Text(
                          "Login with Facebook",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ))),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Column(
                children: <Widget>[
                  Text("Hasn't an account?"),
                  InkWell(
                    child: Text("Create Account"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (cxt) => SignUp()));
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _isValided() {
    if (_emailController.text.length < 1) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("E-mail filed is required!"),
      ));
      return false;
    }
    if (_passController.text.length < 1) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Password filed is required!"),
      ));
      return false;
    }
    return true;
  }
}
