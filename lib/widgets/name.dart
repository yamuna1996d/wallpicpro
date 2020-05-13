import 'package:flutter/material.dart';
import 'package:wallpicpro/models/wallmodel.dart';

Widget HeaderName(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text("Wall",style: TextStyle(color:Colors.deepPurple),),
      Text("pic",style: TextStyle(color: Colors.blue),)
    ],
  );
}
Widget Heade(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text("Wall",style: TextStyle(color:Colors.deepPurple),),
      Text("pic",style: TextStyle(color: Colors.blue),)
    ],
  );
}
Widget wallpapergrid({List<PhotosModel> photomodel,context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(crossAxisCount: 2,
    shrinkWrap: true,
    childAspectRatio: 0.6,
    mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: photomodel.map((photomodel){
        return GridTile(
            child:Container(
              child:Image.network(photomodel.url,fit: BoxFit.cover,),
            ),
        );
      }).toList(),
    ),
  );

}
//SingleChildScrollView(
//child: Container(
//height: 400,
//padding: EdgeInsets.symmetric(horizontal: 16),
//child: ListView.builder(
//itemCount: data==null ?0: data.length,
//shrinkWrap: true,
//itemBuilder:(context,index){
//return Container(
//child:  Image.network(data[index]['url'],fit: BoxFit.cover,),
//
//);
//}),
//),
//)