import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/masterTag.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/popupListPet.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/alertDialogAskUser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class SerialNumberToObjectTagDisplay extends StatefulWidget {
  final Profile profile;

  SerialNumberToObjectTagDisplay({Key key, @required this.profile})
      : super(key: key);

  @override
  _SerialNumberToObjectTagDisplayState createState() =>
      _SerialNumberToObjectTagDisplayState();
}

class _SerialNumberToObjectTagDisplayState
    extends State<SerialNumberToObjectTagDisplay> {
  TextEditingController fnamecontroller = new TextEditingController();
  List<Color> _colors = [ColorConstant.pinkColor, ColorConstant.orangeColor];
  List<double> _stops = [0.0, 1.5];
  var screenWidth, screenHeight;
  List<Tags> tags = [];

  String serialNumber;
  Map<String, String> mapSerial = {};
  List<Map<String, String>> serialNumbers = [];
  String qrCodeResult;
  List<String> serialNumb = [];
  int camera = -1;
  bool backCamera = true;
  String message;
  static showOverlay(
      BuildContext context, String headerMessage, String message) async {
    await Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  static showOverlayChoosePet(BuildContext context, String headerMessage,
      String message, Profile profile, PetTag petTag, Tags tag) async {
    await Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  static showOverlayListPet(BuildContext context, Profile profile) {
    Navigator.of(context).push(ChoosePet(profile));
  }

  static showOverlayAskUser(BuildContext context, String headerMessage,
      String message, Profile profile) {
    Navigator.of(context)
        .push(AlertDialogueAskUser(headerMessage, message, profile));
  }

  static masterOverlay(BuildContext context, Profile profile) {
    Navigator.of(context).push(MasterOverlay(profile));
  }

  @override
  void initState() {
    super.initState();
    if (widget.profile.userGeneralInfo.message == 'shoose pet') {
      Future.delayed(
          Duration.zero, () => showOverlayListPet(context, widget.profile));
    }
    if (widget.profile.userGeneralInfo.message ==
        'You wont to activate your master code and all the codes associated with it ?') {
      message = "objecttag_btn_message".tr();

      Future.delayed(
          Duration.zero,
          () => showOverlayAskUser(
              context, "problem_infos".tr(), message, widget.profile));
    }
    if (widget.profile.userGeneralInfo.message == 'MasterTag') {
      Future.delayed(
        Duration.zero,
        () => masterOverlay(context, widget.profile),
      );
    }
    if (widget.profile.userGeneralInfo.message != null &&
        widget.profile.userGeneralInfo.message != 'null' &&
        widget.profile.userGeneralInfo.message != '' &&
        widget.profile.userGeneralInfo.message != 'shoose pet' &&
        widget.profile.userGeneralInfo.message != 'MasterTag' &&
        widget.profile.userGeneralInfo.message != 'Success' &&
        widget.profile.userGeneralInfo.message !=
            'You wont to activate your master code and all the codes associated with it ?') {
      message = widget.profile.userGeneralInfo.message;
      Future.delayed(
        Duration.zero,
        () => showOverlay(context, "problem_infos".tr(), message),
      );
    }
    tag();
  }

  tag() {
    setState(() {
      widget.profile.userGeneralInfo.tagsList.objectTag.forEach((element) {
        element.tags.forEach((element2) {
          if (element2.tagInfo.active == 1) {
            serialNumb.add(element2.tagInfo.serialNumber);
            // mapSerial.addAll(
            //     {'Serial': element2.tagInfo.serialNumber, 'type': 'object'});
            // serialNumbers.add(mapSerial);
            serialNumbers.add(
                {'Serial': element2.tagInfo.serialNumber, 'type': 'object'});
            tags.add(element2);
          } else {
            serialNumbers.remove(element2.tagInfo.serialNumber);
            tags.remove(element2);
          }
        });
      });

      widget.profile.userGeneralInfo.tagsList.petTag.forEach((element) {
        element.tags.forEach((element2) {
          if (element2.tagInfo.active == 1) {
            serialNumb.add(element2.tagInfo.serialNumber);

            serialNumbers
                .add({'Serial': element2.tagInfo.serialNumber, 'type': 'pet'});
          } else {
            serialNumbers.remove(element2.tagInfo.serialNumber);
          }
        });
      });
      widget.profile.userGeneralInfo.tagsList.medicalTag.forEach((element) {
        element.tags.forEach((element2) {
          if (element2.tagInfo.active == 1) {
            serialNumb.add(element2.tagInfo.serialNumber);

            serialNumbers.add(
                {'Serial': element2.tagInfo.serialNumber, 'type': 'medical'});
          } else {
            serialNumbers.remove(element2.tagInfo.serialNumber);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;
    widget.profile.userGeneralInfo.message = null;
    screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;
    return new Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: screenHeight * 100,
                  decoration: BoxDecoration(color: ColorConstant.pinkColor),

                  //child: Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 16,
                      screenHeight * 40, screenWidth * 16, screenHeight * 30),
                  child: 
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                          
                            GestureDetector(
                                onTap: () {
                                  if (profile.userGeneralInfo.duplicate=='yes'){
                                    profile.userGeneralInfo.duplicate=null;
                                  }
                                  dispatchGoToHome(profile);
                                },
                                child: Container(
                                  width: 50,
                                  height: 180,
                                  padding: EdgeInsets.all(10),
                                  child: Image.asset(
                                    "Assets/Images/back.png",
                                    height: screenHeight * 13.5,
                                    width: screenWidth * 20.24,
                                  ),
                                )),
                          
                            MyText(
                                value: "objecttag_btn_addedittag".tr(),
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white)
                       ,
                      GestureDetector(
                        onTap: () {
                          /*     _showOverlay(context); */

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HelpDisplay(profile: profile)),
                          );

                          //  Navigator.of(context).push(MasterOverlay());
                        },
                        child: Image.asset(
                          "Assets/Images/FAQ.png",
                          height: screenHeight * 25,
                          width: screenWidth * 30,
                        ),
                      ),
                    ],

                  ),
                   
                  // ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, screenHeight * 85, 0, 0),
                    child: InkWell(
                        child: Stack(
                          children: [
                            SvgPicture.asset(
                              "Assets/Images/ScButton.svg",
                              color: ColorConstant.pinkColor,
                            ),
                            Positioned(
                              left: 27,
                              top: 27,
                              child: SvgPicture.asset(
                                "Assets/Images/Scanner.svg",
                                //   color: ColorConstant.pinkColor,
                              ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          ScanResult codeSanner = await BarcodeScanner.scan(
                            options: ScanOptions(
                              useCamera: camera,
                            ),
                          );
                          setState(() {
                            qrCodeResult = codeSanner.rawContent;
                            serialNumber = qrCodeResult;
                               if (serialNumber
                                                      .contains('found') ==
                                                  true) {
                                                
                                                              serialNumber=serialNumber.split('/').last;

                              
                            
                                              }
                 
      
      
                            // if (serialNumber.contains('found') == true) {
                            //   serialNumber = serialNumber.substring(20);
                            // }
                            serialNumber != null && serialNumber != ''
                                ? dispatchGoToAddEdit(profile)
                                : null;
                          });
                        })),
                SizedBox(height: screenHeight * 5),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * 0.01),
                    child: Container(
                      child: MyText(
                          value: "pets_label_scan".tr(),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: ColorConstant.pinkColor),
                    )),
                SizedBox(height: screenHeight * 26),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        value: (qrCodeResult == null) || (qrCodeResult == "")
                            ? "pets_label_scanhereaddedit".tr()
                            : "",
                        fontSize: 14,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(width: screenWidth * 16),
                    ],
                  ),
                ),
                SizedBox(height: screenHeight * 190),
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 16, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: MyText(
                        value: 'pets_label_serialnumber'.tr(),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: ColorConstant.pinkColor),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      screenHeight * 20, 0, screenHeight * 20, 0),
                  child: StreamBuilder(builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaleFactor: MediaQuery.of(context)
                                  .textScaleFactor
                                  .clamp(1.0, 1.0),
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              
                              style: TextStyle(
                                  color: Color(0xff231F20),
                                  fontFamily: 'SFProText',
                                  fontWeight: FontWeight.w500),
                              onChanged: (String value) {
                                serialNumber = value;
                              },
                              cursorColor: ColorConstant.pinkColor,
                              decoration: InputDecoration(
                               //  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2.0)),
    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstant.pinkColor,width: 1.0)),
                                //  prefixIcon: Icon(Icons.call),
                                // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                hintText: serialNumber,
                                // hintStyle: TextStyle(fontSize: screenWidth*21)
                              ),
                            )),
                      ],
                    );
                  }),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 16,
                        screenHeight * 15, screenWidth * 16, screenHeight * 20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9.0),
                        color: ColorConstant.pinkColor,
                      ),
                      width: screenWidth * 343.0,
                      height: screenHeight * 64,
                      child: FlatButton(
                        onPressed: () {
                          serialNumber != null && serialNumber != ''
                              ? dispatchGoToAddEdit(profile)
                              : null;
                        },
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(
                              0, screenHeight * 10, 0, screenHeight * 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                MyText(
                                    value: 'pets_label_continue'.tr(),
                                    textAlign: TextAlign.center,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white),
                                SizedBox(width: screenWidth * 88),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                  size: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(width: screenWidth * 12),
                              ]),
                        ),
                        //color: Colors.grey[400],
                      ),
                    )),
              ]),
        ],
      ),
    )); // onPressed: () => _SomeFunction(),
  }

  void _showOverlay(BuildContext context) {
    /*     Navigator.of(context).push(TutorialOverlay()); */
  }

  void dispatchGoToHome(Profile profile) {
    Navigator.of(context)
        .pushReplacementNamed('/homeProvider', arguments: profile);
  }

  dispatchSwitchObjectTag(Profile profile) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      GoToSwitchObjectTagEvent(
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

  dispatchVerifyTag(Profile profile) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      VerifyTagEvent(
        profile: profile,
      ),
    );
  }

  bool exist = false;
  dispatchGoToAddEdit(Profile profile) {
    int index, indexu;
    serialNumbers;
    // print(serialNumbers[0]['serial']);
    serialNumbers.forEach((element) {
      print(element['type']);

      //  print(key);
      // print(value);
      if (element['Serial'] == serialNumber) {
        exist = true;
        if (element['type'] == 'object') {
          for (int i = 0;
              i < profile.userGeneralInfo.tagsList.objectTag.length;
              i++) {
            for (int j = 0;
                j < profile.userGeneralInfo.tagsList.objectTag[i].tags.length;
                j++) {
              if (profile.userGeneralInfo.tagsList.objectTag[i].tags[j].tagInfo
                      .serialNumber ==
                  serialNumber) {
                indexu = i;
                index = j;
                break;
              }
            }
          }
          BlocProvider.of<TagsBloc>(context).dispatch(
            GoToAddEditObjectTagEvent(
              profile: profile,
              type: "object",
              indexu: indexu,
              index: index,
            ),
          );
        } else if (element['type'] == 'pet') {
          for (int i = 0;
              i < profile.userGeneralInfo.petsInfos.length;
              i++) {
            for (int j = 0;
                j <  profile.userGeneralInfo.petsInfos[i].petTag.length;
                j++) {
              if ( profile.userGeneralInfo.petsInfos[i].petTag[j].tagInfo
                      .serialNumber ==
                  serialNumber) {
                indexu = i;
                index = j;
                break;
              }
            }
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/petsProvider',
              arguments: {
                'profile': profile,
                'index': indexu,
                'route': 'GoToViewPetProfile',
              },
            );
          });
        } else if (element['type'] == 'medical') {
          for (int i = 0;
              i < profile.userGeneralInfo.tagsList.medicalTag.length;
              i++) {
            for (int j = 0;
                j < profile.userGeneralInfo.tagsList.medicalTag[i].tags.length;
                j++) {
              if (profile.userGeneralInfo.tagsList.medicalTag[i].tags[j].tagInfo
                      .serialNumber ==
                  serialNumber) {
                indexu = i;
                index = j;
                break;
              }
            }
          }
          BlocProvider.of<TagsBloc>(context).dispatch(
            GoToAddEditObjectTagEvent(
              profile: profile,
              type: "medical",
              indexu: indexu,
              index: index,
            ),
          );
        } else {}
      }
    });
    if (exist == false) {
      profile.parameters.serial = serialNumber;
      dispatchVerifyTag(profile);
    }
  }
}
/*       ObjectTag objectTag = ObjectTag(
        currency: profile.userGeneralInfo.currency,
        otherInfo: List<OtherInfo>(),
        preferenceUser: profile.userGeneralInfo.preferenceUser,
        emergencyContactUser: profile.userGeneralInfo.userEmergencyContact,
        tagUserInfo: TagUserInfo(
          idUser: profile.userGeneralInfo.idUser,
          firstName: profile.userGeneralInfo.firstName,
          lastName: profile.userGeneralInfo.lastName,
          mail: profile.userGeneralInfo.mail,
          mobile: profile.userGeneralInfo.mobile,
          codePhone: profile.userGeneralInfo.codePhone,
        ),
        tagInfo: TagInfo(
          idTag: null,
          serialNumber: serialNumber,
          idTagCategorie: null,
          active: 1,
          archive: 0,
          idMember: profile.userGeneralInfo.idMember,
        ),
      ); */

/*      profile.userGeneralInfo.userTags.objectTag.add(objectTag); */
/*       BlocProvider.of<TagsBloc>(context).dispatch(
        GoToAddEditObjectTagEvent(
          profile: profile,
          index: null,
        ),
      ); */
