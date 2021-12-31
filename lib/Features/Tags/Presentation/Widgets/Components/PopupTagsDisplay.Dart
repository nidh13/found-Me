import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class PopUpTagsDisplay extends ModalRoute<void> {
  final Tags tags;
  final String picture;
  final String type;

  PopUpTagsDisplay(this.tags, this.picture, this.type);

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
  bool attachement;
  final ScrollController nameScroll = ScrollController();
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
        child: _buildOverlayContent(context, picture),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context, String picture) {
    tags.otherInfo.forEach((element) {
      if (element.documents.length > 0) {
        attachement = true;
      } else {
        attachement = false;
      }
      if (element.documents == null) {
        attachement = false;
      }
    });
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
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 0, bottom: 0, left: 0, right: 0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: (screenWidth * 110.34) / 100,
                          height: (screenWidth * 110.34) / 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(picture
                                  /*      profile.userGeneralInfo.userTags
                                              .medicalTag[index].tagInfo.pictureUrl */

                                  ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 8,
                                bottom: 1,
                                left: screenWidth * 0.78,
                                right: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
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
                      ],
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Row(
                      children: [
                        Visibility(
                          visible: false,
                          child: Expanded(
                            child: ButtonTheme(
                                height: 36.0,
                                minWidth: 133.5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: RaisedButton(
                                    disabledColor: Colors.grey,
                                    disabledTextColor: Colors.white,
                                    color: Colors.white,
                                    textColor: ColorConstant.blueColor,
                                    child: MyText(
                                      value:
                                          'editprofil_general_btn_addnew'.tr(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    onPressed: () {})),
                          ),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        tags.tagInfo.emergency == 1
                            ? Expanded(
                                child: ButtonTheme(
                                    height: 47.0,
                                    minWidth: 133.5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    child: RaisedButton(
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.white,
                                        color: Colors.white,
                                        textColor: ColorConstant.blueColor,
                                        child: Column(
                                          children: [
                                            Image.asset(
                                              "Assets/Images/Medical.png",
                                              width: 18,
                                              height: 18,
                                            ),
                                            MyText(
                                              value:
                                                  'editprofil_medical_btn_active'
                                                      .tr(),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: ColorConstant.textColor,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {})),
                              )
                            : Container(),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: ButtonTheme(
                              height: 47.0,
                              minWidth: 133.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: RaisedButton(
                                  disabledColor: Colors.grey,
                                  disabledTextColor: Colors.white,
                                  color: Colors.white,
                                  textColor: ColorConstant.blueColor,
                                  child: Image.asset(
                                    "Assets/Images/attachment.png",
                                    width: 18,
                                    height: 18,
                                  ),
                                  onPressed: () {})),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: ButtonTheme(
                              height: 47.0,
                              minWidth: 133.5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: RaisedButton(
                                  disabledColor: Colors.grey,
                                  disabledTextColor: Colors.white,
                                  color: Colors.white,
                                  textColor: ColorConstant.blueColor,
                                  child: Image.asset(
                                    "Assets/Images/alarm.png",
                                    width: 18,
                                    height: 18,
                                  ),
                                  onPressed: () {})),
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
