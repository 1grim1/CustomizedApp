import 'package:flutter/material.dart';
import 'package:project/Root/ChangedTabBar.dart';
import 'package:project/Root/RootController.dart';

import '../const.dart';

class HomePage extends StatefulWidget {

  final localdata;

  final mainData;

  HomePage({this.localdata, this.mainData});

  @override
  _HomePageState createState() => _HomePageState(localdata, mainData);
}

class _HomePageState extends State<HomePage> {

  final localdata;

  final mainData;

  _HomePageState(this.localdata, this.mainData){
    print(mainData);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChangedTabBar(data: mainData)
    );
  }




}