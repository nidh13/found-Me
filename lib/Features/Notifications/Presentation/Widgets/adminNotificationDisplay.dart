import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:easy_localization/easy_localization.dart';

class AdminNotificationDisplay extends StatefulWidget {
  final Profile profile;

  AdminNotificationDisplay(this.profile);
  @override
  AdminNotificationState createState() => new AdminNotificationState();
}

class AdminNotificationState extends State<AdminNotificationDisplay> {
  AdminNotificationState();

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
        child: Container(
          color: Colors.white,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            Container(
              height: 128,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: _colors,
                stops: _stops,
              )),

              //child: Padding(

              //padding: const EdgeInsets.symmetric(vertical: ),

              child: Container(
                child: Row(
                    /*mainAxisAlignment: MainAxisAlignment.spaceBetween,*/
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 73.0, 13.5, 41.0),
                        child: GestureDetector(
                            onTap:
                                () {} /*  => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => Notifications(),
                                    )) */
                            ,
                            // onTap: ,
                            child: Image.asset(
                              "Assets/Images/back.png",
                              height: 20,
                              width: 20,
                            )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 44.0, 0, 20),
                        child: Image.asset(
                          "Assets/Images/Groupe5816.png",
                          height: 72,
                          width: 72 * screenWidth,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 67.0, 0.0, 37.0),
                        child: Text(
                          "notifications_label_foundmeadmin".tr(),
                          textScaleFactor: 1.0,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            fontFamily: "SFProText",
                            color: Colors.white,
                          ),
                        ),
                      )
                    ]),
              ),
            ),
            ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                        height: 0.00,
                        color: ColorConstant.dividerColor.withOpacity(.00)),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: profil
                    .userGeneralInfo.notificationlist.adminNotification
                    .toJson()
                    .length,
                padding: EdgeInsets.zero,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: ColorConstant.lightGrey),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(12.0, 4, 12, 4),
                            child: profil
                                        .userGeneralInfo
                                        .notificationlist
                                        .adminNotification
                                        .content[index]
                                        .dateNotification !=
                                    null
                                ? Text(
                                    profil
                                        .userGeneralInfo
                                        .notificationlist
                                        .adminNotification
                                        .content[index]
                                        .dateNotification
                                        .substring(0, 16)
                                        .toString(),
                                    textScaleFactor: 1.0,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontFamily: 'SF Pro Text',
                                      fontSize: 12,
                                      color: ColorConstant.darkGray,
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                      )),
                      GestureDetector(
                        onTap:
                            () {} /* => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Adminnotification3(),
                      )) */
                        ,
                        child: Padding(
                          padding:
                              EdgeInsets.fromLTRB(0, 0, screenWidth * 30, 0.0),
                          child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                  color: ColorConstant.boxColor,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.all(12.0 * screenHeight),
                                    child: Image.network(profil
                                        .userGeneralInfo
                                        .notificationlist
                                        .adminNotification
                                        .content[index]
                                        .url),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Text(
                                          profil
                                                  .userGeneralInfo
                                                  .notificationlist
                                                  .adminNotification
                                                  .content[index]
                                                  .title +
                                              '\n' +
                                              "-------------------------------------------- \n" +
                                              profil
                                                  .userGeneralInfo
                                                  .notificationlist
                                                  .adminNotification
                                                  .content[index]
                                                  .text +
                                              "\n \n " +
                                              "homescree_href_readmore".tr(),
                                          textAlign: TextAlign.left,
                                          textScaleFactor: 1.0,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'SF Pro Text',
                                            fontSize: 14,
                                            color: Colors.black,
                                          ))),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: GestureDetector(
                                      onTap: () {},
                                      child: Text(
                                        "www.found.me/updatenotes",
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontFamily: 'SF Pro Text',
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.lightBlue,
                                            fontSize: screenWidth * 14),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.fromLTRB(0, 5, screenWidth * 285, 0.0),
                          child: Text(
                              profil
                                  .userGeneralInfo
                                  .notificationlist
                                  .adminNotification
                                  .content[index]
                                  .dateNotification
                                  .substring(17, 22)
                                  .toString(),
                              textScaleFactor: 1.0,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'SF Pro Text',
                                fontSize: 12,
                                color: ColorConstant.darkGray,
                              )))
                    ],
                  );
                })
          ]),
        ),
      ),
    );

    // onPressed: () => _SomeFunction(),
  }

  @override
  void initState() {
    super.initState();
  }
}
