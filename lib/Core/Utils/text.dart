import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
//font size by default 14
//fontFamily SFProText
//color by default ColorConstant.textColor

class MyText extends StatelessWidget {
final  String value;
final double fontSize;
final Color color;
final FontWeight fontWeight;
final TextOverflow overflow;
final int maxLines ;
final bool softWrap;
final TextAlign textAlign;
final TextDecoration decoration;
  MyText({this.value, this.fontSize, this.color,this.fontWeight,this.overflow,this.maxLines,this.softWrap,this.textAlign,this.decoration});



  @override
  Widget build(BuildContext context) {
    return Text(
      value,
      overflow: overflow,
      maxLines: maxLines,
      textScaleFactor: 1.0,
      textAlign: textAlign,
      softWrap: softWrap,
      
      style: TextStyle(
        decoration: decoration,
          fontFamily: 'SFProText',
          fontWeight: fontWeight,
          fontSize: fontSize != null ? fontSize : 14,
          color: color != null ? color : ColorConstant.textColor),
    );
  }
}
