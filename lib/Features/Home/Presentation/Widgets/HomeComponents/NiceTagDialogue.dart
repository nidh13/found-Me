import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:easy_localization/easy_localization.dart';

class TutorialOverlayNice extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  double screenWidth;
  double screenHeight;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return Container(
        height: screenHeight * 1.0,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                width: screenWidth * 0.8,
                height: screenHeight * 0.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[
                    SizedBox(height: 0.005 * screenHeight),
                    Container(
                      width: screenWidth * 0.5,
                      height: screenHeight * 0.05,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(
                          "Assets/Images/logo.png",
                        ),
                      )),
                    ),

                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 25),
                      child: Container(
                        width: screenWidth * 0.8,
                        height: screenHeight * 0.1,
                        child: Expanded(
                          child: Text(
                            "nicetag_label_thankyou".tr(),
                            textScaleFactor: 1.0,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 28,
                                color: ColorConstant.pinkColor,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                    //padding: EdgeInsets.only(left: screenWidth * 0.08, right: screenWidth * 0.08, top: 15.0),
                    Container(
                      // padding: EdgeInsets.only(top: 5.5),
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.23,
                      child: Image(
                        image: AssetImage("Assets/Images/nice.png"),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("Assets/Images/close.png"))),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
