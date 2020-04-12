import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:survivor/globals.dart' as globals;
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'dart:async';

import 'package:path/path.dart';
import 'package:survivor/database.dart';

class DailyView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DailyState();
  }
}

class _DailyState extends State<DailyView> {
  var db = new DatabaseHelper();

  @override
  initState() {
    super.initState();

  }

  @override
  void didUpdateWidget( oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height - 265,
        width: MediaQuery.of(context).size.width,
        child:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Row(),
        )
    );
  }
}