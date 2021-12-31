import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:neopolis/Features/Home/Presentation/bloc/home_bloc.dart';
import 'package:neopolis/Features/Notifications/Presentation/Widgets/Components/notificationItemUser.dart';
import 'package:neopolis/Features/Notifications/Presentation/Widgets/foundnotificationsDispaly.dart';
import 'package:neopolis/Features/Home/Presentation/Widgets/HomeComponents/usersPopup.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationsDisplay extends StatefulWidget {
  final Profile profile;
  const NotificationsDisplay({Key key, @required this.profile})
      : super(key: key);
  @override
  _NotificationsDisplayState createState() => _NotificationsDisplayState();
}

class _NotificationsDisplayState extends State<NotificationsDisplay> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  var screenWidth, screenHeight;

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;

    bool selectNotification = true;

    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return Scaffold(
          key: scaffoldKey,
          backgroundColor: Colors.white,
          drawer: Container(
            margin: EdgeInsets.only(top: screenHeight * 0.05),
            child: Drawer(
              child: Container(
                color: ColorConstant.drawerBgColor,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topRight,
                      padding: EdgeInsets.only(
                          right: 5.0,
                          top: (screenHeight * 4.434) / 90,
                          bottom: (screenHeight * 6.035) / 100),
                    ),
                    InkWell(
                      onTap: () {
                        ////////      on  jpressed Notification ///////
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            right: 0,
                            top: (screenHeight * 1.51) / 100,
                            bottom: (screenHeight * 1.51) / 100),
                        child: expandedDrawer(
                            profile: profile,
                            itemName: "drawer_label_home".tr(),
                            seleceted: false),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ////////      on pressed Notification ///////
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: (screenHeight * 1.51) / 100),
                        child: expandedDrawer(
                            profile: profile,
                            itemName: "drawer_label_messages".tr(),
                            seleceted: false),
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.white,
                        accentColor: Colors.white,
                      ),
                      child: ExpansionTile(
                        title: Text(
                          "drawer_label_myaccount".tr(),
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        children: <Widget>[
                          expandedDrawerItem(
                            profile: profile,
                            itemName: "drawer_label_userscreen".tr(),
                          ),
                          expandedDrawerItem(
                            profile: profile,
                            itemName: "drawer_label_resetpassword".tr(),
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.white,
                        accentColor: Colors.white,
                      ),
                      child: ExpansionTile(
                        title: Text(
                          "drawer_label_tags".tr(),
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                        children: <Widget>[
                          expandedDrawerItem(
                            profile: profile,
                            itemName: "drawer_label_mytags".tr(),
                          ),
                          expandedDrawerItem(
                            profile: profile,
                            itemName: "drawer_label_testtag".tr(),
                          ),
                          expandedDrawerItem(
                            profile: profile,
                            itemName: "drawer_label_switchtag".tr(),
                          ),
                          expandedDrawerItem(
                            profile: profile,
                            itemName: "drawer_label_addtag".tr(),
                          ),
                        ],
                      ),
                    ),
                    // ExpansionTile(
                    //   title: Text(
                    //     "Pet tags (Will be removed lately)",
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w400,
                    //     ),
                    //   ),
                    //   children: <Widget>[
                    //     expandedDrawerItem(
                    //         profile: profile,
                    //         itemName: "Customize pet profile"),
                    //     expandedDrawerItem(
                    //         profile: profile, itemName: "View pet profile"),
                    //   ],
                    // ),
                    InkWell(
                      onTap: () {
                        ////////      on pressed Notification ///////
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: (screenHeight * 1.51) / 100),
                        child: expandedDrawer(
                            profile: profile,
                            itemName: "drawer_label_users".tr(),
                            seleceted: false),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ////////      on pressed Notification ///////
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: (screenHeight * 1.51) / 100),
                        child: expandedDrawer(
                            profile: profile,
                            itemName: "drawer_label_remindersalarms".tr(),
                            seleceted: false),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ////////      on pressed Notification ///////
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: (screenHeight * 1.51) / 100),
                        child: expandedDrawer(
                            profile: profile,
                            itemName: "drawer_label_notifications".tr(),
                            seleceted: selectNotification),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ////////      on pressed Notification ///////
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: (screenHeight * 1.51) / 100),
                        child: expandedDrawer(
                            profile: profile,
                            itemName: "drawer_label_mylockscreen".tr(),
                            seleceted: false),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ////////      on pressed Notification ///////
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: (screenHeight * 1.51) / 100),
                        child: expandedDrawer(
                            profile: profile,
                            itemName: "drawer_label_socialmedia".tr(),
                            seleceted: false),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ////////      on pressed Notification ///////
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: (screenHeight * 1.51) / 100),
                        child: expandedDrawer(
                            profile: profile,
                            itemName: "drawer_label_referrals".tr(),
                            seleceted: false),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ////////      on pressed Notification ///////
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: (screenHeight * 1.51) / 100),
                        child: expandedDrawer(
                            profile: profile,
                            itemName: "drawer_label_contacthelp".tr(),
                            seleceted: false),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: InkWell(
                        onTap: () {
                          /*      dispatchLogout(profile); */
                        },
                        child: expandedDrawer(
                            profile: profile,
                            itemName: "drawer_label_logout".tr(),
                            seleceted: false),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: Stack(alignment: Alignment.topCenter, children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 18.0,
              ),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 110,
                  ),
                  // GestureDetector(
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (_) =>
                  //                   AdminNotificationDisplay(profile)));
                  //     },
                  //     child: NotificationItem(
                  //       notif: profile
                  //           .userGeneralInfo.notificationlist.adminNotification,
                  //       index: 1,
                  //       type: "admin",
                  //     )),
                  // Container(
                  //   height: profile.userGeneralInfo.notificationlist
                  //           .whenObjectIsScanned.content.length
                  //           .toDouble() *
                  //       100,
                  //   child: ListView.builder(
                  //       padding: EdgeInsets.fromLTRB(0, 1, 0, 0),
                  //       physics: NeverScrollableScrollPhysics(),
                  //       itemCount: profile.userGeneralInfo.notificationlist
                  //           .whenObjectIsScanned.content.length,
                  //       itemBuilder: (BuildContext context, int index) {
                  //         return GestureDetector(
                  //             onTap: () {
                  //               Navigator.push(
                  //                   context,
                  //                   MaterialPageRoute(
                  //                       builder: (_) => UserNotificationDisplay(
                  //                           profile, index)));
                  //             },
                  //             child: NotificationItemUser(
                  //                 notif: profile.userGeneralInfo
                  //                     .notificationlist.whenObjectIsScanned,
                  //                 index: index));
                  //       }),
                  // ),
                  Container(
                    height: profile.userGeneralInfo.notificationlist
                            .whenObjectIsScanned.content.length
                            .toDouble() *
                        115,
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        itemCount: profile.userGeneralInfo.notificationlist
                            .whenObjectIsScanned.content.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => FoundNotificationDisplay(
                                          profile, index)));
                            },
                            child: NotificationItemUser(
                              notif: profile.userGeneralInfo.notificationlist
                                  .whenObjectIsScanned,
                              index: index,
                              profile: profile,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
            Container(
              height: (screenHeight * 18.5) / 100,
              decoration: BoxDecoration(
                                 color: ColorConstant.pinkColor
,
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(0.0),
                    bottomLeft: Radius.circular(0.0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 2.0,
                    spreadRadius: 0.01,
                  ),
                ],
              ),
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                AppBar(
                  elevation: 0.0,
                  centerTitle: true,
                  leading: IconButton(
                      icon: ImageIcon(
                        AssetImage("Assets/Images/menu.png"),
                        size: 18,
                      ),
                      onPressed: () => scaffoldKey.currentState.openDrawer()),
                  title: Text(
                    "drawer_label_notifications".tr(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  backgroundColor: Colors.transparent,
                  actions: <Widget>[
                    IconButton(
                      icon: Image.asset(
                        "Assets/Images/FAQ.png",
                        height: 28,
                        width: 28,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HelpDisplay(profile: profile)),
                        );
                      },
                    )
                  ],
                ),
              ],
            ),
          ]));
    });
  }

  void dispatchGoToHelp(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/helpProvider',
      arguments: profile,
    );
  }
/* 
  void dispatchGoToEdit() {
    BlocProvider.of<ProfileBloc>(context).dispatch(
      GoToEditProfileEvent(
        profile: widget.profile,
      ),
    );
  } */

  /* for (final type in lstNotf.keys) {
          final value = lstNotf[type];
          final content= lstNotf[type]['content'];
          print('type='+ '$type' +'contenu='+'$content' );
          for(final notif in content){
            print('active');// prints entries like "AED,3.672940"
          }
        }*/
/*         return GestureDetector(
            onTap: () {
              if (index == 0) { */
/*                 Navigator.push(context, MaterialPageRoute(builder: (_) => AdminNotification1(/*lstNotf[index]['content']*/),));

 */

  /*         } else { */
/*                   Navigator.push(context, MaterialPageRoute(builder: (_) => Adminnotification3(/*lstNotf[index]['content']*/)));
 */
/*               }
            },
            child: NotificationItem(lstNotf[key]['content'], index)); */

  Widget expandedDrawerItem(
      {@required Profile profile, @required String itemName}) {
    return Row(
      children: [
        InkWell(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 40.0,
              vertical: (screenHeight * 1) / 100,
            ),
            child: Text(
              itemName,
              textScaleFactor: 1.0,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          ),
          onTap: () {
            if (itemName == "drawer_label_userscreen".tr()) {
              /*     dispatchGoToEditProfileEvent(profile); */
            }
            if (itemName == "drawer_label_resetpassword".tr()) {
              dispatchGoToResetPassword(profile);
            }
            if (itemName == "drawer_label_mytags".tr()) {
              profile.parameters.location = "drawer_label_mytags".tr();
              dispatchListingTag(profile);
            }

            if (itemName == "drawer_label_switchtag".tr()) {
              profile.parameters.location = "drawer_label_switchtag".tr();
              dispatchSwitchObjectTag(profile);
              print(profile.parameters.location);
            }
            if (itemName == "drawer_label_addtag".tr()) {
              profile.parameters.location = "drawer_label_addtag".tr();
              dispatchGoToAddEditObjectTagEvent(profile);
            }
            if (itemName == 'Customize pet profile') {
              dispatchGoToEditPetsEvent(profile);
            }

            if (itemName == '') {}
          },
        ),
      ],
    );
  }

  Widget expandedDrawer(
      {@required Profile profile,
      @required String itemName,
      @required bool seleceted}) {
    return Container(
      color: seleceted
          ? Colors.grey.withOpacity(0.35)
          : Colors.grey.withOpacity(0.00),
      child: Row(
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: (screenHeight * 1) / 100,
              ),
              child: Text(
                itemName,
                textScaleFactor: 1.0,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'SFProText'),
              ),
            ),
            onTap: () {
              if (itemName == "drawer_label_messages".tr()) {
                profile.parameters.location = "drawer_label_messages".tr();
                dispatchGoToMessages(profile);
              }

              if (itemName == "drawer_label_notifications".tr()) {
                profile.parameters.location = "drawer_label_notifications".tr();
                dispatchGoToNotification(profile);
              }
              if (itemName == "drawer_label_remindersalarms".tr()) {
                dispatchGoToReminder(profile);
              }
              if (itemName == "drawer_label_users".tr()) {
                Navigator.of(context).push(UsersPopup(profile));
              }
              if (itemName == "drawer_label_home".tr()) {
                Navigator.of(context).pushReplacementNamed(
                  '/homeProvider',
                  arguments: profile,
                );
              }
              if (itemName == "drawer_label_logout".tr()) {
                dispatchLogout(profile);
              }
              if (itemName == '') {}
            },
          ),
        ],
      ),
    );
  }

/*     void dispatchGoToEditProfileEvent(Profile profile) {
    BlocProvider.of<HomeBloc>(context).dispatch(
      GoToEditProfileEvent(profile: profile),
    );
  }
 */
  void dispatchGoToEditPetsEvent(Profile profile) {
    BlocProvider.of<HomeBloc>(context).dispatch(
      GoToEditPetsEvent(profile: profile),
    );
  }

  void dispatchGoToAddEditObjectTagEvent(Profile profile) {
    BlocProvider.of<HomeBloc>(context).dispatch(
      GoToAddEditObjectTagEvent(profile: profile),
    );
  }

  void dispatchGoToViewObjectTagEvent(Profile profile) {
    // BlocProvider.of<HomeBloc>(context).dispatch(
    //   GoToViewObjectTagEvent(profile: profile),
    // );
  }

  void dispatchLogout(Profile profile) {
    BlocProvider.of<HomeBloc>(context).dispatch(
      LogoutEvent(
        profile: profile,
      ),
    );
  }

  void dispatchGoToNotification(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/notificationsProvider',
      arguments: profile,
    );
  }

  void dispatchGoToReminder(Profile profile) {
    print("ici");
    Navigator.of(context).pushReplacementNamed(
      '/remindersProvider',
      arguments: profile,
    );
  }

  dispatchSwitchObjectTag(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/tagsProvider',
      arguments: profile,
    );
  }

  dispatchListingTag(profile) {
    Navigator.of(context).pushReplacementNamed(
      '/tagsProvider',
      arguments: profile,
    );
  }

  void dispatchGoToResetPassword(Profile profile) {
    BlocProvider.of<HomeBloc>(context).dispatch(
      GoToResetPasswordEvent(
        profile: profile,
      ),
    );
  }

  void dispatchGoToMessages(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/messagesProvider',
      arguments: profile,
    );
  }
}
