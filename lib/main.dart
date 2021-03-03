import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whats_toolkit/direct_page.dart';
import 'package:whats_toolkit/homepage.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DirectPage(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color:  Color(0xff128C7E),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            FaIcon(
              FontAwesomeIcons.whatsapp,
                  size: 40,
                  color: Colors.white,
                ),
              Text("Whats Tools",style: GoogleFonts.poppins(fontSize: 25,fontWeight: FontWeight.bold,color: Colors.white),),
            ],
          ),
        ),
      ),
    );
  }
}
