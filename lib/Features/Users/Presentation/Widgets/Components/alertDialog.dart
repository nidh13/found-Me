import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:easy_localization/easy_localization.dart';

class AlertDialogue extends ModalRoute<void> {
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
  int index;
  AlertDialogue(
      String headerMessage, String message, Profile profile, int index) {
    this.message = message;
    this.profile = profile;
    this.headerMessage = headerMessage;
    this.index = index;
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
                      child: Text(
                        headerMessage,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.08,
                          right: screenWidth * 0.08,
                          top: (screenHeight * 1.72) / 100,
                          bottom: (screenHeight * 1.72) / 100),
                      child: Text(
                        message,
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                        //height:  (screenHeight * 6.4) / 100,
                        margin:
                            EdgeInsets.only(top: (screenHeight * 4.93) / 100),
                        padding: EdgeInsets.only(
                            left: screenWidth * 0.03,
                            bottom: screenHeight * 0.05,
                            right: screenWidth * 0.03),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          color: ColorConstant.greenColor,
                          child: Container(
                            width: screenWidth * 1.0,
                            height: screenHeight * 0.08,
                            alignment: Alignment.center,
                            child: Text(
                              "messages_label_ok".tr(),
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).pushReplacementNamed(
                              '/usersProvider',
                              arguments: {
                                'profile': profile,
                                'route': 'GoToEditViewSubUser',
                                'index': index
                              },
                            );
                          },
                        )),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      '/usersProvider',
                      arguments: {
                        'profile': profile,
                        'route': 'GoToEditViewSubUser',
                        'index': index
                      },
                    );
                  },
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
