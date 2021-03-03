import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WhastappWeb extends StatefulWidget {
  @override
  _WhastappWebState createState() => _WhastappWebState();
}

class _WhastappWebState extends State<WhastappWeb> {
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();

 @override
  Widget build(BuildContext context) {
    return WebView(
      userAgent: "Mozilla/8.0 (X11; U; Linux i686; en-US; rv:1.9.0.4) Gecko/20100101 Firefox/4.0",
      initialUrl: "https://web.whatsapp.com/",
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
    );
  }
}
