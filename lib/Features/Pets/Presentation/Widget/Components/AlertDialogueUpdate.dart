import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/alertDialogPet.dart';
import 'package:neopolis/Core/Utils/text.dart';
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
  BuildContext contex;
  AlertDialogueUpdate(BuildContext context, String headerMessage,
      String message, int index, Profile profile) {
    this.contex = context;
    this.message = message;
    this.headerMessage = headerMessage;
    this.profile = profile;
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
      Profile profile, int index) {
    Navigator.of(context)
        .push(AlertDialogue(context, headerMessage, message, profile, index));
  }

  bool checkerFirstName = true;
  bool checkerEmail1 = true;
  bool checkerEmail2 = true;
  bool checkerTel = true;
  bool _validateName = false;
  bool _validateOwner = false;
  bool _validateType = false;
  int i;
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
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
                                    i = 0;
                                    checkerEmail2 = true;
                                    checkerTel = true;
                                    for (int j = 0; j < 5; j++) {
                                      if (profile
                                                  .userGeneralInfo
                                                  .petsInfos[index]
                                                  .emergencyContact !=
                                              null &&
                                          profile
                                                  .userGeneralInfo
                                                  .petsInfos[index]
                                                  .emergencyContact
                                                  .length !=
                                              0) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .petsInfos[index]
                                                .emergencyContact
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .firstName ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .lastName ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .mail ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .mail2 ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .mobile ==
                                                  '') {
                                            profile
                                                .userGeneralInfo
                                                .petsInfos[index]
                                                .emergencyContact
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .petsInfos[index]
                                                .emergencyContact
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .firstName !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .firstName !=
                                                  '') {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .petsInfos[index]
                                                    .emergencyContact[i]
                                                    .firstName) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "Please verify the name of the emergency contact number"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }
                                          if (profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .mail ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .mail ==
                                                  '') {
                                            checkerEmail1 = false;
                                            message =
                                                "pets_label_primarymailemergencycontact"
                                                        .tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpEmail.hasMatch(profile
                                                    .userGeneralInfo
                                                    .petsInfos[index]
                                                    .emergencyContact[i]
                                                    .mail) !=
                                                true) {
                                              checkerEmail1 = false;
                                              message =
                                                  "pets_label_primarymailemergencycontact"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          if (profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .mail2 !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .mail2 !=
                                                  '') {
                                            if (regExpEmail.hasMatch(profile
                                                    .userGeneralInfo
                                                    .petsInfos[index]
                                                    .emergencyContact[i]
                                                    .mail2) !=
                                                true) {
                                              checkerEmail2 = false;
                                              message =
                                                  "pets_label_secondarymailemergencycontact"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          if (profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .mobile !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .emergencyContact[i]
                                                      .mobile !=
                                                  '') {
                                            if (regExpNumber.hasMatch(profile
                                                    .userGeneralInfo
                                                    .petsInfos[index]
                                                    .emergencyContact[i]
                                                    .mobile) !=
                                                true) {
                                              checkerTel = false;
                                              message =
                                                  "pets_label_phoneemergencycontact"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .petsInfos[index]
                                          .vaccins
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .petsInfos[index]
                                                .vaccins
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .vaccins[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .vaccins[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .vaccins[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .vaccins[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile.userGeneralInfo
                                                .petsInfos[index].vaccins
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .petsInfos[index]
                                                .vaccins
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .vaccins[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .vaccins[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message =
                                                "pets_label_namevaccine".tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .petsInfos[index]
                                                    .vaccins[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_namevaccineinfo"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }
                                      if (profile
                                          .userGeneralInfo
                                          .petsInfos[index]
                                          .otherInfo
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .petsInfos[index]
                                                .otherInfo
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .otherInfo[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .otherInfo[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .otherInfo[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .otherInfo[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile.userGeneralInfo
                                                .petsInfos[index].otherInfo
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .petsInfos[index]
                                                .otherInfo
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .otherInfo[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[index]
                                                      .otherInfo[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message = "pets_label_nameotherinfo"
                                                    .tr() +
                                                " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .petsInfos[index]
                                                    .otherInfo[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_nameotherinfo"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }
                                          i++;
                                        }
                                      }
                                    }
                                    profile.userGeneralInfo.petsInfos[index]
                                                    .generalInfo.name ==
                                                null ||
                                            profile
                                                    .userGeneralInfo
                                                    .petsInfos[index]
                                                    .generalInfo
                                                    .name ==
                                                ''
                                        ? _validateName = false
                                        : _validateName = true;
                                    profile.userGeneralInfo.petsInfos[index]
                                                    .generalInfo.idMember ==
                                                null ||
                                            profile
                                                    .userGeneralInfo
                                                    .petsInfos[index]
                                                    .generalInfo
                                                    .idMember ==
                                                ''
                                        ? _validateOwner = false
                                        : _validateOwner = true;
                                    profile.userGeneralInfo.petsInfos[index]
                                                .generalInfo.idType ==
                                            null
                                        ? _validateType = false
                                        : _validateType = true;
                                    if (_validateName == true &&
                                        _validateType == true &&
                                        _validateOwner == true &&
                                        checkerFirstName == true &&
                                        checkerEmail1 == true &&
                                        checkerEmail2 == true) {
                                      profile.parameters.newPet = false;
                                      profile.parameters.location =
                                         "View save pet";
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        '/petsProvider',
                                        arguments: {
                                          'profile': profile,
                                          'index': index,
                                          'route': 'GoToAddEditPetProfile'
                                        },
                                      );
                                    }
                                    if (_validateName == false) {
                                      Future.delayed(
                                          Duration.zero,
                                          () => showOverlay(
                                              contex,
                                              "problem_infos".tr(),
                                              "pets_label_namerequired".tr(),
                                              profile,
                                              index));
                                    } else if (_validateOwner == false) {
                                      Future.delayed(
                                        Duration.zero,
                                        () => showOverlay(
                                          contex,
                                          "problem_infos".tr(),
                                          "pets_label_ownerrequired".tr(),
                                          profile,
                                          index,
                                        ),
                                      );
                                    } else if (_validateType == false) {
                                      Future.delayed(
                                          Duration.zero,
                                          () => showOverlay(
                                              contex,
                                              "problem_infos".tr(),
                                              "pets_label_typerequired".tr(),
                                              profile,
                                              index));
                                    } else if (checkerFirstName == false) {
                                      Future.delayed(
                                        Duration.zero,
                                        () => showOverlay(
                                          contex,
                                          "problem_infos".tr(),
                                          message,
                                          profile,
                                          index,
                                        ),
                                      );
                                    } else if (checkerEmail1 == false) {
                                      Future.delayed(
                                          Duration.zero,
                                          () => showOverlay(
                                              contex,
                                              "problem_infos".tr(),
                                              message,
                                              profile,
                                              index));
                                    } else if (checkerEmail2 == false) {
                                      Future.delayed(
                                          Duration.zero,
                                          () => showOverlay(
                                              contex,
                                              "problem_infos".tr(),
                                              message,
                                              profile,
                                              index));
                                    }
                                  },
                                )),
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
                                    // if (index == 1) {

                                    if (profile.parameters.newPet == true) {
                                      profile.userGeneralInfo.petsInfos
                                          .removeAt(index);
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        '/homeProvider',
                                        arguments: profile,
                                      );
                                    } else {
                                      profile.parameters.location = "View Pet";
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        '/petsProvider',
                                        arguments: {
                                          'profile': profile,
                                          'index': index,
                                          'route': 'GoToViewPetProfile'
                                        },
                                      );
                                    }
                                    // } else {
                                    //   profile.userGeneralInfo.update = false;
                                    //   profile.parameters.location = "view home";
                                    //   Navigator.of(context)
                                    //       .pushReplacementNamed(
                                    //     '/profileProvider',
                                    //     arguments: profile,
                                    //   );
                                    // }
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
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
