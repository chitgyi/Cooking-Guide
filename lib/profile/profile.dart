import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cooking_guide/components/progress.dart';
import 'package:cooking_guide/login/login.dart';
import 'package:cooking_guide/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseUser user;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final noPhotoUrl = "https://i.ibb.co/DM4nsNx/user.png";
  final _feedController = TextEditingController();
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((usr) {
      setState(() {
        user = usr;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: user == null
            ? Center(child: Text("No User"))
            : Column(
                children: <Widget>[
                  Card(
                    elevation: 8.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              user?.photoUrl == null
                                  ? noPhotoUrl
                                  : user?.photoUrl,
                              fit: BoxFit.fill,
                              width: 100,
                              height: 100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              user?.displayName,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    child: Column(
                      children: <Widget>[
                        Material(
                          child: InkWell(
                            onTap: () {
                              AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.INFO,
                                      animType: AnimType.BOTTOMSLIDE,
                                      desc: 'V-IT (Group III Project)\n@Mg Chit Ye Aung(Developer)\n@Mg Kyaw Min Tun(Database)\n@Mg Sithu Lwin(UI Design)',
                                      tittle: "About",
                                      btnOkOnPress: () {})
                                  .show();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(Icons.info),
                                  ),
                                  Text("About"),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          child: InkWell(
                            onTap: () {
                              print("feed");
                              AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.INFO,
                                  animType: AnimType.BOTTOMSLIDE,
                                  desc: 'Dialog Title',
                                  body: TextField(
                                    maxLines: 4,
                                    controller: _feedController,
                                    decoration: InputDecoration(
                                        labelText: "Write your feedback!",
                                        border: OutlineInputBorder()),
                                  ),
                                  btnCancelOnPress: () {},
                                  btnOkOnPress: () async {
                                    dialog(context).show();
                                    await Firestore.instance
                                        .collection("feedback")
                                        .add(
                                            {"feedback": _feedController.text});
                                    _feedController.clear();
                                    _scaffoldKey.currentState
                                        .showSnackBar(SnackBar(
                                      content: Text("Done!"),
                                      duration: Duration(milliseconds: 1500),
                                    ));
                                    dialog(context).hide();
                                  }).show();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(Icons.feedback),
                                  ),
                                  Text("Feedback"),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          child: InkWell(
                            onTap: () async {
                              var pr = dialog(context);
                              pr.show();
                              AuthService().signOut().then((onValue) {
                                pr.dismiss();
                                pr.hide();
                                Navigator.of(context).pop();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Icon(Icons.exit_to_app),
                                  ),
                                  Text("Logout"),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
