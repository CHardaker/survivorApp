import 'package:flutter/material.dart';
import 'package:survivor/intro.dart';
import 'package:survivor/status.dart';
import 'package:survivor/equipment.dart';
import 'package:survivor/daily.dart';
import 'package:survivor/weekly.dart';
import 'package:survivor/profile.dart';
import 'package:survivor/summary.dart';

import 'package:survivor/database.dart';
import 'package:survivor/globals.dart' as globals;
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  var db = new DatabaseHelper();

  String _currentDateTimeString;
  String currentView = globals.currentView;

  @override
  void initState(){
    super.initState();
    final DateTime now = DateTime.now();
    _currentDateTimeString = _formatDateTime(now);
    Timer.periodic(Duration(seconds: 60), (Timer t) => _getTime());
    if(globals.userId=='tempUser'){
      globals.currentView="Intro";
    }else {
      getSavedData();
    }
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.paused:
        setSavedData();
        print("state paused");
        break;
      case AppLifecycleState.inactive:
        print("state inactive");
        break;
      case AppLifecycleState.resumed:
        getSavedData();
        print("state resumed");
        break;
      case AppLifecycleState.detached:
        print("state detached");
        break;
    }
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _callBackToMain(String newView){
    print("callbackToMain received");
    globals.currentView = newView;
    print(globals.currentView);
    setState(() {});
  }

  Container getCustomContainer(){
    print("currentView " + globals.currentView);
    if(globals.userId=="tempUser"){
      globals.currentView="Intro";
    }else if(globals.history==false){
      globals.currentView="Status";
    }

    switch(globals.currentView){
      case "Intro":
        return Container(
          child: IntroView(callbackToHome: _callBackToMain),
        );
        break;
      case "Profile":
        return Container(
          child: ProfileView(),
        );
        break;
      case "Summary":
        return Container(
          child: SummaryView(callbackToHome: _callBackToMain),
        );
        break;
      case "Status":
        return Container(
          child: StatusView(callbackToHome: _callBackToMain),
        );
        break;
      case "Equipment":
        return Container(
          child: EquipmentView(),
        );
        break;
      case "Daily":
        return Container(
          child: DailyView(),
        );
        break;
      case "Weekly":
        return Container(
          child: WeeklyView(),
        );
        break;
      case "IntroView":
        return Container(
          child: IntroView(),
        );
        break;
    }
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Survivor',
      home: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: getCustomContainer(),
              ),
    );
  }

  void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);
    setState(() {
      _currentDateTimeString = formattedDateTime;
    });
  }

  String _formatDateTime(DateTime dateTime) {
    print(_currentDateTimeString);
    return DateFormat('dd/MM/yy HH:mm').format(dateTime);
  }

  String _generateKey(String userId, String key) {
    return '$userId/$key';
  }

  void getSavedData() async{
    print("getSavedData");
    var prefs = await SharedPreferences.getInstance();

    globals.token = await prefs.getString(_generateKey(globals.userId, 'token'));

    globals.userId = await prefs.getString(_generateKey(globals.userId, 'userId'));
    globals.currentView = await prefs.getString(_generateKey(globals.userId, 'currentView'));
    globals.currentState = await prefs.getString(_generateKey(globals.userId, 'currentState'));
    globals.share = await prefs.getBool(_generateKey(globals.userId, 'share'));
    globals.history = await prefs.getBool(_generateKey(globals.userId, 'history'));
    globals.hasThermometer = await prefs.getBool(_generateKey(globals.userId, "hasThermometer"));
    globals.hasScales = await prefs.getBool(_generateKey(globals.userId, "hasScales"));
    globals.hasBPCuff = await prefs.getBool(_generateKey(globals.userId, "hasBPCuff"));
    globals.hasPeakFlow = await prefs.getBool(_generateKey(globals.userId, "hasPeakFlow"));

    if(globals.token == null)globals.token="thisisnotarealtoken";
    if(globals.userId == null)globals.userId="tempUser";
    if(globals.currentView == null)globals.currentView="intro";
    if(globals.currentState == null)globals.currentState="NI";
    if(globals.share == null)globals.share=false;
    if(globals.history == null)globals.history=false;
    if(globals.hasThermometer == null)globals.hasThermometer=false;
    if(globals.hasScales == null)globals.hasScales=false;
    if(globals.hasBPCuff == null)globals.hasBPCuff=false;
    if(globals.hasPeakFlow == null)globals.hasPeakFlow=false;

    setSavedData();
    print('settings loaded and resaved');
  }

  void setSavedData() async{
    print("setSavedData");
    var prefs = await SharedPreferences.getInstance();

    await prefs.setString(_generateKey(globals.userId, 'token'),globals.token);

    await prefs.setString(_generateKey(globals.userId, 'userId'),globals.userId);
    await prefs.setString(_generateKey(globals.userId, 'currentView'),globals.currentView);
    await prefs.setString(_generateKey(globals.userId, 'currentState'),globals.currentState);
    await prefs.setBool(_generateKey(globals.userId, 'share'),globals.share);
    await prefs.setBool(_generateKey(globals.userId, 'history'),globals.history);
    await prefs.setBool(_generateKey(globals.userId, 'hasThermometer'),globals.hasThermometer);
    await prefs.setBool(_generateKey(globals.userId, 'hasScales'),globals.hasScales);
    await prefs.setBool(_generateKey(globals.userId, 'hasBPCuff'),globals.hasBPCuff);
    await prefs.setBool(_generateKey(globals.userId, 'hasPeakFlow'),globals.hasPeakFlow);

    print("data saved");
  }
}