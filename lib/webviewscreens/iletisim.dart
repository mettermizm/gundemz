import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gundemz/functions/width_height.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Iletisim extends StatefulWidget {
  const Iletisim({Key? key}) : super(key: key);

  @override
  State<Iletisim> createState() => _IletisimState();
}

class _IletisimState extends State<Iletisim> {
  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  UniqueKey _key = UniqueKey();
  late WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://gundemz.com/iletisim/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://gundemz.com/iletisim/'));

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(),
    body: SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth(context) * 0.03,
         // vertical: screenHeight(context) * 0.02,
        ),
        width: screenWidth(context) * 0.94,
        child: WebViewWidget(
          gestureRecognizers: gestureRecognizers,
          key: _key,
          controller: controller,
        ),
      ),
    ),
  );
}
}
