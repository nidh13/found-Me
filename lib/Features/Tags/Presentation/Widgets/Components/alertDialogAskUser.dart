import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class AlertDialogueAskUser extends ModalRoute<void> {
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
  String message, headerMessage;
  Profile profile;
  AlertDialogueAskUser(String headerMessage, String message, Profile profile) {
    this.message = message;
    this.headerMessage = headerMessage;
    this.profile = profile;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
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
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.08,
                          right: screenWidth * 0.08,
                          top: 0.05 * screenHeight),
                      child: MyText(
                          value: headerMessage,
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.08,
                          right: screenWidth * 0.08,
                          top: (screenHeight * 1.72) / 100,
                          bottom: (screenHeight * 1.72) / 100),
                      child: MyText(
                        value: message,
                        textAlign: TextAlign.center,
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      //height:  (screenHeight * 6.4) / 100,
                                      margin: EdgeInsets.only(
                                          top: (screenHeight * 4.93) / 100),
                                      padding: EdgeInsets.only(
                                        bottom: screenHeight * 0.05,
                                      ),
                                      child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          color: ColorConstant.greenColor,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: MyText(
                                                value: "messages_label_ok".tr(),
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onPressed: () {
                                            profile.parameters.location =
                                                'VerifyTag';
                                            profile.parameters.serial = profile
                                                .userGeneralInfo.masterTag;

                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                              '/tagsProvider',
                                              arguments: profile,
                                            );
                                          }))),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      //height:  (screenHeight * 6.4) / 100,
                                      margin: EdgeInsets.only(
                                          top: (screenHeight * 4.93) / 100),
                                      padding: EdgeInsets.only(
                                        bottom: screenHeight * 0.05,
                                      ),
                                      child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0))),
                                          color: ColorConstant.greenColor,
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: MyText(
                                                value:
                                                    "pets_label_continue".tr(),
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          onPressed: () {
                                            profile.parameters.location =
                                                "AddEditTag";
                                            Navigator.of(context)
                                                .pushReplacementNamed(
                                              '/tagsProvider',
                                              arguments: profile,
                                            );
                                          })))
                            ])),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 32,
                    width: 32,
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
