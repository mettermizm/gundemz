import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gundemz/functions/width_height.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YerelSecim extends StatefulWidget {
  const YerelSecim({Key? key}) : super(key: key);

  @override
  State<YerelSecim> createState() => _YerelSecimState();
}

class _YerelSecimState extends State<YerelSecim> {
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
          if (request.url.startsWith('https://gundemz.com/yerel-secim/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://gundemz.com/yerel-secim/'));

  @override
  Widget build(BuildContext context) {
  return Scaffold(
    body: SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth(context) * 0.03,
         
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