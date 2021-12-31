import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';

Widget backAppBar(
    {String title,
    Color backgroundColor,
    @required Function onPressed,
    @required profile,
    @required BuildContext context}) {
  return AppBar(
    elevation: 0.0,
    centerTitle: true,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: onPressed,
    ),
    title: Text(
      title,
      textScaleFactor: 1.0,
      style: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
    ),
    backgroundColor: backgroundColor ?? ColorConstant.pinkColor,
    actions: <Widget>[
      IconButton(
        icon: Image.asset(
          "Assets/Images/FAQ.png",
          height: 28,
          width: 28,
        ),
        onPressed: () {},
      ),
    ],
  );
}
