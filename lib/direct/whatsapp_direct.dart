
import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl_phone_number_input/intl_phone_number_input.dart';




class WhatsappDirect extends StatefulWidget {
  @override
  _WhatsappDirectState createState() => _WhatsappDirectState();
}

class _WhatsappDirectState extends State<WhatsappDirect> {
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _messageController = TextEditingController();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _messageFocus = FocusNode();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
   String phoneNo;
  PhoneNumber number = PhoneNumber(isoCode: 'IN');




  @override
  void dispose() {
    _phoneController.clear();
    _messageController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor:  Colors.white,
        title: Text('Direct Whatsapp',style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 25),),
        elevation: 0.0,
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            tooltip:"Clear",
            onPressed: () {
              _phoneController.clear();
              _messageController.clear();
            },
          )
        ],
      ),
      body: Container(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset("assets/message.png",scale: 3,),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: InternationalPhoneNumberInput(
                      textStyle:  GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
                      onInputChanged: (PhoneNumber number) {
                        print(number.phoneNumber);
                        setState(() {
                          phoneNo = number.phoneNumber.toString();
                        });
                      },
                      onInputValidated: (bool value) {
                        print(value);
                      },
                      selectorConfig: SelectorConfig(
                        selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      ),
                      ignoreBlank: true,
                      autoValidateMode: AutovalidateMode.always,
                      selectorTextStyle: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),
                      initialValue: number,
                      textFieldController: _phoneController,
                      formatInput: true,
                      inputDecoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintStyle: GoogleFonts.poppins(color: Colors.black38,fontWeight: FontWeight.bold,fontSize: 15),
                        hintText: "Enter Mobil No.",
                        suffixIcon: IconButton(icon:Icon(Icons.clear), onPressed: () {
                          setState(() {
                           _phoneController.clear();
                          });
                        },),
                      ),
                      keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                      inputBorder: OutlineInputBorder(),
                      onSaved: (PhoneNumber number) {
                        print('On Saved: $number');
                      },
                    ),
                  ),
                  TextInput(
                    controller: _messageController,
                    hintText: "Enter Your Message",
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.none,
                    focusNode: _messageFocus,
                    icon: Icons.message,
                    maxLength: 300,
                    maxLines: 5,
                    onSubmit: null,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  BouncingWidget(
                    scaleFactor: 1.5,
                    onPressed: () {
                      print(phoneNo);
                      _messageFocus.unfocus();
                      FlutterOpenWhatsapp.sendSingleMessage(phoneNo,_messageController.text);
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Color(0xff128C7E),
                      ),
                      child: Center(
                        child: Text(
                          'Message on Whatsapp',
                          style: GoogleFonts.poppins(
                            fontSize: 20.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final Function onSubmit;
  final String hintText;
  final IconData icon;
  final TextInputAction textInputAction;
  final FocusNode focusNode;
  final int maxLines;
  final int maxLength;
  final TextInputType textInputType;

  TextInput(
      {@required this.controller,
      @required this.hintText,
      @required this.textInputAction,
      @required this.icon,
      @required this.focusNode,
      @required this.onSubmit,
      @required this.textInputType,
      this.maxLines,
      this.maxLength});
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.5), width: 1.0),
          borderRadius: BorderRadius.circular(8.0)),
      child: Row(
        children: <Widget>[
          Container(
            height: maxLines == null ? 30.0 : 30.0 * maxLines * 0.80,
            width: 1.0,
            color: Colors.white.withOpacity(0.5),
            margin: const EdgeInsets.only(right: 10.0),
          ),
          Expanded(
            child: TextFormField(
              autofocus: false,
              controller: controller,
              textInputAction: textInputAction,
              onFieldSubmitted: onSubmit,
              keyboardType: textInputType,
              focusNode: focusNode,
              maxLines: maxLines,
              maxLength: maxLength,
              style: GoogleFonts.poppins(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              controller.clear();
            },
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoundButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final String text;

  RoundButton({
    @required this.icon,
    @required this.onPressed,
    @required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      color: Color(0xff128C7E),
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: onPressed,
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Text(
          text,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
    );
  }
}
