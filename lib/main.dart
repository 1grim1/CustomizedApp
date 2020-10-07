import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'FutureData/FuturePages.dart';

Future<Map<String, dynamic>> _readLocal() async {
  var localDataAsJson;
  await rootBundle.loadString('assets/local.json').then((value) {
    print(value);
    localDataAsJson = json.decode(value);
  });
  return localDataAsJson;
}


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    FutureBuilder(
      future: _readLocal(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return snapshot.data['stayInSystem'] ? ReadDataFromServer(localdata : snapshot.data) : Text("21");// : LoginRegPage();
        }
        else return CircularProgressIndicator();
      },
    )
  );
}