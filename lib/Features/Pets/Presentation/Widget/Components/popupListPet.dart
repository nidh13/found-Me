import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ChoosePet extends ModalRoute<void> {
  final Profile profile;

  ChoosePet(this.profile);

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

  final ScrollController nameScroll = ScrollController();
  List<String> name = ["g", "f", "h", "e", "t"];
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      key: GlobalKey(),
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context, profile),
      ),
    );
  }

  bool _hasBeenPressed = false;

  bool colors = false;
  int indexPet;
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
                child: Center(
                  child: MyText(
                    value: "pets_label_petprofile".tr(),
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 17, bottom: 17, left: 16, right: 16),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.5,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: MyText(
                            value: "pets_label_choosetag".tr(),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: ColorConstant.textColor,
                          ),
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
                    SizedBox(
                      height: 30,
                    ),
                    StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Container(
                        height: name.length > 4 ? 152 : name.length * 38.0,
                        child: Scrollbar(
                          controller: nameScroll,
                          child: Center(
                            child: ListView.separated(
                              controller: nameScroll,
                              separatorBuilder:
                                  (BuildContext context, int index) => Divider(
                                      height: 2,
                                      color: ColorConstant.dividerColor
                                          .withOpacity(.30)),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount:
                                  profile.userGeneralInfo.petsInfos.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  color: indexPet == index
                                      ? ColorConstant.pinkColor
                                      : Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: InkWell(
                                      key: Key(profile.userGeneralInfo
                                          .petsInfos[index].generalInfo.name),
                                      onTap: () {
                                        setState(() {
                                          indexPet = index;
                                        });
                                      },
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
                                                  offset: Offset(0, 0),
                                                ),
                                              ],
                                              color: const Color(0xff7c94b6),
                                              image: new DecorationImage(
                                                image: new NetworkImage(
                                                  profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .generalInfo
                                                      .picturePet,
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
                                                      .petsInfos[index]
                                                      .generalInfo
                                                      .name ??
                                                  '',
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: indexPet == index
                                                  ? Colors.white
                                                  : ColorConstant.textColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: 30.5,
                    ),
                    MyButton(
                      title: "pets_label_continue".tr(),
                      height: 40,
                      titleSize: 14,
                      fontWeight: FontWeight.w500,
                      titleColor: Colors.white,
                      btnBgColor: ColorConstant.greenColor,
                      onPressed: () {
                        profile.userGeneralInfo.petsInfos[indexPet].petTag.add(
                            profile.userGeneralInfo.petsInfos[0].petTag.last);

                        profile.userGeneralInfo.message = null;
                        profile.userGeneralInfo.petsInfos[0].petTag
                            .removeLast();
                       
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.of(context).pushReplacementNamed(
                            '/petsProvider',
                            arguments: {
                              'profile': profile,
                              'index': indexPet,
                              'route': 'GoToAddEditPetProfile'
                            },
                          );
                        });
                      },
                    ),
                    SizedBox(
                      height: 18,
                    ),
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
