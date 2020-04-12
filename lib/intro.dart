import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:survivor/globals.dart' as globals;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:survivor/database.dart';
import 'package:survivor/api.dart';

class IntroView extends StatefulWidget {
  final Function callbackToHome;
  IntroView({Key key,this.callbackToHome}) : super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _IntroViewState();
  }
}

class _IntroViewState extends State<IntroView> {
  var db = new DatabaseHelper();
  var api = new ApiProvider();
  var subView = "Intro";

  User newUser = new User();

  @override
  initState() {
    super.initState();
  }

  @override
  void didUpdateWidget( oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  checkRegistration() async{
    print("checkRegistration");
    bool register=true;
    if(newUser== null || newUser.name == 'unknown' || newUser.name == null){register=false;}
    if(newUser== null || newUser.email == 'unknown' || newUser.email == null){register=false;}
    if(newUser== null || newUser.username == 'unknown' || newUser.username == null){register=false;}
    if(newUser== null || newUser.password == 'unknown' || newUser.password == null){register=false;}
    if(register){
      print("ready to register");
      var result = await api.post('users', {'name':newUser.name,'password':newUser.password});
      print("got here");
      if(result['statusCode']==400){
        print("will attemptlogin instead");
        var loginResult = await api.post('users/login',{'name':newUser.name,'password':newUser.password});
        if(loginResult['user']!=null){
          globals.userId = loginResult['user']['_id'];
          globals.token = loginResult['token'];
          globals.currentView="Summary";
          widget.callbackToHome("Summary");
          print("trying to get home");
        }else{
          print("failed to login");
          print(loginResult.toString());
        }
      }
    }else{
      print("not ready to register");
    }
  }

  checkLogin() async{
    print("checkLogin");
    bool login=true;
    if(newUser== null || newUser.name == 'unknown' || newUser.name == null){login=false;}
    if(newUser== null || newUser.password == 'unknown' || newUser.password == null){login=false;}
    if(login){
      var loginResult = await api.post('users/login',{'name':newUser.name,'password':newUser.password});
      if(loginResult['user']!=null){
        globals.userId = loginResult['user']['_id'];
        globals.token = loginResult['token'];
        globals.currentView="Summary";
        widget.callbackToHome("Summary");
        print("trying to get home");
      }else{
        print("failed to login");
        print(loginResult.toString());
      }
    }else{
      print("not ready to login");
    }
  }

  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          (subView=="Register")?
              Container(
                color: globals.sBackground,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
                      child: Text("Register",style: TextStyle(color: globals.sGreen, fontSize: 30, fontWeight: FontWeight.bold),),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, (MediaQuery.of(context).size.height - 789)/2),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Name",style: TextStyle(color: globals.sGreen, fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: TextField(
                          onChanged: (text){
                            newUser.name=text;
                          },
                          onSubmitted: (text){
                            newUser.name=text;
                            checkRegistration();
                          },
                          onEditingComplete: (){
                            checkRegistration();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Email",style: TextStyle(color: globals.sGreen, fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: TextField(
                          onChanged: (text){
                            newUser.email=text;
                          },
                          onSubmitted: (text){
                            newUser.email=text;
                            checkRegistration();
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("Username",style: TextStyle(color: globals.sGreen, fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                          Text("Available",style: TextStyle(color: globals.sGreen, fontSize: 16, fontWeight: FontWeight.normal),textAlign: TextAlign.start,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: TextField(
                          onChanged: (text){
                            newUser.username=text;
                          },
                          onSubmitted: (text){
                            newUser.username=text;
                            checkRegistration();
                          },
                        ),
                      ),
                    ),                    //emailaddress fiend
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Password",style: TextStyle(color: globals.sGreen, fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10))),
                        child: TextField(
                          onChanged: (text){
                            newUser.password=text;
                          },
                          onSubmitted: (text){
                            newUser.password=text;
                            checkRegistration();
                          },
                          obscureText: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
                      child: SizedBox(
                        height: 40,
                        width: MediaQuery.of(context).size.width-80,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: RaisedButton(
                            color: globals.sGreen,
                            child: Text("Register",style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),),
                            onPressed: (){
                              print("registering");
                              checkRegistration();
                              },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40,40,40,40),
                      child: Text("By registering, you are accepting the Survivor app terms and conditions availabe here",style: TextStyle(color: globals.sGreen, fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                      child: FlatButton(
                        onPressed: (){
                          subView="Login";
                          setState(() {});
                        },
                        child: Text("Already registered? Login here",style: TextStyle(color: globals.sGreen, fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, (MediaQuery.of(context).size.height - 789)/2),
                    )
                    //disclaimer text
                    //switch to login
                  ],
                ),
              )
          :
              Container()
          ,
          (subView=="Login")?
              Container(
            color: globals.sBackground,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
                  child: Text("Login",style: TextStyle(color: globals.sGreen, fontSize: 30, fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, (MediaQuery.of(context).size.height-478)/2),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Name",style: TextStyle(color: globals.sGreen, fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      onChanged: (text){
                        newUser.name=text;
                      },
                      onSubmitted: (text){
                        newUser.name=text;
                        checkLogin();
                      },
                    ),
                  ),
                ),                    //emailaddress fiend
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Password",style: TextStyle(color: globals.sGreen, fontSize: 16, fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
                      Text("Forgot?",style: TextStyle(color: globals.sGreen, fontSize: 16, fontWeight: FontWeight.normal),textAlign: TextAlign.start,),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: TextField(
                      onChanged: (text){
                        newUser.password=text;
                      },
                      onSubmitted: (text){
                        newUser.password=text;
                        checkLogin();
                      },
                      obscureText: true,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
                  child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width-80,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: RaisedButton(
                        color: globals.sGreen,
                        child: Text("Login",style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),),
                        onPressed: (){
                          print("login");
                          checkLogin();
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 40, 40, 40),
                  child: FlatButton(
                    onPressed: (){
                      subView="Register";
                      setState(() {});
                    },
                    child: Text("New user? Register here",style: TextStyle(color: globals.sGreen, fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, (MediaQuery.of(context).size.height-478)/2),
                )
                //disclaimer text
                //switch to login
              ],
            ),
          )
          :
              Container()
          ,
          (subView=="Intro")?
              Container(
                color: globals.sBackground,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(height: (MediaQuery.of(context).size.height - 300)/4,),
                    Image(image: AssetImage('images/logo.png'),height: 200,width: 200,),
                    Text("Survivors",textAlign: TextAlign.center,style: TextStyle(color: globals.sBlue,fontSize: 35,fontWeight: FontWeight.bold),),
                    Container(height: (MediaQuery.of(context).size.height - 300)/4,),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Text("Each one of us has the power to prevent the Corona pandemic",textAlign: TextAlign.center,style: TextStyle(color: globals.sBlue,fontSize: 20,fontWeight: FontWeight.bold),maxLines: 2,),
                    ),
                    Container(height: (MediaQuery.of(context).size.height - 300)/4,),
                    SizedBox(
                      height: 40,
                      width: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: RaisedButton(
                          color: globals.sGreen,
                          child: Text("Get Started",style: TextStyle(color: Colors.white, fontSize: 25,fontWeight: FontWeight.bold),),
                          onPressed: (){
                            subView="Register";
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(40, 20, 40,51),
                      child: FlatButton(
                        onPressed: (){
                          subView="Login";
                          setState(() {});
                        },
                        child: Text("Already registered? Login here",style: TextStyle(color: globals.sGreen, fontSize: 12, fontStyle: FontStyle.italic, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      ),
                    ), //button
                  ],
                ),
              )
          :
              Container(),
          /*
          Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 20, 5),
            child: Text("Welcome to Survivor",style: TextStyle(color: globals.sBlue, fontSize: 20, fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 20, 5),
            child: Text("This app is designed to help you with managing your long term recovery from the Corona virus.",style: TextStyle(color: globals.sPink, fontSize: 16, fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 20, 5),
            child: Text("At this time, it is unknown whether there are long term effects from having had Corona virus, so this app helps you monitor your condition long term so that any difficulties can be detected early.",style: TextStyle(color: globals.sPink, fontSize: 16, fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 20, 5),
            child: Text("In additiona, we would like to make this data available to researchers so that they might learn more about pandemics and their long term impacts. If you allow us to share your data, we promise that no-one will be able to tell that they data they are using is yours. Everything unique about you will be hidden.",style: TextStyle(color: globals.sPink, fontSize: 16, fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 20, 5),
            child: Text("And naturally, if they find anything interesting, you will be one of the first to know.",style: TextStyle(color: globals.sPink, fontSize: 16, fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 20, 5),
            child: Text("So, for now, let us know if you would like to share you data. You can change this decision any time in your profile settings.",style: TextStyle(color: globals.sPink, fontSize: 16, fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(5, 20, 20, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(onPressed: (){
                  print("SHARE Pressed");
                  globals.share=true;
                  globals.currentView="Summary";
                  globals.userId="slskdjskskjdslsjdlslsjflsdgjha";
                  widget.callbackToHome();
                  },child: Text("Yes, Share"),color: globals.sBlue,),
                RaisedButton(onPressed: (){
                  print("NOSHARE Pressed");
                  globals.share=false;
                  globals.currentView="Summary";
                  globals.userId="slskdjskskjdslsjdlslsjflsdgjha";
                  widget.callbackToHome();
                },child: Text("Do not share"),color: globals.sBlue,)
              ],
            ),
          ),
           */
        ],
      ),
    );
  }
}