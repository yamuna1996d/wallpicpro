import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wallpicpro/Views/category.dart';
import 'package:wallpicpro/Views/search.dart';
import 'package:wallpicpro/Views/wallpaperfull.dart';
import 'package:wallpicpro/datas/data.dart';
import 'package:wallpicpro/models/wallmodel.dart';
import 'package:wallpicpro/widgets/name.dart';
import 'package:http/http.dart' as http;
import 'models/catemoddel.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = new List();
  List<PhotosModel>wallpapers =new List();
  TextEditingController searchcontrol = TextEditingController();

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
    categories =getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: HeaderName(),
        elevation: 0.0,
      ),
      body:SingleChildScrollView(
        child:
          Container(

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
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>Search(
                            searchQuery:searchcontrol.text,
                          )));
                        },
                        child: Container(
                            child: Icon(Icons.search)),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10,),
                Container(
                  height: 90,
                  child: ListView.builder(
                      padding: EdgeInsets.all(20),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context,index){

                        return CategoryTile(
                          title: categories[index].catergoryName,
                          imgurl: categories[index].imgUrl,
                        );
                      }),
                ),
                      Container(
                        height: 450,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child:
                        GridView.builder(
                          itemCount: data==null ?0: data.length,
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
                        },),
                      ),
                    ],

            ),
          ),
       // ],
      )
    );
  }
}
class CategoryTile extends StatelessWidget {
  final String imgurl,title;
  CategoryTile({@required this.imgurl,@required this.title});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context)=>Categories(categoriName: title.toLowerCase(),)));
      },
      child: Container(
        margin: EdgeInsets.all(4),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imgurl,height: 50,width: 100,fit: BoxFit.cover,),
            ),
            Container(
              color: Colors.black12,
              height: 50,width: 100,
              alignment: Alignment.center,
              child: Text(title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w800,fontSize: 15),),
            )
          ],
        ),
      ),
    );
  }
}

