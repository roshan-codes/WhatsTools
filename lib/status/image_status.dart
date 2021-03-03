import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:whats_toolkit/status/view_photo.dart';

final Directory _photoDir = new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class ImageStatus extends StatefulWidget {
  @override
  _ImageStatusState createState() => _ImageStatusState();
}

class _ImageStatusState extends State<ImageStatus> {


  @override
  Widget build(BuildContext context) {
    if(!Directory("${_photoDir.path}").existsSync()) {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text("Whatsapp Photo Status"),
        // ),
        body: Container(
          padding: EdgeInsets.only(bottom: 60.0),
          child: Center(
            child: Text("Install WhatsApp\nYour Friend's Status will be available here.", style: TextStyle(
                fontSize: 18.0
            ),),
          ),
        ),
      );
    }else {
      var imageList = _photoDir.listSync().map((item) => item.path).where((
          item) => item.endsWith(".jpg")).toList(growable: false);

      if (imageList.length > 0) {
        return Scaffold(
          // appBar: AppBar(
          //   title: Text("Whatsapp Photo Status"),
          // ),
          body: Container(
            child: StaggeredGridView.countBuilder(
              padding: const EdgeInsets.all(8.0),
              crossAxisCount: 4,
              itemCount: imageList.length,
              itemBuilder: (context, index) {
                String imgPath = imageList[index];
                return Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: InkWell(
                    onTap: () =>
                        Navigator.push(context, new MaterialPageRoute(
                            builder: (context) => new ViewPhotos(imgPath)
                        ),),
                    child: Hero(
                      tag: imgPath,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.file(
                          File(imgPath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (i) =>
                  StaggeredTile.count(2, i.isEven ? 2 : 2),
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text("Whatsapp Photo Status"),
          ),
          body: Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 60.0),
              child: Text("Sorry, No Images Found.", style: TextStyle(
                  fontSize: 18.0
              ),),
            ),
          ),
        );
      }
    }
  }
}