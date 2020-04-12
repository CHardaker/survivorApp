import 'dart:async';
import 'dart:io' as io;
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "main.db");
    var theDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute("CREATE TABLE user(id TEXT PRIMARY KEY, createDate TEXT, name TEXT, email TEXT, username TEXT, password TEXT, dateOfBirth TEXT, geneticGender TEXT, updatedDate TEXT)");
    await db.execute("CREATE TABLE userAttributes(id INTEGER PRIMARY KEY, identifiedGender TEXT, ppn TEXT, country TEXT, postCode TEXT, education TEXT, maritalStatus TEXT, livingStatus TEXT, employmentStatus TEXT, height TEXT, heightUnits TEXT, weight TEXT, weightUnits TEXT, smoker TEXT, drinker TEXT, updatedDate TEXT)");
    await db.execute("CREATE TABLE equipment(id INTEGER PRIMARY KEY, equipmentName TEXT, hasEquipment INTEGER, updateDate TEXT)");
    await db.execute("CREATE TABLE medication(id INTEGER PRIMARY KEY, medicationName TEXT, doseValue INTEGER, doseUnit TEXT, frequncy INT, frequencyUnit Text, updateDate TEXT)");
    await db.execute("CREATE TABLE condition(id INTEGER PRIMARY KEY, conditionName TEXT, hasCondition INTEGER, diagnosisDate INTEGER, severity INT, updateDate TEXT)");
    await db.execute("CREATE TABLE events(id INTEGER PRIMARY KEY, eventName TEXT, eventSeverity INT, eventDate TEXT, updatedDate TEXT)");
    await db.execute("CREATE TABLE daily(id INTEGER PRIMARY KEY, dateAdded TEXT, fever INT, temperature REAL, coughStrength INT, coughType INT, breathing INT, peakFlow REAL, tiredness INT, throat INT, nasal INT, tasteSmell INT, bp TEXT)");
    await db.execute("CREATE TABLE weekly(id INTEGER PRIMARY KEY, dateAdded TEXT, d11 INT, d12 INT, d13 INT, d14 INT,d21 INT, d22 INT, d23 INT, d24 INT,d31 INT, d32 INT, d33 INT, d34 INT,d41 INT, d42 INT, d43 INT, d44 INT,d51 INT, d52 INT, d53 INT, d54 INT,d61 INT, d62 INT, d63 INT, d64 INT,d71 INT, d72 INT, d73 INT, d74 INT,d81 INT, d82 INT, d83 INT, d84 INT,d91 INT, d92 INT, d93 INT, d94 INT,d01 INT, d02 INT, d03 INT, d04 INT)");
    }

  dateTimeToString(DateTime date){
    return DateFormat('dd/MM/yyyy – HH:mm').format(date);
  }
  stringToDateTime(String dateString){
    return DateFormat('dd/MM/yyyy – HH:mm').parse(dateString);
  }

  dateToString(DateTime date){
    return DateFormat('dd/MM/yyyy').format(date);
  }
  stringToDate(String dateString){
    return DateFormat('dd/MM/yyyy').parse(dateString);
  }

  Future<int> createUser(Map<String,dynamic> input) async{
    User newUser;
    if(input['userId']!=null){
      newUser.id = input['userID'];
    }else{
      newUser.id = "tempUser";
    }
    if(input['createDate']!=null){newUser.createDate=input['createDate'];}else{newUser.createDate=dateTimeToString(DateTime.now());}
    if(input['name']!=null){newUser.name=input['name'];}else{newUser.name='unknown';}
    if(input['email']!=null){newUser.email=input['email'];}else{newUser.email='unknown';}
    if(input['username']!=null){newUser.username=input['username'];}else{newUser.username='unknown';}
    if(input['password']!=null){newUser.password=input['password'];}else{newUser.password='unknown';}
    if(input['dateOfBirth']!=null){newUser.dateOfBirth=input['dateOfBirth'];}else{newUser.dateOfBirth="01/01/0001 - 00:00";}
    if(input['geneticGender']!=null){newUser.geneticGender=input['geneticGender'];}else{newUser.geneticGender="U";}
    if(input['updatedDate']){newUser.updatedDate=input['updatedDate'];}else{newUser.updatedDate=dateTimeToString(DateTime.now());}

    var dbClient = await db;
    int res = await dbClient.insert("user", newUser.toMap());
    return res;
  }
  Future<bool> updateUser(User input) async{
    User currentUser = await getUser(input.id);
    if(input.name!=null){currentUser.email=input.name;}
    if(input.email!=null){currentUser.email=input.email;}
    if(input.username!=null){currentUser.username=input.username;}
    if(input.password!=null){currentUser.password=input.password;}
    if(input.dateOfBirth!=null){currentUser.dateOfBirth=input.dateOfBirth;}
    if(input.geneticGender!=null){currentUser.geneticGender=input.geneticGender;}
    currentUser.updatedDate=dateTimeToString(DateTime.now());

    var dbClient = await db;
    int res =   await dbClient.update("user", currentUser.toMap(),
        where: "id = ?", whereArgs: <String>[currentUser.id]);
    return res > 0 ? true : false;
  }
  Future<User> getUser(String userId) async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM user WHERE id = ?',[userId]);
    if(list.length==1) {
      User user = new User(id: list[0]['id'],
          createDate: list[0]['createDate'],
          name: list[0]['name'],
          email: list[0]['email'],
          username: list[0]['username'],
          password: list[0]['password'],
          dateOfBirth: list[0]['dateOfBirth'],
          geneticGender: list[0]['geneticGender'],
          updatedDate: list[0]['updatedDate']);
      return user;
    }else{
      User user = new User(id: "unknown",
          createDate: "unknown",
          name:"unknown",
          email: "unknown",
          username:"unknown",
          password:"unknown",
          dateOfBirth: "unknown",
          geneticGender: "unknown",
          updatedDate: "unknown");
      return user;
    }
  }

  Future<int> updateAttributes(Attributes input) async{
    Attributes updatedAttr = await getAttributes();
    print("exisstingAttribute.id = "+updatedAttr.id.toString());
    print("input Attribute.id = "+input.id.toString());
    if(updatedAttr.id==null)updatedAttr.id=0;
    input.id = updatedAttr.id + 1;
    updatedAttr.id = input.id;
    print("exisstingAttribute.id = "+updatedAttr.id.toString());
    if(input.identifiedGender!=null){updatedAttr.identifiedGender = input.identifiedGender;}
    if(input.ppn!=null){updatedAttr.ppn = input.identifiedGender;}
    if(input.country!=null){updatedAttr.country = input.country;}
    if(input.postCode!=null){updatedAttr.postCode = input.postCode;}
    if(input.education!=null){updatedAttr.education = input.education;}
    if(input.maritalStatus!=null){updatedAttr.maritalStatus = input.maritalStatus;}
    if(input.livingStatus!=null){updatedAttr.livingStatus = input.livingStatus;}
    if(input.employmentStatus!=null){updatedAttr.employmentStatus = input.employmentStatus;}
    if(input.height!=null){updatedAttr.height = input.height;}
    if(input.heightUnits!=null){updatedAttr.heightUnits = input.heightUnits;}
    if(input.weight!=null){updatedAttr.weight = input.weight;}
    if(input.weightUnits!=null){updatedAttr.weightUnits = input.weightUnits;}
    if(input.smoker!=null){updatedAttr.smoker = input.smoker;}
    if(input.drinker!=null){updatedAttr.drinker = input.drinker;}
    updatedAttr.updatedDate=dateTimeToString(DateTime.now());

    var dbClient = await db;
    int res = await dbClient.insert("userAttributes", updatedAttr.toMap());
    return res;
  }
  Future<Attributes> getAttributes() async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM userAttributes ORDER BY id DESC LIMIT 1');
    if(list.length==1) {
      Attributes attribute = new Attributes();
      attribute.id = list[0]['id'];
      attribute.identifiedGender = list[0]['identifiedGender'];
      attribute.ppn = list[0]['ppn'];
      attribute.country = list[0]['country'];
      attribute.postCode = list[0]['postCode'];
      attribute.education = list[0]['education'];
      attribute.maritalStatus = list[0]['maritalStatus'];
      attribute.livingStatus = list[0]['livingStatus'];
      attribute.employmentStatus = list[0]['employmentStatus'];
      attribute.height = int.parse(list[0]['height']);
      attribute.heightUnits = list[0]['heightUnits'];
      attribute.weight = int.parse(list[0]['weight']);
      attribute.weightUnits = list[0]['weightUnits'];
      attribute.updatedDate = list[0]['updatedDate'];
      return attribute;
    }else{
      Attributes attribute = new Attributes();
      attribute.id = 0;
      attribute.identifiedGender = "U";
      attribute.ppn = "U";
      attribute.country = "U";
      attribute.postCode = "U";
      attribute.education = "U";
      attribute.maritalStatus = "U";
      attribute.livingStatus = "U";
      attribute.employmentStatus = "U";
      attribute.height = 0;
      attribute.heightUnits = "U";
      attribute.weight = 0;
      attribute.weightUnits = "U";
      attribute.updatedDate = dateTimeToString(DateTime.now());
      return attribute;
    }
  }

  Future<int> updateEquipment(Map<String,dynamic> input) async{
    var dbClient = await db;
    await dbClient.execute("INSERT INTO equipment VALUES(DEFAULT,?,?,?",[input['equipmentName'],[input['equipmentStatus']],[dateTimeToString(DateTime.now())]]);
    return 1;
  }
  Future<Equipment> getEquipment(String equipmentType) async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM equipment WHERE equipmentName = ? ORDER BY updateDate DESC LIMIT 1',[equipmentType]);
    if(list.length==1) {
      Equipment equipment = new Equipment();
      equipment.id = list[0]['id'];
      equipment.equipmentName = list[0]['equipmentName'];
      equipment.hasEquipment = list[0]['hasEquipment'];
      equipment.updatedDate = list[0]['updatedDate'];
      return equipment;
    }else{
      Equipment equipment = new Equipment();
      equipment.id = 0;
      equipment.equipmentName = equipmentType;
      equipment.hasEquipment = 0;
      equipment.updatedDate = dateTimeToString(DateTime.now());
      return equipment;
    }
  }

  Future<int> updateCondition(Map<String,dynamic> input) async{
    // see if condition exists, then update, else create new
    var dbClient = await db;
    await dbClient.execute("INSERT INTO condition VALUES(DEFAULT, ?, ?, ?, ?, ?)",[input['conditionName'],[input['hasCondition']],[input['diagnosisDate']],[input['severity']],[dateTimeToString(DateTime.now())]]);
    return 1;
  }
  Future<Condition> getCondition(String conditionName) async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM condition WHERE conditionName = ? ORDER BY updateDate DESC LIMIT 1',[conditionName]);
    if(list.length==1) {
      Condition condition = new Condition(list[0]['id'],list[0]['conditionName'],list[0]['hasCondition'],list[0]['diagnosisDate'],list[0]['severity'],list[0]['updatedDate']);
      return condition;
    }else{
      Condition condition = new Condition(0, conditionName, 0, '00/00/0000 - 00:00', 0, dateTimeToString(DateTime.now()));
      return condition;
    }
  }

  Future<bool> insertDaily(Map<String,dynamic> input) async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM daily WHERE dateAdded = ? LIMIT 1',[input['createDate']]);
    if(list.length==1) {
      Daily dailyData = new Daily();
      dailyData.id = list[0]['id'];
      dailyData.dateAdded = list[0]['dateAdded'];
      dailyData.fever = list[0]['fever'];
      dailyData.temperature = list[0]['temperature'];
      dailyData.coughStrength= list[0]['coughStrength'];
      dailyData.coughType= list[0]['coughType'];
      dailyData.breathing= list[0]['breathing'];
      dailyData.peakFlow= list[0]['peakFlow'];
      dailyData.tiredness= list[0]['tiredness'];
      dailyData.throat= list[0]['throat'];
      dailyData.nasal= list[0]['nasal'];
      dailyData.tasteSmell= list[0]['tasteSmell'];

      if(input['fever']!=null){dailyData.fever = input['fever'];}
      if(input['temperature']!=null){dailyData.temperature = input['temperature'];}
      if(input['coughStrength']!=null){dailyData.coughStrength = input['coughStrength'];}
      if(input['coughType']!=null){dailyData.coughType = input['coughType'];}
      if(input['breathing']!=null){dailyData.breathing = input['breathing'];}
      if(input['peakFlow']!=null){dailyData.peakFlow = input['peakFlow'];}
      if(input['tiredness']!=null){dailyData.tiredness = input['tiredness'];}
      if(input['throat']!=null){dailyData.throat = input['throat'];}
      if(input['nasal']!=null){dailyData.nasal = input['nasal'];}
      if(input['tasteSmell']!=null){dailyData.tasteSmell = input['tasteSmell'];}

      var dbClient = await db;
      int res =   await dbClient.update("daily", dailyData.toMap(),
          where: "id = ?", whereArgs: <int>[dailyData.id]);
      return res > 0 ? true : false;
    }else{
      Daily dailyData = new Daily();
      dailyData.dateAdded = dateToString(DateTime.now());
      dailyData.fever = 0;
      dailyData.temperature = 0;
      dailyData.coughStrength= 9;
      dailyData.coughType= 9;
      dailyData.breathing= 9;
      dailyData.peakFlow= 0;
      dailyData.tiredness= 9;
      dailyData.throat= 9;
      dailyData.nasal= 9;
      dailyData.tasteSmell= 9;

      if(input['fever']!=null){dailyData.fever = input['fever'];}
      if(input['temperature']!=null){dailyData.temperature = input['temperature'];}
      if(input['coughStrength']!=null){dailyData.coughStrength = input['coughStrength'];}
      if(input['coughType']!=null){dailyData.coughType = input['coughType'];}
      if(input['breathing']!=null){dailyData.breathing = input['breathing'];}
      if(input['peakFlow']!=null){dailyData.peakFlow = input['peakFlow'];}
      if(input['tiredness']!=null){dailyData.tiredness = input['tiredness'];}
      if(input['throat']!=null){dailyData.throat = input['throat'];}
      if(input['nasal']!=null){dailyData.nasal = input['nasal'];}
      if(input['tasteSmell']!=null){dailyData.tasteSmell = input['tasteSmell'];}

      var dbClient = await db;
      await dbClient.execute("INSERT INTO daily VALUES(DEFAULT, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",[dailyData.dateAdded,dailyData.fever,dailyData.temperature,dailyData.coughStrength,dailyData.coughType,dailyData.breathing,dailyData.peakFlow,dailyData.tiredness,dailyData.throat,dailyData.nasal,dailyData.tasteSmell]);
      return true;
    }
  }
  Future<Daily> getDaily(String date) async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM daily WHERE dateAdded = ? LIMIT 1',[date]);
    if(list.length==1) {
      Daily dailyData = new Daily();
      dailyData.id = list[0]['id'];
      dailyData.dateAdded = list[0]['dateAdded'];
      dailyData.fever = list[0]['fever'];
      dailyData.temperature = list[0]['temperature'];
      dailyData.coughStrength= list[0]['coughStrength'];
      dailyData.coughType= list[0]['coughType'];
      dailyData.breathing= list[0]['breathing'];
      dailyData.peakFlow= list[0]['peakFlow'];
      dailyData.tiredness= list[0]['tiredness'];
      dailyData.throat= list[0]['throat'];
      dailyData.nasal= list[0]['nasal'];
      dailyData.tasteSmell= list[0]['tasteSmell'];
      dailyData.bp= list[0]['bp'];
      return dailyData;
    }else{
      Daily dailyData = new Daily();
      dailyData.dateAdded = dateToString(DateTime.now());
      dailyData.fever = 0;
      dailyData.temperature = 0;
      dailyData.coughStrength= 9;
      dailyData.coughType=9;
      dailyData.breathing= 9;
      dailyData.peakFlow= 0;
      dailyData.tiredness= 9;
      dailyData.throat= 9;
      dailyData.nasal= 9;
      dailyData.tasteSmell= 9;
      dailyData.bp= "0/0";
      return dailyData;
    }
  }

  Future<bool> insertWeekly(Map<String,dynamic> input) async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM weekly WHERE createDate = ? LIMIT 1',[input['createDate']]);
    if(list.length==1) {
      Weekly weeklyData = new Weekly();
      weeklyData.id = list[0]['id'];
      weeklyData.dateAdded = list[0]['dateAdded'];
      weeklyData.d11 = list[0]['d11'];
      weeklyData.d12 = list[0]['d12'];
      weeklyData.d13 = list[0]['d13'];
      weeklyData.d14 = list[0]['d14'];
      weeklyData.d21 = list[0]['d21'];
      weeklyData.d22 = list[0]['d22'];
      weeklyData.d23 = list[0]['d23'];
      weeklyData.d24 = list[0]['d24'];
      weeklyData.d31 = list[0]['d31'];
      weeklyData.d32 = list[0]['d32'];
      weeklyData.d33 = list[0]['d33'];
      weeklyData.d34 = list[0]['d34'];
      weeklyData.d41 = list[0]['d41'];
      weeklyData.d42 = list[0]['d42'];
      weeklyData.d43 = list[0]['d43'];
      weeklyData.d44 = list[0]['d44'];
      weeklyData.d51 = list[0]['d51'];
      weeklyData.d52 = list[0]['d52'];
      weeklyData.d53 = list[0]['d53'];
      weeklyData.d54 = list[0]['d54'];
      weeklyData.d61 = list[0]['d61'];
      weeklyData.d62 = list[0]['d62'];
      weeklyData.d63 = list[0]['d63'];
      weeklyData.d64 = list[0]['d64'];
      weeklyData.d71 = list[0]['d71'];
      weeklyData.d72 = list[0]['d72'];
      weeklyData.d73 = list[0]['d73'];
      weeklyData.d74 = list[0]['d74'];
      weeklyData.d81 = list[0]['d81'];
      weeklyData.d82 = list[0]['d82'];
      weeklyData.d83 = list[0]['d83'];
      weeklyData.d84 = list[0]['d84'];
      weeklyData.d91 = list[0]['d91'];
      weeklyData.d92 = list[0]['d92'];
      weeklyData.d93 = list[0]['d93'];
      weeklyData.d94 = list[0]['d94'];
      weeklyData.d01 = list[0]['d01'];
      weeklyData.d02 = list[0]['d02'];
      weeklyData.d03 = list[0]['d03'];
      weeklyData.d04 = list[0]['d04'];

      if(input['d11'] != null){weeklyData.d11 = input['d11'];}
      if(input['d12'] != null){weeklyData.d12 = input['d12'];}
      if(input['d13'] != null){weeklyData.d13 = input['d13'];}
      if(input['d14'] != null){weeklyData.d14 = input['d14'];}
      if(input['d21'] != null){weeklyData.d21 = input['d21'];}
      if(input['d22'] != null){weeklyData.d22 = input['d22'];}
      if(input['d23'] != null){weeklyData.d23 = input['d23'];}
      if(input['d24'] != null){weeklyData.d24 = input['d24'];}
      if(input['d31'] != null){weeklyData.d31 = input['d31'];}
      if(input['d32'] != null){weeklyData.d32 = input['d32'];}
      if(input['d33'] != null){weeklyData.d33 = input['d33'];}
      if(input['d34'] != null){weeklyData.d34 = input['d34'];}
      if(input['d41'] != null){weeklyData.d41 = input['d41'];}
      if(input['d42'] != null){weeklyData.d42 = input['d42'];}
      if(input['d43'] != null){weeklyData.d43 = input['d43'];}
      if(input['d44'] != null){weeklyData.d44 = input['d44'];}
      if(input['d51'] != null){weeklyData.d51 = input['d51'];}
      if(input['d52'] != null){weeklyData.d52 = input['d52'];}
      if(input['d53'] != null){weeklyData.d53 = input['d53'];}
      if(input['d54'] != null){weeklyData.d54 = input['d54'];}
      if(input['d61'] != null){weeklyData.d61 = input['d61'];}
      if(input['d62'] != null){weeklyData.d62 = input['d62'];}
      if(input['d63'] != null){weeklyData.d63 = input['d63'];}
      if(input['d64'] != null){weeklyData.d64 = input['d64'];}
      if(input['d71'] != null){weeklyData.d71 = input['d71'];}
      if(input['d72'] != null){weeklyData.d72 = input['d72'];}
      if(input['d73'] != null){weeklyData.d73 = input['d73'];}
      if(input['d74'] != null){weeklyData.d74 = input['d74'];}
      if(input['d81'] != null){weeklyData.d81 = input['d81'];}
      if(input['d82'] != null){weeklyData.d82 = input['d82'];}
      if(input['d83'] != null){weeklyData.d83 = input['d83'];}
      if(input['d84'] != null){weeklyData.d84 = input['d84'];}
      if(input['d91'] != null){weeklyData.d91 = input['d91'];}
      if(input['d92'] != null){weeklyData.d92 = input['d92'];}
      if(input['d93'] != null){weeklyData.d93 = input['d93'];}
      if(input['d94'] != null){weeklyData.d94 = input['d94'];}
      if(input['d01'] != null){weeklyData.d01 = input['d01'];}
      if(input['d02'] != null){weeklyData.d02 = input['d02'];}
      if(input['d03'] != null){weeklyData.d03 = input['d03'];}
      if(input['d04'] != null){weeklyData.d03 = input['d04'];}

      var dbClient = await db;
      int res =   await dbClient.update("weekly", weeklyData.toMap(),
          where: "id = ?", whereArgs: <int>[weeklyData.id]);
      return res > 0 ? true : false;
    }else{
      Weekly weeklyData = new Weekly();
      weeklyData.dateAdded = dateToString(DateTime.now());
      weeklyData.d11 = 9;
      weeklyData.d12 = 9;
      weeklyData.d13 = 9;
      weeklyData.d14 = 9;
      weeklyData.d21= 9;
      weeklyData.d22= 9;
      weeklyData.d23= 9;
      weeklyData.d24= 9;
      weeklyData.d31= 9;
      weeklyData.d32= 9;
      weeklyData.d33= 9;
      weeklyData.d34= 9;
      weeklyData.d41= 9;
      weeklyData.d42= 9;
      weeklyData.d43= 9;
      weeklyData.d44= 9;
      weeklyData.d51= 9;
      weeklyData.d52= 9;
      weeklyData.d53= 9;
      weeklyData.d54= 9;
      weeklyData.d61= 9;
      weeklyData.d62= 9;
      weeklyData.d63= 9;
      weeklyData.d64= 9;
      weeklyData.d71= 9;
      weeklyData.d72= 9;
      weeklyData.d73= 9;
      weeklyData.d74= 9;
      weeklyData.d81= 9;
      weeklyData.d82= 9;
      weeklyData.d83= 9;
      weeklyData.d84= 9;
      weeklyData.d91= 9;
      weeklyData.d92= 9;
      weeklyData.d93= 9;
      weeklyData.d94= 9;
      weeklyData.d01= 9;
      weeklyData.d02= 9;
      weeklyData.d03= 9;
      weeklyData.d04= 9;

      if(input['d11'] != null){weeklyData.d11 = input['d11'];}
      if(input['d12'] != null){weeklyData.d12 = input['d12'];}
      if(input['d13'] != null){weeklyData.d13 = input['d13'];}
      if(input['d14'] != null){weeklyData.d14 = input['d14'];}
      if(input['d21'] != null){weeklyData.d21 = input['d21'];}
      if(input['d22'] != null){weeklyData.d22 = input['d22'];}
      if(input['d23'] != null){weeklyData.d23 = input['d23'];}
      if(input['d24'] != null){weeklyData.d24 = input['d24'];}
      if(input['d31'] != null){weeklyData.d31 = input['d31'];}
      if(input['d32'] != null){weeklyData.d32 = input['d32'];}
      if(input['d33'] != null){weeklyData.d33 = input['d33'];}
      if(input['d34'] != null){weeklyData.d34 = input['d34'];}
      if(input['d41'] != null){weeklyData.d41 = input['d41'];}
      if(input['d42'] != null){weeklyData.d42 = input['d42'];}
      if(input['d43'] != null){weeklyData.d43 = input['d43'];}
      if(input['d44'] != null){weeklyData.d44 = input['d44'];}
      if(input['d51'] != null){weeklyData.d51 = input['d51'];}
      if(input['d52'] != null){weeklyData.d52 = input['d52'];}
      if(input['d53'] != null){weeklyData.d53 = input['d53'];}
      if(input['d54'] != null){weeklyData.d54 = input['d54'];}
      if(input['d61'] != null){weeklyData.d61 = input['d61'];}
      if(input['d62'] != null){weeklyData.d62 = input['d62'];}
      if(input['d63'] != null){weeklyData.d63 = input['d63'];}
      if(input['d64'] != null){weeklyData.d64 = input['d64'];}
      if(input['d71'] != null){weeklyData.d71 = input['d71'];}
      if(input['d72'] != null){weeklyData.d72 = input['d72'];}
      if(input['d73'] != null){weeklyData.d73 = input['d73'];}
      if(input['d74'] != null){weeklyData.d74 = input['d74'];}
      if(input['d81'] != null){weeklyData.d81 = input['d81'];}
      if(input['d82'] != null){weeklyData.d82 = input['d82'];}
      if(input['d83'] != null){weeklyData.d83 = input['d83'];}
      if(input['d84'] != null){weeklyData.d84 = input['d84'];}
      if(input['d91'] != null){weeklyData.d91 = input['d91'];}
      if(input['d92'] != null){weeklyData.d92 = input['d92'];}
      if(input['d93'] != null){weeklyData.d93 = input['d93'];}
      if(input['d94'] != null){weeklyData.d94 = input['d94'];}
      if(input['d01'] != null){weeklyData.d01 = input['d01'];}
      if(input['d02'] != null){weeklyData.d02 = input['d02'];}
      if(input['d03'] != null){weeklyData.d03 = input['d03'];}
      if(input['d04'] != null){weeklyData.d03 = input['d04'];}

      var dbClient = await db;
      await dbClient.execute("INSERT INTO weekly VALUES(DEFAULT, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",[weeklyData.dateAdded,weeklyData.d11,weeklyData.d12,weeklyData.d13,weeklyData.d14,weeklyData.d21,weeklyData.d22,weeklyData.d23,weeklyData.d24,weeklyData.d31,weeklyData.d32,weeklyData.d33,weeklyData.d34,weeklyData.d41,weeklyData.d42,weeklyData.d43,weeklyData.d44,weeklyData.d51,weeklyData.d52,weeklyData.d53,weeklyData.d54,weeklyData.d61,weeklyData.d62,weeklyData.d63,weeklyData.d64,weeklyData.d71,weeklyData.d72,weeklyData.d73,weeklyData.d74,weeklyData.d81,weeklyData.d82,weeklyData.d83,weeklyData.d84,weeklyData.d91,weeklyData.d92,weeklyData.d93,weeklyData.d94,weeklyData.d01,weeklyData.d02,weeklyData.d03,weeklyData.d04]);
      return true;
    }
  }

  Future<bool> insertEvent(Event input) async{

    Event newEvent = new Event();
    if(input.eventName!=null){newEvent.eventName=input.eventName;}else{newEvent.eventName="Unknown";}
    if(input.eventSeverity!=null){newEvent.eventSeverity=input.eventSeverity;}else{newEvent.eventSeverity=0;}
    if(input.eventDate!=null){newEvent.eventDate=input.eventDate;}else{newEvent.eventDate=dateTimeToString(DateTime.now());}
    if(input.updatedDate!=null){newEvent.updatedDate=input.updatedDate;}else{newEvent.updatedDate=dateTimeToString(DateTime.now());}

    var dbClient = await db;
    await dbClient.execute("INSERT INTO events (eventName, eventSeverity, eventDate, updatedDate) VALUES( ?, ?, ?, ?)",[newEvent.eventName,newEvent.eventSeverity,newEvent.eventDate,newEvent.updatedDate]);
    return true;
  }
  Future<Event> getEvent(String eventName) async{
    var dbClient = await db;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM events WHERE eventName = ? ORDER BY updatedDate DESC LIMIT 1',[eventName]);
    if(list.length==1) {
      Event event = new Event();
      event.id = list[0]['id'];
      event.eventName = list[0]['eventName'];
      event.eventSeverity = list[0]['eventSeverity'];
      event.eventDate = list[0]['eventDate'];
      event.updatedDate = list[0]['updatedDate'];
      return event;
    }else{
      Event event = new Event();
      event.id = 0;
      event.eventName = eventName;
      event.eventSeverity = 0;
      event.eventDate = '00/00/0000 - 00:00';
      event.updatedDate = '00/00/0000 - 00:00';
      return event;
    }

  }

}


class User{
  String id;
  String createDate;
  String name;
  String email;
  String username;
  String password;
  String dateOfBirth;
  String geneticGender;
  String updatedDate;

  User({this.id, this.createDate, this.name, this.email, this.username, this.password, this.dateOfBirth, this.geneticGender, this.updatedDate});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'createDate':createDate,
      'name':name,
      'email':email,
      'username':username,
      'password':password,
      'dateOfBirth':dateOfBirth,
      'geneticGender':geneticGender,
      'updatedDate':updatedDate,
    };
  }
  @override
  String toString() {
    return 'User{id: $id,createDate:$createDate,name:$name,email:$email,username:$username,password:$password,dateOfBirth:$dateOfBirth,geneticGender:$geneticGender,updateDate:$updatedDate}';
  }
}

class Attributes{
  int id;
  String identifiedGender;
  String ppn;
  String country;
  String postCode;
  String education;
  String maritalStatus;
  String livingStatus;
  String employmentStatus;
  int height;
  String heightUnits;
  int weight;
  String weightUnits;
  String smoker;
  String drinker;
  String updatedDate;

  Attributes({this.id, this.identifiedGender, this.ppn, this.country, this.postCode, this.education, this.maritalStatus, this.livingStatus, this.employmentStatus, this.height, this.heightUnits, this.weight, this.weightUnits, this.smoker, this.drinker, this.updatedDate});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'identifiedGender':identifiedGender,
      'ppn':ppn,
      'country':country,
      'postCode':postCode,
      'education':education,
      'maritalStatus':maritalStatus,
      'livingStatus':livingStatus,
      'employmentStatus':employmentStatus,
      'height':height,
      'heightUnits':heightUnits,
      'weight':weight,
      'weightUnits':weightUnits,
      'smoker':smoker,
      'drinker':drinker,
      'updatedDate':updatedDate,
    };
  }
  @override
  String toString() {
    return 'Attributes{id:$id,identifiedGender:$identifiedGender,ppn:$ppn,country:$country,postCode:$postCode,education:$education,maritalStatus:$maritalStatus,livingStatus:$livingStatus,employmentStatus:$employmentStatus,height:$height,heightUnits:$heightUnits,weight:$weight,weightUnits:$weightUnits,smoker:$smoker,drinker:$drinker,updatedDate:$updatedDate,}';
  }
}

class Equipment{
  int id;
  String equipmentName;
  int hasEquipment;
  String updatedDate;

  Equipment({this.id, this.equipmentName, this.hasEquipment, this.updatedDate});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'equipmentName':equipmentName,
      'hasEquipment':hasEquipment,
      'updatedDate':updatedDate,
    };
  }
  @override
  String toString() {
    return 'Equipment{id: $id,equipmentName:$equipmentName,hasEquipment:$hasEquipment,updateDate:$updatedDate}';
  }
}

class Condition{
  int id;
  String conditionName;
  int hasCondition;
  String diagnosisDate;
  int severity;
  String updatedDate;

  Condition(this.id, this.conditionName, this.hasCondition, this.diagnosisDate, this.severity, this.updatedDate);

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'conditionName':conditionName,
      'hasCondition':hasCondition,
      'diagnosisDate':diagnosisDate,
      'severity':severity,
      'updatedDate':updatedDate,
    };
  }
  @override
  String toString() {
    return 'Condition{id: $id,conditionName:$conditionName,asCondition:$hasCondition,diagnosisDate:$diagnosisDate,severity:$severity,updateDate:$updatedDate}';
  }
}

class Medication{
  int id;
  String medicationName;
  int doseValue;
  String doseUnit;
  int frequency;
  String frequencyUnit;
  String updatedDate;

  Medication(this.id, this.medicationName, this.doseValue, this.doseUnit, this.frequency, this.frequencyUnit, this.updatedDate);

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'medicationName':medicationName,
      'doseValue':doseValue,
      'doseUnit':doseUnit,
      'frequency':frequency,
      'frequencyUnit':frequencyUnit,
      'updatedDate':updatedDate,
    };
  }
  @override
  String toString() {
    return 'Condition{id: $id,medicationName:$medicationName,doseValue:$doseValue,doseUnit:$doseUnit,frequency:$frequency,frequencyUnit:$frequencyUnit,updatedDate:$updatedDate}';
  }
}

class Daily{
  int id;
  String dateAdded;
  int fever;
  double temperature;
  int coughStrength;
  int coughType;
  int breathing;
  double peakFlow;
  int tiredness;
  int throat;
  int nasal;
  int tasteSmell;
  String bp;

  Daily({this.id, this.dateAdded, this.fever, this.temperature, this.coughStrength, this.coughType, this.breathing, this.peakFlow, this.tiredness, this.throat, this.nasal, this.tasteSmell, this.bp});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'dateAdded':dateAdded,
      'fever':fever,
      'temperature':temperature,
      'coughStrength':coughStrength,
      'coughType':coughType,
      'breathing':breathing,
      'peakFlow': peakFlow,
      'tiredness': tiredness,
      'throat': throat,
      'nasal':  nasal,
      'tasteSmell': tasteSmell,
      'bp': bp,
  };
  }
  @override
  String toString() {
    return 'Daily{id: $id,dateAdded:$dateAdded,fever:$fever,temperature:$temperature,coughStrength:$coughStrength,coughType:$coughType,breathing:$breathing,peakFlow:$peakFlow,tiredness:$tiredness,throat:$throat,nasal:$nasal,tasteSmell:$tasteSmell,bp:$bp}';
  }
}

class Weekly{
  int id;
  String dateAdded;
  int d11;
  int d12;
  int d13;
  int d14;
  int d21;
  int d22;
  int d23;
  int d24;
  int d31;
  int d32;
  int d33;
  int d34;
  int d41;
  int d42;
  int d43;
  int d44;
  int d51;
  int d52;
  int d53;
  int d54;
  int d61;
  int d62;
  int d63;
  int d64;
  int d71;
  int d72;
  int d73;
  int d74;
  int d81;
  int d82;
  int d83;
  int d84;
  int d91;
  int d92;
  int d93;
  int d94;
  int d01;
  int d02;
  int d03;
  int d04;

  Weekly({this.id, this.dateAdded, this.d11, this.d12, this.d13, this.d14, this.d21, this.d22, this.d23, this.d24, this.d31, this.d32, this.d33, this.d34, this.d41, this.d42, this.d43, this.d44, this.d51, this.d52, this.d53, this.d54, this.d61, this.d62, this.d63, this.d64, this.d71, this.d72, this.d73, this.d74, this.d81, this.d82, this.d83, this.d84, this.d91, this.d92, this.d93, this.d94, this.d01, this.d02, this.d03, this.d04});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'dateAdded':dateAdded,
      'd11':d11,
      'd12':d12,
      'd13':d13,
      'd14':d14,
      'd21':d21,
      'd22':d22,
      'd23':d23,
      'd24':d24,
      'd31':d31,
      'd32':d32,
      'd33':d33,
      'd34':d34,
      'd41':d41,
      'd42':d42,
      'd43':d43,
      'd44':d44,
      'd51':d51,
      'd52':d52,
      'd53':d53,
      'd54':d54,
      'd61':d61,
      'd62':d62,
      'd63':d63,
      'd64':d64,
      'd71':d71,
      'd72':d72,
      'd73':d73,
      'd74':d74,
      'd81':d81,
      'd82':d82,
      'd83':d83,
      'd84':d84,
      'd91':d91,
      'd92':d92,
      'd93':d93,
      'd94':d94,
      'd01':d01,
      'd02':d02,
      'd03':d03,
      'd04':d04,
    };
  }
  @override
  String toString() {
    return 'Weekly{id: $id,dateAdded:$dateAdded,d11:$d11,d12:$d12,d13:$d13,d14:$d14,d21:$d21,d22:$d22,d23:$d23,d24:$d24,d31:$d31,d32:$d32,d33:$d33,d34:$d34,d41:$d41,d42:$d42,d43:$d43,d44:$d44,d51:$d51,d52:$d52,d53:$d53,d54:$d54,d61:$d61,d62:$d62,d63:$d63,d64:$d64,d71:$d71,d72:$d72,d73:$d73,d74:$d74,d81:$d81,d82:$d82,d83:$d83,d84:$d84,d91:$d91,d92:$d92,d93:$d93,d94:$d94,d01:$d01,d02:$d02,d03:$d03,d04:$d04,}';
  }
}

class Event{
  int id;
  String eventName;
  int eventSeverity;
  String eventDate;
  String updatedDate;

  Event({this.id, this.eventName, this.eventSeverity, this.eventDate, this.updatedDate});

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'eventName':eventName,
      'eventSeverity':eventSeverity,
      'eventDate':eventDate,
      'updatedDate':updatedDate,
    };
  }
  @override
  String toString() {
    return 'Event{id: $id,eventName:$eventName,eventSeverity:$eventSeverity,eventDate:$eventDate,updatedDate:$updatedDate}';
  }
}
