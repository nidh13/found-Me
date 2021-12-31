library custom_switch;

import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';

class DiseableCustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color activeColor;

  const DiseableCustomSwitch(
      {Key key, this.value, this.onChanged, this.activeColor})
      : super(key: key);

  @override
  _DiseableCustomSwitchState createState() => _DiseableCustomSwitchState();
}

class _DiseableCustomSwitchState extends State<DiseableCustomSwitch>
    with SingleTickerProviderStateMixin {
  Animation _circleAnimation;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 60));
    _circleAnimation = AlignmentTween(
            begin: widget.value ? Alignment.centerRight : Alignment.centerLeft,
            end: widget.value ? Alignment.centerLeft : Alignment.centerRight)
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.linear));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            height: 24, width: 46.41, //color:Colors.blue,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    width: 44.83,
                    height: 21.43,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: _circleAnimation.value == Alignment.centerLeft
                            ? ColorConstant.darkGray
                            : ColorConstant.darkGray),
                  ),
                ),
                Center(
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      _circleAnimation.value == Alignment.centerRight
                          ? Padding(
                              padding: const EdgeInsets.only(
                                left: 22.0,
                                right: 0.0,
                              ),
                              /* child: Text(
                                  'On',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16.0),
                                ),*/
                            )
                          : Container(),
                      Align(
                        alignment: _circleAnimation.value,
                        child: Container(
                          width: 24.0,
                          height: 24.0,
                          decoration: BoxDecoration(boxShadow: [
                            new BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 1),
                              //  spreadRadius: 7.0,
                              blurRadius: 6.0,
                            ),
                          ], shape: BoxShape.circle, color: Colors.white),
                        ),
                      ),
                      _circleAnimation.value == Alignment.centerLeft
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 22.0, right: 0.0),
                              /*child: Text(
                                  'Off',
                                  style: TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 16.0),
                                ),*/
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
