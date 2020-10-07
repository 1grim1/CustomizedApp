
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:project/const.dart';

class Product extends StatelessWidget{
  final String modelName;
  final String name;
  final String description;
  final List<dynamic> imageAssetList;
  final List<dynamic> imageUrlList;
  final String price;
  final String catalogName;

  Product({Key key,this.modelName, this.description,this.price, this.imageAssetList, this.catalogName, this.name, this.imageUrlList});

  Map<String, dynamic> toJson() => 
  {
     "model_name": modelName,
        "name": name,
        "description": description,
        "price": price,
        "image_list_asset": imageAssetList == null ? [] : imageAssetList,
        "image_list_url":imageUrlList == null ? [] : imageUrlList
  };

  Product.fromJson(Map<String, dynamic> json, this.catalogName)
  : modelName = json['model_name'],
    name = json['name'],
    description = json['description'],
    imageAssetList = json['image_list_asset'],
    price = json['price'],
    imageUrlList = json['"image_list_url":'];


  Widget get card => Card(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: imageAssetList == null ? Icon(Icons.block) : Icon(Icons.cake)
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1),
              child: Text(
                // products is out demo list
                modelName == null ? "modelName example" : modelName,
                textAlign: TextAlign.center,
                style: TextStyle(color: textLightColor),
              ),
            ),
            Text(
              price == null ? "price example" : "$price",
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ],
        ),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.of(context).pop()),
        backgroundColor: Colors.grey,
        centerTitle: true,
        title: Text(catalogName == null ? "catalog name" : catalogName, style: TextStyle(fontFamily: 'Varela',fontSize: 15.0, fontWeight: FontWeight.bold, color: textColor)),
        elevation: 0,
      ),
      body: Center(child: Text("12121")),
  );
  }

}