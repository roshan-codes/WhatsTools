import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:whats_toolkit/direct/whatsapp_direct.dart';
import 'package:whats_toolkit/status/status_tab.dart';

class DirectPage extends StatefulWidget {
  @override
  _DirectPageState createState() => _DirectPageState();
}

class _DirectPageState extends State<DirectPage> {
  final List<TitledNavigationBarItem> items = [
    TitledNavigationBarItem(title: Text('Direct Msg'), icon: Icons.send),
    TitledNavigationBarItem(title: Text('Status'), icon: Icons.image_sharp),

  ];

  bool navBarMode = false;
  int page = 0;


  Widget Page(){
    if(page == 0){
      return WhatsappDirect();
    }
    if(page == 1){
      return StatusTab();
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      // appBar: AppBar(
      //   title: Text("WhatsTools",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25),),
      //   // centerTitle: true,
      //   elevation: 0.0,
      //   backgroundColor: Colors.white,
      // ),
      body: Page(),
      bottomNavigationBar: TitledBottomNavigationBar(
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        // reverse: navBarMode,
        curve: Curves.easeInBack,
        currentIndex: page,
        items: items,
        activeColor: Color(0xff128C7E),
        inactiveColor: Colors.blueGrey,
      ),
    );
  }
}