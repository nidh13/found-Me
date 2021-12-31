import 'package:flutter/material.dart';
import 'package:neopolis/Features/Help/Presentation/Widgets/Components/expandable_help_list.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mailto/mailto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Home/Presentation/bloc/home_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class HelpDisplay extends StatefulWidget {
  final Profile profile;

  const HelpDisplay({Key key, @required this.profile}) : super(key: key);

  @override
  _HelpDisplayState createState() => _HelpDisplayState();
}

class _HelpDisplayState extends State<HelpDisplay> {
  var screenWidth, screenHeight;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  //Search bar
  FocusNode _searchFocus = FocusNode();
  TextEditingController searchController = new TextEditingController();

  bool popularTopics = false;
  bool faq = false;
  bool itWork = false;
  String textsearch;
  bool feedback = false;
  bool compliance = false;
  List<Color> _colors = [
    Color(0xffEC1C40),
    Color(0XFFED273C),
    Color(0xffEE3638),
    Color(0xffF47025)
  ];
  List<double> _stops = [0.1, 0.4, 0.6, 0.9];
  List<bool> popularTopicss = new List();
  Future<Map> lstHelpers;

  List<String> categoriesList = [];

  @override
  void initState() {
    super.initState();
    widget.profile.parameters.faq.forEach((key, value) {
      categoriesList.add(key);
    });
  }

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;

    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    var children2 = <Widget>[
      _appbarView(profile),
      SizedBox(
        height: 40,
      ),
      _listView(profile),
      _contactUs(),
      SizedBox(
        height: 30,
      ),
    ];
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: ColorConstant.boxColor,
        // drawer: Container(
        //   margin: EdgeInsets.only(top: screenHeight * 0.05),
        //   child: Drawer(
        //     child: Container(
        //       color: ColorConstant.drawerBgColor,
        //       child: ListView(
        //         padding: EdgeInsets.zero,
        //         children: <Widget>[
        //           Container(
        //             alignment: Alignment.topRight,
        //             padding: EdgeInsets.only(
        //                 right: 5.0,
        //                 top: (screenHeight * 4.434) / 90,
        //                 bottom: (screenHeight * 6.035) / 100),
        //           ),
        //           InkWell(
        //             onTap: () {
        //               ////////      on pressed Notification ///////
        //             },
        //             child: Container(
        //               padding: EdgeInsets.only(
        //                   right: 0,
        //                   top: (screenHeight * 1.51) / 100,
        //                   bottom: (screenHeight * 1.51) / 100),
        //               child: expandedDrawer(
        //                   profile: profile,
        //                   itemName: "drawer_label_home".tr(),
        //                   seleceted: false),
        //             ),
        //           ),
        //           InkWell(
        //             onTap: () {
        //               ////////      on pressed Notification ///////
        //             },
        //             child: Container(
        //               padding:
        //                   EdgeInsets.only(bottom: (screenHeight * 1.51) / 100),
        //               child: expandedDrawer(
        //                   profile: profile,
        //                   itemName: "drawer_label_messages".tr(),
        //                   seleceted: false),
        //             ),
        //           ),
        //           Theme(
        //             data: ThemeData(
        //               unselectedWidgetColor: Colors.white,
        //               accentColor: Colors.white,
        //             ),
        //             child: ExpansionTile(
        //               title: Text(
        //                 "drawer_label_myaccount".tr(),
        //                 textScaleFactor: 1.0,
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 18,
        //                     fontWeight: FontWeight.w400),
        //               ),
        //               children: <Widget>[
        //                 expandedDrawerItem(
        //                   profile: profile,
        //                   itemName: "drawer_label_userscreen".tr(),
        //                 ),
        //                 expandedDrawerItem(
        //                   profile: profile,
        //                   itemName: "drawer_label_resetpassword".tr(),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           Theme(
        //             data: ThemeData(
        //               unselectedWidgetColor: Colors.white,
        //               accentColor: Colors.white,
        //             ),
        //             child: ExpansionTile(
        //               title: Text(
        //                 "drawer_label_tags".tr(),
        //                 textScaleFactor: 1.0,
        //                 style: TextStyle(
        //                     color: Colors.white,
        //                     fontSize: 18,
        //                     fontWeight: FontWeight.w400),
        //               ),
        //               children: <Widget>[
        //                 expandedDrawerItem(
        //                   profile: profile,
        //                   itemName: "drawer_label_mytags".tr(),
        //                 ),
        //                 expandedDrawerItem(
        //                   profile: profile,
        //                   itemName: "drawer_label_testtag".tr(),
        //                 ),
        //                 expandedDrawerItem(
        //                   profile: profile,
        //                   itemName: "drawer_label_switchtag".tr(),
        //                 ),
        //                 expandedDrawerItem(
        //                   profile: profile,
        //                   itemName: "drawer_label_addtag".tr(),
        //                 ),
        //               ],
        //             ),
        //           ),
        //           // ExpansionTile(
        //           //   title: Text(
        //           //     "Pet tags (Will be removed lately)",
        //           //     style: TextStyle(
        //           //       color: Colors.white,
        //           //       fontSize: 18,
        //           //       fontWeight: FontWeight.w400,
        //           //     ),
        //           //   ),
        //           //   children: <Widget>[
        //           //     expandedDrawerItem(
        //           //         profile: profile,
        //           //         itemName: "Customize pet profile"),
        //           //     expandedDrawerItem(
        //           //         profile: profile, itemName: "View pet profile"),
        //           //   ],
        //           // ),
        //           InkWell(
        //             onTap: () {
        //               ////////      on pressed Notification ///////
        //             },
        //             child: Container(
        //               padding:
        //                   EdgeInsets.only(bottom: (screenHeight * 1.51) / 100),
        //               child: expandedDrawer(
        //                   profile: profile,
        //                   itemName: "drawer_label_users".tr(),
        //                   seleceted: false),
        //             ),
        //           ),
        //           InkWell(
        //             onTap: () {
        //               ////////      on pressed Notification ///////
        //             },
        //             child: Container(
        //               padding:
        //                   EdgeInsets.only(bottom: (screenHeight * 1.51) / 100),
        //               child: expandedDrawer(
        //                   profile: profile,
        //                   itemName: "drawer_label_remindersalarms".tr(),
        //                   seleceted: false),
        //             ),
        //           ),
        //           InkWell(
        //             onTap: () {
        //               ////////      on pressed Notification ///////
        //             },
        //             child: Container(
        //               padding:
        //                   EdgeInsets.only(bottom: (screenHeight * 1.51) / 100),
        //               child: expandedDrawer(
        //                   profile: profile,
        //                   itemName: "drawer_label_notifications".tr(),
        //                   seleceted: false),
        //             ),
        //           ),
        //           InkWell(
        //             onTap: () {
        //               ////////      on pressed Notification ///////
        //             },
        //             child: Container(
        //               padding:
        //                   EdgeInsets.only(bottom: (screenHeight * 1.51) / 100),
        //               child: expandedDrawer(
        //                   profile: profile,
        //                   itemName: "drawer_label_mylockscreen".tr(),
        //                   seleceted: false),
        //             ),
        //           ),
        //           InkWell(
        //             onTap: () {
        //               ////////      on pressed Notification ///////
        //             },
        //             child: Container(
        //               padding:
        //                   EdgeInsets.only(bottom: (screenHeight * 1.51) / 100),
        //               child: expandedDrawer(
        //                   profile: profile,
        //                   itemName: "drawer_label_socialmedia".tr(),
        //                   seleceted: false),
        //             ),
        //           ),
        //           InkWell(
        //             onTap: () {
        //               ////////      on pressed Notification ///////
        //             },
        //             child: Container(
        //               padding:
        //                   EdgeInsets.only(bottom: (screenHeight * 1.51) / 100),
        //               child: expandedDrawer(
        //                   profile: profile,
        //                   itemName: "drawer_label_referrals".tr(),
        //                   seleceted: false),
        //             ),
        //           ),
        //           InkWell(
        //             onTap: () {
        //               ////////      on pressed Notification ///////
        //             },
        //             child: Container(
        //               padding:
        //                   EdgeInsets.only(bottom: (screenHeight * 1.51) / 100),
        //               child: expandedDrawer(
        //                   profile: profile,
        //                   itemName: "drawer_label_contacthelp".tr(),
        //                   seleceted: true),
        //             ),
        //           ),
        //           Padding(
        //             padding: EdgeInsets.only(bottom: 20.0),
        //             child: InkWell(
        //               onTap: () {
        //                 /*      dispatchLogout(profile); */
        //               },
        //               child: expandedDrawer(
        //                   profile: profile,
        //                   itemName: "drawer_label_logout".tr(),
        //                   seleceted: false),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: children2,
          ),
        ));
  }

  _appbarView(Profile profile) {
    return Container(
      height: 128,
    color: ColorConstant.pinkColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(''),
            // GestureDetector(
            //   onTap: () => scaffoldKey.currentState.openDrawer(),
            //   child: Container(
            //     width: 40,
            //     child: Image.asset(
            //       "Assets/Images/menu.png",
            //       height: 16,
            //       width: 16,
            //     ),
            //   ),
            // ),
            Text(
              "drawer_label_help".tr(),
              textScaleFactor: 1.0,
              style: TextStyle(
                  fontFamily: 'SFProText',
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.white),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 30,
                child: Image.asset(
                  "Assets/Images/close-white.png",
                  height: 16,
                  width: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _listView(Profile profile) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0, right: 24),
      child: Column(
        children: [
          Container(
            height: 42,
            decoration: BoxDecoration(
              color: ColorConstant.greyTextColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextFormField(
              controller: searchController,
              focusNode: _searchFocus,
              cursorColor: ColorConstant.pinkColor,
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: ColorConstant.boxColor,
                ),
                hintText: "listingtags_filter_title".tr(),
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: ColorConstant.boxColor,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SFProText',
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                contentPadding: EdgeInsets.fromLTRB(10.0, 12.0, 10.0, 12.0),
              ),
              keyboardType: TextInputType.text,
              style: TextStyle(
                color: Colors.white,
              ),
              onChanged: (value) {},
            ),
          ),
          SizedBox(
            height: 38,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: profile.parameters.faq.length,
              itemBuilder: (BuildContext context, int index) {
                return categories(profile, categoriesList[index]);
              }),
          SizedBox(
            height: 38,
          ),
        ],
      ),
    );
  }

  categories(Profile profile, String categorieName) {
    String categorieKey;
    List<dynamic> categorieValue;
    profile.parameters.faq.forEach((key, value) {
      if (key == categorieName) {
        categorieKey = key;
        categorieValue = value;
      }
    });

    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            setState(() {
              faq = !faq;
            });
          },
          child: Container(
            height: faq ? 40 : 72,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              border: Border.all(width: 0, color: Colors.white),
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(faq ? 0 : 8),
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(faq ? 0 : 8),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 16, right: 23.2),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment:
                          faq ? Alignment.bottomLeft : Alignment.centerLeft,
                      child: Text(
                        categorieKey,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontFamily: 'SFProText',
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: ColorConstant.textColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        faq
            ? Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1.0, 3.0),
                        //  spreadRadius: 7.0,
                        blurRadius: 3.0,
                      ),
                    ],
                    border: Border.all(width: 0, color: Colors.white),
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8))),
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                    height: 0.45,
                    color: ColorConstant.dividerColor.withOpacity(.30),
                  ),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: categorieValue.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new ExpandableHelpList(
                      value: categorieValue[index],
                    );
                  },
                ),
              )
            : Container(),
        SizedBox(
          height: 16,
        )
      ],
    );
  }

  _contactUs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28),
      child: InkWell(
        onTap: () {
          setState(() {});
        },
        child: Container(
          height: 96,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 0), // changes position of shadow
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              )),
          child: Padding(
            padding: EdgeInsets.only(left: 18, top: 13, right: 25.8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "faq_label_questionsNA".tr(),
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontFamily: 'SFProText',
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: ColorConstant.textColor),
                ),
                SizedBox(
                  height: 19,
                ),
                GestureDetector(
                  child: Row(
                    children: [
                      Image.asset(
                        "Assets/Images/email-red-border.png",
                        height: 20,
                        width: 26,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "faq_label_contact".tr(),
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontFamily: 'SFProText',
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: ColorConstant.textColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                  onTap: () async {
                    final mailtoLink = Mailto(
                      to: ['foundme@gmail.com'],
                      subject: 'FAQ - New question',
                      body: '',
                    );
                    await launch('$mailtoLink');
                  },
                ),
                SizedBox(
                  height: 16,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void dispatchGoToHome(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/homeProvider',
      arguments: profile,
    );
  }

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
              dispatchGoToUserscreen(profile);
            }
            if (itemName == "drawer_label_resetpassword".tr()) {
              profile.parameters.location = "drawer_label_resetpassword".tr();

              dispatchGoToHome(profile);
            }
            if (itemName == "drawer_label_mytags".tr()) {
              profile.parameters.location = "drawer_label_mytags".tr();
              Navigator.of(context).pushReplacementNamed(
                '/tagsProvider',
                arguments: profile,
              );
              // dispatchListingTag(profile);
            }

            if (itemName == "drawer_label_switchtag") {
              profile.parameters.location = "drawer_label_switchtag";
              Navigator.of(context).pushReplacementNamed(
                '/tagsProvider',
                arguments: profile,
              );
            }
            if (itemName == "drawer_label_addtag".tr()) {
              profile.parameters.location = "drawer_label_addtag".tr();
              Navigator.of(context).pushReplacementNamed(
                '/tagsProvider',
                arguments: profile,
              );
              //   dispatchGoToAddEditObjectTagEvent(profile);
            }
            if (itemName == 'Customize pet profile') {
              //   dispatchGoToEditPetsEvent(profile);
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

  void dispatchGoToEditProfileEvent(Profile profile) {
    BlocProvider.of<HomeBloc>(context).dispatch(
      GoToEditProfileEvent(profile: profile),
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

  void dispatchGoToUserscreen(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/profileProvider',
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
