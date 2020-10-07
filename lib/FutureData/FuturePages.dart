import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/Pages/HomePage.dart';
import 'package:project/const.dart';

class ReadDataFromServer extends StatelessWidget {
  
  final localdata;


  ReadDataFromServer({this.localdata});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _readDataFromServer(),
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          return HomePage(
            localdata: localdata,
            mainData: snapshot.data,
          );
        }
        else return CircularProgressIndicator();
      },
    );
  }

  Future<List<dynamic>> _readDataFromServer() async {
   /* var dataAsJson;
    Socket socket = await Socket.connect(host, port);
    print("connect");

    socket.add(utf8.encode('getData\n'));
    socket.listen((event) {
      dataAsJson = json.decode(utf8.decode(event));
    });
    await Future.delayed(Duration(microseconds: 0));
    print(dataAsJson);
    socket.close();
    return dataAsJson;*/

    var localDataAsJson;
    await rootBundle.loadString('assets/local_entity.json').then((value) {
    print(value);
    localDataAsJson = json.decode(value);});
    return localDataAsJson;
  }

}