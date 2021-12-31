import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class Scan4Dialog extends ModalRoute<void> {
  final Profile profile;

  Scan4Dialog(this.profile);

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

  var nameData;

  final ScrollController nameScroll = ScrollController();
  List<String> name = ["g", "f", "h", "e", "t"];
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
        child: _buildOverlayContent(context, profile),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context, Profile profile) {
    return OrientationBuilder(builder: (context, orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.all(20.0),
          width: screenWidth * 0.85,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: ColorConstant.pinkColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10.0),
                    )),
                height: 51,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 12, left: 13, right: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: MyText(
                            value: "editprofil_label_link".tr(),
                            fontWeight: FontWeight.w600,
                            fontSize: 21,
                            color: Colors.white),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          height: 16,
                          width: 16,
                          child: Image.asset(
                            "Assets/Images/close-white.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 17, bottom: 17, left: 16, right: 16),
                child: Column(
                  children: [
                    MyText(
                        value: "editprofil_label_scan_msg".tr(),
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ColorConstant.textColor),
                    SizedBox(
                      height: 18,
                    ),
                    Divider(
                      height: 0,
                      color: ColorConstant.dividerColor,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 24,
                      width: 130,
                      child: MyText(
                        value: profile.userGeneralInfo.firstName ??
                            '' + ' ' + profile.userGeneralInfo.lastName ??
                            '',
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      decoration: BoxDecoration(
                        color: ColorConstant.textfieldColor,
                        borderRadius: BorderRadius.circular(5.0),
                        // border: Border.all(style: BorderStyle.solid, width: 0.70),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      height: 0,
                      color: ColorConstant.dividerColor,
                    ),
                    SizedBox(
                      height: 20.5,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: MyText(
                              value: "editprofil_label_linktother".tr(),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: ColorConstant.textColor),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          "Assets/Images/info.png",
                          height: 14,
                          width: 14,
                        ),
                      ],
                    ),
                    profile.userGeneralInfo.subUsers.length == 0
                        ? SizedBox(
                            height: 0,
                          )
                        : SizedBox(
                            height: 30,
                          ),
                    Container(
                        height: name.length > 4 ? 152 : name.length * 38.0,
                        child: Scrollbar(
                            controller: nameScroll,
                            child: profile.userGeneralInfo.subUsers.length == 0
                                ? MyText(
                                    value:
                                        'editprofil_label_linktothermsg'.tr(),
                                  )
                                : ListView.separated(
                                    controller: nameScroll,
                                    separatorBuilder: (BuildContext context,
                                            int index) =>
                                        Divider(
                                            height: 0,
                                            color: ColorConstant.dividerColor
                                                .withOpacity(.30)),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount:
                                        profile.userGeneralInfo.subUsers.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                            top: 4.5,
                                            bottom: 4.5,
                                            left: 5,
                                            right: 5),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 29.0,
                                              height: 29.0,
                                              decoration: new BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    offset: Offset(0,
                                                        0), // changes position of shadow
                                                  ),
                                                ],
                                                color: const Color(0xff7c94b6),
                                                image: new DecorationImage(
                                                  image: new NetworkImage(
                                                    profile
                                                        .userGeneralInfo
                                                        .subUsers[index]
                                                        .userGeneralInfo
                                                        .profilePictureUrl,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: new BorderRadius
                                                        .all(
                                                    new Radius.circular(50.0)),
                                                border: new Border.all(
                                                  color: Colors.white,
                                                  width: 3.0,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 12,
                                            ),
                                            Expanded(
                                              child: MyText(
                                                  value: profile
                                                          .userGeneralInfo
                                                          .subUsers[index]
                                                          .userGeneralInfo
                                                          .firstName ??
                                                      '' +
                                                          ' ' +
                                                          profile
                                                              .userGeneralInfo
                                                              .subUsers[index]
                                                              .userGeneralInfo
                                                              .lastName ??
                                                      '',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                      ColorConstant.textColor),
                                            ),
                                            CustomSwitch(
                                              activeColor: Color(0xff34C759),
                                              value: profile.userGeneralInfo
                                                  .linkedMedicalRecord
                                                  .contains(
                                                profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .userGeneralInfo
                                                    .idMember,
                                              ),
                                              onChanged: (value) {
                                                setState(() {
                                                  profile.userGeneralInfo
                                                          .linkedMedicalRecord
                                                          .contains(
                                                    profile
                                                        .userGeneralInfo
                                                        .subUsers[index]
                                                        .userGeneralInfo
                                                        .idMember,
                                                  )
                                                      ? profile.userGeneralInfo
                                                          .linkedMedicalRecord
                                                          .remove(
                                                          profile
                                                              .userGeneralInfo
                                                              .subUsers[index]
                                                              .userGeneralInfo
                                                              .idMember,
                                                        )
                                                      : profile.userGeneralInfo
                                                          .linkedMedicalRecord
                                                          .add(
                                                          profile
                                                              .userGeneralInfo
                                                              .subUsers[index]
                                                              .userGeneralInfo
                                                              .idMember
                                                              .toString(),
                                                        );
                                                });
                                              },
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ))),
                    profile.userGeneralInfo.subUsers.length == 0
                        ? SizedBox(
                            height: 0,
                          )
                        : SizedBox(
                            height: 30.5,
                          ),
                    profile.userGeneralInfo.subUsers.length == 0
                        ? MyButton(
                            title: "pets_label_save".tr(),
                            height: 40,
                            titleSize: 14,
                            fontWeight: FontWeight.w500,
                            titleColor: Colors.white,
                            btnBgColor: ColorConstant.darkGray,
                            onPressed: null,
                          )
                        : MyButton(
                            title: "pets_label_save".tr(),
                            height: 40,
                            titleSize: 14,
                            fontWeight: FontWeight.w500,
                            titleColor: Colors.white,
                            btnBgColor: ColorConstant.pinkColor,
                            onPressed: () => Navigator.pop(context),
                          ),
                    SizedBox(
                      height: 18,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: MyText(
                          value: "editprofil_label_linktothermsg".tr() + ",",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorConstant.textColor),
                    ),
                    Row(
                      children: [
                        MyText(
                            value: "editprofil_label_please".tr() + " ",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.textColor),
                        GestureDetector(
                          onTap: profile.userGeneralInfo.roleLabel ==
                                  'Administrator'
                              ? () {
                                  Navigator.of(context).pushReplacementNamed(
                                    '/usersProvider',
                                    arguments: {
                                      'profile': profile,
                                      'route': 'GoToAddNewUser',
                                    },
                                  );
                                }
                              : null,
                          child: Text("editprofil_label_clickhere".tr(),
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'SFProText',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: profile.userGeneralInfo.roleLabel ==
                                          'Administrator'
                                      ? ColorConstant.textColor
                                      : ColorConstant.greyChar)),
                        ),
                      ],
                    )
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
