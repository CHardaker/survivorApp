import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:survivor/globals.dart' as globals;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:survivor/database.dart';

class WeeklyView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WeeklyState();
  }
}

class _WeeklyState extends State<WeeklyView> {
  var db = new DatabaseHelper();

  Weekly weekly;

  @override
  initState() {
    super.initState();

  }

  @override
  void didUpdateWidget( oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Widget build(BuildContext context) {
    return Material(
        color: Colors.white,
//        height: MediaQuery.of(context).size.height - 265,
//        width: MediaQuery.of(context).size.width,
        child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(
            children: <Widget>[
              (isoWeekNumber(DateTime.now()).isEven)?
                  Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width/2,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Text("In the last 30 days, how much difficulty did you have in:"),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width/2,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  RotatedBox(
                                    quarterTurns: 1,
                                    child: Text('None'),
                                  ),

                                  Text('Mild'),
                                  Text('Moderate'),
                                  Text('Severe'),
                                  Text('Extreme'),
                                  Text('Cannot do'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  :
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Text("In the last 30 days, how much difficulty did you have in:"),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              RotatedBox(
                                quarterTurns: -1,
                                child: Text('None'),
                              ),
                              RotatedBox(
                                quarterTurns: -1,
                                child: Text('Mild'),
                              ),
                              RotatedBox(
                                quarterTurns: -1,
                                child: Text('Moderate'),
                              ),
                              RotatedBox(
                                quarterTurns: -1,
                                child: Text('Severe'),
                              ),
                              RotatedBox(
                                quarterTurns: -1,
                                child: Text('Extreme'),
                              ),
                              RotatedBox(
                                quarterTurns: -1,
                                child: Text('Cannot do'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Learning a new task, for example, learning how to get to a new place?"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            (weekly==null||weekly.d11==null||weekly.d11!=0)?
                                SizedBox(
                                  width: 25,
                                  child: FlatButton(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Icon(Icons.panorama_fish_eye),
                                    onPressed: (){
                                      weekly.d11=0;
                                      setState(() {});;
                                      },
                                    color: Colors.white,
                                  )
                                )
                            :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=0;
                                    setState(() {});;
                                    },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=1)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=1;
                                    setState(() {});;
                                    },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                              width: 25,
                              child: FlatButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Icon(Icons.brightness_1),
                              onPressed: (){
                                weekly.d11=1;
                                setState(() {});;
                              },
                              color: Colors.white,
                            )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=2)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                              width: 25,
                              child: FlatButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Icon(Icons.brightness_1),
                              onPressed: (){
                                weekly.d11=2;
                                setState(() {});;
                              },
                              color: Colors.white,
                            )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=3)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                              width: 25,
                              child: FlatButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Icon(Icons.brightness_1),
                              onPressed: (){
                                weekly.d11=3;
                                setState(() {});;
                              },
                              color: Colors.white,
                            )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=4)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                              width: 25,
                              child: FlatButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Icon(Icons.brightness_1),
                              onPressed: (){
                                weekly.d11=4;
                                setState(() {});;
                              },
                              color: Colors.white,
                            )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=5)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                              width: 25,
                              child: FlatButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Icon(Icons.brightness_1),
                              onPressed: (){
                                weekly.d11=5;
                                setState(() {});;
                              },
                              color: Colors.white,
                            )
                            )
                            ,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Learning a new task, for example, learning how to get to a new place?"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            (weekly==null||weekly.d11==null||weekly.d11!=0)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=1)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=2)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=3)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=4)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=5)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Learning a new task, for example, learning how to get to a new place?"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            (weekly==null||weekly.d11==null||weekly.d11!=0)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=1)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=2)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=3)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=4)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=5)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Learning a new task, for example, learning how to get to a new place?"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            (weekly==null||weekly.d11==null||weekly.d11!=0)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=1)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=2)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=3)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=4)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=5)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Learning a new task, for example, learning how to get to a new place?"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            (weekly==null||weekly.d11==null||weekly.d11!=0)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=1)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=2)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=3)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=4)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=5)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Learning a new task, for example, learning how to get to a new place?"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            (weekly==null||weekly.d11==null||weekly.d11!=0)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=1)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=2)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=3)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=4)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d11==null||weekly.d11!=5)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d11=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d11=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Getting along with people who are close to you?"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            (weekly==null||weekly.d41==null||weekly.d41!=0)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d41=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d41=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d41==null||weekly.d41!=1)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d41=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d41=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d41==null||weekly.d41!=2)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d41=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d41=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d41==null||weekly.d41!=3)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d41=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d41=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d41==null||weekly.d41!=4)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d41=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d41=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d41==null||weekly.d41!=5)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d41=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d41=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Making new friends?"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            (weekly==null||weekly.d42==null||weekly.d42!=0)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d42=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d42=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d42==null||weekly.d42!=1)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d42=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d42=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d42==null||weekly.d42!=2)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d42=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d42=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d42==null||weekly.d42!=3)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d42=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d42=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d42==null||weekly.d42!=4)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d42=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d42=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d42==null||weekly.d42!=5)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d42=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d42=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Doing most important household tasks well?"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            (weekly==null||weekly.d51==null||weekly.d51!=0)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d51=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d51=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d51==null||weekly.d51!=1)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d51=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d51=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d51==null||weekly.d51!=2)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d51=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d51=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d51==null||weekly.d51!=3)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d51=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d51=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d51==null||weekly.d51!=4)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d51=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d51=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d51==null||weekly.d51!=5)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d51=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d51=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("Getting your work done as quickly as needed?"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            (weekly==null||weekly.d52==null||weekly.d52!=0)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d52=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d52=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d52==null||weekly.d52!=1)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d52=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d52=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d52==null||weekly.d52!=2)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d52=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d52=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d52==null||weekly.d52!=3)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d52=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d52=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d52==null||weekly.d52!=4)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d52=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d52=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d52==null||weekly.d52!=5)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d52=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d52=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("How much of a problem did you have joining in community activities (festivities, religious or other) in the same way as anyone else can?"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            (weekly==null||weekly.d61==null||weekly.d61!=0)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d61=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d61=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d61==null||weekly.d61!=1)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d61=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d61=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d61==null||weekly.d61!=2)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d61=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d61=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d61==null||weekly.d61!=3)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d61=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d61=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d61==null||weekly.d61!=4)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d61=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d61=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d61==null||weekly.d61!=5)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d61=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d61=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text("How much have you been emotionally affected by your health problems?"),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width/2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            (weekly==null||weekly.d62==null||weekly.d62!=0)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d62=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d62=0;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d62==null||weekly.d62!=1)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d62=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d62=1;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d62==null||weekly.d62!=2)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d62=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d62=2;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d62==null||weekly.d62!=3)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d62=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d62=3;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d62==null||weekly.d62!=4)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d62=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d62=4;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                            (weekly==null||weekly.d62==null||weekly.d62!=5)?
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.panorama_fish_eye),
                                  onPressed: (){
                                    weekly.d62=5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                                :
                            SizedBox(
                                width: 25,
                                child: FlatButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  child: Icon(Icons.brightness_1),
                                  onPressed: (){
                                    weekly.d62 =5;
                                    setState(() {});;
                                  },
                                  color: Colors.white,
                                )
                            )
                            ,
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              )
              ,
            ],
          ),
        )
    );
  }
}

int isoWeekNumber(DateTime date) {
  int daysToAdd = DateTime.thursday - date.weekday;
  DateTime thursdayDate = daysToAdd > 0 ? date.add(Duration(days: daysToAdd)) : date.subtract(Duration(days: daysToAdd.abs()));
  int dayOfYearThursday = dayOfYear(thursdayDate);
  return 1 + ((dayOfYearThursday - 1) / 7).floor();
}
int dayOfYear(DateTime date) {
  return date.difference(DateTime(date.year, 1, 1)).inDays;
}