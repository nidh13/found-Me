import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Core/Utils/text.dart';

class UsersPopup extends ModalRoute<void> {
  final Profile profile;

  UsersPopup(this.profile);

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

  List nameList = ['Df', 'Vb'];
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
    return OrientationBuilder(
      builder: (context, orientation) {
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
                            top: 17, bottom: 17, left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              value: "homescree_subtitle_users".tr(),
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.pinkColor,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: screenHeight * 0.5,
                              child: GridView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 12.0,
                                        mainAxisSpacing: 8.0,
                                        childAspectRatio: MediaQuery.of(context)
                                                .size
                                                .width /
                                            (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.35)),
                                itemCount:
                                    profile.userGeneralInfo.subUsers.length + 2,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      if (index == 0)
                                        GestureDetector(
                                          onTap: profile.userGeneralInfo
                                                      .roleLabel ==
                                                  'Administrator'
                                              ? () {
                                                  Navigator.of(context)
                                                      .pushReplacementNamed(
                                                    '/usersProvider',
                                                    arguments: {
                                                      'profile': profile,
                                                      'route': 'GoToAddNewUser',
                                                    },
                                                  );
                                                }
                                              : null,
                                          child: Container(
                                            height: 150,
                                            width: screenWidth * 0.231,
                                            decoration: BoxDecoration(
                                                color: ColorConstant.lightGrey,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                                boxShadow: [
                                                  new BoxShadow(
                                                    color: Colors.black26,
                                                    offset: Offset(1.0, 4.0),
                                                    //  spreadRadius: 7.0,
                                                    blurRadius: 5.0,
                                                  ),
                                                ]),
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  8.0, 30, 8, 5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: <Widget>[
                                                  Image.asset(
                                                      "Assets/Images/add.png",
                                                      color: profile
                                                                  .userGeneralInfo
                                                                  .roleLabel ==
                                                              'Administrator'
                                                          ? ColorConstant
                                                              .pinkColor
                                                          : ColorConstant
                                                              .greyChar,
                                                      height: 38,
                                                      width: 39),
                                                  MyText(
                                                      value:
                                                          "objecttag_btn_addnew"
                                                              .tr(),
                                                      fontSize: 10,
                                                      color: profile
                                                                  .userGeneralInfo
                                                                  .roleLabel ==
                                                              'Administrator'
                                                          ? ColorConstant
                                                              .pinkColor
                                                          : ColorConstant
                                                              .greyChar,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (index == 1)
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              profile.parameters.location =
                                                  'profile';
                                              Navigator.of(context)
                                                  .pushReplacementNamed(
                                                '/profileProvider',
                                                arguments: profile,
                                              );
                                            },
                                            child: Container(
                                              width: screenWidth * 0.25,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  color:
                                                      //  profile.userGeneralInfo
                                                      //         .linkedMedicalRecord
                                                      //         .contains(
                                                      //   profile
                                                      //       .userGeneralInfo
                                                      //       .subUsers[index - 1]
                                                      //       .userGeneralInfo
                                                      //       .idMember,
                                                      // )
                                                      //     ? ColorConstant.redColor
                                                      //     :
                                                      ColorConstant.lightGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  boxShadow: [
                                                    new BoxShadow(
                                                      color: Colors.black26,
                                                      offset: Offset(1.0, 4.0),
                                                      //  spreadRadius: 7.0,
                                                      blurRadius: 5.0,
                                                    ),
                                                  ]),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height:
                                                          (screenWidth * 19.2) /
                                                              100,
                                                      width:
                                                          (screenWidth * 19.2) /
                                                              100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 3.0),
                                                          boxShadow: [
                                                            new BoxShadow(
                                                              color:
                                                                  Colors.black,
                                                              blurRadius: 2.0,
                                                              spreadRadius:
                                                                  0.01,
                                                            ),
                                                          ],
                                                          image: DecorationImage(
                                                              image: NetworkImage(profile
                                                                  .userGeneralInfo
                                                                  .profilePictureUrl),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  ),
                                                  Flexible(
                                                      child: viewFisrtNameLastNameMember(
                                                          profile
                                                              .userGeneralInfo
                                                              .firstName,
                                                          profile
                                                              .userGeneralInfo
                                                              .lastName)),
                                                  SizedBox(
                                                    height: 4,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      if (index != 0 && index != 1)
                                        Expanded(
                                          child: InkWell(
                                            onTap: profile.userGeneralInfo
                                                        .roleLabel ==
                                                    'Administrator'
                                                ? () {
                                                    Navigator.of(context)
                                                        .pushReplacementNamed(
                                                      '/usersProvider',
                                                      arguments: {
                                                        'profile': profile,
                                                        'route':
                                                            'GoToEditSubUser',
                                                        'index': index - 2
                                                      },
                                                    );
                                                  }
                                                : null,
                                            child: Container(
                                              width: screenWidth * 0.25,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  color:
                                                      //  profile.userGeneralInfo
                                                      //         .linkedMedicalRecord
                                                      //         .contains(
                                                      //   profile
                                                      //       .userGeneralInfo
                                                      //       .subUsers[index - 1]
                                                      //       .userGeneralInfo
                                                      //       .idMember,
                                                      // )
                                                      //     ? ColorConstant.redColor
                                                      //     :
                                                      ColorConstant.lightGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  boxShadow: [
                                                    new BoxShadow(
                                                      color: Colors.black26,
                                                      offset: Offset(1.0, 4.0),
                                                      //  spreadRadius: 7.0,
                                                      blurRadius: 5.0,
                                                    ),
                                                  ]),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      height:
                                                          (screenWidth * 19.2) /
                                                              100,
                                                      width:
                                                          (screenWidth * 19.2) /
                                                              100,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white,
                                                              width: 3.0),
                                                          boxShadow: [
                                                            new BoxShadow(
                                                              color:
                                                                  Colors.black,
                                                              blurRadius: 2.0,
                                                              spreadRadius:
                                                                  0.01,
                                                            ),
                                                          ],
                                                          image: DecorationImage(
                                                              image: NetworkImage(profile
                                                                  .userGeneralInfo
                                                                  .subUsers[
                                                                      index - 2]
                                                                  .userGeneralInfo
                                                                  .profilePictureUrl),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  ),
                                                  Flexible(
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 4,
                                                                  right: 4.0),
                                                          child: viewFisrtNameLastNameMember(
                                                              profile
                                                                  .userGeneralInfo
                                                                  .subUsers[
                                                                      index - 2]
                                                                  .userGeneralInfo
                                                                  .firstName,
                                                              profile
                                                                  .userGeneralInfo
                                                                  .subUsers[
                                                                      index - 2]
                                                                  .userGeneralInfo
                                                                  .lastName))),
                                                  SizedBox(
                                                    height: 4,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
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
            )));
      },
    );
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

  viewFisrtNameLastNameMember(String first, String last) {
    if (first != null && last == null) {
      return MyText(
        value: first,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: ColorConstant.pinkColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.center,
      );
    }
    if (first == null && last != null) {
      return MyText(
        value: last,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: ColorConstant.pinkColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.center,
      );
    }
    if (first == null && last == null) {
      return MyText(
        value: ' ',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: ColorConstant.pinkColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.center,
      );
    }
    if (first != null && last != null) {
      return MyText(
        value: first + ' ' + last,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        color: ColorConstant.pinkColor,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.center,
      );
    }
  }
}
