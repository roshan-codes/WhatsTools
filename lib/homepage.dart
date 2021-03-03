import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:whats_toolkit/direct/whatsapp_direct.dart';
import 'package:whats_toolkit/link_generator/link_generator.dart';
import 'package:whats_toolkit/read_more/readmore.dart';
import 'package:whats_toolkit/status/image_status.dart';
import 'package:whats_toolkit/status/status_tab.dart';
import 'package:whats_toolkit/status/video_status.dart';
import 'package:whats_toolkit/whatsapp_web/whatsapp_web.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff128C7E),
        centerTitle: true,
        title: Text("What'sapp Toolkit"),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.more),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context)=> QRScanner()));
            },
          )
        ],
      ),
      body: ListView(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(
                    0.7, 0.0), // 10% of the width, so there are ten blinds.
                colors: [
                  Color(0xff128C7E),
                  Color(0xff128C7E),
                ], // red to yellow
                tileMode:
                    TileMode.mirror, // repeats the gradient over the canvas
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      right: 15, top: 40, bottom: 20, left: 20),
                  child: Text("Whats Tools",
                      style: GoogleFonts.poppins(
                          fontSize: 50,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      // Align(
                      //   alignment: Alignment.center,
                      //   child: Container(
                      //     height: 5.0,
                      //     width: 30,
                      //     decoration: BoxDecoration(
                      //       color: Colors.black26,
                      //       borderRadius: BorderRadius.all(
                      //         Radius.circular(20),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      Row(
                        children: [
                          ButtonCard(
                            title: "WA Direct",
                            icon: FontAwesomeIcons.paperPlane,
                            color: [Colors.redAccent, Colors.pinkAccent],
                            id: 1,
                          ),
                          ButtonCard(
                            title: "Read More",
                            icon: FontAwesomeIcons.readme,
                            color: [Colors.lightBlue, Colors.lightBlueAccent],
                            id: 2,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          ButtonCard(
                            title: "Whatsapp Status",
                            icon: FontAwesomeIcons.images,
                            color: [Colors.green, Colors.green[400]],
                            id: 3,
                          ),
                          ButtonCard(
                            title: "Link Generator",
                            icon: FontAwesomeIcons.link,
                            color: [Colors.deepOrange, Colors.deepOrangeAccent],
                            id: 4,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ButtonCard extends StatelessWidget {
  String title;
  IconData icon;
  int id;
  List<Color> color;
  ButtonCard({@required this.title, @required this.icon, this.color, this.id});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BouncingWidget(
        duration: Duration(milliseconds: 100),
        scaleFactor: 1.5,
        onPressed: () async{
          if (id == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => WhatsappDirect()));
          }
          if (id == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ReadMore()));
          }
          if (id == 3) {
            var status = await Permission.storage.status;
            if (status.isUndetermined) {
              // You can request multiple permissions at once.
              Map<Permission, PermissionStatus> statuses = await [
                Permission.storage,
              ].request();
              print(statuses[Permission
                  .storage]); // it should print PermissionStatus.granted
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => StatusTab()));
            }
            else{
              if (await Permission.contacts.request().isGranted) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatusTab()));
              }
              else{
                Map<Permission, PermissionStatus> statuses = await [
                  Permission.storage,
                ].request();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => StatusTab()));
              }

            }
          }
          if (id == 4) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LinkGenerator()));
          }
        },
        child: GradientCard(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(
                0.8, 0.0), // 10% of the width, so there are ten blinds.
            colors: color, // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
          // shadowColor: Gradients.tameer.colors.last
          //     .withOpacity(0.25),
          elevation: 8,
          margin: EdgeInsets.all(10),
          child: Container(
            height: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FaIcon(
                  icon,
                  size: 40,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
