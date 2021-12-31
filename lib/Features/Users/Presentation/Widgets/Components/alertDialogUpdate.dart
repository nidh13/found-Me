import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';

import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/alertDialog.dart';
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
  AlertDialogueUpdate(
      String headerMessage, String message, Profile profile, int index) {
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
        .push(AlertDialogue(headerMessage, message, profile, index));
  }

  bool checkerFirstName = true;
  bool checkerEmail1 = true;
  bool checkerEmail2 = true;
  bool checkerTel = true;
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
                      child: Text(
                        headerMessage,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenWidth * 0.08,
                          right: screenWidth * 0.08,
                          top: (screenHeight * 1.72) / 100,
                          bottom: (screenHeight * 1.72) / 100),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                          fontSize: 14,
                        ),
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
                                    child: Text(
                                      "pets_label_save".tr(),
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  onPressed: () {
                                    message = '';
                                    checkerFirstName = true;
                                    checkerEmail1 = true;
                                    checkerEmail2 = true;
                                    checkerTel = true;
                                    i = 0;

                                    for (int p = 0; p < 5; p++) {
                                      if (profile
                                                  .userGeneralInfo
                                                  .subUsers[index]
                                                  .userGeneralInfo
                                                  .firstName !=
                                              null &&
                                          profile
                                                  .userGeneralInfo
                                                  .subUsers[index]
                                                  .userGeneralInfo
                                                  .firstName !=
                                              '') {
                                        if (regExpName.hasMatch(profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .userGeneralInfo
                                                .firstName) !=
                                            true) {
                                          checkerFirstName = false;
                                          message =
                                              "pets_label_verifyname".tr();
                                        }
                                      } else {
                                        checkerFirstName = false;
                                        message = "pets_label_verifyname".tr();
                                      }

                                      // MAIL
                                      if (profile
                                              .userGeneralInfo
                                              .subUsers[index]
                                              .userGeneralInfo
                                              .role !=
                                          4) {
                                        if (profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .userGeneralInfo
                                                    .mail !=
                                                null &&
                                            profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .userGeneralInfo
                                                    .mail !=
                                                '') {
                                          if (regExpEmail.hasMatch(profile
                                                  .userGeneralInfo
                                                  .subUsers[index]
                                                  .userGeneralInfo
                                                  .mail) !=
                                              true) {
                                            checkerEmail1 = false;
                                            message =
                                                "pets_label_verifyprimarymail"
                                                    .tr();
                                          }
                                        } else {
                                          checkerEmail1 = false;
                                          message =
                                              "pets_label_verifyprimarymail"
                                                  .tr();
                                        }
                                      }

                                      if (profile
                                                  .userGeneralInfo
                                                  .subUsers[index]
                                                  .userGeneralInfo
                                                  .mail2 !=
                                              null &&
                                          profile
                                                  .userGeneralInfo
                                                  .subUsers[index]
                                                  .userGeneralInfo
                                                  .mail2 !=
                                              '') {
                                        if (regExpEmail.hasMatch(profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .userGeneralInfo
                                                .mail2) !=
                                            true) {
                                          checkerEmail2 = false;
                                          message =
                                              "pets_label_verifysecondarymail"
                                                  .tr();
                                        }
                                      }

                                      if (profile
                                                  .userGeneralInfo
                                                  .subUsers[index]
                                                  .userGeneralInfo
                                                  .mobile !=
                                              null &&
                                          profile
                                                  .userGeneralInfo
                                                  .subUsers[index]
                                                  .userGeneralInfo
                                                  .mobile !=
                                              '') {
                                        if (regExpNumber.hasMatch(profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .userGeneralInfo
                                                .mobile) !=
                                            true) {
                                          checkerTel = false;
                                          message =
                                              "pets_label_verifyphone".tr();
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .userGeneralInfo
                                          .userEmergencyContact
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .userGeneralInfo
                                                .userEmergencyContact
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .firstName ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .lastName ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .mail ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .mail2 ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .mobile ==
                                                  '') {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .userGeneralInfo
                                                .userEmergencyContact
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .userGeneralInfo
                                                .userEmergencyContact
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .firstName !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .firstName !=
                                                  '') {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .userGeneralInfo
                                                    .userEmergencyContact[i]
                                                    .firstName) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_namealsocontact"
                                                          .tr() +
                                                      ' ${i + 1}';
                                            }
                                          }
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .mail ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .mail ==
                                                  '') {
                                            checkerEmail1 = false;
                                            message =
                                                "pets_label_primarymailalsocontact2"
                                                        .tr() +
                                                    ' ${i + 1}';
                                          } else {
                                            if (regExpEmail.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .userGeneralInfo
                                                    .userEmergencyContact[i]
                                                    .mail) !=
                                                true) {
                                              checkerEmail1 = false;
                                              message =
                                                  "pets_label_primarymailalsocontact2"
                                                          .tr() +
                                                      ' ${i + 1}';
                                            }
                                          }
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .mail2 !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .mail2 !=
                                                  '') {
                                            if (regExpEmail.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .userGeneralInfo
                                                    .userEmergencyContact[i]
                                                    .mail2) !=
                                                true) {
                                              checkerEmail2 = false;
                                              message =
                                                  "pets_label_secondarymailalsocontact2"
                                                          .tr() +
                                                      ' ${i + 1}';
                                            }
                                          }
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .mobile !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .userGeneralInfo
                                                      .userEmergencyContact[i]
                                                      .mobile !=
                                                  '') {
                                            if (regExpNumber.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .userGeneralInfo
                                                    .userEmergencyContact[i]
                                                    .mobile) !=
                                                true) {
                                              checkerTel = false;
                                              message =
                                                  "pets_label_phonealsocontact2"
                                                          .tr() +
                                                      ' ${i + 1}';
                                            }
                                          }
                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .userEmergencyContact
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .userEmergencyContact
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .firstName ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .lastName ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .mail ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .mail2 ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .mobile ==
                                                  '') {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .userEmergencyContact
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .userEmergencyContact
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .firstName !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .firstName !=
                                                  '') {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .userEmergencyContact[i]
                                                    .firstName) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_nameemergencycontact"
                                                          .tr() +
                                                      ' ${i + 1}';
                                            }
                                          }
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .mail ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .mail ==
                                                  '') {
                                            checkerEmail1 = false;
                                            message =
                                                "pets_label_primarymailemergencycontact"
                                                        .tr() +
                                                    ' ${i + 1}';
                                          } else {
                                            if (regExpEmail.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .userEmergencyContact[i]
                                                    .mail) !=
                                                true) {
                                              checkerEmail1 = false;
                                              message =
                                                  "pets_label_primarymailemergencycontact"
                                                          .tr() +
                                                      ' ${i + 1}';
                                            }
                                          }

                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .mail2 !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .mail2 !=
                                                  '') {
                                            if (regExpEmail.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .userEmergencyContact[i]
                                                    .mail2) !=
                                                true) {
                                              checkerEmail2 = false;
                                              message =
                                                  "pets_label_secondarymailemergencycontact"
                                                          .tr() +
                                                      ' ${i + 1}';
                                            }
                                          }

                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .mobile !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .userEmergencyContact[i]
                                                      .mobile !=
                                                  '') {
                                            if (regExpNumber.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .userEmergencyContact[i]
                                                    .mobile) !=
                                                true) {
                                              checkerTel = false;
                                              message =
                                                  "pets_label_phoneemergencycontact"
                                                          .tr() +
                                                      ' ${i + 1}';
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .physicianContact
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .physicianContact
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .physicianContact[i]
                                                      .firstName ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .physicianContact[i]
                                                      .mail ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .physicianContact[i]
                                                      .mail2 ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .physicianContact[i]
                                                      .mobile ==
                                                  '') {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .physicianContact
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .physicianContact
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .physicianContact[i]
                                                      .firstName !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .physicianContact[i]
                                                      .firstName !=
                                                  '') {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .physicianContact[i]
                                                    .firstName) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_namephysiciancontact"
                                                          .tr() +
                                                      ' ${i + 1}';
                                            }
                                          }
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .physicianContact[i]
                                                      .mail ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .physicianContact[i]
                                                      .mail ==
                                                  '') {
                                            checkerEmail1 = false;
                                            message = ' ${i + 1}';
                                          } else {
                                            if (regExpEmail.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .physicianContact[i]
                                                    .mail) !=
                                                true) {
                                              checkerEmail1 = false;
                                              message =
                                                  "pets_label_primarymailphysiciancontact"
                                                          .tr() +
                                                      ' ${i + 1}';
                                            }
                                          }

                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .physicianContact[i]
                                                      .mail2 !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .physicianContact[i]
                                                      .mail2 !=
                                                  '') {
                                            if (regExpEmail.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .physicianContact[i]
                                                    .mail2) !=
                                                true) {
                                              checkerEmail2 = false;
                                              message =
                                                  "pets_label_secondaryymailphysiciancontact"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .physicianContact[i]
                                                      .mobile !=
                                                  null &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .physicianContact[i]
                                                      .mobile !=
                                                  '') {
                                            if (regExpNumber.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .physicianContact[i]
                                                    .mobile) !=
                                                true) {
                                              checkerTel = false;
                                              message =
                                                  "pets_label_phonephysiciancontact"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .insuranceInfo
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .insuranceInfo
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .insuranceInfo[i]
                                                      .insuranceCampanyName ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .insuranceInfo[i]
                                                      .additionalInformations ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .insuranceInfo[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .insuranceInfo[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .insuranceInfo
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }

                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .insuranceInfo
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .insuranceInfo[i]
                                                      .insuranceCampanyName ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .insuranceInfo[i]
                                                      .insuranceCampanyName ==
                                                  '') {
                                            checkerFirstName = false;
                                            message =
                                                "pets_label_nameinsuranceinfo"
                                                        .tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .insuranceInfo[i]
                                                    .insuranceCampanyName) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_nameinsuranceinfo"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .miscilanious
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .miscilanious
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .miscilanious[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .miscilanious[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .miscilanious[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .miscilanious[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .miscilanious
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .miscilanious
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .miscilanious[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .miscilanious[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message =
                                                "pets_label_namemiscilanious"
                                                        .tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .miscilanious[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_namemiscilanious"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .otherMedicalRecordInfo
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .otherMedicalRecordInfo
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .otherMedicalRecordInfo[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .otherMedicalRecordInfo[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .otherMedicalRecordInfo[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .otherMedicalRecordInfo[i]
                                                      .reminder
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .otherMedicalRecordInfo
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .otherMedicalRecordInfo
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .otherMedicalRecordInfo[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .otherMedicalRecordInfo[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message = "pets_label_nameotherinfo"
                                                    .tr() +
                                                " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .otherMedicalRecordInfo[i]
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

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .medicalDiseaces
                                          .infectionDisaces
                                          .blocks
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .infectionDisaces
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .infectionDisaces
                                                      .blocks[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .infectionDisaces
                                                      .blocks[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .infectionDisaces
                                                      .blocks[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .infectionDisaces
                                                      .blocks[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .infectionDisaces
                                                .blocks
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .infectionDisaces
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .infectionDisaces
                                                      .blocks[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .infectionDisaces
                                                      .blocks[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message =
                                                "pets_label_nameinfectiondiseace"
                                                        .tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .medicalDiseaces
                                                    .infectionDisaces
                                                    .blocks[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_nameinfectiondiseace"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .medicalDiseaces
                                          .allergies
                                          .blocks
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .allergies
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .allergies
                                                      .blocks[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .allergies
                                                      .blocks[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .allergies
                                                      .blocks[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .allergies
                                                      .blocks[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .allergies
                                                .blocks
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .allergies
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .allergies
                                                      .blocks[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .allergies
                                                      .blocks[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message =
                                                "pets_label_nameallergie".tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .medicalDiseaces
                                                    .allergies
                                                    .blocks[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_nameallergie"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .medicalDiseaces
                                          .implants
                                          .blocks
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .implants
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .implants
                                                      .blocks[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .implants
                                                      .blocks[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .implants
                                                      .blocks[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .implants
                                                      .blocks[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .implants
                                                .blocks
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .implants
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .implants
                                                      .blocks[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .implants
                                                      .blocks[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message =
                                                "pets_label_nameimplants".tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .medicalDiseaces
                                                    .implants
                                                    .blocks[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_nameimplants"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .medicalDiseaces
                                          .renalKenedy
                                          .blocks
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .renalKenedy
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .renalKenedy
                                                      .blocks[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .renalKenedy
                                                      .blocks[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .renalKenedy
                                                      .blocks[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .renalKenedy
                                                      .blocks[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .renalKenedy
                                                .blocks
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .renalKenedy
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .renalKenedy
                                                      .blocks[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .renalKenedy
                                                      .blocks[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message =
                                                "pets_label_namerenalkenedy"
                                                        .tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .medicalDiseaces
                                                    .renalKenedy
                                                    .blocks[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_namerenalkenedy"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .medicalDiseaces
                                          .cardiac
                                          .blocks
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .cardiac
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .cardiac
                                                      .blocks[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .cardiac
                                                      .blocks[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .cardiac
                                                      .blocks[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .cardiac
                                                      .blocks[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .cardiac
                                                .blocks
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .cardiac
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .cardiac
                                                      .blocks[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .cardiac
                                                      .blocks[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message =
                                                "pets_label_namecardiac".tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .medicalDiseaces
                                                    .cardiac
                                                    .blocks[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message = "pets_label_namecardiac"
                                                      .tr() +
                                                  " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .medicalDiseaces
                                          .psychiatric
                                          .blocks
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .psychiatric
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .psychiatric
                                                      .blocks[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .psychiatric
                                                      .blocks[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .psychiatric
                                                      .blocks[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .psychiatric
                                                      .blocks[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .psychiatric
                                                .blocks
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .psychiatric
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .psychiatric
                                                      .blocks[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .psychiatric
                                                      .blocks[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message =
                                                "pets_label_namepsychiatric"
                                                        .tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .medicalDiseaces
                                                    .psychiatric
                                                    .blocks[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_namepsychiatric"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .medicalDiseaces
                                          .neuroligic
                                          .blocks
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .neuroligic
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .neuroligic
                                                      .blocks[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .neuroligic
                                                      .blocks[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .neuroligic
                                                      .blocks[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .neuroligic
                                                      .blocks[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .neuroligic
                                                .blocks
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .neuroligic
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .neuroligic
                                                      .blocks[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .neuroligic
                                                      .blocks[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message =
                                                "pets_label_nameneurologic"
                                                        .tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .medicalDiseaces
                                                    .neuroligic
                                                    .blocks[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_nameneurologic"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .medicalDiseaces
                                          .plumonary
                                          .blocks
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .plumonary
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .plumonary
                                                      .blocks[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .plumonary
                                                      .blocks[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .plumonary
                                                      .blocks[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .plumonary
                                                      .blocks[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .plumonary
                                                .blocks
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .plumonary
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .plumonary
                                                      .blocks[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .plumonary
                                                      .blocks[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message = "pets_label_nameplumonary"
                                                    .tr() +
                                                " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .medicalDiseaces
                                                    .plumonary
                                                    .blocks[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_nameplumonary"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .medicalDiseaces
                                          .medication
                                          .blocks
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .medication
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .medication
                                                      .blocks[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .medication
                                                      .blocks[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .medication
                                                      .blocks[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .medication
                                                      .blocks[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .medication
                                                .blocks
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .medication
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .medication
                                                      .blocks[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .medication
                                                      .blocks[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message =
                                                "pets_label_namemedication"
                                                        .tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .medicalDiseaces
                                                    .medication
                                                    .blocks[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_namemedication"
                                                          .tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }

                                      if (profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .medicalRecord
                                          .medicalDiseaces
                                          .cancer
                                          .blocks
                                          .isNotEmpty) {
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .cancer
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .cancer
                                                      .blocks[i]
                                                      .label ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .cancer
                                                      .blocks[i]
                                                      .description ==
                                                  '' &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .cancer
                                                      .blocks[i]
                                                      .documents
                                                      .length ==
                                                  0 &&
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .cancer
                                                      .blocks[i]
                                                      .reminders
                                                      .length ==
                                                  0) {
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .cancer
                                                .blocks
                                                .removeAt(i);
                                          } else {
                                            i++;
                                          }
                                        }
                                        i = 0;
                                        while (i <
                                            profile
                                                .userGeneralInfo
                                                .subUsers[index]
                                                .medicalRecord
                                                .medicalDiseaces
                                                .cancer
                                                .blocks
                                                .length) {
                                          if (profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .cancer
                                                      .blocks[i]
                                                      .label ==
                                                  null ||
                                              profile
                                                      .userGeneralInfo
                                                      .subUsers[index]
                                                      .medicalRecord
                                                      .medicalDiseaces
                                                      .cancer
                                                      .blocks[i]
                                                      .label ==
                                                  '') {
                                            checkerFirstName = false;
                                            message =
                                                "pets_label_namecancer".tr() +
                                                    " ${i + 1}";
                                          } else {
                                            if (regExpName.hasMatch(profile
                                                    .userGeneralInfo
                                                    .subUsers[index]
                                                    .medicalRecord
                                                    .medicalDiseaces
                                                    .cancer
                                                    .blocks[i]
                                                    .label) !=
                                                true) {
                                              checkerFirstName = false;
                                              message =
                                                  "pets_label_namecancer".tr() +
                                                      " ${i + 1}";
                                            }
                                          }

                                          i++;
                                        }
                                      }
                                    }

                                    if (checkerFirstName == false ||
                                        checkerEmail1 == false ||
                                        checkerEmail2 == false ||
                                        checkerTel == false) {
                                      showOverlay(context, "problem_infos".tr(),
                                          message, profile, index);
                                    } else {
                                      profile.parameters.newUser = false;
                                      profile.userGeneralInfo.update = false;
                                      profile.parameters.location =
                                          'view save user';
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        '/usersProvider',
                                        arguments: {
                                          'profile': profile,
                                          'index': index,
                                          'route': 'GoToSaveSubUser',
                                        },
                                      );
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
                                    child: Text(
                                      "pets_label_exit".tr(),
                                      textScaleFactor: 1.0,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  onPressed: () {
                                    profile.userGeneralInfo.update = false;
                                    if (profile.parameters.newUser == true) {
                                      profile.userGeneralInfo.subUsers
                                          .removeAt(index);
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                        '/homeProvider',
                                        arguments: profile,
                                      );
                                    } else {
                                      profile.parameters.location =
                                          'view sub user';
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              '/usersProvider',
                                              arguments: {
                                            'profile': profile,
                                            'index': index,
                                            'route': 'GoToSaveSubUser',
                                          });
                                    }

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
                            image: AssetImage("Assets/Images/close.png"))),
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
