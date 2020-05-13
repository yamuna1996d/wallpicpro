import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Wallpics extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<Wallpics> {
  final String api ="https://wallpro.herokuapp.com/add/view";
  Future<dynamic>  getWallpaper(String api) async {return http.get(api).then((http.Response response){
    final int statuscode=response.statusCode;
    if(statuscode <200 || statuscode >400 || json ==null){
      throw new Exception("Error while fetching data");
    }
    print(response.body.toString());
    setState(() {
      data= json.decode(response.body);
    });
    //Map<String,dynamic> jsonData = jsonDecode(response.body);

//      PhotosModel photomodel =new PhotosModel();
//      photomodel =PhotosModel.fromMap(data);
//      wallpapers.add(photomodel);
//      setState(() {
//
//      });
  });


  }
  List data;
  @override
  void initState() {
    getWallpaper("https://wallpro.herokuapp.com/add/view");
    //categories =getCategories();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
    height: 400,
    padding: EdgeInsets.symmetric(horizontal: 16),
        child:
                GridView.builder(
                    itemCount: data==null ?0: data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                    childAspectRatio: 0.6,
                      mainAxisSpacing: 6.0,
                    crossAxisSpacing: 6.0,
                ),  itemBuilder: (context,index){
                      return GridTile(
                          child:Container(
                            child:Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),

                            child: Image.network(data[index]['url'],fit: BoxFit.cover,)),
                ),
                );
                },),
                );
                  }
                }
