import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_expansion_tile.dart'
    as custom;
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/attachmentSelection.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/expandable_listView.dart';
import 'package:neopolis/Features/Users/Presentation/bloc/users_bloc.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popUpImage.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/animationViewSubuser.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ViewProfileSubUserDisplay extends StatefulWidget {
  final Profile profile;
  final int index;
  const ViewProfileSubUserDisplay(
      {Key key, @required this.profile, @required this.index})
      : super(key: key);
  @override
  _ViewProfileSubUserDisplayState createState() =>
      _ViewProfileSubUserDisplayState();
}

class _ViewProfileSubUserDisplayState extends State<ViewProfileSubUserDisplay> {
  var screenWidth, screenHeight;

  bool _objectRecordEmail = false;
  bool _objectRecordPrint = false;

  List<Blocks> userMedicalDiseacesCancer = [];
  List<Blocks> userMedicalDiseacesAllergies = [];
  List<Blocks> userMedicalDiseacesCardiac = [];

  List<Blocks> userMedicalDiseacesImplants = [];
  List<Blocks> userMedicalDiseacesMedication = [];
  List<Blocks> userMedicalDiseacesNeurologic = [];
  List<Blocks> userMedicalDiseacesPlumonary = [];
  List<Blocks> userMedicalDiseacesPsychiatric = [];
  List<Blocks> userMedicalDiseacesRenal = [];
  List<Blocks> userMedicalDiseacesInfectionDisaces = [];

  double _petItemWidth = 0.0;
  int _medicalIndicatorIndex = 0;
  int nombrebolckAllergies = 0;
  int nombrebolckImplant = 0;
  int nombrebolckRenal = 0;
  int nombrebolckCardiac = 0;
  int nombrebolckPsychiatric = 0;
  int nombrebolckNeurologic = 0;
  int nombrebolckPulmonary = 0;
  int nombrebolckMedication = 0;
  int nombrebolckCancer = 0;
  int nombrebolckInfectiousDesease = 0;

  bool _infectiousdiseases = false;
  bool _allergies = false;
  bool _dnr = false;
  bool lockSreen = true;
  bool _implants = false;
  bool _renalKidney = false;
  bool _psychiatric = false;
  bool _neurologic = false;
  bool _pulmonary = false;
  bool _medication = false;
  bool _cancer = false;
  bool cardiac = false;
  bool attachmentMedicalInfectious = false;
  bool reminderMedicalInfectious = false;
  bool attachmentMedicalAllergies = false;
  bool reminderMedicalAllergies = false;
  bool attachmentMedicalImplant = false;
  bool reminderMedicalImplant = false;
  bool attachmentMedicalRenal = false;
  bool reminderMedicalRenal = false;
  bool attachmentMedicalCardiac = false;
  bool reminderMedicalCaridac = false;

  bool attachmentMedicalPsy = false;
  bool reminderMedicalPsy = false;
  bool attachmentMedicalNeuro = false;
  bool reminderMedicalNeuro = false;
  bool attachmentMedicalPulmo = false;
  bool reminderMedicalPulmo = false;
  bool attachmentMedicalMedication = false;
  bool reminderMedicalMedication = false;
  bool attachmentMedicalCancer = false;
  bool reminderMedicalCancer = false;
  bool attachmentMedicalBlood = false;
  bool reminderMedicalBlood = false;
  bool attachmentMedicalOrgan = false;
  bool reminderMedicalOrgan = false;
  bool attachmentMedicalCardia = false;
  bool reminderMedicalCardiac = false;
  ScrollController _userScrollController = new ScrollController();

  void scrollListenerWithItemHeight() {
    double itemHeight = _petItemWidth;
    double scrollOffset = _userScrollController.offset / 3;
    int firstVisibleItemIndex =
        scrollOffset < itemHeight ? 0 : ((scrollOffset) ~/ itemHeight);
    _medicalIndicatorIndex = firstVisibleItemIndex;
    setState(() {});
  }

  viewFisrtNameLastName(String first, String last) {
    if (first != null && last == null) {
      return MyText(value: first, fontSize: 24, fontWeight: FontWeight.w600);
    }
    if (first == null && last != null) {
      return MyText(value: last, fontSize: 24, fontWeight: FontWeight.w600);
    }
    if (first == null && last == null) {
      return MyText(value: ' ', fontSize: 24, fontWeight: FontWeight.w600);
    }
    if (first != null && last != null) {
      return MyText(
          value: first + ' ' + last, fontSize: 24, fontWeight: FontWeight.w600);
    }
  }

  viewFisrtName(String first, String last) {
    if (first != null && last == null) {
      return MyText(value: first, fontSize: 14, fontWeight: FontWeight.w500);
    }
    if (first == null && last != null) {
      return MyText(value: last, fontSize: 14, fontWeight: FontWeight.w500);
    }
    if (first == null && last == null) {
      return MyText(value: ' ', fontSize: 14, fontWeight: FontWeight.w500);
    }
    if (first != null && last != null) {
      return MyText(
          value: first + ' ' + last, fontSize: 14, fontWeight: FontWeight.w500);
    }
  }

  myMedicalDiseaces() {
    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
        .preferenceUser
        .toJson()
        .forEach((key, value) {
      if (value['value'] == '1') {
        if (widget.profile.userGeneralInfo.subUsers[widget.index]
                .userGeneralInfo.role ==
            3) {
          if ((value['acces_label_txt'] != 'Share my email(s) with finder') &&
              (value['acces_label_txt'] !=
                  'Share my phone number with finder') &&
              (value['acces_label_txt'] != 'Include child name') &&
              (value['acces_label_txt'] != 'Include my picture') &&
              (value['acces_label_txt'] != 'Include child name') &&
              (value['acces_label_txt'] != 'Include child picture')) {
            listActive.add(value);
          }
        } else {
          if (widget.profile.userGeneralInfo.subUsers[widget.index]
                  .userGeneralInfo.role ==
              4) {
            listActive.add(value);
          } else if ((value['acces_label_txt'] != 'Include child name') &&
              (value['acces_label_txt'] != 'Include child picture')) {
            listActive.add(value);
          }
        }
      } else {
        if (widget.profile.userGeneralInfo.subUsers[widget.index]
                .userGeneralInfo.role ==
            3) {
          if ((value['acces_label_txt'] != 'Share my email(s) with finder') &&
              (value['acces_label_txt'] !=
                  'Share my phone number with finder') &&
              (value['acces_label_txt'] != 'Include child name') &&
              (value['acces_label_txt'] != 'Include my picture') &&
              (value['acces_label_txt'] != 'Include child name') &&
              (value['acces_label_txt'] != 'Include child picture')) {
            listInactive.add(value);
          }
        } else {
          if ((value['acces_label_txt'] != 'Include child name') &&
              (value['acces_label_txt'] != 'Include child picture')) {
            listInactive.add(value);
          }
        }
      }
    });
    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                .role ==
            4
        ? widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
            .userEmergencyContact
            .forEach((element) {
            if (element.active == 1) {
              listActiveContacts.add(element.toJson());
            } else {
              listInactiveContacts.add(element.toJson());
            }
          })
        : widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
            .userEmergencyContact
            .forEach((element) {
            listActiveContacts.add(element.toJson());
          });
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
        .physicianContact
        .forEach((element) {
      listActivePhysicienContacts.add(element.toJson());
    });
    widget.profile.userGeneralInfo.tagsList.medicalTag.forEach((element) {
      if (element.idMember ==
          widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
              .idMember) {
        userMedicalTagList = element.tags;
      }
    });

    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
        .medicalDiseaces
        .toJson()
        .forEach(
      (key, value) {
        if (value['blocks'].length == 0) {
          medicalDiseacesInactiveNames.add(key);

          medicalDiseacesInactive.add({key: value['blocks']});
        } else {
          medicalDiseacesActiveNames.add(key);

          medicalDiseacesActive.add({key: value['blocks']});
        }
      },
    );

    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
        .miscilanious
        .forEach((element) {
      if (element.documents != null)
        element.documents.forEach((element) {
          documents.add(element);
        });
    });
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.cancer !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.cancer.blocks
            .forEach((element) {
            userMedicalDiseacesCancer.add(element);
          })
        : Container();
    nombrebolckCancer = userMedicalDiseacesCancer.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.allergies !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.allergies.blocks
            .forEach((element) {
            userMedicalDiseacesAllergies.add(element);
          })
        : Container();
    nombrebolckAllergies = userMedicalDiseacesAllergies.length;

    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.cardiac !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.cardiac.blocks
            .forEach((element) {
            userMedicalDiseacesCardiac.add(element);
          })
        : Container();
    nombrebolckCardiac = userMedicalDiseacesCardiac.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.implants !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.implants.blocks
            .forEach((element) {
            userMedicalDiseacesImplants.add(element);
          })
        : Container();
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.medication !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.medication.blocks
            .forEach((element) {
            userMedicalDiseacesMedication.add(element);
          })
        : Container();
    nombrebolckMedication = userMedicalDiseacesMedication.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.neuroligic !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.neuroligic.blocks
            .forEach((element) {
            userMedicalDiseacesNeurologic.add(element);
          })
        : Container();
    nombrebolckNeurologic = userMedicalDiseacesNeurologic.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.plumonary !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.plumonary.blocks
            .forEach((element) {
            userMedicalDiseacesPlumonary.add(element);
          })
        : Container();
    nombrebolckPulmonary = userMedicalDiseacesPlumonary.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.psychiatric !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.psychiatric.blocks
            .forEach((element) {
            userMedicalDiseacesPsychiatric.add(element);
          })
        : Container();
    nombrebolckPsychiatric = userMedicalDiseacesPsychiatric.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.renalKenedy !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.renalKenedy.blocks
            .forEach((element) {
            userMedicalDiseacesRenal.add(element);
          })
        : Container();
    nombrebolckRenal = userMedicalDiseacesRenal.length;
    widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                .medicalDiseaces.infectionDisaces !=
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].medicalRecord
            .medicalDiseaces.infectionDisaces.blocks
            .forEach((element) {
            userMedicalDiseacesInfectionDisaces.add(element);
          })
        : Container();
    nombrebolckInfectiousDesease = userMedicalDiseacesInfectionDisaces.length;
  }

  bool iconAttachmentMedicalInfectious() {
    userMedicalDiseacesInfectionDisaces.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalInfectious = true;
      }
    });
    return attachmentMedicalInfectious;
  }

  bool iconReminderMedicalInfectious() {
    userMedicalDiseacesInfectionDisaces.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalInfectious = true;
      }
    });
    return reminderMedicalInfectious;
  }

  bool iconAttachmentMedicalAllergies() {
    userMedicalDiseacesAllergies.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalAllergies = true;
      }
    });
    return attachmentMedicalAllergies;
  }

  bool iconReminderMedicalAllergies() {
    userMedicalDiseacesAllergies.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalAllergies = true;
      }
    });
    return reminderMedicalAllergies;
  }

  bool iconAttachmentMedicalImplant() {
    userMedicalDiseacesImplants.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalImplant = true;
      }
    });
    return attachmentMedicalImplant;
  }

  bool iconReminderMedicalImplant() {
    userMedicalDiseacesImplants.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalImplant = true;
      }
    });
    return reminderMedicalImplant;
  }

  bool iconAttachmentMedicalCardiac() {
    userMedicalDiseacesCardiac.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalCardia = true;
      }
    });
    return attachmentMedicalCardia;
  }

  bool iconReminderMedicalCardiac() {
    userMedicalDiseacesCardiac.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalCardiac = true;
      }
    });
    return reminderMedicalCardiac;
  }

  bool iconAttachmentMedicalRenal() {
    userMedicalDiseacesRenal.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalRenal = true;
      }
    });
    return attachmentMedicalRenal;
  }

  bool iconReminderMedicalRenal() {
    userMedicalDiseacesRenal.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalRenal = true;
      }
    });
    return reminderMedicalRenal;
  }

  bool iconAttachmentMedicalPsy() {
    userMedicalDiseacesPsychiatric.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalPsy = true;
      }
    });
    return attachmentMedicalPsy;
  }

  bool iconReminderMedicalPsy() {
    userMedicalDiseacesPsychiatric.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalPsy = true;
      }
    });
    return reminderMedicalPsy;
  }

  bool iconAttachmentMedicalNeuro() {
    userMedicalDiseacesNeurologic.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalNeuro = true;
      }
    });
    return attachmentMedicalNeuro;
  }

  bool iconReminderMedicalNeuro() {
    userMedicalDiseacesNeurologic.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalNeuro = true;
      }
    });
    return reminderMedicalNeuro;
  }

  bool iconAttachmentMedicalPulmo() {
    userMedicalDiseacesPlumonary.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalPulmo = true;
      }
    });
    return attachmentMedicalPulmo;
  }

  bool iconReminderMedicalPulmo() {
    userMedicalDiseacesPlumonary.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalPulmo = true;
      }
    });
    return reminderMedicalPulmo;
  }

  bool iconAttachmentMedicalMedication() {
    userMedicalDiseacesMedication.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalMedication = true;
      }
    });
    return attachmentMedicalMedication;
  }

  bool iconReminderMedicalMedication() {
    userMedicalDiseacesMedication.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalMedication = true;
      }
    });
    return reminderMedicalMedication;
  }

  bool iconAttachmentMedicalCancer() {
    userMedicalDiseacesCancer.forEach((element) {
      if (element.documents.length != 0) {
        attachmentMedicalCancer = true;
      }
    });
    return attachmentMedicalCancer;
  }

  bool iconReminderMedicalCancer() {
    userMedicalDiseacesCancer.forEach((element) {
      if (element.reminders.length != 0) {
        reminderMedicalCancer = true;
      }
    });
    return reminderMedicalCancer;
  }

  @override
  void initState() {
    _userScrollController.addListener(scrollListenerWithItemHeight);
    myMedicalDiseaces();

    super.initState();
  }

  List<Map<String, dynamic>> listActive = [];
  List<Map<String, dynamic>> listInactive = [];
  List<Map<String, dynamic>> listActiveContacts = [];
  List<Map<String, dynamic>> listInactiveContacts = [];
  List<Map<String, dynamic>> listActivePhysicienContacts = [];
  List<Tags> userMedicalTagList = [];

  List<Map<String, dynamic>> medicalDiseacesActive = [];
  List<String> medicalDiseacesActiveNames = [];
  List<String> medicalDiseacesInactiveNames = [];
  List<Documents> documents = [];

  List<Map<String, dynamic>> medicalDiseacesInactive = [];
  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;

    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return NestedScrollView(
        // floatHeaderSlivers: true,
        physics: NeverScrollableScrollPhysics(),

        headerSliverBuilder: (context, value) {
          return [
            SliverPersistentHeader(
              pinned: true,
              floating: true,
              delegate: CustomSliverDelegate(
                  hideTitleWhenExpanded: true,
                  expandedHeight: 165,
                  profile: profile,
                  index: widget.index),
            ),
          ];
        },
        body: Column(
          children: [
            Expanded(
              child: ListView(
                physics: ScrollPhysics(),
                children: <Widget>[
                  userMedicalTagList.length != 0
                      ? Padding(
                          padding: EdgeInsets.only(left: 24.0, top: 0),
                          child: MyText(
                              value: "editprofil_medical_subtitle_medicaltags"
                                  .tr(),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.pinkColor))
                      : Container(),

                  userMedicalTagList.length != 0
                      ? Container(
                          height: 140,
                          // color: Colors.white,
                          width: double.maxFinite,
                          child: ListView.builder(
                              shrinkWrap: true,
                              controller: _userScrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: userMedicalTagList.length,
                              itemBuilder: (BuildContext context, int index) {
                                _petItemWidth = screenWidth * 0.32;

                                return Container(
                                  height: 120,
                                  width: 100,
                                  margin: EdgeInsets.only(
                                      left: 25, top: 15, bottom: 10),
                                  decoration: BoxDecoration(
                                      color: ColorConstant.lightGrey,
                                      borderRadius: BorderRadius.circular(8.0),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.black26,
                                          offset: Offset(0.0, 2.0),
                                          blurRadius: 5.0,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 14,
                                        bottom: 0,
                                        right: 14.7,
                                        left: 15),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          height: 70,
                                          width: 70,
                                          decoration: BoxDecoration(
                                            color: ColorConstant
                                                .imgBackgroundColor,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 2,
                                                offset: Offset(0, 0),
                                              ),
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6)),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                userMedicalTagList[index]
                                                        .tagInfo
                                                        .pictureUrl ??
                                                    "https://ws.interface-crm.com:445/documents/found_me_doc/3b712de48137572f3849aabd5666a4e3/de20e7222dadb5e8b9e8c06ef9cf3c99b1a55c369d10f213384a9c32e3589833.jpg",
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Flexible(
                                          child: MyText(
                                            value: userMedicalTagList[index]
                                                    .tagInfo
                                                    .tagLabel ??
                                                " ",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            color: ColorConstant.pinkColor,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Flexible(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              MyText(
                                                  value:
                                                      'pets_label_code'.tr() +
                                                          ':',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: ColorConstant.darkGray,
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.w400),
                                              MyText(
                                                  value:
                                                      userMedicalTagList[index]
                                                          .tagInfo
                                                          .serialNumber,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: ColorConstant.darkGray,
                                                  fontSize: 8,
                                                  textAlign: TextAlign.center,
                                                  fontWeight: FontWeight.w400),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Container(),

                  userMedicalTagList.length < 3
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                              (userMedicalTagList.length / 3).round(),
                              (int index) {
                            return Container(
                              width: 8.0,
                              height: 8.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _medicalIndicatorIndex == index
                                    ? ColorConstant.activeIndicatorColor
                                    : ColorConstant.indicatorColor,
                              ),
                            );
                          }).toList(),
                        ),

// user information ///

                  Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 4.064) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    child: MyText(
                      value: "editprofil_general_label_myinfo".tr(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: ColorConstant.pinkColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: screenHeight * 0.005,
                      right: screenWidth * 0.0627,
                      left: screenWidth * 0.0627,
                    ),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: MyText(
                              value: "pets_label_name".tr() + " :",
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Flexible(
                            child: viewFisrtName(
                                profile.userGeneralInfo.subUsers[widget.index]
                                    .userGeneralInfo.firstName,
                                profile.userGeneralInfo.subUsers[widget.index]
                                    .userGeneralInfo.lastName)),
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.005,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627,
                      ),
                      child: profile.userGeneralInfo.subUsers[widget.index]
                                  .userGeneralInfo.role ==
                              4
                          ? Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                    value: "editprofil_general_subtitle_email"
                                            .tr() +
                                        " :",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Flexible(
                                  child: MyText(
                                    value: profile.userGeneralInfo.mail ?? '',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                    value: "editprofil_general_subtitle_email"
                                            .tr() +
                                        " :",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Flexible(
                                  child: MyText(
                                    value: profile
                                            .userGeneralInfo
                                            .subUsers[widget.index]
                                            .userGeneralInfo
                                            .mail ??
                                        '',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            )),
                  Container(
                    margin: EdgeInsets.only(
                      top: screenHeight * 0.005,
                      right: screenWidth * 0.0627,
                      left: screenWidth * 0.0627,
                    ),
                    child: profile.userGeneralInfo.subUsers[widget.index]
                                .userGeneralInfo.role ==
                            4
                        ? profile.userGeneralInfo.tel != null
                            ? Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: MyText(
                                        value:
                                            "editprofil_label_tel".tr() + " :",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: MyText(
                                      value: profile.userGeneralInfo.tel,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            : Container()
                        : profile.userGeneralInfo.subUsers[widget.index]
                                    .userGeneralInfo.tel !=
                                null
                            ? Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: MyText(
                                        value:
                                            "editprofil_label_tel".tr() + " :",
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: MyText(
                                      value: profile
                                          .userGeneralInfo
                                          .subUsers[widget.index]
                                          .userGeneralInfo
                                          .tel,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                  ),
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .idGender !=
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                            top: screenHeight * 0.005,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627,
                          ),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                    value: "pets_label_sex".tr() + " :",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: MyText(
                                  value: profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .idGender !=
                                          null
                                      ? profile.parameters.genderList[profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .idGender -
                                          1]['gendre_label']
                                      : '',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ))
                      : Container(),
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .heightweight.heightCm !=
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                            top: screenHeight * 0.005,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627,
                          ),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: MyText(
                                  value: "pets_label_height".tr() + " :",
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                              Flexible(
                                child: MyText(
                                  value: profile
                                          .userGeneralInfo
                                          .subUsers[widget.index]
                                          .medicalRecord
                                          .heightweight
                                          .heightCm
                                          .toString() +
                                      ' ' +
                                      "pets_label_cm".tr(),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ))
                      : Container(),
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .heightweight.weightKg !=
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                            top: screenHeight * 0.005,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627,
                          ),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                  child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: MyText(
                                  value: "pets_label_weight".tr() + " :",
                                  fontWeight: FontWeight.w700,
                                ),
                              )),
                              Flexible(
                                child: MyText(
                                  value: profile
                                          .userGeneralInfo
                                          .subUsers[widget.index]
                                          .medicalRecord
                                          .heightweight
                                          .weightKg
                                          .toString() +
                                      ' ' +
                                      "pets_label_kg".tr(),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ))
                      : Container(),
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .idEyeColor !=
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                            top: screenHeight * 0.005,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627,
                          ),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                    value:
                                        "editprofil_medical_subtitle_eyecolor"
                                                .tr() +
                                            " :",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: MyText(
                                  value: profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .idEyeColor !=
                                          null
                                      ? profile.parameters.eyeColorList[profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .idEyeColor -
                                          1]['eye_color_label']
                                      : '',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ))
                      : Container(),
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .spokenLanguages !=
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                            top: screenHeight * 0.005,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627,
                          ),
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: RichText(
                                textScaleFactor: 1.0,
                                text: TextSpan(
                                    text: 'editprofil_medical_subtitle_speaks'
                                            .tr() +
                                        ' :',
                                    style: TextStyle(
                                        fontFamily: 'SFProText',
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700,
                                        color: ColorConstant.textColor),
                                    children: [
                                      TextSpan(
                                          text: profile
                                              .userGeneralInfo
                                              .subUsers[widget.index]
                                              .medicalRecord
                                              .spokenLanguages
                                              .toString(),
                                          style: TextStyle(
                                              fontFamily: 'SFProText',
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w400,
                                              color: ColorConstant.textColor))
                                    ]),
                              )))
                      : Container(),

                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .distitnctSign !=
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                            top: screenHeight * 0.005,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627,
                          ),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                    value: "editprofil_medical_subtitle_signs"
                                            .tr() +
                                        " :",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: MyText(
                                  value: profile
                                          .userGeneralInfo
                                          .subUsers[widget.index]
                                          .medicalRecord
                                          .distitnctSign ??
                                      '',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ))
                      : Container(),
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .petAtHome !=
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                            top: screenHeight * 0.005,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627,
                          ),
                          child: Row(
                            children: <Widget>[
                              Flexible(
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                    value:
                                        "editprofil_medical_subtitle_pet".tr() +
                                            " :",
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: MyText(
                                  value: profile
                                          .userGeneralInfo
                                          .subUsers[widget.index]
                                          .medicalRecord
                                          .petAtHome ??
                                      '',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ))
                      : SizedBox(),
//            Contact Setting

                  listActive.length > 0
                      ? Container(
                          margin: EdgeInsets.only(
                            top: (screenHeight * 4.064) / 100,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627,
                          ),
                          child: MyText(
                              value: "objecttag_bloctitle_contact".tr(),
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.pinkColor,
                              fontSize: 18),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 8,
                  ),
                  listActive.length > 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listActive.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(
                                right: screenWidth * 0.0627,
                                left: screenWidth * 0.0627,
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 2.0,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: ColorConstant.pinkColor,
                                    ),
                                  ),
                                  MyText(
                                    value: listActive[index]['acces_label_txt'],
                                    fontWeight: FontWeight.w700,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Container(),

// Contact emergency ////
                  listActiveContacts.length != 0 ||
                          listActivePhysicienContacts.length != 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 4.064) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: MyText(
                            value: "editprofil_medical_subtitle_contact".tr(),
                            fontSize: 18.0,
                            color: ColorConstant.pinkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : SizedBox(),
                  SizedBox(
                    height: 8,
                  ),
                  listActiveContacts.length != 0
                      ? Container(
                          margin: EdgeInsets.only(
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: custom.ExpansionTile(
                            headerMinHeight: 0,
                            title: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: MyText(
                                  value:
                                      "editprofil_medical_subtitle_personalcontact"
                                          .tr(),
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstant.textColor),
                            ),
                            trailing: Container(),
                            leading: Icon(
                              Icons.check,
                              color: ColorConstant.pinkColor,
                            ),
                            children: <Widget>[
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: listActiveContacts.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Container(
                                        width: screenWidth,
                                        margin: EdgeInsets.only(
                                          left: (screenWidth * 14) / 100,
                                          top: screenHeight * 0.0123,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            MyText(
                                              value: listActiveContacts[index]
                                                      ['first_name'] +
                                                  ' ' +
                                                  listActiveContacts[index]
                                                      ['last_name'],
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstant.textColor,
                                            ),
                                            listActiveContacts[index]
                                                            ['mobile'] !=
                                                        null &&
                                                    listActiveContacts[index]
                                                            ['mobile'] !=
                                                        ''
                                                ? MyText(
                                                    value: listActiveContacts[
                                                        index]['mobile'],
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        ColorConstant.textColor,
                                                  )
                                                : SizedBox(),
                                            MyText(
                                              value: listActiveContacts[index]
                                                  ['mail'],
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstant.textColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(),
                  listActivePhysicienContacts.length != 0
                      ? Container(
                          margin: EdgeInsets.only(
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: custom.ExpansionTile(
                              headerMinHeight: 0,
                              title: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12.0),
                                child: MyText(
                                    value:
                                        "editprofil_medical_subtitle_physiciancontact"
                                            .tr(),
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.textColor),
                              ),
                              trailing: Container(),
                              leading: Icon(
                                Icons.check,
                                color: ColorConstant.pinkColor,
                              ),
                              children: <Widget>[
                                ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: listActivePhysicienContacts.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      width: screenWidth,
                                      margin: EdgeInsets.only(
                                        left: (screenWidth * 14) / 100,
                                        top: screenHeight * 0.0123,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          MyText(
                                            value: listActivePhysicienContacts[
                                                    index]['first_name'] +
                                                ' ' +
                                                listActivePhysicienContacts[
                                                    index]['last_name'],
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.textColor,
                                          ),
                                          listActivePhysicienContacts[index]
                                                          ['mobile'] ==
                                                      null ||
                                                  listActivePhysicienContacts[
                                                          index]['mobile'] ==
                                                      ''
                                              ? SizedBox()
                                              : MyText(
                                                  value:
                                                      listActivePhysicienContacts[
                                                          index]['mobile'],
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ColorConstant.textColor,
                                                ),
                                          MyText(
                                            value: listActivePhysicienContacts[
                                                index]['mail'],
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.textColor,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ]),
                        )
                      : Container(),
//            Medical Information
                  (userMedicalDiseacesInfectionDisaces.length == 0 &&
                          userMedicalDiseacesAllergies.length == 0 &&
                          userMedicalDiseacesImplants.length == 0 &&
                          userMedicalDiseacesImplants.length == 0 &&
                          userMedicalDiseacesRenal.length == 0 &&
                          userMedicalDiseacesCardiac.length == 0 &&
                          userMedicalDiseacesPsychiatric.length == 0 &&
                          userMedicalDiseacesNeurologic.length == 0 &&
                          userMedicalDiseacesPlumonary.length == 0 &&
                          userMedicalDiseacesMedication.length == 0 &&
                          userMedicalDiseacesCancer.length == 0)
                      ? SizedBox()
                      : Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 4.064) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: MyText(
                              value: "editprofil_medical_bloctitle_medicalinfor"
                                  .tr(),
                              fontSize: 18.0,
                              color: ColorConstant.pinkColor,
                              fontWeight: FontWeight.w600),
                        ),

                  Container(
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.005,
                        right: screenWidth * 0.0927,
                        left: screenWidth * 0.0927,
                      ),
                      child: Column(
                        children: [
                          userMedicalDiseacesInfectionDisaces.length != 0
                              ? Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: infectiousdiseases(profile),
                                    ),
                                  ],
                                )
                              : Container(),
                          userMedicalDiseacesAllergies.length != 0
                              ? Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: _Allergies(profile),
                                    ),
                                  ],
                                )
                              : Container(),
                          userMedicalDiseacesImplants.length != 0
                              ? Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: implants(profile),
                                    ),
                                  ],
                                )
                              : Container(),
                          userMedicalDiseacesRenal.length != 0
                              ? Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: _RenalKidney(profile),
                                    ),
                                  ],
                                )
                              : Container(),
                          userMedicalDiseacesCardiac.length != 0
                              ? Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: _cardiac(profile),
                                    ),
                                  ],
                                )
                              : Container(),
                          userMedicalDiseacesPsychiatric.length != 0
                              ? Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: psychiatric(profile),
                                    ),
                                  ],
                                )
                              : Container(),
                          userMedicalDiseacesNeurologic.length != 0
                              ? Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: _Neurologic(profile),
                                    ),
                                  ],
                                )
                              : Container(),
                          userMedicalDiseacesPlumonary.length != 0
                              ? Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: pulmonary(profile),
                                    ),
                                  ],
                                )
                              : Container(),
                          userMedicalDiseacesMedication.length != 0
                              ? Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: _Medication(profile),
                                    ),
                                  ],
                                )
                              : Container(),
                          userMedicalDiseacesCancer.length != 0
                              ? Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: cancer(profile),
                                    ),
                                  ],
                                )
                              : Container(),
                        ],
                      )),

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: documents.length,
                    itemBuilder: (BuildContext context, int index) {
                      bool _isXRay =
                          documents[index].public == 1 ? true : false;
                      return Container(
                        margin: EdgeInsets.only(
                          top: screenHeight * 0.005,
                          right: screenWidth * 0.0627,
                          left: screenWidth * 0.1627,
                        ),
                        child: AttachmentSelection(
                          title: documents[index].labelDoc,
                          isSelected: _isXRay,
                          onPressed: () {
                            setState(() {
                              _isXRay = !_isXRay;
                            });
                          },
                        ),
                      );
                    },
                  ),

                  Container(
                    margin: EdgeInsets.only(
                      top: (screenHeight * 4.064) / 100,
                      right: screenWidth * 0.0627,
                      left: screenWidth * 0.0627,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: MyText(
                                value: "objecttag_bloctitle_exportmedical".tr(),
                                fontSize: 18.0,
                                color: ColorConstant.pinkColor,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: (screenWidth * 27) / 100),
                            child: Image.asset(
                              "Assets/Images/info.png",
                              height: 14,
                              width: 14,
                            ),
                          )
                        ]),
                  ),
                  objectRecordWidget(),

                  Container(
                    margin: EdgeInsets.only(
                      top: (screenHeight * 4.064) / 100,
                      right: screenWidth * 0.0627,
                      left: screenWidth * 0.0627,
                    ),
                    child: Divider(color: ColorConstant.lightGreyTextColor),
                  ),
//            Information not supplied
                  Container(
                    margin: EdgeInsets.only(
                      top: (screenHeight * 4.064) / 100,
                      right: screenWidth * 0.0627,
                      left: screenWidth * 0.0627,
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: MyText(
                                value: "pets_label_informationns".tr(),
                                fontSize: 18.0,
                                color: ColorConstant.pinkColor,
                                fontWeight: FontWeight.w600),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                right: (screenWidth * 27) / 100),
                            child: Image.asset(
                              "Assets/Images/info.png",
                              height: 14,
                              width: 14,
                            ),
                          )
                        ]),
                  ),

// My info

                  userMedicalTagList.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 4.064) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: MyText(
                              value: "editprofil_medical_subtitle_medicaltags"
                                  .tr(),
                              fontSize: 18.0,
                              color: ColorConstant.pinkColor,
                              fontWeight: FontWeight.w600),
                        )
                      : Container(),

                  (profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                                  .maritalStatus ==
                              null &&
                          profile.userGeneralInfo.subUsers[widget.index]
                                  .userGeneralInfo.tel ==
                              null &&
                          profile.userGeneralInfo.subUsers[widget.index]
                                  .medicalRecord.idGender ==
                              null &&
                          profile.userGeneralInfo.subUsers[widget.index]
                                  .medicalRecord.idGender ==
                              null &&
                          profile.userGeneralInfo.subUsers[widget.index]
                                  .medicalRecord.heightweight.heightCm ==
                              null &&
                          profile.userGeneralInfo.subUsers[widget.index]
                                  .medicalRecord.heightweight.weightKg ==
                              null &&
                          profile.userGeneralInfo.subUsers[widget.index]
                                  .medicalRecord.idEyeColor ==
                              null &&
                          profile.userGeneralInfo.subUsers[widget.index]
                                  .medicalRecord.spokenLanguages ==
                              null &&
                          profile.userGeneralInfo.subUsers[widget.index]
                                  .medicalRecord.distitnctSign ==
                              null &&
                          profile.userGeneralInfo.subUsers[widget.index]
                                  .medicalRecord.petAtHome ==
                              null)
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 4.064) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: MyText(
                              value: "editprofil_general_label_myinfo".tr(),
                              fontSize: 18.0,
                              color: ColorConstant.pinkColor,
                              fontWeight: FontWeight.w600),
                        )
                      : SizedBox(),
                  Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 1.23) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    child: Row(children: [
                      Icon(
                        Icons.clear,
                        color: ColorConstant.lightGreyTextColor,
                        size: 18,
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      MyText(
                          value: "editprofil_medical_subtitle_status".tr(),
                          fontSize: 14.0,
                          color: ColorConstant.lightGreyTextColor,
                          fontWeight: FontWeight.w600),
                    ]),
                  ),
                  profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
                              .tel ==
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                                value: "editprofil_label_tel".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),

                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .idGender ==
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                                value: "pets_label_sex".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),

                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .heightweight.heightCm ==
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                                value: "pets_label_height".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),

                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .heightweight.weightKg ==
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                                value: "pets_label_weight".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),

                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .idEyeColor ==
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                                value:
                                    "editprofil_medical_subtitle_eyecolor".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),

                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .spokenLanguages ==
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                                value:
                                    "editprofil_medical_subtitle_speaks".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),

                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .distitnctSign ==
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                                value: "editprofil_medical_subtitle_signs".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),
                  profile.userGeneralInfo.subUsers[widget.index].medicalRecord
                              .petAtHome ==
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                                value: "editprofil_medical_subtitle_pet".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),
//            Contact Settings
                  listInactive.length != 0
                      ? Container(
                          margin: EdgeInsets.only(
                            top: (screenHeight * 4.064) / 100,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627,
                          ),
                          child: MyText(
                            value: "objecttag_bloctitle_contact".tr(),
                            fontSize: 18.0,
                            color: ColorConstant.pinkColor,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      : SizedBox(),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: listInactive.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(
                          top: (screenHeight * 1.23) / 100,
                          right: screenWidth * 0.0627,
                          left: screenWidth * 0.0627,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                                value: listInactive[index]['acces_label_txt'] ??
                                    ' ',
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ],
                        ),
                      );
                    },
                  ),

//           Emergency contacts
                  (listActiveContacts.length == 0 ||
                          listActivePhysicienContacts.length == 0)
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 4.064) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: MyText(
                              value: "editprofil_medical_subtitle_contact".tr(),
                              fontSize: 18.0,
                              color: ColorConstant.pinkColor,
                              fontWeight: FontWeight.w600),
                        )
                      : SizedBox(),
                  listActiveContacts.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                              value:
                                  "editprofil_medical_subtitle_personalcontact"
                                      .tr(),
                              fontSize: 14.0,
                              color: ColorConstant.lightGreyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ]),
                        )
                      : Container(),
                  listActivePhysicienContacts.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                              value:
                                  "editprofil_medical_subtitle_physiciancontact"
                                      .tr(),
                              fontSize: 14.0,
                              color: ColorConstant.lightGreyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ]),
                        )
                      : Container(),

//             Medical information
                  (userMedicalDiseacesInfectionDisaces.length == 0 &&
                          userMedicalDiseacesAllergies.length == 0 &&
                          userMedicalDiseacesImplants.length == 0 &&
                          userMedicalDiseacesImplants.length == 0 &&
                          userMedicalDiseacesRenal.length == 0 &&
                          userMedicalDiseacesCardiac.length == 0 &&
                          userMedicalDiseacesPsychiatric.length == 0 &&
                          userMedicalDiseacesNeurologic.length == 0 &&
                          userMedicalDiseacesPlumonary.length == 0 &&
                          userMedicalDiseacesMedication.length == 0 &&
                          userMedicalDiseacesCancer.length == 0)
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 4.064) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: MyText(
                              value: "editprofil_medical_bloctitle_medicalinfor"
                                  .tr(),
                              fontSize: 18.0,
                              color: ColorConstant.pinkColor,
                              fontWeight: FontWeight.w600),
                        )
                      : SizedBox(),

                  userMedicalDiseacesInfectionDisaces.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                              value:
                                  "editprofil_medical_subtitle_diseases".tr(),
                              fontSize: 14.0,
                              color: ColorConstant.lightGreyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ]),
                        )
                      : Container(),

                  userMedicalDiseacesAllergies.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                              value:
                                  "editprofil_medical_subtitle_allergies".tr(),
                              fontSize: 14.0,
                              color: ColorConstant.lightGreyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ]),
                        )
                      : Container(),

                  userMedicalDiseacesImplants.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                              value:
                                  "editprofil_medical_subtitle_implants".tr(),
                              fontSize: 14.0,
                              color: ColorConstant.lightGreyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ]),
                        )
                      : Container(),

                  userMedicalDiseacesRenal.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                              value: "editprofil_medical_subtitle_renal".tr(),
                              fontSize: 14.0,
                              color: ColorConstant.lightGreyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ]),
                        )
                      : Container(),

                  userMedicalDiseacesCardiac.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                              value: "editprofil_medical_subtitle_cardiac".tr(),
                              fontSize: 14.0,
                              color: ColorConstant.lightGreyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ]),
                        )
                      : Container(),

                  userMedicalDiseacesPsychiatric.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                              value: "editprofil_medical_subtitle_psychiatric"
                                  .tr(),
                              fontSize: 14.0,
                              color: ColorConstant.lightGreyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ]),
                        )
                      : Container(),

                  userMedicalDiseacesNeurologic.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                              value:
                                  "editprofil_medical_subtitle_neurologic".tr(),
                              fontSize: 14.0,
                              color: ColorConstant.lightGreyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ]),
                        )
                      : Container(),

                  userMedicalDiseacesPlumonary.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                              value:
                                  "editprofil_medical_subtitle_pulmonary".tr(),
                              fontSize: 14.0,
                              color: ColorConstant.lightGreyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ]),
                        )
                      : Container(),

                  userMedicalDiseacesMedication.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                              value:
                                  "editprofil_medical_subtitle_medication".tr(),
                              fontSize: 14.0,
                              color: ColorConstant.lightGreyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ]),
                        )
                      : Container(),

                  userMedicalDiseacesCancer.length == 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 1.23) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(children: [
                            Icon(
                              Icons.clear,
                              color: ColorConstant.lightGreyTextColor,
                              size: 18,
                            ),
                            SizedBox(
                              width: 12.0,
                            ),
                            MyText(
                              value: "editprofil_medical_subtitle_cancer".tr(),
                              fontSize: 14.0,
                              color: ColorConstant.lightGreyTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ]),
                        )
                      : Container(),

                  SizedBox(
                    height: (screenHeight * 8.6) / 100,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, left: 12, right: 12),
              child: MyButton(
                  title: "editprofil_medical_btn_edituser".tr(),
                  height: 46.0,
                  titleSize: 14,
                  cornerRadius: 8,
                  fontWeight: FontWeight.w600,
                  titleColor: Color(0xffEC1C40),
                  btnBgColor: ColorConstant.boxColor,
                  onPressed: () {
                    dispatchGoToEdit(profile, widget.index);
                  }),
            ),
          ],
        ),
      );
    });
  }

  infectiousdiseases(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  _infectiousdiseases = !_infectiousdiseases;
                });
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: ColorConstant.pinkColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_diseases".tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: _infectiousdiseases ||
                                    userMedicalDiseacesInfectionDisaces
                                            .length !=
                                        0
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        _infectiousdiseases
            ? Container(
                padding: EdgeInsets.only(left: 5, top: 0),
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.00,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.30)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userMedicalDiseacesInfectionDisaces.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                              ),
                              SizedBox(width: 30),
                              ExpandableListViewDes(
                                  type: 'infectionDisaces',
                                  profile: profile,
                                  index: index,
                                  diseace: userMedicalDiseacesInfectionDisaces[
                                      index],
                                  title: userMedicalDiseacesInfectionDisaces[
                                          index]
                                      .label,
                                  desc: userMedicalDiseacesInfectionDisaces[
                                          index]
                                      .description,
                                  attachment:
                                      userMedicalDiseacesInfectionDisaces[index]
                                                  .documents
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                  documents:
                                      userMedicalDiseacesInfectionDisaces[index]
                                          .documents,
                                  alarm: userMedicalDiseacesInfectionDisaces[
                                                  index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders:
                                      userMedicalDiseacesInfectionDisaces[index]
                                          .reminders,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: true),
                              SizedBox(
                                width: 12,
                              ),
                            ]);
                          },
                        ),
                        SizedBox(
                          height: 16.5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _Allergies(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  _allergies = !_allergies;
                });
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: ColorConstant.pinkColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_allergies".tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: ColorConstant.textColor),
                      ),
                    ),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        _allergies
            ? Container(
                padding: EdgeInsets.only(left: 5, top: 0),
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.45,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.00)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userMedicalDiseacesAllergies.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                              ),
                              SizedBox(width: 30),
                              userMedicalDiseacesAllergies[index].label != ''
                                  ? ExpandableListViewDes(
                                      type: 'allergies',
                                      profile: profile,
                                      index: index,
                                      diseace: userMedicalDiseacesAllergies[
                                          index],
                                      title: userMedicalDiseacesAllergies[index]
                                          .label,
                                      desc: userMedicalDiseacesAllergies[index]
                                          .description,
                                      attachment: userMedicalDiseacesAllergies[
                                                      index]
                                                  .documents
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                      documents: userMedicalDiseacesAllergies[
                                              index]
                                          .documents,
                                      alarm: userMedicalDiseacesAllergies[index]
                                                  .reminders
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                      reminders:
                                          userMedicalDiseacesAllergies[index]
                                              .reminders,
                                      // text: bloodController,
                                      switchValue: true,
                                      dropdownValue: true,
                                      visibile: true)
                                  : Container(),
                              SizedBox(
                                width: 12,
                              ),
                            ]);
                          },
                        ),
                        SizedBox(
                          height: 16.5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _Dnr() {
    return Column(
      children: <Widget>[
        Container(
          height: 49,
          padding: EdgeInsets.only(
            left: 10,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: Colors.black26,
                  offset: Offset(1.0, 3.0),
                  //  spreadRadius: 7.0,
                  blurRadius: 3.0,
                ),
              ],
              color: _dnr ? ColorConstant.pinkColor : ColorConstant.boxColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  bottomLeft: Radius.circular(_dnr ? 0 : 5.0),
                  topRight: Radius.circular(5.0),
                  bottomRight: Radius.circular(5.0))),
          child: InkWell(
              onTap: () {
                setState(() {
                  _dnr = !_dnr;
                });
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                    color: ColorConstant.boxColor,
                    border: Border.all(width: 0, color: ColorConstant.boxColor),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(_dnr ? 0 : 5.0))),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.only(left: 11),
                      child: MyText(
                          value: "editprofil_label_donotrecusitate".tr(),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: _dnr
                              ? ColorConstant.textColor
                              : ColorConstant.darkGray),
                    )),
                    _dnr
                        ? Image.asset(
                            "Assets/Images/arrow-up.png",
                            height: 8,
                            width: 13.18,
                          )
                        : Container(),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        _dnr
            ? Container(
                padding: EdgeInsets.only(left: 10, top: 0),
                decoration: BoxDecoration(
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black26,
                        offset: Offset(1.0, 3.0),
                        //  spreadRadius: 7.0,
                        blurRadius: 3.0,
                      ),
                    ],
                    color: ColorConstant.pinkColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0))),
                child: Container(
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 0, color: ColorConstant.boxColor),
                      color: ColorConstant.boxColor,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(5))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            height: 0.45, color: ColorConstant.dividerColor),
                        Container(
                            height: 0.45,
                            color: ColorConstant.dividerColor.withOpacity(.30)),
                        SizedBox(
                          height: 16.5,
                        ),
                        Container(
                            height: 0.45,
                            color: ColorConstant.dividerColor.withOpacity(.30)),
                        SizedBox(
                          height: 16.5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  implants(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  _implants = !_implants;
                });
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: ColorConstant.pinkColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_implants".tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: _implants ||
                                    userMedicalDiseacesImplants.length != 0
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        _implants
            ? Container(
                padding: EdgeInsets.only(left: 10, top: 0),
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.45,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.00)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userMedicalDiseacesImplants.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                              ),
                              SizedBox(width: 30),
                              ExpandableListViewDes(
                                  profile: profile,
                                  index: index,
                                  type: 'Implants',
                                  diseace: userMedicalDiseacesImplants[index],
                                  title:
                                      userMedicalDiseacesImplants[index].label,
                                  desc: userMedicalDiseacesImplants[index]
                                      .description,
                                  attachment: userMedicalDiseacesImplants[index]
                                              .documents
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  documents: userMedicalDiseacesImplants[index]
                                      .documents,
                                  alarm: userMedicalDiseacesImplants[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders: userMedicalDiseacesImplants[index]
                                      .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: true),
                              SizedBox(
                                width: 12,
                              ),
                            ]);
                          },
                        ),
                        SizedBox(
                          height: 16.5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _RenalKidney(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  _renalKidney = !_renalKidney;
                });
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: ColorConstant.pinkColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_renal".tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: _renalKidney ||
                                    userMedicalDiseacesRenal.length != 0
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        _renalKidney
            ? Container(
                padding: EdgeInsets.only(left: 5, top: 0),
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.00,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.00)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userMedicalDiseacesRenal.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                              ),
                              SizedBox(width: 30),
                              ExpandableListViewDes(
                                  profile: profile,
                                  index: index,
                                  type: 'renalKenedy',
                                  diseace: userMedicalDiseacesRenal[index],
                                  title: userMedicalDiseacesRenal[index].label,
                                  desc: userMedicalDiseacesRenal[index]
                                      .description,
                                  attachment: userMedicalDiseacesRenal[index]
                                              .documents
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  documents:
                                      userMedicalDiseacesRenal[index].documents,
                                  alarm: userMedicalDiseacesRenal[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders:
                                      userMedicalDiseacesRenal[index].reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: true),
                              SizedBox(
                                width: 12,
                              ),
                            ]);
                          },
                        ),
                        SizedBox(
                          height: 16.5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _cardiac(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  cardiac = !cardiac;
                });
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: ColorConstant.pinkColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_cardiac".tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: cardiac ||
                                    userMedicalDiseacesCardiac.length != 0
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        cardiac
            ? Container(
                padding: EdgeInsets.only(left: 5, top: 0),
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.00,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.00)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userMedicalDiseacesCardiac.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                              ),
                              SizedBox(width: 30),
                              ExpandableListViewDes(
                                  profile: profile,
                                  index: index,
                                  type: 'cardiac',
                                  diseace: userMedicalDiseacesCardiac[index],
                                  title:
                                      userMedicalDiseacesCardiac[index].label,
                                  desc: userMedicalDiseacesCardiac[index]
                                      .description,
                                  attachment: userMedicalDiseacesCardiac[index]
                                              .documents
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  documents: userMedicalDiseacesCardiac[index]
                                      .documents,
                                  alarm: userMedicalDiseacesCardiac[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders: userMedicalDiseacesCardiac[index]
                                      .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: true),
                              SizedBox(
                                width: 12,
                              ),
                            ]);
                          },
                        ),
                        SizedBox(
                          height: 16.5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  psychiatric(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  _psychiatric = !_psychiatric;
                });
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: ColorConstant.pinkColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                          value: "editprofil_medical_subtitle_psychiatric".tr(),
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          color: _psychiatric ||
                                  userMedicalDiseacesPsychiatric.length != 0
                              ? ColorConstant.textColor
                              : ColorConstant.darkGray,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        _psychiatric
            ? Container(
                padding: EdgeInsets.only(left: 5, top: 0),
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.00,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.00)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userMedicalDiseacesPsychiatric.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                              ),
                              SizedBox(width: 30),
                              ExpandableListViewDes(
                                  profile: profile,
                                  index: index,
                                  type: 'psychiatric',
                                  diseace:
                                      userMedicalDiseacesPsychiatric[index],
                                  title:
                                      userMedicalDiseacesPsychiatric[index]
                                          .label,
                                  desc:
                                      userMedicalDiseacesPsychiatric[index]
                                          .description,
                                  attachment:
                                      userMedicalDiseacesPsychiatric[index]
                                                  .documents
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                  documents:
                                      userMedicalDiseacesPsychiatric[
                                              index]
                                          .documents,
                                  alarm: userMedicalDiseacesPsychiatric[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders:
                                      userMedicalDiseacesPsychiatric[index]
                                          .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: true),
                              SizedBox(
                                width: 12,
                              ),
                            ]);
                          },
                        ),
                        SizedBox(
                          height: 16.5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _Neurologic(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  _neurologic = !_neurologic;
                });
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: ColorConstant.pinkColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value:
                                "editprofil_medical_subtitle_neurologic".tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: _neurologic ||
                                    userMedicalDiseacesNeurologic.length != 0
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        _neurologic
            ? Container(
                padding: EdgeInsets.only(left: 5, top: 0),
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.00,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.00)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userMedicalDiseacesNeurologic.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                              ),
                              SizedBox(width: 30),
                              ExpandableListViewDes(
                                  profile: profile,
                                  index: index,
                                  type: 'neuroligic',
                                  diseace: userMedicalDiseacesNeurologic[index],
                                  title: userMedicalDiseacesNeurologic[index]
                                      .label,
                                  desc: userMedicalDiseacesNeurologic[index]
                                      .description,
                                  attachment:
                                      userMedicalDiseacesNeurologic[index]
                                                  .documents
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                  documents:
                                      userMedicalDiseacesNeurologic[index]
                                          .documents,
                                  alarm: userMedicalDiseacesNeurologic[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders:
                                      userMedicalDiseacesNeurologic[index]
                                          .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: true),
                              SizedBox(
                                width: 12,
                              ),
                            ]);
                          },
                        ),
                        SizedBox(
                          height: 16.5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  pulmonary(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  _pulmonary = !_pulmonary;
                });
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: ColorConstant.pinkColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_pulmonary".tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: _pulmonary ||
                                    userMedicalDiseacesPlumonary.length != 0
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        _pulmonary
            ? Container(
                padding: EdgeInsets.only(left: 5, top: 0),
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.00,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.00)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userMedicalDiseacesPlumonary.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                              ),
                              SizedBox(width: 30),
                              ExpandableListViewDes(
                                  profile: profile,
                                  index: index,
                                  type: 'plumonary',
                                  diseace: userMedicalDiseacesPlumonary[index],
                                  title:
                                      userMedicalDiseacesPlumonary[index].label,
                                  desc: userMedicalDiseacesPlumonary[index]
                                      .description,
                                  attachment:
                                      userMedicalDiseacesPlumonary[index]
                                                  .documents
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                  documents: userMedicalDiseacesPlumonary[index]
                                      .documents,
                                  alarm: userMedicalDiseacesPlumonary[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders: userMedicalDiseacesPlumonary[index]
                                      .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: true),
                              SizedBox(
                                width: 12,
                              ),
                            ]);
                          },
                        ),
                        SizedBox(
                          height: 16.5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  _Medication(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  _medication = !_medication;
                });
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: ColorConstant.pinkColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value:
                                "editprofil_medical_subtitle_medication".tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: _medication ||
                                    userMedicalDiseacesMedication.length != 0
                                ? ColorConstant.textColor
                                : ColorConstant.darkGray),
                      ),
                    ),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        _medication
            ? Container(
                padding: EdgeInsets.only(left: 5, top: 0),
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.0,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.00)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userMedicalDiseacesMedication.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                              ),
                              SizedBox(width: 30),
                              ExpandableListViewDes(
                                  profile: profile,
                                  index: index,
                                  type: 'medication',
                                  diseace: userMedicalDiseacesMedication[index],
                                  title: userMedicalDiseacesMedication[index]
                                      .label,
                                  desc: userMedicalDiseacesMedication[index]
                                      .description,
                                  attachment:
                                      userMedicalDiseacesMedication[index]
                                                  .documents
                                                  .length ==
                                              0
                                          ? false
                                          : true,
                                  documents:
                                      userMedicalDiseacesMedication[index]
                                          .documents,
                                  alarm: userMedicalDiseacesMedication[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders:
                                      userMedicalDiseacesMedication[index]
                                          .reminders,
                                  // text: bloodController,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: true),
                              SizedBox(
                                width: 12,
                              ),
                            ]);
                          },
                        ),
                        SizedBox(
                          height: 16.5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  cancer(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          child: InkWell(
              onTap: () {
                setState(() {
                  _cancer = !_cancer;
                });
              },
              child: Container(
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.check,
                      color: ColorConstant.pinkColor,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: MyText(
                            value: "editprofil_medical_subtitle_cancer".tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color:
                                _cancer || userMedicalDiseacesCancer.length != 0
                                    ? ColorConstant.textColor
                                    : ColorConstant.darkGray),
                      ),
                    ),
                    SizedBox(
                      width: 22.2,
                    )
                  ],
                ),
              )),
        ),
        _cancer
            ? Container(
                padding: EdgeInsets.only(left: 5, top: 0),
                child: Container(
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10.5, right: 20.5, bottom: 17),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        ListView.separated(
                          separatorBuilder: (BuildContext context, int index) =>
                              Container(
                                  height: 0.45,
                                  color: ColorConstant.dividerColor
                                      .withOpacity(.00)),
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: userMedicalDiseacesCancer.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                              ),
                              SizedBox(width: 30),
                              ExpandableListViewDes(
                                  profile: profile,
                                  index: index,
                                  type: 'cancer',
                                  diseace: userMedicalDiseacesCancer[index],
                                  title: userMedicalDiseacesCancer[index].label,
                                  desc: userMedicalDiseacesCancer[index]
                                      .description,
                                  attachment: userMedicalDiseacesCancer[index]
                                              .documents
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  documents: userMedicalDiseacesCancer[index]
                                      .documents,
                                  alarm: userMedicalDiseacesCancer[index]
                                              .reminders
                                              .length ==
                                          0
                                      ? false
                                      : true,
                                  reminders: userMedicalDiseacesCancer[index]
                                      .reminders,
                                  switchValue: true,
                                  dropdownValue: true,
                                  visibile: true),
                              SizedBox(
                                width: 12,
                              ),
                            ]);
                          },
                        ),
                        SizedBox(
                          height: 16.5,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  objectRecordWidget() {
    return Container(
      margin: EdgeInsets.only(
          top: (screenHeight * 1.85) / 100,
          right: screenWidth * 0.0627,
          left: screenWidth * 0.0627),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _objectRecordPrint = !_objectRecordPrint;
              });
            },
            child: Column(
              children: [
                Container(
                  height: 36,
                  width: (screenWidth * 29.07) / 100,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3,
                        ),
                      ],
                      color: _objectRecordPrint
                          ? ColorConstant.pinkColor
                          : ColorConstant.boxColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  alignment: Alignment.center,
                  child: Image.asset(
                    "Assets/Images/print-red.png",
                    color: _objectRecordPrint
                        ? Colors.white
                        : ColorConstant.pinkColor,
                    height: 21,
                    width: 21,
                  ),
                ),
                SizedBox(
                  height: (screenHeight * 0.74) / 100,
                ),
                MyText(
                    value: "editprofil_general_label_print".tr(),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.textColor),
              ],
            ),
          ),
          SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              setState(() {
                _objectRecordEmail = !_objectRecordEmail;
              });
            },
            child: Column(
              children: [
                Container(
                  height: 36,
                  width: (screenWidth * 29.07) / 100,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3,
                        ),
                      ],
                      color: _objectRecordEmail
                          ? ColorConstant.pinkColor
                          : ColorConstant.boxColor,
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Center(
                    child: Image.asset(
                      "Assets/Images/email-red.png",
                      color: _objectRecordEmail
                          ? Colors.white
                          : ColorConstant.pinkColor,
                      height: 21,
                      width: 24.85,
                    ),
                  ),
                ),
                SizedBox(
                  height: (screenHeight * 0.74) / 100,
                ),
                MyText(
                    value: "editprofil_medical_btn_email".tr(),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.textColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void dispatchGoToHome(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/homeProvider',
      arguments: profile,
    );
  }

  void dispatchGoToHelp(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/helpProvider',
    );
  }

  void dispatchGoToEdit(Profile profile, int index) {
    BlocProvider.of<UsersBloc>(context).dispatch(
      GoToEditProfileSubUserEvent(profile: profile, index: index),
    );
  }
}
