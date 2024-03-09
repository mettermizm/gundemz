import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gundemz/variables/linkes.dart';
import 'package:gundemz/widgets/cupertinoactivityindicator.dart';

appAppBar(context) {
  String urlLogo = logoAdress;
  double screenwidth = MediaQuery.of(context).size.width;
  double screenheight = MediaQuery.of(context).size.height;
  return AppBar(
    leadingWidth: screenwidth * 0.10,
    toolbarHeight: screenheight * 0.06,
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: Container(
      margin: EdgeInsets.only(left: screenwidth * 0),
      height: screenheight * 0.05,
      width: screenwidth * 0.10,
      child: Builder(
        builder: (context) => IconButton(
          icon: new Icon(
            Icons.short_text,
            color: Colors.black,
            size: screenheight * 0.041,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
    ),
    title: Center(
      child: Container(
        // margin: EdgeInsets.only(right: screenwidth * 0.10),
        width: screenwidth * 0.60,
        height: screenheight * 0.05,
        child: CachedNetworkImage(
          // ignore: unnecessary_null_comparison
          imageUrl: urlLogo == null
              ? 'assets/images/ggndemzsiteicinlogo.png'
              : urlLogo,
          placeholder: (context, url) => IndicatorApp(
            radius: 10,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    ),
  );
}
