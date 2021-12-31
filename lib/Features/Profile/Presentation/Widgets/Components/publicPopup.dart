import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:easy_localization/easy_localization.dart';

class PublicPopup extends ModalRoute<void> {
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
                width: screenWidth * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 24.2, bottom: 31.9),
                      height: 104.2,
                      width: 112.9,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("Assets/Images/delete-icon.png"))),
                    ),
                    Padding(
                        padding: EdgeInsets.only(bottom: 9.4),
                        child: Image.asset('Assets/Images/publicatt.png',
                            width: 70)),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.08,
                          right: screenWidth * 0.08,
                          bottom: 6),
                      child: Text(
                        "editprofil_general_blocinfo_publicaccess".tr(),
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'SF Pro Display',
                          fontSize: 21,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.08, right: screenWidth * 0.08),
                      child: Text(
                        "editprofil_general_blocinfo_publicaccess_message".tr(),
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'SF Pro Text',
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 41),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            width: screenWidth * 1.0,
                            alignment: Alignment.center,
                            child: Text(
                              "editprofil_general_bloctitle_makepublic".tr(),
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SF Pro Text',
                                  letterSpacing: 0,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          color: ColorConstant.greenColor,
                          onPressed: () {
                            setState(() {});
                          },
                        )),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 0.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          alignment: Alignment.center,
                          child: Text(
                            "editprofil_general_bloctitle_notmakepublic".tr(),
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                color: ColorConstant.darkGray,
                                fontFamily: 'SF Pro Text',
                                letterSpacing: 0,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                ),
              ),
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
