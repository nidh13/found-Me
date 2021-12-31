import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/popupTestTag.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:easy_localization/easy_localization.dart';

class TestTagDisplay extends StatefulWidget {
  final Profile profile;

  TestTagDisplay({Key key, @required this.profile}) : super(key: key);

  @override
  _TestTagDisplayState createState() => _TestTagDisplayState();
}

class _TestTagDisplayState extends State<TestTagDisplay> {
  TextEditingController fnamecontroller = new TextEditingController();
  List<Color> _colors = [ColorConstant.pinkColor, ColorConstant.orangeColor];
  List<double> _stops = [0.0, 1.5];
  var screenWidth, screenHeight;
  List<Tags> tags = [];

  String serialNumber;
  List<String> serialNumbers = [];
  String qrCodeResult;
  int camera = -1;
  bool backCamera = true;
  String message;
  static showOverlay(
      BuildContext context, String headerMessage, String message) async {
    await Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  @override
  void initState() {
    widget.profile.userGeneralInfo.tagsList.objectTag.forEach((element) {
      element.tags.forEach((element2) {
        if (element2.tagInfo.active == 1) {
          // mapSerial.addAll(
          //     {'Serial': element2.tagInfo.serialNumber, 'type': 'object'});
          // serialNumbers.add(mapSerial);
          serialNumbers.add(
            element2.tagInfo.serialNumber,
          );
        } else {
          serialNumbers.remove(element2.tagInfo.serialNumber);
        }
      });
    });

    widget.profile.userGeneralInfo.tagsList.petTag.forEach((element) {
      element.tags.forEach((element2) {
        if (element2.tagInfo.active == 1) {
          serialNumbers.add(
            element2.tagInfo.serialNumber,
          );
        } else {
          serialNumbers.remove(element2.tagInfo.serialNumber);
        }
      });
 });

      widget.profile.userGeneralInfo.tagsList.medicalTag.forEach((element) {
        element.tags.forEach((element2) {
          if (element2.tagInfo.active == 1) {
            serialNumbers.add(
              element2.tagInfo.serialNumber,
            );
          } else {
            serialNumbers.remove(element2.tagInfo.serialNumber);
          }
        });
      });
   
    super.initState();
  }

  static testTagDisplay(BuildContext context, Profile profile) {
    Navigator.of(context).push(TestTag(profile));
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
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
                          value: "drawer_label_testtag".tr(),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                      GestureDetector(
                        onTap: () {
                          /*     _showOverlay(context); */

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HelpDisplay(profile: profile)),
                          );

                          //    Navigator.of(context).push(MasterOverlay());
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
                          ); //barcode scnner
                          setState(() {
                            qrCodeResult = codeSanner.rawContent;
                            serialNumber = qrCodeResult;
                          });
                         serialNumber=serialNumber.split('/').last;

                          serialNumber != null && serialNumber != ''
                              ? dispatchTestEdit(profile)
                              : null;
                        })),
                SizedBox(height: screenHeight * 5),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * 0.01),
                  child: Container(
                      child: MyText(
                          value: "pets_label_scan".tr(),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: ColorConstant.pinkColor)),
                ),
                SizedBox(height: screenHeight * 26),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyText(
                        value: (qrCodeResult == null) || (qrCodeResult == "")
                            ? "pets_label_scanhere".tr()
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
                              decoration: InputDecoration(
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
                          profile.userGeneralInfo.masterTag = serialNumber;
                          serialNumber != null && serialNumber != ''
                              ? dispatchTestEdit(profile)
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

  dispatchTestEdit(Profile profile) {
    int index, indexu;

    if (serialNumbers.contains(serialNumber) == true) {
      profile.userGeneralInfo.masterTag = serialNumber;
      testTagDisplay(context, profile);
    } else {
      showOverlay(
          context, "problem_infos".tr(), 'pets_label_invalidserialnumber'.tr());

      //   profile.parameters.serial = serialNumber;
      //   profile.userGeneralInfo.switchTag = 'yes';
      //   profile.parameters.indexu = indexu;
      //   profile.parameters.indext = index;
      //   dispatchVerifyTag(profile);
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
  }
}
