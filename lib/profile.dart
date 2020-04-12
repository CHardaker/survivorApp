import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:survivor/globals.dart' as globals;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:survivor/database.dart';

class ProfileView extends StatefulWidget {
  final Function callbackToHome;
  ProfileView({Key key,this.callbackToHome}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<ProfileView> {
  var db = new DatabaseHelper();

  User user;
  Attributes attributes;
  String birthMonth;
  String birthYear;

  @override
  initState() {
    super.initState();
    getData();
  }

  getData() async{
    user = await db.getUser(globals.userId);
    attributes = await db.getAttributes();

    print(user);
    print(attributes);
    setState(() {});
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
          child: Column(
            children:<Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Text("Below is information that would really help researchers put your data to good use. \nWe will NOT share your email address.",maxLines: 5,style: TextStyle(color: globals.sTan, fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
              ),
              (user == null || user.email == null || user.email=="unknown")?
                  Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Please enter your email address.",style: TextStyle(color:Colors.black,fontSize: 14),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          width: 300,
                          height: 25,
                          child: TextField(
                            onChanged: (text){
                              user.email=text;
                            },
                            onSubmitted: (text){
                              user.email=text;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              :
                  Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Your email address.",style: TextStyle(color:Colors.black,fontSize: 14),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(user.email,style: TextStyle(color:Colors.black,fontSize: 14),),
                        Container(
                          width: 5,
                        ),
                        SizedBox(
                          height: 20,
                          width: 80,
                          child: RaisedButton(
                            onPressed: (){
                              print("changeEmail");
                            },
                            child: Text("CHANGE",style: TextStyle(color: Colors.black, fontSize: 10),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              ,

              (user == null || user.dateOfBirth == null || user.dateOfBirth=="unknown")?
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text("Please select the month and year of your birth.",style: TextStyle(color:Colors.black,fontSize: 14),),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          DropdownButton<String>(
                            items: <String>['Jan', 'Feb', 'Mar', 'Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              birthMonth=value;
                              if(birthYear!=null) {
                                user.dateOfBirth = birthMonth + "/" + birthYear;
                                if (user.dateOfBirth.length == 8) {
                                  setState(() {});
                                }
                              }
                            },
                          ),
                          DropdownButton<String>(
                            items: <String>['2020','2019','2018','2017','2016','2015','2014','2013','2012','2011','2010','2009','2008','2007','2006','2005','2004','2003','2002','2001','2000','1999','1998','1997','1996','1995','1994','1993','1992','1991','1990','1989','1988','1987','1986','1985','1984','1983','1982','1981','1980','1979','1978','1977','1976','1975','1974','1973','1972','1971','1970','1969','1968','1967','1966','1965','1964','1963','1962','1961','1960','1959','1958','1957','1956','1955','1954','1953','1952','1951','1950','1949','1948','1947','1946','1945','1944','1943','1942','1941','1940','1939','1938','1937','1936','1935','1934','1933','1932','1931','1930','1929','1928','1927','1926','1925','1924','1923','1922','1921'].map((String value) {
                              return new DropdownMenuItem<String>(
                                value: value,
                                child: new Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              birthYear=value;
                              if(birthMonth!=null) {
                                user.dateOfBirth = birthMonth + "/" + birthYear;
                                if (user.dateOfBirth.length == 8) {
                                  setState(() {});
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ],
                  )
              :
                  Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Your date of birth.",style: TextStyle(color:Colors.black,fontSize: 14),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(user.dateOfBirth,style: TextStyle(color:Colors.black,fontSize: 14),),
                        Container(
                          width: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              )
              ,
              (user==null || user.geneticGender == null || user.geneticGender=="unknown")?
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Please select your genetic gender.",style: TextStyle(color:Colors.black,fontSize: 14),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5,0,5,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                              width:70,
                              child: RaisedButton(
                                onPressed: (){
                                  user.geneticGender="M";
                                  setState(() {});
                                },
                                child: Text("Male",style: TextStyle(color: Colors.black,fontSize: 14),),
                              ),
                            ),
                            SizedBox(width: 5,),
                            SizedBox(
                              height: 20,
                              width: 90,
                              child: RaisedButton(
                                onPressed: (){
                                  user.geneticGender="F";
                                  setState(() {});
                                },
                                child: Text("Female",style: TextStyle(color: Colors.black,fontSize: 14),),
                              ),
                            ),
                            SizedBox(width: 5,),
                            SizedBox(
                              height: 20,
                              width: 80,
                              child: RaisedButton(
                                onPressed: (){
                                  user.geneticGender="O";
                                  setState(() {});
                                },
                                child: Text("Other",style: TextStyle(color: Colors.black,fontSize: 14),),
                              ),
                            ),
                            SizedBox(width: 5,),
                            SizedBox(
                              height: 20,
                              width: 60,
                              child: RaisedButton(
                                onPressed: (){
                                  user.geneticGender="N";
                                  setState(() {});
                                },
                                child: Text("No",style: TextStyle(color: Colors.black,fontSize: 14),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              :
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Your genetic gender is recorded as",style: TextStyle(color:Colors.black,fontSize: 14),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(user.geneticGender,style: TextStyle(color:Colors.black,fontSize: 14),)
                          ],
                        ),
                      ),
                    ],
                  )
              ,
              (attributes==null||attributes.country==null||attributes.country=="U")?
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Please enter your country of residence",style: TextStyle(color:Colors.black,fontSize: 14),),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                              width: 200,
                              child: TextField(
                                onChanged: (text){
                                  attributes.country=text;
                                },
                                onSubmitted: (text){
                                  attributes.country=text;
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              :
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Your country of residence is recorded as",style: TextStyle(color:Colors.black,fontSize: 14),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5,0,5,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(attributes.country,style: TextStyle(color:Colors.black,fontSize: 14),),
                            Container(
                              width: 5,
                            ),
                            SizedBox(
                              height: 20,
                              width: 80,
                              child: RaisedButton(
                                onPressed: (){
                                  print("changeCountry");
                                },
                                child: Text("CHANGE",style: TextStyle(color: Colors.black, fontSize: 10),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ,
              (attributes==null||attributes.postCode==null||attributes.postCode=="U")?
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Please enter your postcode",style: TextStyle(color:Colors.black,fontSize: 14),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                          width: 200,
                          child: TextField(
                            onChanged: (text){
                              attributes.postCode=text;
                            },
                            onSubmitted: (text){
                              attributes.postCode=text;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  :
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Your postcode is recorded as",style: TextStyle(color:Colors.black,fontSize: 14),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5,0,5,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(attributes.postCode,style: TextStyle(color:Colors.black,fontSize: 14),),
                        Container(
                          width: 5,
                        ),
                        SizedBox(
                          height: 20,
                          width: 80,
                          child: RaisedButton(
                            onPressed: (){
                              print("changePosstcode");
                            },
                            child: Text("CHANGE",style: TextStyle(color: Colors.black, fontSize: 10),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              ,
              (attributes==null||attributes.education==null||attributes.education=="U")?
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Please select your highest educational achievement ",style: TextStyle(color:Colors.black,fontSize: 14),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            DropdownButton<String>(
                              items: <String>['Primary', 'Secondary', 'Some Tertiary', 'Bachelors','Doctorate','Masters','Multiple degrees','Other'].map((String value) {
                                return new DropdownMenuItem<String>(
                                  value: value,
                                  child: new Text(value),
                                );
                              }).toList(),
                              onChanged: (value) {
                                attributes.education=value;
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              :
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("Your highest educational achievement is recorded as",style: TextStyle(color:Colors.black,fontSize: 14),)
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5,0,5,0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(attributes.education,style: TextStyle(color:Colors.black,fontSize: 14),),
                            Container(
                              width: 5,
                            ),
                            SizedBox(
                              height: 20,
                              width: 80,
                              child: RaisedButton(
                                onPressed: (){
                                  print("changeEducation");
                                },
                                child: Text("CHANGE",style: TextStyle(color: Colors.black, fontSize: 10),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
              ,
              (attributes==null||attributes.maritalStatus==null||attributes.maritalStatus=="U")?
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Please select your marital status ",style: TextStyle(color:Colors.black,fontSize: 14),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        DropdownButton<String>(
                          items: <String>['Single', 'Living together', 'Married', 'Divorced','Widowed','Polygamy','Polyamorous','Other'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            attributes.maritalStatus=value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  :
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Your marital status is recorded as",style: TextStyle(color:Colors.black,fontSize: 14),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5,0,5,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(attributes.maritalStatus,style: TextStyle(color:Colors.black,fontSize: 14),),
                        Container(
                          width: 5,
                        ),
                        SizedBox(
                          height: 20,
                          width: 80,
                          child: RaisedButton(
                            onPressed: (){
                              print("changeMaritalStatus");
                            },
                            child: Text("CHANGE",style: TextStyle(color: Colors.black, fontSize: 10),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              ,
              (attributes==null||attributes.livingStatus==null||attributes.livingStatus=="U")?
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Please select your living status ",style: TextStyle(color:Colors.black,fontSize: 14),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        DropdownButton<String>(
                          items: <String>['Alone', 'Flatting', 'Partner', 'Family','Commune','Kabutz','Homeless','Other'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            attributes.livingStatus=value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  :
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Your living status is recorded as",style: TextStyle(color:Colors.black,fontSize: 14),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5,0,5,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(attributes.livingStatus,style: TextStyle(color:Colors.black,fontSize: 14),),
                        Container(
                          width: 5,
                        ),
                        SizedBox(
                          height: 20,
                          width: 80,
                          child: RaisedButton(
                            onPressed: (){
                              print("changeLivingStatus");
                            },
                            child: Text("CHANGE",style: TextStyle(color: Colors.black, fontSize: 10),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              ,
              (attributes==null||attributes.employmentStatus==null||attributes.employmentStatus=="U")?
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Please select your employment status ",style: TextStyle(color:Colors.black,fontSize: 14),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        DropdownButton<String>(
                          items: <String>['Student', 'Unemployed', 'Self employed', 'Part time','Full time','Retired','Sabatical','Parental leave','Other'].map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            attributes.employmentStatus=value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  :
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Your employment status is recorded as",style: TextStyle(color:Colors.black,fontSize: 14),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5,0,5,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(attributes.employmentStatus,style: TextStyle(color:Colors.black,fontSize: 14),),
                        Container(
                          width: 5,
                        ),
                        SizedBox(
                          height: 20,
                          width: 80,
                          child: RaisedButton(
                            onPressed: (){
                              print("changeEmploymentStatus");
                            },
                            child: Text("CHANGE",style: TextStyle(color: Colors.black, fontSize: 10),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              ,
              (attributes==null||attributes.height==null||attributes.height==0||attributes.heightUnits==null||attributes.heightUnits=="U")?
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Please enter your height and select the appropriate units",style: TextStyle(color:Colors.black,fontSize: 14),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        (attributes==null||attributes.height==null||attributes.height==0)?
                            SizedBox(
                              height: 20,
                              width: 100,
                              child: TextField(
                                onChanged: (text){
                                  attributes.height = int.parse(text);
                                },
                                onSubmitted: (text){
                                  attributes.height = int.parse(text);
                                  setState(() {});
                                },
                              ),
                            )
                        :
                            Text(attributes.height.toString(),style: TextStyle(color:Colors.black,fontSize: 14),)
                        ,
                        (attributes==null||attributes.heightUnits==null||attributes.heightUnits=="U")?
                            RaisedButton(
                              child: Text("inches",style: TextStyle(color:Colors.black,fontSize: 14),),
                              onPressed: (){
                                attributes.heightUnits=" inches";
                                setState(() {});
                                },
                            )
                        :
                            Container()
                        ,
                        (attributes==null||attributes.heightUnits==null||attributes.heightUnits=="U")?
                            RaisedButton(
                              child: Text("cms",style: TextStyle(color:Colors.black,fontSize: 14),),
                              onPressed: (){
                                attributes.heightUnits=" cms";
                                setState(() {});
                                },
                            )
                        :
                            Text(attributes.heightUnits,style: TextStyle(color:Colors.black,fontSize: 14),)
                        ,
                      ],
                    ),
                  ),
                ],
              )
                  :
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Your height is recorded as",style: TextStyle(color:Colors.black,fontSize: 14),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5,0,5,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(attributes.height.toString()+attributes.heightUnits,style: TextStyle(color:Colors.black,fontSize: 14),),
                        Container(
                          width: 5,
                        ),
                        SizedBox(
                          height: 20,
                          width: 80,
                          child: RaisedButton(
                            onPressed: (){
                              print("changeHeight");
                            },
                            child: Text("CHANGE",style: TextStyle(color: Colors.black, fontSize: 10),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              ,
              (attributes==null||attributes.weight==null||attributes.weight==0||attributes.weightUnits==null||attributes.weightUnits=="U")?
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Please enter your weight and select the appropriate units",style: TextStyle(color:Colors.black,fontSize: 14),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        (attributes==null||attributes.weight==null||attributes.weight==0)?
                        SizedBox(
                          height: 20,
                          width: 100,
                          child: TextField(
                            onChanged: (text){
                              attributes.weight = int.parse(text);
                            },
                            onSubmitted: (text){
                              attributes.weight = int.parse(text);
                              setState(() {});
                            },
                          ),
                        )
                            :
                        Text(attributes.weight.toString(),style: TextStyle(color:Colors.black,fontSize: 14),)
                        ,
                        (attributes==null||attributes.weightUnits==null||attributes.weightUnits=="U")?
                            RaisedButton(
                              child: Text("lbs",style: TextStyle(color:Colors.black,fontSize: 14),),
                              onPressed: (){
                                attributes.weightUnits=" lbs";
                                setState(() {});
                                },
                            )
                            :
                            Container()
                            ,
                        (attributes==null||attributes.weightUnits==null||attributes.weightUnits=="U")?
                            RaisedButton(
                              child: Text("kgs",style: TextStyle(color:Colors.black,fontSize: 14),),
                              onPressed: (){
                                attributes.weightUnits=" kgs";
                                setState(() {});
                              },
                            )
                            :
                            Text(attributes.weightUnits,style: TextStyle(color:Colors.black,fontSize: 14),)
                        ,
                      ],
                    ),
                  ),
                ],
              )
                  :
              Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Your weight is recorded as",style: TextStyle(color:Colors.black,fontSize: 14),)
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5,0,5,0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(attributes.weight.toString()+attributes.weightUnits,style: TextStyle(color:Colors.black,fontSize: 14),),
                        Container(
                          width: 5,
                        ),
                        SizedBox(
                          height: 20,
                          width: 80,
                          child: RaisedButton(
                            onPressed: (){
                              print("changeWeight");
                            },
                            child: Text("CHANGE",style: TextStyle(color: Colors.black, fontSize: 10),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              ,
            ]

          ),
        )
    );
  }
}