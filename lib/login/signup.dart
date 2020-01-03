import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cooking_guide/components/progress.dart';
import 'package:cooking_guide/services/auth.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _cpassController = TextEditingController();
  final _nameController = TextEditingController();

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
                child: Text("Cooking Guide",
                    style:
                        TextStyle(fontWeight: FontWeight.w500, fontSize: 16))),
            SizedBox(
              height: 60,
            ),
            Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail,
                  ),
                  labelText: "Name",
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 5.0,
            ),
            TextFormField(
              validator: (str) {
                print(str);
                return str;
              },
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
            SizedBox(
              height: 5.0,
            ),
            TextField(
              controller: _cpassController,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock,
                ),
                border: OutlineInputBorder(),
                labelText: "Confirm Password",
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
                  "SignUp",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  if (!_isValided()) return;
                  loading.show();
                  bool user = await AuthService().signUpWithEmail(
                      name: _nameController.text,
                      email: _emailController.text,
                      password: _passController.text);
                  loading.hide();

                  if (!user) {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.ERROR,
                            animType: AnimType.SCALE,
                            tittle: 'Error',
                            desc:
                                'Your e-mail is already exist. Please verify e-mail!',
                            dismissOnTouchOutside: false,
                            btnOkOnPress: () {})
                        .show();
                  } else {
                    AwesomeDialog(
                            context: context,
                            dialogType: DialogType.SUCCES,
                            animType: AnimType.SCALE,
                            tittle: 'Success',
                            desc: 'Check your e-mail inbox and verify it!',
                            dismissOnTouchOutside: false,
                            btnOkOnPress: () {
                              Navigator.pop(context);
                            })
                        .show();
                  }
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
                child: Column(children: <Widget>[
              Text("Has alredy an account?"),
              InkWell(
                child: Text("LOGIN"),
                onTap: () {
                  Navigator.pop(context);
                },
              )
            ]))
          ],
        ),
      ),
    );
  }

  _isValided() {
    if (_nameController.text.length < 3) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Your name is too short. Please enter more characters!"),
      ));
      return false;
    }
    if (_emailController.text.length < 1) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("E-mail filed is required!"),
      ));
      return false;
    } else {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(_emailController.text)) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Please enter valid e-mail!"),
        ));
        return false;
      }
    }
    if (_passController.text.length < 6) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Please enter 6 characters and more in Password Field!"),
      ));
      return false;
    }
    if (_cpassController.text.length < 6) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text("Please enter 6 characters and more in Confirm Password!"),
      ));
      return false;
    }
    if (_passController.text.toString() != _cpassController.text.toString()) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Your password didn't match!"),
      ));
      return false;
    }
    return true;
  }
}
