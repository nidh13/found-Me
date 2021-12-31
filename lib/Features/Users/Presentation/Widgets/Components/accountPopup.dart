import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:easy_localization/easy_localization.dart';

class AccountOverlay extends ModalRoute<void> {
  final Profile profile;
  final int index;
  bool value;
  bool roleChild;
  bool roleAdmin;

  bool roleMember;
  final BuildContext contextt;

  AccountOverlay(this.profile, this.index, this.value, this.roleChild,
      this.roleMember, this.roleAdmin, this.contextt);
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
                      margin: EdgeInsets.only(top: 25.0, bottom: 0.0),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60),
                            bottomLeft: Radius.circular(60),
                            bottomRight: Radius.circular(60)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage: NetworkImage(profile.userGeneralInfo
                            .subUsers[index].userGeneralInfo.profilePictureUrl),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.08,
                          right: screenWidth * 0.08,
                          top: 10.0,
                          bottom: 30),
                      child: Text(
                        profile.userGeneralInfo.subUsers[index].userGeneralInfo
                            .firstName,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 42.0, right: 42.0, top: 1.0, bottom: 2.0),
                      child: Text(
                        "popup_label_administratormsg".tr(),
                        textScaleFactor: 1.0,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            height: 1.5,
                            fontSize: 14,
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                        height: 50,
                        margin: EdgeInsets.only(top: 25.0),
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
                              "popup_label_yes".tr(),
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'SF Pro Text',
                                  letterSpacing: 0,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          color: ColorConstant.greenColor,
                          onPressed: () {
                            if (value == true) {
                              setState(() {
                                profile.userGeneralInfo.subUsers[index]
                                    .userGeneralInfo.role = 2;
                                profile
                                    .userGeneralInfo
                                    .subUsers[index]
                                    .userGeneralInfo
                                    .roleLabel = 'Administrator';
                                roleChild = false;
                                roleMember = false;
                              });
                              setState(() {
                                print(roleMember);
                                print(roleChild);
                              });
                            } else {
                              setState(() {});
                            }
                            Navigator.pop(context);
                          },
                        )),
                    InkWell(
                      onTap: () {
                        roleAdmin = false;
                        Navigator.pop(context);
                        value = false;
                      },
                      child: Container(
                          height: 50,
                          margin: EdgeInsets.only(top: 0.0),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.05),
                          alignment: Alignment.center,
                          child: Text(
                            "popup_label_no".tr(),
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                color: ColorConstant.darkGray,
                                fontFamily: 'SF Pro Text',
                                letterSpacing: 0,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          )),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 325,
                right: 18,
                top: 1,
                bottom: 380,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 35,
                    width: 25,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                      "assets/image/icon1.png",
                    ))),
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
