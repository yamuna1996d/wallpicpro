import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
class Wall extends StatefulWidget {
  final String imageUrl;

  const Wall({@required this.imageUrl,});
  @override
  _WallState createState() => _WallState();
}

class _WallState extends State<Wall> {
  var filePath;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: widget.imageUrl,
          child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Image.network(widget.imageUrl, fit: BoxFit.cover,)
          ),
        ),
        Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.only(left: 140, bottom: 50),
            child: Row(
              children: <Widget>[
                FloatingActionButton(onPressed: () {
                   _save();
                },
                  child: Icon(Icons.file_download,)
                  ,
                ),
              ],
            )

        ),





//        Container(
//          alignment: Alignment.bottomCenter,
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.end,
//            children: <Widget>[
////              Container(
////                decoration: BoxDecoration(
////                  borderRadius: BorderRadius.circular(30),
////                  border:Border.all(color: Colors.black),
////                  gradient: LinearGradient(
////                    colors: [ Colors.white,
////                      Colors.black]
////                  )
////                ),
////              ),
//              Text("Cancel",style: TextStyle(color: Colors.white),),
//              SizedBox(height: 50,)
//            ],
//          ),
//        )

      ],
    );
  }

   _onImageWallpapButtonPressed() async {

    var response = await Dio().get(widget.imageUrl);
    filePath = await ImagePickerSaver.saveFile(fileData: response.data);

    _getWallpaper();
  }


  static const platform = const MethodChannel('wallpaper');
  Future<void> _getWallpaper() async {
    try {
      final int result =  await platform.invokeMethod('getWallpaper',{"text":filePath});
    } on PlatformException catch (e) {
      Navigator.pop(context);

    }
  }
  _save() async {
    if(Platform.isAndroid){
      await _askPermission();
    }
    var response = await Dio().get(widget.imageUrl,
        options: Options(responseType: ResponseType.bytes));
    final result =
    await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
    print(result);
    Navigator.pop(context);
  }

  _askPermission() async {
    if (Platform.isIOS) {
      /*Map<PermissionGroup, PermissionStatus> permissions =
          */await PermissionHandler()
          .requestPermissions([PermissionGroup.photos]);
    } else {
      PermissionHandler permission = PermissionHandler();
      await permission.requestPermissions([PermissionGroup.storage,PermissionGroup.camera,PermissionGroup.location]);
      await permission.checkPermissionStatus(PermissionGroup.storage);
    }
  }
}
//  void onDownload()async{
//
//  }
//  void onLoading(bool t){
//    if(t){
//      showDialog(
//          context:context,barrierDismissible: false,
//        builder: (BuildContext context){
//        return SimpleDialog(
//          children: <Widget>[
//            new CircularProgressIndicator(),
//            new Text("Downloading"),
//          ]);
//        });
//    }
//    else{
//      Navigator.pop(context);
//      showDialog(context: context,barrierDismissible: false,
//      builder: (BuildContext context) {
//        return SimpleDialog(
//            children: <Widget>[
//              new CircularProgressIndicator(),
//              new Text("Done"),
//            ]);
//      });
//      Future.delayed(const Duration(seconds: 3),(){
//        Navigator.pop(context);
//      });
//    }
//  }
//  static const platform = const MethodChannel("wallpaper");
//}

