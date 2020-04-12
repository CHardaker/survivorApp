import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:survivor/globals.dart' as globals;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:survivor/database.dart';

class StatusView extends StatefulWidget {
  final Function callbackToHome;
  StatusView({Key key,this.callbackToHome}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StatusState();
  }
}

class _StatusState extends State<StatusView> {
  var db = new DatabaseHelper();
  User user = new User();
  Attributes attributes = new Attributes();

  String questionBlock="Lifestyle";

  @override
  initState() {
    super.initState();
  }

  @override
  void didUpdateWidget( oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  getData() async{
    user = await db.getUser(globals.userId);
    attributes = await db.getAttributes();
    print(user.toString());
    print(attributes.toString());
    setState(() {});
  }

  testHeight(){
    if(attributes.height>0 && attributes.heightUnits!="U") {
      saveAttributes();
      getData();
    }else{
      print("height error");
    }
  }

  testWeight(){
    if(attributes.weight>0 && attributes.weightUnits!="U") {
      saveAttributes();
      getData();
    }else{
      print("weight error");
    }
  }


  saveUser() async{
    await db.updateUser(user);
  }
  saveAttributes() async{
    await db.updateAttributes(attributes);
  }


  Widget build(BuildContext context) {
    return Material(
        color: globals.sBackground,
//        height: MediaQuery.of(context).size.height - 265,
//        width: MediaQuery.of(context).size.width,
        child:Column(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding:EdgeInsets.fromLTRB(20,50,20,10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FlatButton(
                          onPressed: (){
                            globals.history=true;
                            globals.currentView="Summary";
                            widget.callbackToHome("Summary");
                          },
                          child: Text("HOME",style: TextStyle(color: globals.sBackground),),
                        ),
                        Text("History",style:TextStyle(color:globals.sGreen,fontSize:30,fontWeight:FontWeight.bold)),
                        FlatButton(
                          onPressed: (){
                            globals.history=true;
                            globals.currentView="Summary";
                            widget.callbackToHome("Summary");
                          },
                          child: Text("HOME",style: TextStyle(color: globals.sBackground),),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child:Text("To help us understand the context of your health, please answer the following 5 groups of questions.",style:TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
                  ),
                ],
              ),
              Padding(
                padding:EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: Container(
                  decoration: BoxDecoration(color:Colors.white,borderRadius: BorderRadius.all(Radius.circular(10))),
                  child:Padding(
                    padding:EdgeInsets.fromLTRB(0,5,0,5),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                              border: Border.all(width: 3,style: BorderStyle.solid,color:(questionBlock=="Lifestyle")?globals.sBlue:Colors.white, )
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  border: Border.all(width: 3,style: BorderStyle.solid,color:globals.sGreen,)
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                onPressed: (){
                                  questionBlock="Lifestyle";
                                  setState(() {});
                                },
                                child: Text("Lifestyle",style: TextStyle(color: globals.sGreen,fontSize: 10,fontWeight: FontWeight.bold),maxLines: 1,textAlign: TextAlign.center,),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                              border: Border.all(width: 3,style: BorderStyle.solid,color:(questionBlock=="Medication")?globals.sGreen:Colors.white, )
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  border: Border.all(width: 3,style: BorderStyle.solid,color:globals.sGreen,)
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                onPressed: (){
                                  questionBlock="Medication";
                                  setState(() {});
                                },
                                child: Text("Medicine",style: TextStyle(color: globals.sGreen,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                              border: Border.all(width: 3,style: BorderStyle.solid,color:(questionBlock=="History")?globals.sGreen:Colors.white, )
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  border: Border.all(width: 3,style: BorderStyle.solid,color:globals.sGreen,)
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                onPressed: (){
                                  questionBlock="History";
                                  setState(() {});
                                },
                                child: Text("Medical\nHistory",style: TextStyle(color: globals.sGreen,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                              border: Border.all(width: 3,style: BorderStyle.solid,color:(questionBlock=="Chronic")?globals.sGreen:Colors.white, )
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(30)),
                                  border: Border.all(width: 3,style: BorderStyle.solid,color:globals.sGreen,)
                              ),
                              child: FlatButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                onPressed: (){
                                  questionBlock="Chronic";
                                  setState(() {});
                                },
                                child: Text("Chronic\nDiseases",style: TextStyle(color: globals.sGreen,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ),
              ),
              Row(
                children: <Widget>[
                  Container(
                    height: 5,
                  ),
                ],
              ),
              (questionBlock=="Lifestyle")?
              Padding(
                  padding:EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: <Widget>[
                      (attributes == null || attributes.height == null || attributes.height==0 || attributes.heightUnits == null || attributes.heightUnits == "U")?
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0,0,15,0),
                                  child:Text("Please enter your height and select the units",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      height: 40,
                                      width: MediaQuery.of(context).size.width-170,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          color: Colors.white
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                        child: TextField(
                                          onChanged: (text){
                                            attributes.height = int.parse(text);
                                          },
                                          onEditingComplete: (){
                                            testHeight();
                                          },
                                          onSubmitted: (text){
                                            attributes.height = int.parse(text);
                                            testHeight();
                                          },
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Container(
                                        height: 30,
                                        width: 60,
                                        child: RaisedButton(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          color: globals.sBlue,
                                          onPressed: (){
                                            print("heightUnit cms");
                                            attributes.heightUnits="cms";
                                            testHeight();
                                            },
                                          child: Text("cms",style: TextStyle(color: Colors.white),),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Container(
                                        height: 30,
                                        width: 60,
                                        child: RaisedButton(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          color: globals.sBlue,
                                          onPressed: (){
                                            print("heightUnit inches");
                                            attributes.heightUnits="inches";
                                            testHeight();
                                          },
                                          child: Text("inches",style: TextStyle(color: Colors.white),),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                              ],
                            ),
                          )
                      :
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("We have your height recorded as",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width-100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    child: Text(attributes.height.toString()+' '+attributes.heightUnits,style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("height change");
                                        attributes.height=0;
                                        attributes.heightUnits="U";
                                        testHeight();
                                        setState(() {});
                                      },
                                      child: Text("EDIT",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),


                              ],
                            ),

                          ],
                        ),
                      )
                      ,
                      (attributes == null || attributes.weight == null || attributes.weight==0 || attributes.weightUnits == null || attributes.weightUnits == "U")?
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0,0,15,0),
                              child:Text("Please enter your weight and select the units",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width-170,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    child: TextField(
                                      onChanged: (text){
                                        attributes.weight = int.parse(text);
                                      },
                                      onEditingComplete: (){
                                        testWeight();
                                      },
                                      onSubmitted: (text){
                                        attributes.weight = int.parse(text);
                                        testWeight();
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("WeightUnit kgs");
                                        attributes.weightUnits="kgs";
                                        testWeight();
                                      },
                                      child: Text("kgs",style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("weightUnit lbs");
                                        attributes.weightUnits="lbs";
                                        testWeight();
                                      },
                                      child: Text("lbs",style: TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                ),

                              ],
                            ),

                          ],
                        ),
                      )
                          :
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("We have your weight recorded as",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width-100,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    child: Text(attributes.weight.toString()+' '+attributes.weightUnits,style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("weight change");
                                        attributes.weight=0;
                                        attributes.weightUnits="U";
                                        testWeight();
                                        setState(() {});
                                      },
                                      child: Text("EDIT",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      )
                      ,
                      (attributes == null || attributes.smoker==null||attributes.smoker=="U")?
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Do you smoke?",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)
                                    ],
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        child: RaisedButton(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          color: globals.sBlue,
                                          onPressed: (){
                                            print("smoker change");
                                            attributes.smoker="N";
                                            setState(() {});
                                          },
                                          child: Text("NO",style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                      child: Container(
                                        height: 60,
                                        width: 60,
                                        child: RaisedButton(
                                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          color: globals.sBlue,
                                          onPressed: (){
                                            print("smoking change");
                                            attributes.smoker="Y";
                                            setState(() {});
                                          },
                                          child: Text("YES",style: TextStyle(color: Colors.white)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                      :
                          Container()
                      ,
                      (attributes.smoker=="N")?
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("We have you as a non-smoker",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Container(
                                height: 30,
                                width: 60,
                                child: RaisedButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  color: globals.sBlue,
                                  onPressed: (){
                                    print("weight change");
                                    attributes.smoker="U";
                                    setState(() {});
                                  },
                                  child: Text("EDIT",style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                          :
                      Container()
                      ,
                      (attributes.smoker=="Y")?
                          Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text("Are you a",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("weight change");
                                        attributes.smoker="Social";
                                        saveAttributes();
                                        setState(() {});
                                      },
                                      child: Text("Social",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("smoking change");
                                        attributes.smoker="Light";
                                        saveAttributes();
                                        setState(() {});
                                      },
                                      child: Text("Light",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("smoking change");
                                        attributes.smoker="Medium";
                                        saveAttributes();
                                        setState(() {});
                                      },
                                      child: Text("Medium",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("smoking change");
                                        attributes.smoker="Heavy";
                                        saveAttributes();
                                        setState(() {});
                                      },
                                      child: Text("Heavy",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text("smoker?",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                              ],
                            ),
                          ],
                        ),
                      )
                          :
                          Container()
                      ,
                      (attributes.smoker=="Social"||attributes.smoker=="Light"||attributes.smoker=="Medium"||attributes.smoker=="Heavy")?
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text("We have you as a ${attributes.smoker} smoker.",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("smoker change");
                                        attributes.smoker="U";
                                        setState(() {});
                                      },
                                      child: Text("EDIT",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          :
                          Container()
                      ,
                      (attributes == null || attributes.drinker==null||attributes.drinker=="U")?
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text("Do you drink alcohol?",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,)
                                ],
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("drinker change");
                                        attributes.drinker="N";
                                        setState(() {});
                                      },
                                      child: Text("NO",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 60,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("drinker change");
                                        attributes.drinker="Y";
                                        setState(() {});
                                      },
                                      child: Text("YES",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                          :
                      Container()
                      ,
                      (attributes.drinker=="N")?
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("We have you as not drinking alcohol",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Container(
                                height: 30,
                                width: 60,
                                child: RaisedButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  color: globals.sBlue,
                                  onPressed: (){
                                    print("drinker change");
                                    attributes.drinker="U";
                                    setState(() {});
                                  },
                                  child: Text("EDIT",style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                          :
                      Container()
                      ,
                      (attributes.drinker=="Y")?
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child:Text("Are you a",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("driner change");
                                        attributes.drinker="Social";
                                        saveAttributes();
                                        setState(() {});
                                      },
                                      child: Text("Social",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("drinker change");
                                        attributes.drinker="Light";
                                        saveAttributes();
                                        setState(() {});
                                      },
                                      child: Text("Light",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("drinker change");
                                        attributes.drinker="Medium";
                                        saveAttributes();
                                        setState(() {});
                                      },
                                      child: Text("Medium",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Container(
                                    height: 30,
                                    width: 60,
                                    child: RaisedButton(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                      color: globals.sBlue,
                                      onPressed: (){
                                        print("driner change");
                                        attributes.drinker="Heavy";
                                        saveAttributes();
                                        setState(() {});
                                      },
                                      child: Text("Heavy",style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child:Text("drinker?",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                                ),

                              ],
                            ),
                          ],
                        ),
                      )
                          :
                      Container()
                      ,
                      (attributes.drinker=="Social"||attributes.drinker=="Light"||attributes.drinker=="Medium"||attributes.drinker=="Heavy")?
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("We have you as a ${attributes.drinker} drinker.",style: TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Container(
                                height: 30,
                                width: 60,
                                child: RaisedButton(
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  color: globals.sBlue,
                                  onPressed: (){
                                    print("drinker change");
                                    attributes.drinker="U";
                                    setState(() {});
                                  },
                                  child: Text("EDIT",style: TextStyle(color: Colors.white),),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                          :
                      Container()
                      ,
                        ],
                  )
              )
                  :
              Container()
              ,
              (questionBlock=="Medication")?
              Padding(
                  padding:EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("need to do a generic medication list"),
                          Text("Vacinations"),
                          Text("Generallly up to date?"),
                          Text("Seasonal flu?"),
                          Text("Pneumococis"),
                          Text("BCG"),
                        ],
                      ),
                    ],
                  )
              )
                  :
              Container()
              ,
              (questionBlock=="History")?
              Padding(
                  padding:EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Cardiovascular disease"),
                          Text("Cancer"),
                          Text("Asthma/severe allergy"),
                          Text("Rheumatic fever"),
                          Text("Depression"),
                        ],
                      ),
                    ],
                  )
              )
                  :
              Container()
              ,
              (questionBlock=="Chronic")?
              Padding(
                  padding:EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text("Hypertension"),
                          Text("Diabetes"),
                          Text("COPD"),
                          Text("Autoimmune"),
                          Text("Endochrine"),
                          Text("Other"),
                        ],
                      ),
                    ],
                  )
              )
                  :
              Container()
              ,

            ],
          ),
    );
  }
}