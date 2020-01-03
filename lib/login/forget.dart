import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cooking_guide/components/progress.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Forget extends StatelessWidget {
  final _mailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Forget Password",
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: TextField(
          controller: _mailController,
          onSubmitted: (str) {
            _onSubmit(str, context);
            // dialog(context).hide();
            // if (result != null) {
            //   result
            //       ? AwesomeDialog(
            //               context: context,
            //               dialogType: DialogType.SUCCES,
            //               animType: AnimType.SCALE,
            //               tittle: 'Success',
            //               desc: "Check your e-mail and follow link!",
            //               dismissOnTouchOutside: false,
            //               btnOkOnPress: () {})
            //           .show()
            //       : AwesomeDialog(
            //               context: context,
            //               dialogType: DialogType.ERROR,
            //               animType: AnimType.SCALE,
            //               tittle: 'Error',
            //               desc: "Your e-mail doesn't exit!",
            //               dismissOnTouchOutside: false,
            //               btnOkOnPress: () {})
            //           .show();
            // }
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Enter your e-mail",
              prefixIcon: Icon(Icons.email),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  _onSubmit(_mailController.text, context);
                },
              )),
        ),
      ),
    );
  }

  _onSubmit(String str, BuildContext context) async {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(str)) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        duration: Duration(milliseconds: 1500),
        content: Text("Your email is invalid!"),
      ));
    } else {
      try {
        dialog(context).show();
        await FirebaseAuth.instance.sendPasswordResetEmail(email: str);
        dialog(context).hide();
        AwesomeDialog(
                context: context,
                dialogType: DialogType.SUCCES,
                animType: AnimType.SCALE,
                tittle: 'Success',
                desc: "Check your mail and follow link!",
                dismissOnTouchOutside: false,
                btnOkOnPress: () {
                  Navigator.pop(context);
                })
            .show();
      } catch (e) {
        dialog(context).hide();
        AwesomeDialog(
                context: context,
                dialogType: DialogType.ERROR,
                animType: AnimType.SCALE,
                tittle: 'Error',
                desc: "Your e-mail doen't exit!",
                dismissOnTouchOutside: false,
                btnOkOnPress: () {})
            .show();
      }
    }
  }
}
