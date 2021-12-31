import 'dart:async';
import 'package:flutter/material.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Features/Notifications/Presentation/Widgets/Components/NotificationOverlay.dart';

class FoundNotificationDisplay extends StatefulWidget {
  final Profile profile;
  final int index;

  FoundNotificationDisplay(this.profile, this.index);
  @override
  FoundNotificationDisplayState createState() =>
      new FoundNotificationDisplayState();
}

class FoundNotificationDisplayState extends State<FoundNotificationDisplay> {
  TextEditingController fnamecontroller = new TextEditingController();
  StreamController<String> emailStreamcontroller;
  TextEditingController emailcontroller = new TextEditingController();

  List<Color> _colors = [ColorConstant.pinkColor, ColorConstant.orangeColor];
  List<double> _stops = [0.0, 1.5];
  var screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    Profile profil = widget.profile;
    screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;

    return new Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: 128,
                decoration: BoxDecoration(
                  color: ColorConstant.pinkColor
                  ),

                //child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
                //padding: const EdgeInsets.symmetric(vertical: ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          GestureDetector(
                              onTap: () {
                                widget.profile.parameters.location =
                                    "drawer_label_notifications".tr();

                                Navigator.of(context).pushReplacementNamed(
                                  '/notificationsProvider',
                                  arguments: widget.profile,
                                );
                              },
                              child: Image.asset(
                                "Assets/Images/back.png",
                                height: 20,
                                width: 20,
                              )),
                          SizedBox(
                            width: 100,
                          ),
                          Text("drawer_label_notifications".tr(),
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: "SFProText",
                                  color: Colors.white))
                        ]),
                    GestureDetector(
                      onTap: () {
                        //   _showOverlay(context);
                      },
                      child: Image.asset(
                        "Assets/Images/FAQ.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
                // ),
              ),
              SizedBox(height: 8 * screenHeight),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 9),
                child: Container(
                    width: 326 * screenWidth,
                    height: 56 * screenHeight,
                    child: Text(
                      profil
                              .userGeneralInfo
                              .notificationlist
                              .whenObjectIsScanned
                              .content[widget.index]
                              .tagLabel ??
                          ' ',
                      textScaleFactor: 1.0,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: "SFProText",
                          fontSize: 28,
                          color: ColorConstant.pinkColor),
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(28.0, 33.0, 28.0, 20.0),
                child: Container(
                    child: Text(
                  profil.userGeneralInfo.notificationlist.whenObjectIsScanned
                      .content[widget.index].content,
                  textScaleFactor: 1.0,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: 'SF Pro Text',
                    fontSize: 14,
                  ),
                )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(28.0, 0.0, 28.0, 20.0),
                child: Container(
                    child: profil
                                .userGeneralInfo
                                .notificationlist
                                .whenObjectIsScanned
                                .content[widget.index]
                                .url !=
                            null
                        ? Image.network(
                            profil.userGeneralInfo.notificationlist
                                .whenObjectIsScanned.content[widget.index].url,
                            width: screenWidth * 900,
                            height: screenHeight * 297,
                          )
                        : Image.asset(
                            "Assets/Images/noti.png",
                            //    color: Colors.black,
                            width: screenWidth * 900,
                            height: screenHeight * 297,
                          )),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(28.0, 0.0, 28.0, 0.0),
                  child: Container()),
            ]),
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(InAppNotificationOverlay());
  }

  @override
  void initState() {
    emailStreamcontroller = StreamController<String>.broadcast();
    emailcontroller.addListener(() {
      emailStreamcontroller.sink.add(emailcontroller.text.trim());
    });

    super.initState();
  }
}
