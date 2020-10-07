import 'package:flutter/material.dart';
import 'package:project/Product/Product.dart';

import '../const.dart';

class ChangedTabBar extends StatefulWidget {

  final data;

  ChangedTabBar({Key key ,this.data});

  @override
  _ChangedTabBarState createState() => _ChangedTabBarState(data);
}

class _ChangedTabBarState extends State<ChangedTabBar> with TickerProviderStateMixin{


  List<Widget> _tabNameList = [];

  List<Widget> _tabViewList = [];

  List data;

  TabController _tabController;


  @override
  
  void dispose() { 
    _tabController.dispose();
    super.dispose();
  }

  _ChangedTabBarState(this.data){
    _tabController = TabController(length: data.length, vsync: this);
    if (data != null) {
      for(var e in data){
      _tabNameList.add(StatefulTab(title: e['catalogName'], key: UniqueKey(),));
      _tabViewList.add(StatefulTabView(data: e, key:  UniqueKey(),));
    }
    }
  }

  void _addNewTab(){
    _tabNameList.add(StatefulTab(title: null, key: UniqueKey(),));
    _tabViewList.add(StatefulTabView(data: null, key: GlobalKey(),));
    setState(() {
      this._tabController = TabController(length: _tabViewList.length, vsync: this);
    });
  }
  void _deleteTab(){
    int index = _tabController.index;
    _tabViewList.removeAt(index);
    _tabNameList.removeAt(index);
    setState(() {
      this._tabController = TabController(length: _tabViewList.length, vsync: this);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(child: Center(child: Text("Save Cahnges")),),
      appBar: AppBar(
        bottom: TabBar(
              controller: _tabController,
              indicatorColor: textColor,
              labelColor: textColor,
              isScrollable: true,
              labelPadding: EdgeInsets.only(right: 45.0),
              unselectedLabelColor: textLightColor ,
              tabs: _tabNameList.toList()
            ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: TabBarView(
                  controller: _tabController,
                  children: _tabViewList.toList()
              ),
            ),
            isRoot ? 
              Row(
                children: <Widget>[
                  IconButton(icon: Icon(Icons.add), onPressed: () => _addNewTab(),),
                  IconButton(icon: Icon(Icons.remove), onPressed: () => _deleteTab(),)
                ],
              ) : SizedBox(height: 0, width: 0,)
          ],
        ),
      )
    );
  }
}

class StatefulTab extends StatefulWidget {

  final String title;

  StatefulTab({Key key, @required this.title}) : super(key: key);

  @override
  _StatefulTabState createState() => _StatefulTabState(title);
}

class _StatefulTabState extends State<StatefulTab> {

  String _title;

  _StatefulTabState(this._title);


  TextEditingController _textController;

  bool _errorText = false;


  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: _title);
  }

  @override
  void dispose() {
    super.dispose();
    _textController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(color: Colors.transparent, child: Tab(child: Text(_title == null ? "Catalog Name" : _title,style: TextStyle(fontFamily: 'Times New Roman',fontSize: 16.0,)),),),
      onLongPress: (){
        showDialog(
          context: context,
          child: Dialog(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(hintText: "Write new name", errorText: _errorText ? "Write correct name" : null),
                ),
                FlatButton(
                  child: Text("Save"),
                  onPressed: (){
                    setState(() {
                      _errorText = _textController.text.replaceAll(" ", "") == "";
                      if(!_errorText) _title = _textController.text;
                    });
                    Navigator.of(context).pop();                  },
                )
              ],
            ),
          )
        );
      },
    );
  }
}

class StatefulTabView extends StatefulWidget {

  final data;

 StatefulTabView({Key key, @required this.data}) : super(key: key);

  @override
   _StatefulTabViewState createState() =>  _StatefulTabViewState(data);
}

class  _StatefulTabViewState extends State<StatefulTabView> with AutomaticKeepAliveClientMixin<StatefulTabView>{

  final data;

  List<Product> modelList = [];

  _StatefulTabViewState(this.data){
    if(data != null)
      for(var e in data['models']){
        modelList.add(Product.fromJson(e, data['catalogName']));
      }
    //modelList.add(DoorCard());
  }

  swapButtonAndCard(){
    setState(() {
      modelList.add(Product());
    });
  }

 Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: padding),
            child: GridView.builder(
                itemCount: modelList.length + 1,
                primary: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.5,
                  crossAxisCount: 2,
                  mainAxisSpacing: padding,
                  crossAxisSpacing: padding,
                ),
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onLongPress: (){
                    setState(() {
                      modelList.removeAt(index);
                    });
                  },
                  onTap: () => Navigator.of(context).push( MaterialPageRoute(builder: (context) => modelList[index] )),
                  child: index < modelList.length ? modelList[index].card : IconButton(icon: Icon(Icons.add), onPressed: swapButtonAndCard)
                  )
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}