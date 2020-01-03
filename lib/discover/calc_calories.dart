import 'package:cooking_guide/models/activities.dart';
import 'package:flutter/material.dart';

class CalculateCal extends StatefulWidget {
  @override
  _CalculateCalState createState() => _CalculateCalState();
}

final textStyle = TextStyle(color: Colors.black, fontWeight: FontWeight.w500);

class _CalculateCalState extends State<CalculateCal> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Activity activity;
  Gender gender;
  int total = 0;
  final TextEditingController heightIn = TextEditingController();
  final TextEditingController heightFt = TextEditingController();
  final TextEditingController weight = TextEditingController();
  final TextEditingController age = TextEditingController();

  @override
  void initState() {
    heightIn.text = "0";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Calculate Calories"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 100, child: Text("Age")),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: TextField(
                        controller: age,
                        onChanged: (str) {
                          if (str.length > 3) {
                            age.clear();
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "year",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 100, child: Text("Gender")),
                    SizedBox(
                        width: 100,
                        height: 50,
                        child: DropdownButton<Gender>(
                          hint: Text(gender == null ? "Select" : gender.gender),
                          isExpanded: true,
                          underline: Container(),
                          items: genders.map((Gender gender) {
                            return DropdownMenuItem<Gender>(
                              value: gender,
                              child: Text(gender.gender),
                            );
                          }).toList(),
                          onChanged: (_) {
                            setState(() {
                              gender = _;
                            });
                          },
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 100, child: Text("Weight")),
                    SizedBox(
                      width: 100,
                      height: 50,
                      child: TextField(
                        controller: weight,
                        onChanged: (str) {
                          if (str.length > 3) {
                            weight.clear();
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "lb",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 100, child: Text("Height")),
                    SizedBox(
                      width: 80,
                      height: 50,
                      child: TextField(
                        controller: heightFt,
                        onChanged: (str) {
                          if (str.length > 2) {
                            heightFt.clear();
                          }
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "ft",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: SizedBox(
                        width: 80,
                        height: 50,
                        child: TextField(
                          onChanged: (str) {
                            if (str.length > 2) {
                              heightIn.clear();
                            } else if (int.parse(str) > 11) {
                              heightIn.clear();
                            }
                          },
                          controller: heightIn,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "in",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 100, child: Text("Activity")),
                    SizedBox(
                        width: 190,
                        height: 50,
                        child: DropdownButton<Activity>(
                          hint: Text(activity == null
                              ? "Select Activity"
                              : activity.acti),
                          isExpanded: true,
                          underline: Container(),
                          items: activities.map((Activity activity) {
                            return DropdownMenuItem<Activity>(
                              value: activity,
                              child: Text(activity.acti),
                            );
                          }).toList(),
                          onChanged: (_) {
                            setState(() {
                              activity = _;
                            });
                          },
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                    ),
                    SizedBox(
                      width: 180,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.deepPurpleAccent.withOpacity(0.7),
                        onPressed: () {
                          _calculate();
                        },
                        child: Text(
                          "Calculate",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              total == 0
                  ? Text("")
                  : Column(
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          elevation: 3.5,
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        color: Colors.amber,
                                        child: Text(
                                          "Normal Weight\n0lb/week",
                                          style: textStyle,
                                        )),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    indent: 1,
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        color: Colors.amber,
                                        child: Text(
                                          total.toString() + "\nCalories/day",
                                          style: textStyle,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        color: Colors.amber,
                                        child: Text(
                                          "Mild Loss Weight\n0.5lb/week",
                                          style: textStyle,
                                        )),
                                  ),
                                  Divider(
                                    indent: 1,
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        color: Colors.amber,
                                        child: Text(
                                          (total * 0.9).toInt().toString() +
                                              "\nCalories/day",
                                          style: textStyle,
                                        )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        color: Colors.amber,
                                        child: Text("Loss Weight\n1lb/week",
                                            style: textStyle)),
                                  ),
                                  Divider(
                                    indent: 1,
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        color: Colors.amber,
                                        child: Text(
                                            (total * 0.8).toInt().toString() +
                                                "\nCalories/day",
                                            style: textStyle)),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.0,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        color: Colors.amber,
                                        child: Text(
                                            "Extreme Loss Weight\n2lb/week",
                                            style: textStyle)),
                                  ),
                                  Divider(
                                    indent: 1,
                                  ),
                                  Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        color: Colors.amber,
                                        child: Text(
                                            (total * 0.61).toInt().toString() +
                                                "\nCalories/day",
                                            style: textStyle)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                            "Tip: Recommanded minimun calories are 1500 for teenagers!")
                      ],
                    ),
            ],
          ),
        ));
  }

  _calculate() {
    if (age.text.isEmpty) {
      _showSnack("Age field is required!");
      return;
    }
    if (weight.text.isEmpty) {
      _showSnack("Weight field is required!");
      return;
    }
    if (heightFt.text.isEmpty) {
      _showSnack("Height field is required!");
      return;
    }

    if (heightIn.text.isEmpty) {
      heightIn.text = "0";
    }
    if (activity == null) {
      _showSnack("Please choose your activity");
      return;
    }
    if (gender == null) {
      _showSnack("Please choose your gender");
      return;
    }
    int year = int.parse(age.text) * 5;
    double gen = gender.value;
    double kg = double.parse(weight.text) * 0.453;
    double cm =
        (double.parse(heightFt.text) + double.parse(heightIn.text) * 0.08) *
            30.48;
    double avg = (10 * kg) + (6.25 * cm) - year + gen;
    avg *= activity.rate;
    setState(() {
      total = avg.ceil();
    });
  }

  void _showSnack(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.red,
    ));
  }
}
