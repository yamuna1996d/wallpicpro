import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:wallpicpro/Views/wallpaperfull.dart';
import 'package:wallpicpro/widgets/name.dart';
class Search extends StatefulWidget {
  final String searchQuery;

  Search({this.searchQuery});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchcontrol =TextEditingController();
  Future<dynamic>  searchWallpaper(String query) async {return http.get("https://wallpro.herokuapp.com/add/search?qname=$query").then((http.Response response){
    final int statuscode=response.statusCode;
    if(statuscode <200 || statuscode >400 || json ==null){
      throw new Exception("Error while fetching data");
    }
    print(response.body.toString());
    setState(() {
      data= json.decode(response.body);
    });

  });
  }
  @override
  void initState() {
    searchWallpaper(widget.searchQuery);
    super.initState();
  }
  List data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Heade(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(child: Container(
        child: Column(
            children: <Widget>[
        Container(
        decoration: BoxDecoration(
            color: Color(0xfff5f8fd),
        borderRadius: BorderRadius.circular(30),
      ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: searchcontrol,
                decoration: InputDecoration(hintText: "Search in small letters",border: InputBorder.none),

              ),
            ),
            GestureDetector(
              onTap: (){
                searchWallpaper(searchcontrol.text);
              },
              child: Container(
                  child: Icon(Icons.search)),
            ),
          ],
        ),
      ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                height: 520,
                width: 600,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child:
                GridView.builder(
                    itemCount: data==null ?0: data.length,
                    physics: ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      mainAxisSpacing: 6.0,
                      crossAxisSpacing: 6.0,
                    ), itemBuilder: (context,index){
                  return GridTile(
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Wall(imageUrl: data[index]['url'],)));
                      },
                      child: Hero(
                        tag: data[index]['url'],
                        child: Container(
                          child:ClipRRect(
                              borderRadius: BorderRadius.circular(20),

                              child: Image.network(data[index]['url'],fit: BoxFit.cover,)),
                        ),
                      ),
                    ),
                  );
                }),
              )
        ]
      )))
    );
  }
}

