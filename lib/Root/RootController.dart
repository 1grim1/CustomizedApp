import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/const.dart';

class RootController {

  var data;

  List<Widget> tabs = []; //tab name

  List<Widget> tabview = []; // tabview widget for catalog pages

  Function onChangeTabName;

  RootController(this.data, {this.onChangeTabName}){
    _make();
  }

  void _make(){
    for(var elem in data){
      tabs.add(
        GestureDetector(child: ControllerTab(elem['catalogName']).getTab(), onLongPress: onChangeTabName,)
        );
      tabview.add(ControllerTabView(elem['models']));
    }
  }

}

class ControllerTabView extends StatelessWidget {

  List<Widget> models = [];

  ControllerTabView(this.models);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding),
            child: GridView.builder(
              itemCount: models.length,
              primary: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.5,
                crossAxisCount: 2,
                mainAxisSpacing: padding,
                crossAxisSpacing: padding,
              ),
              shrinkWrap: true,
              itemBuilder: (context, index) => Text(index.toString())
            ),
          ),
        ),
      ],
    );
  }
}

class ControllerTab {
  String title;

  ControllerTab(this.title);

  Tab getTab(){
    return Tab(
        child: Text(title,
        style: TextStyle(
          fontFamily: 'Times New Roman',
          fontSize: 16.0,
        )
      ),
    );
  }
}