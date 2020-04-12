import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:survivor/globals.dart' as globals;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:survivor/database.dart';

class SummaryView extends StatefulWidget {
  final Function callbackToHome;
  SummaryView({Key key,this.callbackToHome}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SummaryState();
  }
}

class _SummaryState extends State<SummaryView> {
  var db = new DatabaseHelper();

  bool neverInfected = true;
  String socialDistancing;
  String clinicalDiagnosis;
  String testResultPositive;
  String homeQuarantine;
  String hospitalAdmission;
  String icuAdmission;
  String intubation;
  String extubation;
  String icuDischarge;
  String hospitalDischarge;
  String clinicalClearance;
  String currentStatus = "Never infected";

  String settingDateFor;

  String questionBlock="Status";

  int symptomScore = 0;

  User user;
  Daily dailyResults;

  @override
  initState() {
    getStatuses();
    super.initState();
  }
  getUser() async{
    user = await db.getUser(globals.userId);
    setState(() {});
  }

  getDailyData() async{
    if(globals.selectedDate == null){
      globals.selectedDate = db.dateToString(DateTime.now());
    }
    print(globals.selectedDate);
    dailyResults = await db.getDaily(globals.selectedDate);
    print(dailyResults);
    recalculateSymptomScore();
  }

  getStatuses() async{
    Event siTest = await db.getEvent("socialDistancing");
    socialDistancing = siTest.eventDate;
    Event cdTest = await db.getEvent("clinicalDiagnosis");
    clinicalDiagnosis = cdTest.eventDate;
    Event tpTest = await db.getEvent('testResultPositive');
    testResultPositive = tpTest.eventDate;
    Event hqTest = await db.getEvent('homeQuarantine');
    homeQuarantine = hqTest.eventDate;
    Event haTest = await db.getEvent("hospitalAdmission");
    hospitalAdmission = haTest.eventDate;
    Event iaTest = await db.getEvent('icuAdmission');
    icuAdmission = iaTest.eventDate;
    Event itTest = await db.getEvent("intubation");
    intubation = itTest.eventDate;
    Event exTest = await db.getEvent('extubation');
    extubation = exTest.eventDate;
    Event idTest = await db.getEvent('icuDischarge');
    icuDischarge = idTest.eventDate;
    Event hdTest = await db.getEvent('hospitalDischarge');
    hospitalDischarge = hdTest.eventDate;
    Event ccTest = await db.getEvent('clinicalClearance');
    clinicalClearance = ccTest.eventDate;

    if(clinicalDiagnosis!="00/00/0000 - 00:00"){
      neverInfected=false;
      currentStatus="Clinically diagnosed";
    }
    if(testResultPositive!="00/00/0000 - 00:00"){
      neverInfected=false;
      currentStatus="Tested positive";
    }
    if(homeQuarantine!="00/00/0000 - 00:00"){
      neverInfected=false;
      currentStatus="Home quarantined";
    }
    if(hospitalAdmission!="00/00/0000 - 00:00"){
      neverInfected=false;
      currentStatus="Admitted to Hospital";
    }
    if(icuAdmission!="00/00/0000 - 00:00"){
      neverInfected=false;
      currentStatus="Admitted to ICU";
    }
    if(intubation!="00/00/0000 - 00:00") {
      neverInfected = false;
      currentStatus="Intubated";
    }
    if(extubation!="00/00/0000 - 00:00") {
      neverInfected = false;
      currentStatus="Admitted to ICU";
    }
    if(icuDischarge!="00/00/0000 - 00:00") {
      neverInfected = false;
      currentStatus="Admitted to Hospital";
    }
    if(hospitalDischarge!="00/00/0000 - 00:00") {
      neverInfected = false;
      currentStatus = "Discharged from Hospital";
    }
    if(clinicalClearance!="00/00/0000 - 00:00") {
      neverInfected = false;
      currentStatus="Recovered";
    }

    print(clinicalDiagnosis);
    setState(() {});
  }

  recalculateSymptomScore(){
    print(dailyResults.fever.toString()+" "+dailyResults.temperature.toString()+" "+dailyResults.tasteSmell.toString()+" "+dailyResults.nasal.toString()+" "+dailyResults.tiredness.toString()+" "+dailyResults.breathing.toString()+" "+dailyResults.coughStrength.toString()+" "+dailyResults.coughType.toString());
    symptomScore = 0;
    if(dailyResults.fever==1)symptomScore++;
    if(dailyResults.temperature > 38)symptomScore++;
    if(dailyResults.tasteSmell>2)symptomScore++;
    if(dailyResults.nasal==3)symptomScore++;
    if(dailyResults.throat>2)symptomScore++;
    if(dailyResults.tiredness>2)symptomScore++;
    if(dailyResults.breathing>2)symptomScore++;
    if(dailyResults.coughStrength>2)symptomScore++;
    if(dailyResults.coughType==2)symptomScore++;

    if(dailyResults.tasteSmell==9)symptomScore--;
    if(dailyResults.nasal==9)symptomScore--;
    if(dailyResults.throat==9)symptomScore--;
    if(dailyResults.tiredness==9)symptomScore--;
    if(dailyResults.breathing==9)symptomScore--;
    if(dailyResults.coughStrength==9)symptomScore--;
    if(dailyResults.coughType==9)symptomScore--;
    setState(() {});
  }

  @override
  void didUpdateWidget( oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    print(settingDateFor);
    if (picked != null){
      switch(settingDateFor){
        case 'socialDistancing':
          socialDistancing=db.dateToString(picked);
          print(settingDateFor+" set to "+db.dateToString(picked));
          break;
        case 'clinicalDiagnosis':
          clinicalDiagnosis=db.dateToString(picked);
          print(settingDateFor+" set to "+db.dateToString(picked));
          break;
        case 'testResultPositive':
          testResultPositive=db.dateToString(picked);
          print(settingDateFor+" set to "+db.dateToString(picked));
          break;
        case 'homeQuarantine':
          homeQuarantine=db.dateToString(picked);
          print(settingDateFor+" set to "+db.dateToString(picked));
          break;
        case 'hospitalAdmission':
          hospitalAdmission=db.dateToString(picked);
          print(settingDateFor+" set to "+db.dateToString(picked));
          break;
        case 'icuAdmission':
          icuAdmission=db.dateToString(picked);
          print(settingDateFor+" set to "+db.dateToString(picked));
          break;
        case 'intubation':
          intubation==db.dateToString(picked);
          print(settingDateFor+" set to "+db.dateToString(picked));
          break;
        case 'extubation':
          extubation=db.dateToString(picked);
          print(settingDateFor+" set to "+db.dateToString(picked));
          break;
        case 'icuDischarge':
          icuDischarge=db.dateToString(picked);
          print(settingDateFor+" set to "+db.dateToString(picked));
          break;
        case 'hospitalDischarge':
          hospitalDischarge=db.dateToString(picked);
          print(settingDateFor+" set to "+db.dateToString(picked));
          break;
        case 'clinicalClearance':
          clinicalClearance=db.dateToString(picked);
          print(settingDateFor+" set to "+db.dateToString(picked));
          break;
        default:
          break;
      }
      Event newEvent = new Event();
      newEvent.eventName=settingDateFor;
      newEvent.eventDate=db.dateToString(picked);
      newEvent.eventSeverity=0;
      newEvent.updatedDate=db.dateToString(DateTime.now());
      print(newEvent.toString());
      if(settingDateFor!=null) {
        await db.insertEvent(newEvent);
      }else{
        print("settingDateFor is null");
      }
      settingDateFor=null;
      setState(() {});
    }
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
                child:Text("Phase",style:TextStyle(color:globals.sGreen,fontSize:30,fontWeight:FontWeight.bold)),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child:Text("To track your overall health and path to recovery, please keep this section up to date.",style:TextStyle(color: globals.sGreen,fontSize: 16,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
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
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          border: Border.all(width: 3,style: BorderStyle.solid,color:(questionBlock=="Diagnosis")?globals.sGreen:Colors.white, )
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                              border: Border.all(width: 3,style: BorderStyle.solid,color:globals.sGreen,)
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            onPressed: (){
                              questionBlock="Diagnosis";
                              setState(() {});
                            },
                            child: Text("Diagnosis",style: TextStyle(color: globals.sGreen,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          border: Border.all(width: 3,style: BorderStyle.solid,color:(questionBlock=="Symptoms")?globals.sBlue:Colors.white, )
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                              border: Border.all(width: 3,style: BorderStyle.solid,color:globals.sGreen,)
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            onPressed: (){
                              questionBlock="Symptoms";
                              setState(() {});
                            },
                            child: Text("Symptoms",style: TextStyle(color: globals.sGreen,fontSize: 10,fontWeight: FontWeight.bold),maxLines: 1,textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          border: Border.all(width: 3,style: BorderStyle.solid,color:(questionBlock=="Treatment")?globals.sGreen:Colors.white, )
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        child: Container(
                          height: 70,
                          width: 70,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(35)),
                              border: Border.all(width: 3,style: BorderStyle.solid,color:globals.sGreen,)
                          ),
                          child: FlatButton(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            onPressed: (){
                              questionBlock="Treatment";
                              setState(() {});
                            },
                            child: Text("Treatment",style: TextStyle(color: globals.sGreen,fontSize: 10,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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
          (questionBlock=="Diagnosis")?
          Padding(
            padding:EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
              width: MediaQuery.of(context).size.width-20,
              height: MediaQuery.of(context).size.height-283,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child:Column(
                children: <Widget>[
                  Padding(
                    padding:EdgeInsets.fromLTRB(0,0,0,0),
                  ),
                  (neverInfected)?
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                    child: Row(
                      children: <Widget>[
                        Text("Never diagnosed",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      ],
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                    child: Row(
                      children: <Widget>[
                        Text(currentStatus,style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      ],
                    ),
                  )
                  ,
                  (socialDistancing=="00/00/0000 - 00:00")?
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Social distancing",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 60,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="socialDistancing";
                                  _selectDate(context);
                                  },
                                child: Text("UPDATE",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Social distancing",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 90,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="socialDistancing";
                                  _selectDate(context);
                                },
                                child: Text(socialDistancing.toString(),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                  ,
                  (clinicalDiagnosis=="00/00/0000 - 00:00")?
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Diagnosed by a Doctor",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 60,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="clinicalDiagnosis";
                                  _selectDate(context);
                                },
                                child: Text("UPDATE",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Diagnosed by a Doctor",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 90,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="clinicalDiagnosis";
                                  _selectDate(context);
                                },
                                child: Text(clinicalDiagnosis,style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                  ,
                  (testResultPositive=="00/00/0000 - 00:00")?
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Test results positive",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 60,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="testResultPositive";
                                  _selectDate(context);
                                },
                                child: Text("UPDATE",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Test results positive",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 90,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="testResultPositive";
                                  _selectDate(context);
                                },
                                child: Text(testResultPositive.toString(),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                  ,
                  (homeQuarantine=="00/00/0000 - 00:00")?
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Home quarantine",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 60,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="homeQuarantine";
                                  _selectDate(context);
                                },
                                child: Text("UPDATE",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Home quarantine",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 90,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="homeQuarantine";
                                  _selectDate(context);
                                },
                                child: Text(homeQuarantine.toString(),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                  ,
                  (hospitalAdmission=="00/00/0000 - 00:00")?
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Admitted to Hospital",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 60,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="hospitalAdmission";
                                  _selectDate(context);
                                },
                                child: Text("UPDATE",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Admitted to Hospital",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 90,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="hospitalAdmission";
                                  _selectDate(context);
                                },
                                child: Text(hospitalAdmission.toString(),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                  ,
                  (icuAdmission=="00/00/0000 - 00:00")?
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Admitted to ICU",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 60,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="icuAdmission";
                                  _selectDate(context);
                                },
                                child: Text("UPDATE",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Admitted to ICU",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 90,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="icuAdmission";
                                  _selectDate(context);
                                },
                                child: Text(icuAdmission.toString(),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                  ,
                  (intubation=="00/00/0000 - 00:00")?
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Intubated"+intubation,style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 60,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="intubation";
                                  _selectDate(context);
                                },
                                child: Text("UPDATE",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Intubated"+intubation,style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 90,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="intubation";
                                  _selectDate(context);
                                },
                                child: Text(intubation.toString(),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                  ,
                  (extubation=="00/00/0000 - 00:00")?
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Extubated",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 60,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="extubation";
                                  _selectDate(context);
                                },
                                child: Text("UPDATE",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Extubated",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 90,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="extubation";
                                  _selectDate(context);
                                },
                                child: Text(extubation.toString(),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                  ,
                  (icuDischarge=="00/00/0000 - 00:00")?
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Discharged from ICU",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 60,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="icuDischarge";
                                  _selectDate(context);
                                },
                                child: Text("UPDATE",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Discharged from ICU",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 90,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="icuDischarge";
                                  _selectDate(context);
                                },
                                child: Text(icuDischarge.toString(),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                  ,
                  (hospitalDischarge=="00/00/0000 - 00:00")?
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Discharge from Hospital",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 60,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="hospitalDischarge";
                                  _selectDate(context);
                                },
                                child: Text("UPDATE",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Discharged from Hospital",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 90,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="hospitalDischarge";
                                  _selectDate(context);
                                },
                                child: Text(hospitalDischarge.toString(),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                  ,
                  (clinicalClearance=="00/00/0000 - 00:00")?
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Cleared by Doctor",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 60,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="clinicalClearance";
                                  _selectDate(context);
                                },
                                child: Text("UPDATE",style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                      :
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:<Widget>[
                          Text("Cleared by Doctor",style: TextStyle(color: globals.sGreen, fontSize: 20, fontWeight: FontWeight.bold),),
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Container(
                              height: 30,
                              width: 90,
                              child: RaisedButton(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                color: globals.sBlue,
                                onPressed: (){
                                  settingDateFor="clinicalClearance";
                                  _selectDate(context);
                                },
                                child: Text(clinicalClearance.toString(),style: TextStyle(color: Colors.white),),
                              ),
                            ),
                          ),
                        ]
                    ),
                  )
                  ,
                  FlatButton(
                    child:Text("reset"),
                    onPressed: (){
                      getStatuses();
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),

          )
              :
          Container()
          ,
          (questionBlock=="Symptoms")?
          Padding(
              padding:EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: <Widget>[
                      Text("Fever"),
                      Text("Cough"),
                      Text("Difficulty breathing"),
                      Text("Tiredness"),
                      Text("Sore throat"),
                      Text("Runny nose"),
                      Text("Loss of taste/smell"),
                ],
              )
          )
              :
          Container()
          ,
          (questionBlock=="Treatment")?
          Column(
            children:<Widget>[
            Text("Oxygen therapy"),
            Text("NSAIDs(eg:.....)"),
            Text("Paracetamol"),
            Text("Antibiotics (eg:. azithromycin)"),
            Text("Antimalarial drugs"),
            Text("Antiviral drugs"),
            Text("Systemic glucocorticosteroids"),
            Text("Plasma"),
            Text("Other"),
],
    )
              :
          Container()
          ,
          (questionBlock=="History")?
          Column()
              :
          Container()
          ,
          (questionBlock=="Chronic")?
          Column()
              :
          Container()
          ,

        ],
      ),
    );
  }
}