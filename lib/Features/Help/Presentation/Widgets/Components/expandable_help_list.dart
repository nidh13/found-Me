import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';

class ExpandableHelpList extends StatefulWidget {
  final dynamic value;

  ExpandableHelpList({
    Key key,
    this.value,
  });

  @override
  _ExpandableHelpListState createState() => new _ExpandableHelpListState();
}

class _ExpandableHelpListState extends State<ExpandableHelpList> {
  bool open = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          open = !open;
        });
      },
      child: Column(
        children: [
          Container(
            height: 76,
            color: Colors.transparent,
            padding:
                EdgeInsets.only(left: 16, right: 25.8, bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.value['question'][0].toString(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ColorConstant.textColor),
                  ),
                ),
                InkWell(
                  child: Container(),
                  onTap: () {
                    open = !open;
                  },
                ),
                open == true
                    ? Container(
                        margin: EdgeInsets.only(bottom: 3, left: 0.21),
                        child: Image.asset(
                          "Assets/Images/arrow-up.png",
                          height: 13.18,
                          width: 13,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
          open == true
              ? Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        height: 0.45,
                        color: ColorConstant.dividerColor.withOpacity(.30),
                      ),
                    ),
                    SizedBox(
                      height: 21,
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 25, 25),
                      child: Column(
                        children: [
                          Container(
                            alignment: new FractionalOffset(0.0, 1.0),
                            child: Text(
                              widget.value['answer'][0],
                              textScaleFactor: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }
}
