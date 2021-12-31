import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Pets/Presentation/bloc/pets_bloc.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/popupListPet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:flutter_svg/svg.dart';
class SerialNumberToPetTagDisplay extends StatefulWidget {
  final Profile profile;
  final int index;
  SerialNumberToPetTagDisplay(
      {Key key, @required this.profile, @required this.index})
      : super(key: key);

  @override
  _SerialNumberToPetTagDisplayState createState() =>
      _SerialNumberToPetTagDisplayState();
}

class _SerialNumberToPetTagDisplayState
    extends State<SerialNumberToPetTagDisplay> {
  TextEditingController fnamecontroller = new TextEditingController();
  List<Color> _colors = [ColorConstant.pinkColor, ColorConstant.orangeColor];
  List<double> _stops = [0.0, 1.5];
  var screenWidth, screenHeight;

  String serialNumber;
  List<String> serialNumbers = [];
  String qrCodeResult;
  int camera = -1;
  bool backCamera = true;

  static showOverlay(
      BuildContext context, String headerMessage, String message) async {
    await Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  String message;
  @override
  void initState() {
    super.initState();

    if (widget.profile.userGeneralInfo.message != null &&
        widget.profile.userGeneralInfo.message != 'null' &&
        widget.profile.userGeneralInfo.message != 'Success') {
      message = widget.profile.userGeneralInfo.message;

      Future.delayed(Duration.zero,
          () => showOverlay(context, "problem_infos".tr(), message));
    }
    widget.profile.userGeneralInfo.petsInfos.forEach((element) {
      if (element != null) {
        element.petTag.forEach((element1) {
          if (element1.tagInfo.serialNumber != null) {
            serialNumbers.add(element1.tagInfo.serialNumber);
          }
        });
      }
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
                  decoration: BoxDecoration(
                    color: ColorConstant.pinkColor
                   ),

                  //child: Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 16,
                      screenHeight * 40, screenWidth * 16, screenHeight * 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(
                              width: screenWidth * 23,
                            ),
                            GestureDetector(
                                onTap: () {
                                  BlocProvider.of<PetsBloc>(context).dispatch(
                                    GoToEditProfilePetDisplayEvent(
                                      profile: profile,
                                      index: widget.index,
                                    ),
                                  );
                                },
                                child: Image.asset(
                                  "Assets/Images/back.png",
                                  height: screenHeight * 13.5,
                                  width: screenWidth * 20.24,
                                )),
                            SizedBox(
                              width: screenWidth * 50,
                            ),
                            MyText(
                                value: "pets_label_addpettag".tr(),
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white)
                          ]),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HelpDisplay(profile: profile)),
                          );
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
                        child:  Stack(
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
  if (serialNumber
                                                      .contains('found') ==
                                                  true) {
                                                
                                                              serialNumber=serialNumber.split('/').last;

                              
                            
                                              }
                          serialNumber != null && serialNumber != ''
                              ? dispatchGoToAddEdit(profile)
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
                        color: ColorConstant.pinkColor),
                  ),
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
                        value: "pets_label_serialnumber".tr(),
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
                            style: TextStyle(
                                color: Color(0xff231F20),
                                fontFamily: 'SFProText',
                                fontWeight: FontWeight.w500),
                            onChanged: (String value) {
                              serialNumber = value;
                            },
                            decoration: InputDecoration(
                                                                     focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ColorConstant.pinkColor,width: 1.0)),

                              //  prefixIcon: Icon(Icons.call),
                              // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                              hintText: serialNumber,
                              // hintStyle: TextStyle(fontSize: screenWidth*21)
                            ),
                          ),
                        ),
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
                                    value: "pets_label_continue".tr(),
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

  dispatchGoToAddEdit(Profile profile) {
    int index;

    if (serialNumbers.contains(serialNumber) == true) {
      index = profile.userGeneralInfo.petsInfos[widget.index].petTag.indexWhere(
        (element) => element.tagInfo.serialNumber == serialNumber,
      );
      Future.delayed(
        Duration.zero,
        () => showOverlay(
          context,
          "problem_infos".tr(),
          "pets_label_serialnumberexists".tr(),
        ),
      );
    } else {
      profile.parameters.serial = serialNumber;
      BlocProvider.of<PetsBloc>(context).dispatch(
        AddTagPetsEvent(
          profile: profile,
          index: widget.index,
        ),
      );
      // PetTag petTag = PetTag(
      //   otherInfo: List<OtherInfo>(),
      //   preferenceUser:
      //       profile.userGeneralInfo.petsInfos[widget.index].preferencePet,
      //   emergencyContactUser:
      //       profile.userGeneralInfo.petsInfos[widget.index].emergencyContact,
      //   tagUserInfo: TagUserInfo(
      //     idUser: profile
      //         .userGeneralInfo.petsInfos[widget.index].generalInfo.idPet
      //         .toString(),
      //     firstName:
      //         profile.userGeneralInfo.petsInfos[widget.index].generalInfo.name,
      //   ),
      //   tagInfo: TagInfo(
      //       idType: null,
      //       idTag: null,
      //       serialNumber: serialNumber,
      //       idTagCategorie: 3,
      //       active: 1,
      //       archive: 0,
      //       emergency: 0,
      //       idMember: profile
      //           .userGeneralInfo.petsInfos[widget.index].generalInfo.idMember),
      // );

      // profile.userGeneralInfo.petsInfos[widget.index].petTag.add(petTag);
      // BlocProvider.of<PetsBloc>(context).dispatch(
      //   GoToEditProfilePetDisplayEvent(
      //     profile: profile,
      //     index: widget.index,
      //   ),
      // );
    }
  }
}
