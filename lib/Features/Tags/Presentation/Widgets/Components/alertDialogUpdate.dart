import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/alertDialogueTag.dart';
import 'package:easy_localization/easy_localization.dart';

class AlertDialogueUpdate extends ModalRoute<void> {
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
  String message, headerMessage;
  int index;
  Profile profile;
  int indexu;
  String type;
  AlertDialogueUpdate(String headerMessage, String message, Profile profile,
      String type, int indexu, int index) {
    this.message = message;
    this.headerMessage = headerMessage;
    this.profile = profile;
    this.type = type;
    this.indexu = indexu;
    this.index = index;
  }

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  static showOverlay(BuildContext context, String headerMessage, String message,
      Profile profile, String type, int indexu, int index) {
    Navigator.of(context).push(
        AlertDialogue(headerMessage, message, profile, type, indexu, index));
  }

  bool checkerFirstName = true;
  bool checkerEmail1 = true;
  bool checkerEmail2 = true;
  bool checkerTel = true;
  bool validateDescription = true;
  bool validateCategorie = true;
  bool validateOwner = true;
  int i;
  int j;
  int k;
  int l;
  int m;
  int n;
  int o;

  Widget _buildOverlayContent(BuildContext context) {
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
                          left: screenWidth * 0.08,
                          right: screenWidth * 0.08,
                          top: 0.05 * screenHeight),
                      child: MyText(
                          value: headerMessage,
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.08,
                          right: screenWidth * 0.08,
                          top: (screenHeight * 1.72) / 100,
                          bottom: (screenHeight * 1.72) / 100),
                      child: MyText(
                        value: message,
                        textAlign: TextAlign.center,
                        fontSize: 14,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                                //height:  (screenHeight * 6.4) / 100,
                                margin: EdgeInsets.only(
                                    top: (screenHeight * 4.93) / 100),
                                padding: EdgeInsets.only(
                                  bottom: screenHeight * 0.05,
                                ),
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    color: ColorConstant.greenColor,
                                    disabledColor: Colors.grey,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: MyText(
                                          value: "pets_label_save".tr(),
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    onPressed: () {
                                      message = '';
                                      checkerFirstName = true;
                                      checkerEmail1 = true;
                                      checkerEmail2 = true;
                                      checkerTel = true;
                                      validateDescription = true;
                                      validateCategorie = true;
                                      validateOwner = true;
                                      i = 0;
                                      j = 0;
                                      k = 0;
                                      l = 0;
                                      m = 0;
                                      n = 0;
                                      o = 0;
                                      if (type == 'object') {
                                        if (profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[indexu]
                                            .tags[index]
                                            .emergencyContactUser
                                            .isNotEmpty) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[indexu]
                                                      .firstName ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[indexu]
                                                      .tags[index]
                                                      .emergencyContactUser
                                                      .last
                                                      .mail ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[indexu]
                                                      .tags[index]
                                                      .emergencyContactUser
                                                      .last
                                                      .mail2 ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[indexu]
                                                      .tags[index]
                                                      .emergencyContactUser
                                                      .last
                                                      .mobile ==
                                                  '') {
                                            profile
                                                .userGeneralInfo
                                                .tagsList
                                                .objectTag[indexu]
                                                .tags[index]
                                                .emergencyContactUser
                                                .removeLast();
                                          }
                                        }

                                        if (profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[indexu]
                                            .tags[index]
                                            .otherInfo
                                            .isNotEmpty) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[indexu]
                                                      .tags[index]
                                                      .otherInfo
                                                      .last
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[indexu]
                                                      .tags[index]
                                                      .otherInfo
                                                      .last
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[indexu]
                                                      .tags[index]
                                                      .otherInfo
                                                      .last
                                                      .documents
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .tagsList
                                                .objectTag[indexu]
                                                .tags[index]
                                                .otherInfo
                                                .removeLast();
                                          } else if (profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .objectTag[indexu]
                                                  .tags[index]
                                                  .otherInfo
                                                  .last
                                                  .label ==
                                              '') {
                                            checkerFirstName = false;
                                            message =
                                                'pets_label_labelrequired'.tr();
                                          }
                                        }

                                        if (profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[indexu]
                                            .tags[index]
                                            .emergencyContactUser
                                            .isNotEmpty) {
                                          profile
                                              .userGeneralInfo
                                              .tagsList
                                              .objectTag[indexu]
                                              .tags[index]
                                              .emergencyContactUser
                                              .forEach((element) {
                                            i++;

                                            if (element.firstName.isNotEmpty) {
                                              if (regExpName.hasMatch(
                                                      element.firstName) !=
                                                  true) {
                                                checkerFirstName = false;
                                                message =
                                                    'pets_label_namealsocontact'
                                                            .tr() +
                                                        ' $i';
                                              }
                                            }
                                            if (regExpEmail
                                                    .hasMatch(element.mail) !=
                                                true) {
                                              checkerEmail1 = false;
                                              message =
                                                  'pets_label_primarymailalsocontact'
                                                          .tr() +
                                                      ' ${element.firstName}';
                                            }

                                            if (element.mail2.isNotEmpty) {
                                              if (regExpEmail.hasMatch(
                                                      element.mail2) !=
                                                  true) {
                                                checkerEmail2 = false;
                                                message =
                                                    'pets_label_secondarymailalsocontact'
                                                            .tr() +
                                                        ' ${element.firstName}';
                                              }
                                            }
                                            if (element.mobile.isNotEmpty) {
                                              if (regExpNumber.hasMatch(
                                                      element.mobile) !=
                                                  true) {
                                                checkerTel = false;
                                                message =
                                                    'pets_label_phonealsocontact'
                                                            .tr() +
                                                        ' ${element.firstName}';
                                              }
                                            }
                                          });
                                        }

                                        if (profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .objectTag[indexu]
                                                    .tags[index]
                                                    .tagInfo
                                                    .tagLabel ==
                                                null ||
                                            profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .objectTag[indexu]
                                                    .tags[index]
                                                    .tagInfo
                                                    .tagLabel ==
                                                '') {
                                          validateDescription = false;
                                          message =
                                              'pets_label_descriptionrequired'
                                                  .tr();
                                        }

                                        if (profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .objectTag[indexu]
                                                    .tags[index]
                                                    .tagInfo
                                                    .idMember ==
                                                null ||
                                            profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .objectTag[indexu]
                                                    .tags[index]
                                                    .tagInfo
                                                    .idMember ==
                                                '') {
                                          validateOwner = false;
                                          message =
                                              'pets_label_ownerobjectrequired'
                                                  .tr();
                                        }

                                        if (profile
                                                .userGeneralInfo
                                                .tagsList
                                                .objectTag[indexu]
                                                .tags[index]
                                                .tagInfo
                                                .idType ==
                                            null) {
                                          validateCategorie = false;
                                          message =
                                              'pets_label_categoryrequired'
                                                  .tr();
                                        }
                                      } else if (type == 'medical') {
                                        if (profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[indexu]
                                            .tags[index]
                                            .emergencyContactUser
                                            .isNotEmpty) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[indexu]
                                                      .firstName ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[indexu]
                                                      .tags[index]
                                                      .emergencyContactUser
                                                      .last
                                                      .mail ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[indexu]
                                                      .tags[index]
                                                      .emergencyContactUser
                                                      .last
                                                      .mail2 ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[indexu]
                                                      .tags[index]
                                                      .emergencyContactUser
                                                      .last
                                                      .mobile ==
                                                  '') {
                                            profile
                                                .userGeneralInfo
                                                .tagsList
                                                .medicalTag[indexu]
                                                .tags[index]
                                                .emergencyContactUser
                                                .removeLast();
                                          }
                                        }

                                        if (profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[indexu]
                                            .tags[index]
                                            .otherInfo
                                            .isNotEmpty) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[indexu]
                                                      .tags[index]
                                                      .otherInfo
                                                      .last
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[indexu]
                                                      .tags[index]
                                                      .otherInfo
                                                      .last
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[indexu]
                                                      .tags[index]
                                                      .otherInfo
                                                      .last
                                                      .documents
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .tagsList
                                                .medicalTag[indexu]
                                                .tags[index]
                                                .otherInfo
                                                .removeLast();
                                          } else if (profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .medicalTag[indexu]
                                                  .tags[index]
                                                  .otherInfo
                                                  .last
                                                  .label ==
                                              '') {
                                            checkerFirstName = false;
                                            message =
                                                'pets_label_labelrequired'.tr();
                                          }
                                        }

                                        if (profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[indexu]
                                            .tags[index]
                                            .emergencyContactUser
                                            .isNotEmpty) {
                                          profile
                                              .userGeneralInfo
                                              .tagsList
                                              .medicalTag[indexu]
                                              .tags[index]
                                              .emergencyContactUser
                                              .forEach((element) {
                                            i++;

                                            if (element.firstName.isNotEmpty) {
                                              if (regExpName.hasMatch(
                                                      element.firstName) !=
                                                  true) {
                                                checkerFirstName = false;
                                                message =
                                                    'pets_label_namealsocontact'
                                                            .tr() +
                                                        ' $i';
                                              }
                                            }
                                            if (regExpEmail
                                                    .hasMatch(element.mail) !=
                                                true) {
                                              checkerEmail1 = false;
                                              message =
                                                  'pets_label_primarymailalsocontact'
                                                          .tr() +
                                                      ' ${element.firstName}';
                                            }

                                            if (element.mail2.isNotEmpty) {
                                              if (regExpEmail.hasMatch(
                                                      element.mail2) !=
                                                  true) {
                                                checkerEmail2 = false;
                                                message =
                                                    'pets_label_secondarymailalsocontact'
                                                            .tr() +
                                                        ' ${element.firstName}';
                                              }
                                            }
                                            if (element.mobile.isNotEmpty) {
                                              if (regExpNumber.hasMatch(
                                                      element.mobile) !=
                                                  true) {
                                                checkerTel = false;
                                                message =
                                                    'pets_label_phonealsocontact'
                                                            .tr() +
                                                        ' ${element.firstName}';
                                              }
                                            }
                                          });
                                        }

                                        if (profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .medicalTag[indexu]
                                                    .tags[index]
                                                    .tagInfo
                                                    .tagLabel ==
                                                null ||
                                            profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .medicalTag[indexu]
                                                    .tags[index]
                                                    .tagInfo
                                                    .tagLabel ==
                                                '') {
                                          validateDescription = false;
                                          message =
                                              'pets_label_descriptionrequired'
                                                  .tr();
                                        }

                                        if (profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .medicalTag[indexu]
                                                    .tags[index]
                                                    .tagInfo
                                                    .idMember ==
                                                null ||
                                            profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .medicalTag[indexu]
                                                    .tags[index]
                                                    .tagInfo
                                                    .idMember ==
                                                '') {
                                          validateOwner = false;
                                          message =
                                              'pets_label_ownerobjectrequired'
                                                  .tr();
                                        }

                                        if (profile
                                                .userGeneralInfo
                                                .tagsList
                                                .medicalTag[indexu]
                                                .tags[index]
                                                .tagInfo
                                                .idType ==
                                            null) {
                                          validateCategorie = false;
                                          message =
                                              'pets_label_categoryrequired'
                                                  .tr();
                                        }
                                      }
                                      if (checkerFirstName == false ||
                                          checkerEmail1 == false ||
                                          checkerEmail2 == false ||
                                          validateCategorie == false ||
                                          validateOwner == false ||
                                          checkerTel == false) {
                                        showOverlay(
                                            context,
                                            "problem_infos".tr(),
                                            message,
                                            profile,
                                            type,
                                            indexu,
                                            index);
                                      } else {
                                        profile.userGeneralInfo.update = false;
                                        profile.parameters.location = 'SaveTag';
                                        profile.parameters.typecheck = type;
                                        profile.parameters.indext = index;
                                        profile.parameters.indexu = indexu;
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                          '/tagsProvider',
                                          arguments: profile,
                                        );
                                      }
                                    })),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                                //height:  (screenHeight * 6.4) / 100,
                                margin: EdgeInsets.only(
                                    top: (screenHeight * 4.93) / 100),
                                padding: EdgeInsets.only(
                                  bottom: screenHeight * 0.05,
                                ),
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0))),
                                  color: ColorConstant.greenColor,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: MyText(
                                        value: "pets_label_exit".tr(),
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  onPressed: () {
                                    profile.userGeneralInfo.update = false;
                                    profile.parameters.location = 'Cancel';
                                    profile.parameters.typecheck = type;
                                    profile.parameters.indext = index;
                                    profile.parameters.indexu = indexu;
                                    Navigator.of(context).pushReplacementNamed(
                                      '/tagsProvider',
                                      arguments: profile,
                                    );

                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           ViewProfileSubUserDisplay(
                                    //               profile: profile,
                                    //               index: index)),
                                    // );
                                  },
                                )),
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
                        image: AssetImage("Assets/Images/close.png"),
                      ),
                    ),
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
}
