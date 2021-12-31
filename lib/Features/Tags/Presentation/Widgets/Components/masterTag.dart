import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class MasterOverlay extends ModalRoute<void> {
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
  Profile profile;
  MasterOverlay(Profile profile) {
    this.profile = profile;
  }

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
                      margin: EdgeInsets.fromLTRB(92.0, 0.0, 91.0, 0.0),
                      height: 180.0,
                      width: 190.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage("Assets/Images/masterTag.png"),
                      )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.08,
                        right: screenWidth * 0.08,
                      ),
                      child: MyText(
                          value: profile.userGeneralInfo.masterTag,
                          color: ColorConstant.pinkColor,
                          fontSize: 29,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.08,
                          right: screenWidth * 0.08,
                          top: 28.0),
                      child: MyText(
                          value: "objecttag_btn_mastercodemsg1".tr(),
                          textAlign: TextAlign.center,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.08,
                          right: screenWidth * 0.08,
                          top: 28.0),
                      child: MyText(
                          value: "objecttag_btn_mastercodemsg2".tr(),
                          textAlign: TextAlign.center,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.08,
                          right: screenWidth * 0.08,
                          top: 28.0),
                      child: MyText(
                          value: "objecttag_btn_mastercodemsg3".tr(),
                          textAlign: TextAlign.center,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 30.0),
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: Container(
                            width: screenWidth * 1.0,
                            alignment: Alignment.center,
                            child: MyText(
                                value: "objecttag_btn_mastercodemsg4".tr(),
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
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
                          child: MyText(
                              value: "objecttag_btn_mastercodemsg5".tr(),
                              color: ColorConstant.darkGray,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
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
