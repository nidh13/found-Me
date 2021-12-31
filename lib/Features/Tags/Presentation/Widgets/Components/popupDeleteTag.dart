import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';

class TutorialOverlay extends ModalRoute<void> {
  final Profile profile;
  final int indexu;

  final int index;
  String type;
  BuildContext context;
  TutorialOverlay(
      this.profile, this.indexu, this.index, this.type, this.context);

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
    // String nameTag =
    //     profile.userGeneralInfo.userTags.objectTag[0].tagInfo.tagDescription;
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
                margin: EdgeInsets.all(30.0),
                width: screenWidth * 0.85,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.85,
                      decoration: BoxDecoration(
                          color: Color(0xffEC1C40),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      height: 49,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 39,
                      ),
                      child: MyText(
                        value: "objecttag_btn_becareful".tr(),
                        fontSize: 21,
                        fontWeight: FontWeight.w600,
                        color: Color(0xffEC1C40),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03),
                        margin: EdgeInsets.only(top: 49, bottom: 75.0),
                        child: MyText(
                          value: "notification_canceltag_content".tr(),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          textAlign: TextAlign.center,
                        )),
                    Container(
                        height: (screenHeight * 6.4) / 100,
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            color: Color(0xffEC1C40),
                            child: Container(
                              width: screenWidth * 1.0,
                              alignment: Alignment.center,
                              child: MyText(
                                  value:
                                      "notification_canceltag_btn_confirm".tr(),
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            onPressed: () {
                              if (type == 'object') {
                                profile
                                    .userGeneralInfo
                                    .tagsList
                                    .objectTag[indexu]
                                    .tags[index]
                                    .tagInfo
                                    .archive = 1;
                                profile
                                    .userGeneralInfo
                                    .tagsList
                                    .objectTag[indexu]
                                    .tags[index]
                                    .tagInfo
                                    .active = 0;
                              } else if (type == 'medical') {
                                profile
                                    .userGeneralInfo
                                    .tagsList
                                    .medicalTag[indexu]
                                    .tags[index]
                                    .tagInfo
                                    .archive = 1;
                                profile
                                    .userGeneralInfo
                                    .tagsList
                                    .medicalTag[indexu]
                                    .tags[index]
                                    .tagInfo
                                    .active = 0;
                              }

                              // print(profile.userGeneralInfo.userTags
                              //     .objectTag[index].tagInfo.active);
                              // profile.userGeneralInfo.userTags.objectTag[index]
                              //     .tagInfo.active = 0;
                              // print(profile.userGeneralInfo.userTags
                              //     .objectTag[index].tagInfo.active);
                              // profile.userGeneralInfo.userTags.objectTag[index]
                              //     .tagInfo.archive = 1;
                              profile.parameters.location = 'DeleteTag';
                              profile.parameters.typecheck = type;
                              profile.parameters.indext = index;
                              profile.parameters.indexu = indexu;
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                Navigator.of(context).pushReplacementNamed(
                                  '/tagsProvider',
                                  arguments: profile,
                                );
                              });
                            }

                            //    dispatchAddEditObjectTag(contextt, profile, index);
                            /*  Navigator.pop(context) */

                            )),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05,
                            vertical: (screenHeight * 1.85) / 100),
                        alignment: Alignment.center,
                        child: MyText(
                            value: "notification_canceltag_btn_cancel".tr(),
                            color: Color(0xff999999),
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: screenWidth * 0.37,
                child: Container(
                  height: 105,
                  width: 105,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1.0, 3.0),
                        //  spreadRadius: 7.0,
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset('Assets/Images/beCareful.svg'),
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

  dispatchAddEditObjectTag(BuildContext context, Profile profile, int index) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      AddEditObjectTagEvent(
        profile: profile,
        index: index,
      ),
    );
  }
}
