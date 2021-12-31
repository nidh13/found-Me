import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Home/Presentation/Widgets/HomeComponents/home_screen.dart';
import 'package:neopolis/Features/Home/Presentation/bloc/home_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:neopolis/Features/Home/Presentation/Widgets/HomeComponents/usersPopup.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Core/Theme/ColorTheme.dart';
import 'package:neopolis/Core/Utils/text.dart';

class HomeDisplay extends StatefulWidget {
  final Profile profile;

  const HomeDisplay({Key key, @required this.profile}) : super(key: key);

  @override
  _HomeDisplayState createState() => _HomeDisplayState();
}

class _HomeDisplayState extends State<HomeDisplay> {
  var screenWidth, screenHeight;

  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;
    bool selecthome = true;

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
          appBar: AppBar(
            backgroundColor: ColorConstant.pinkColor,
            elevation: 0.0,
            centerTitle: true,
            leading: IconButton(
                icon: SvgPicture.asset(
                  'Assets/Images/Hamburger.svg',
                ),
                onPressed: () => scaffoldKey.currentState.openDrawer()),
            title: SvgPicture.asset(
              'Assets/Images/homeLog.svg',
            ),
            actions: <Widget>[
              IconButton(
                icon: SvgPicture.asset(
                  "Assets/Images/FAQ.svg",
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HelpDisplay(profile: profile)),
                  );
                },
              )
            ],
          ),
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
                            seleceted: selecthome),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        ////////      on pressed Notification ///////
                      },
                      child: Container(
                        // padding: EdgeInsets.only(
                        //     bottom: (screenHeight * 1.51) / 100),
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
                        title: MyText(
                            value: "drawer_label_myaccount".tr(),
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        children: <Widget>[
                          expandedDrawerItem(
                              profile: profile,
                              itemName: "drawer_label_userscreen".tr()),
                          expandedDrawerItem(
                              profile: profile,
                              itemName: "drawer_label_resetpassword".tr()),
                        ],
                      ),
                    ),
                    Theme(
                      data: ThemeData(
                        unselectedWidgetColor: Colors.white,
                        accentColor: Colors.white,
                      ),
                      child: ExpansionTile(
                        title: MyText(
                            value: "drawer_label_tags".tr(),
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                        children: <Widget>[
                          expandedDrawerItem(
                              profile: profile,
                              itemName: "drawer_label_mytags".tr()),
                          expandedDrawerItem(
                              profile: profile,
                              itemName: "drawer_label_testtag".tr()),
                          expandedDrawerItem(
                              profile: profile,
                              itemName: "drawer_label_switchtag".tr()),
                          expandedDrawerItem(
                              profile: profile,
                              itemName: "drawer_label_addtag".tr()),
                        ],
                      ),
                    ),
                    // ExpansionTile(
                    //   title:   MyText(
                    //      value:
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
                    InkWell(
                      onTap: () {
                        ////////      on pressed Notification ///////
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            bottom: (screenHeight * 1.51) / 100),
                        child: expandedDrawer(
                            profile: profile,
                            itemName: 'colortheme_label_title'.tr(),
                            seleceted: false),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20.0),
                      child: InkWell(
                        onTap: () {
                          dispatchLogout(profile);
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
          body: HomeScreen(
            profile: profile,
          ),
        );
      },
    );
  }

  Widget expandedDrawerItem(
      {@required Profile profile, @required String itemName}) {
    return Container(
      child: Row(
        children: [
          InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: (screenHeight * 1) / 100,
              ),
              child: MyText(
                  value: itemName,
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
            onTap: () {
              if (itemName == "drawer_label_userscreen".tr()) {
                profile.parameters.location = "drawer_label_userscreen".tr();
                dispatchGoToEditProfileEvent(profile);
              }
              if (itemName == "drawer_label_resetpassword".tr()) {
                dispatchGoToResetPassword(profile);
              }
              if (itemName == "drawer_label_mytags".tr()) {
                profile.parameters.location = "drawer_label_mytags".tr();
                profile.parameters.viewTag = '';
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

              if (itemName == "drawer_label_testtag".tr()) {
                profile.parameters.location = "drawer_label_testtag".tr();
                dispatchGoToAddEditObjectTagEvent(profile);
              }
            },
          ),
        ],
      ),
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
              child: MyText(
                value: itemName,
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w400,
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
              if (itemName == 'drawer_label_logout'.tr()) {
                dispatchLogout(profile);
              }
              if (itemName == 'colortheme_label_title'.tr()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ThemeColorDisplay(profile: profile)),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  void dispatchGoToEditProfileEvent(Profile profile) {
    profile.parameters.location = 'profile';
    Navigator.of(context).pushReplacementNamed(
      '/profileProvider',
      arguments: profile,
    );
  }

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

  void dispatchGoToHelp(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/helpProvider',
      arguments: profile,
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
      arguments: {
        'profile': profile,
      },
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

  dispatchTestTag(profile) {
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
