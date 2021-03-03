import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whats_toolkit/status/video_status.dart';

import 'image_status.dart';

class StatusTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor:Colors.white,
            bottom: TabBar(
              indicatorColor: Color(0xff128C7E),
              onTap: (index) {
                // Tab index when user select it, it start from zero
              },
              tabs: [
                Tab(child: Text("Images",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w400),),),
                Tab(child: Text("Videos",style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w400)),),
              ],
            ),
            title: Text('Whatsapp Status',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 25),),
          ),
          body: TabBarView(
            children: [
              ImageStatus(),
              VideoListView(),
            ],
          ),
        ),
    );
  }
}
