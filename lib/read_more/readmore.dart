import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:whats_toolkit/direct/whatsapp_direct.dart';
import 'package:bouncing_widget/bouncing_widget.dart';

class ReadMore extends StatelessWidget {
   TextEditingController _phoneController = TextEditingController();
  TextEditingController _beforeReadMoreTextEditingController = TextEditingController();
  TextEditingController _afterReadMoreTextEditingController = TextEditingController();
  final FocusNode _intoMessageFocus = FocusNode();
  final FocusNode _readMoreMessageFocus = FocusNode();
   final FocusNode _phoneFocus = FocusNode();
   


   _fieldFocusChange(
       BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
     currentFocus.unfocus();
     FocusScope.of(context).requestFocus(nextFocus);
   }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Read More"),
          centerTitle: true,
          backgroundColor:  Color(0xff128C7E),
          actions: [
            IconButton(
              icon: Icon(Icons.copy),
              onPressed: (){
                FlutterClipboard.copy(_beforeReadMoreTextEditingController.text+"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "+ _afterReadMoreTextEditingController.text).then(( value ) => print('copied'));

              },
            )
          ],
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            Image.asset('assets/readmore.png',scale: 2,),
            TextInput(
              controller: _beforeReadMoreTextEditingController,
              hintText: "Enter Intro Text",
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.none,
              focusNode: _intoMessageFocus,
              icon: Icons.message,
              maxLength: 100,
              maxLines: 2,
              onSubmit: null,
            ),
            TextInput(
              controller: _afterReadMoreTextEditingController,
              hintText: "Read More Text",
              textInputType: TextInputType.text,
              textInputAction: TextInputAction.none,
              focusNode: _readMoreMessageFocus,
              icon: Icons.message,
              maxLength: 100,
              maxLines: 2,
              onSubmit: null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: BouncingWidget(
                scaleFactor: 1.5,
                onPressed: () {
                   _readMoreMessageFocus.unfocus();
                   FlutterOpenWhatsapp.sendSingleMessage(" ", _beforeReadMoreTextEditingController.text+"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    "+ _afterReadMoreTextEditingController.text);
                    },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Color(0xff128C7E),
                  ),
                  child: Center(
                    child: Text(
                      'Send Direct',
                      style: GoogleFonts.poppins(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
