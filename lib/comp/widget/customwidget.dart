import'package:flutter/material.dart';

class CustomWidget extends StatelessWidget {

  final String malzemeismi;
  final String imageURL;
  var fiyat; 

  CustomWidget({Key key,this.malzemeismi,this.imageURL,this.fiyat}) : assert(imageURL!=null), super(key: key);

 Widget get imagePlace => imageURL.isEmpty
 ? Container(width: 100,child: Placeholder())
 : Image.network(imageURL.toString());

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      child: ListTile(
        title:Text(this.malzemeismi),
        subtitle: Text(this.fiyat.toString()),
        leading: imagePlace,
      ),
    );
  }
}