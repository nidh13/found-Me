import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';

class AttachmentSelection extends StatefulWidget {
  final Function onPressed;
  final Color borderColor;
  final bool isSelected;
  final String title;

  const AttachmentSelection(
      {Key key,
      this.onPressed,
      this.borderColor,
      this.isSelected,
      @required this.title})
      : super(key: key);

  @override
  _AttachmentSelectionState createState() => _AttachmentSelectionState();
}

class _AttachmentSelectionState extends State<AttachmentSelection> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Row(children: [
        Container(
          width: 37,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 1.0,
                  color: widget.isSelected
                      ? ColorConstant.iconGreenColor
                      : ColorConstant.greyTextColor),
              borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 15,
                padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 3.0),
                decoration: BoxDecoration(
                    color: widget.isSelected
                        ? ColorConstant.iconGreenColor
                        : ColorConstant.greyTextColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(3),
                        topLeft: Radius.circular(3))),
                child: Image.asset(
                  "Assets/Images/attachment.png",
                  height: 11,
                  width: 9,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  // padding: EdgeInsets.symmetric(vertical: 2.5, horizontal: 3.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(3),
                          topRight: Radius.circular(3))),
                  child: widget.isSelected
                      ? Image.asset(
                          "Assets/Images/eye-green.png",
                          height: 11,
                          width: 9,
                        )
                      : Image.asset(
                          "Assets/Images/eye-close.png",
                          height: 11,
                          width: 9,
                        ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 13,
        ),
        Text(
          widget.title ?? "",
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 12.0,
              color: ColorConstant.textColor,
              fontWeight: FontWeight.w500),
        )
      ]),
    );
  }
}
