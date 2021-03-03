import 'dart:io';
import 'package:flutter/material.dart';
import 'package:thumbnails/thumbnails.dart';
import 'package:whats_toolkit/status/video_play.dart';
final Directory _videoDir = new Directory('/storage/emulated/0/WhatsApp/Media/.Statuses');

class VideoListView extends StatefulWidget {

  @override
  VideoListViewState createState() {
    return new VideoListViewState();
  }
}

class VideoListViewState extends State<VideoListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(!Directory("${_videoDir.path}").existsSync()) {
      return Scaffold(
        // appBar: AppBar(
        //   title: Text("Whatsapp Video Status"),
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
    }
    else{
      return Scaffold(
        // appBar: AppBar(
        //   title: Text("Whatsapp Video Status"),
        // ),
        body: VideoGrid(directory: _videoDir),
      );
    }
  }
}
class VideoGrid extends StatefulWidget {
  final Directory directory;

  const VideoGrid({Key key, this.directory}) : super(key: key);

  @override
  _VideoGridState createState() => _VideoGridState();
}

class _VideoGridState extends State<VideoGrid> {

  _getImage(videoPathUrl) async {
    //await Future.delayed(Duration(milliseconds: 500));
    String thumb = await Thumbnails.getThumbnail(
        videoFile: videoPathUrl,
        imageType: ThumbFormat.PNG,//this image will store in created folderpath
        quality: 10);
    return thumb;
  }

  @override
  Widget build(BuildContext context) {
    var videoList = widget.directory.listSync().map((item) => item.path).where((item) => item.endsWith(".mp4")).toList(growable: false);

    if(videoList!=null){
      if(videoList.length>0){
        return Container(
          child: GridView.builder(
            itemCount: videoList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 8.0/8.0),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: ()=> Navigator.push(context, new MaterialPageRoute(
                      builder: (context)=>new PlayStatusVideo(videoList[index])
                  ),),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // Where the linear gradient begins and ends
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        // Add one stop for each color. Stops should increase from 0 to 1
                        stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                        colors: [
                          // Colors are easy thanks to Flutter's Colors class.
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                          Color(0xffb7d8cf),
                        ],
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    child: FutureBuilder(
                        future: _getImage(videoList[index]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            if (snapshot.hasData) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Hero(
                                      tag: videoList[index],
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10.0),
                                          child: Image.file(
                                            File(snapshot.data),
                                            height: 280.0,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10.0, right: 10.0,bottom: 5.0),
                                      child: RaisedButton(
                                        child: Text("Play Video"),
                                        color: Colors.green,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          Navigator.push(context, new MaterialPageRoute(
                                              builder: (context)=>new PlayStatusVideo(videoList[index])
                                          ),);
                                        },
                                      ),
                                    ),
                                  ]
                              );
                            }
                            else{
                              return Center(child: CircularProgressIndicator(),);
                            }
                          }else{
                            return Hero(
                              tag: videoList[index],
                              child: Container(
                                height: 280.0,
                                child: Image.network('https://4.bp.blogspot.com/-f66IrIeNEBg/Wxy3LzFDc3I/AAAAAAAAHQ8/0F41uFvIfzsth4n2fnSNnJadCCK2j2FnQCLcBGAs/s320/Youtube%2BChannel%2BArt%2B-%2BUntitled%2B%25283%2529.jpg'),
                              ),
                            );
                          }
                        }
                    ),
                    //new cod
                  ),
                ),
              );
            },
          ),
        );
      }else{
        return Center(
          child: Container(
            padding: EdgeInsets.only(bottom: 60.0),
            child: Text("Sorry, No Videos Found.", style: TextStyle(
                fontSize: 18.0
            ),),
          ),
        );
      }
    }else{
      return Center(child: CircularProgressIndicator(),);
    }
  }
}