import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkGenerator extends StatefulWidget {
  @override
  _LinkGeneratorState createState() => _LinkGeneratorState();
}

class _LinkGeneratorState extends State<LinkGenerator> {

  final _formKey = GlobalKey<FormState>();
  PhoneNumber number = PhoneNumber(isoCode: 'IN');
  String phone, message;
  String generatedUrl;
  bool urlGenerated = false, copied = false, validate = false;

  String _whatsAppLinkBuilder({phone,message}){
    String updatedMessage = message.toString().replaceAll(" ", "%20");
    String link = "https://api.whatsapp.com/send?phone=$phone&text="
        + updatedMessage;
    print(link);
    setState(() {
      generatedUrl = link;
      validate = false;
      urlGenerated = true;
      copied = false;
    });
    return link;

  }

  _launchURL() async {
    if (await canLaunch(generatedUrl)) {
      await launch(generatedUrl);
    } else {
      throw 'Could not launch $generatedUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Let's Generate"),
        centerTitle: true,
        backgroundColor:  Color(0xff128C7E),
      ),
      body: Stack(
        children: <Widget>[
          Container(height: double.infinity,width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(80)),
            ),),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 30,),
                  Stack(
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InternationalPhoneNumberInput(
                          onInputChanged: (PhoneNumber number) {
                            print(number.phoneNumber);
                            setState(() {
                              phone = number.phoneNumber.toString();
                            });
                          },
                          onInputValidated: (bool value) {
                            print(value);
                          },
                          selectorConfig: SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          ),
                          ignoreBlank: false,
                          autoValidateMode: AutovalidateMode.disabled,
                          selectorTextStyle: TextStyle(color: Colors.black),
                          initialValue: number,
                          // textFieldController: _phoneController,
                          formatInput: false,
                          keyboardType: TextInputType.numberWithOptions(signed: true, decimal: true),
                          inputBorder: OutlineInputBorder(),
                          onSaved: (PhoneNumber number) {
                            print('On Saved: $number');
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text('Make sure you include the country code followed'
                        ' by the area code. E.g.1 for the US, 91 for the INDIA.',
                      style: TextStyle(fontSize: 14,color: Colors.green[400]),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 16,),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black.withOpacity(0.5), width: 1.0),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                        child: Icon(
                          Icons.chat,
                          color: Colors.black,
                        ),
                      ),
                      Container(

                        color: Colors.white.withOpacity(0.5),
                        margin: const EdgeInsets.only(right: 10.0),
                      ),
                      Expanded(
                        child: TextFormField(
                 onChanged: (value){
                   setState(() {
                     message = value;
                   });
                 },
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type pre-typed message here..",
                            hintStyle: TextStyle(
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  SizedBox(height: 8,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text('What message do you want your customers to see'
                        ' when they contact you?',
                      style: TextStyle(fontSize: 14,color: Colors.green[400]),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 24,),
                  BouncingWidget(
                    scaleFactor: 1.5,
                    onPressed: () {
                      _formKey.currentState.save();
                      if(phone.isEmpty || message.isEmpty){
                        setState(() {
                          validate = true;
                        });
                      }else{
                        _whatsAppLinkBuilder(phone: phone,message: message);
                      }
                    },
                    child: Container(
                      height: 60,
                      width: 270,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100.0),
                        color: Color(0xff128C7E),
                      ),
                      child: Center(
                        child: Text(
                          'Generate Link',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8,),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Text(validate ? '''Make Sure both feilds are filled '''+
                        ''''then click "Generate WhatsApp Link"''':"",
                      style: TextStyle(fontSize: 14,color: Colors.red[400]),
                      textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: 20,),
                  Flexible(
                    child: Wrap(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            InkWell(
                              child: Text(!urlGenerated ? "":generatedUrl,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14),),
                              onTap: () async {
                                _launchURL();
                              },),
                            SizedBox(height: 8,),
                            urlGenerated ? GestureDetector(
                                onTap: (){
                                  Clipboard.setData(new ClipboardData(text: generatedUrl));
                                  setState(() {
                                    copied = true;
                                  });
                                },
                                child: Icon(Icons.content_copy,color: copied ? Colors.green:Colors.black26,)):Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}