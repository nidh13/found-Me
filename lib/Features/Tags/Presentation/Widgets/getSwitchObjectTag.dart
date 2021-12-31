import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:grouped_checkbox/grouped_checkbox.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popUpImage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class GetSwitchObjectTagDisplay extends StatefulWidget {
  final Profile profile;
  final String type;
  final int indexu;
  final int index;

  const GetSwitchObjectTagDisplay({
    Key key,
    @required this.profile,
    @required this.type,
    @required this.indexu,
    @required this.index,
  }) : super(key: key);
  @override
  _GetSwitchbjectTagDisplayState createState() =>
      _GetSwitchbjectTagDisplayState();
}

class _GetSwitchbjectTagDisplayState extends State<GetSwitchObjectTagDisplay> {
  var screenWidth, screenHeight;
  List<Documents> documentAttachment = [];
  List<Reminders> remindersList = [];
  int nombrebolckAttachment;
  String qrCodeResult;
  int camera = -1;
  bool backCamera = true;

  bool _attachment = false;

  List<Map<String, dynamic>> idMembers = [];
  String serialNumber;

  String thisMember;
  owner() {
    idMembers.add({
      'firstName': widget.profile.userGeneralInfo.firstName,
      'idMember': widget.profile.userGeneralInfo.idMember,
    });

    widget.profile.userGeneralInfo.subUsers.forEach((element) {
      idMembers.add({
        'firstName': element.userGeneralInfo.firstName,
        'idMember': element.userGeneralInfo.idMember,
      });
    });
    print(idMembers);
  }

  List<String> allItemList = [
    'Damaged, Manufacturing defect',
    'User damaged',
    'Wear and tear',
  ];

  static List<String> checkedItemList = [
    'Damaged, Manufacturing defect',
    'Wear and tear'
  ];

  List<String> selectedItemList = checkedItemList ?? [];
  List<String> serialNumbers = [];
  String message;
  @override
  void initState() {
    if (widget.profile.userGeneralInfo.message != null &&
        widget.profile.userGeneralInfo.message != 'null') {
      message = widget.profile.userGeneralInfo.message;
      Future.delayed(
        Duration.zero,
        () => showOverlay(context, "problem_infos".tr(), message),
      );
    }
    owner();
    widget.profile.userGeneralInfo.tagsList.objectTag.forEach((element) {
      if (element != null) {
        element.tags.forEach((element2) {
          if (element2.tagInfo.active == 1) {
            serialNumbers.add(element2.tagInfo.serialNumber);
          }
        });
      }
    });
    widget.profile.userGeneralInfo.tagsList.petTag.forEach((element) {
      if (element != null) {
        element.tags.forEach((element2) {
          if (element2.tagInfo.active == 1) {
            serialNumbers.add(element2.tagInfo.serialNumber);
          }
        });
      }
    });

    widget.profile.userGeneralInfo.tagsList.medicalTag.forEach((element) {
      if (element != null) {
        element.tags.forEach((element2) {
          if (element2.tagInfo.active == 1) {
            serialNumbers.add(element2.tagInfo.serialNumber);
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String tag = widget.type;
    print(tag);

/* 
    profile.userGeneralInfo.userTags.objectTag != null
        ? profile.userGeneralInfo.userTags.objectTag.forEach((element) {
            element.otherInfo.forEach((element2) {
              element2.documents.forEach((docum) {
                documentAttachment.add(docum);

                nombrebolckAttachment = documentAttachment.length;
              });
            });
          })
        : Container();

    profile.userGeneralInfo.userTags.objectTag.forEach((element) {
      element.otherInfo.forEach((element2) {
        element2.reminders.forEach((remind) {
          if (remind != null) {
            remindersList.add(remind);
          }
        });
      });
    }); */

    readAttachement() {
      documentAttachment.forEach((element) {
        print(element.documentName.toString());
      });
    }

    return OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  height: (screenHeight * 21.5) / 100,
                  decoration: BoxDecoration(
                    color: ColorConstant.pinkColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(23.0),
                        bottomLeft: Radius.circular(23.0)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 2.0,
                        spreadRadius: 0.01,
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    AppBar(
                      elevation: 0.0,
                      centerTitle: true,
                      leading: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            //     Navigator.canPop(context);
                            dispatchGoToHome(widget.profile);
                          }),
                      title: MyText(
                          value: 'drawer_label_switchtag'.tr(),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                      backgroundColor: Colors.transparent,
                      actions: <Widget>[
                        IconButton(
                          icon: Image.asset(
                            "Assets/Images/FAQ.png",
                            height: 28,
                            width: 28,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HelpDisplay(profile: widget.profile)),
                            );
                          },
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.0350,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6.0,
                            spreadRadius: 0.01,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: (screenWidth * 3.2) / 100,
                        vertical: (screenHeight * 1.24) / 100,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Stack(
                            children: [
                              widget.type == "object"
                                  ? InkWell(
                                      child: Container(
                                        width: (screenWidth * 21.34) / 100,
                                        height: (screenWidth * 21.34) / 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                          border: Border.all(
                                              color: Colors.white,
                                              width:
                                                  (screenHeight * 0.62) / 100),
                                          boxShadow: [
                                            new BoxShadow(
                                              color: Colors.black38,
                                              blurRadius: 5.0,
                                              spreadRadius: 0.01,
                                            ),
                                          ],
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              widget
                                                      .profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[widget.indexu]
                                                      .tags[widget.index]
                                                      .tagInfo
                                                      .pictureUrl ??
                                                  "https://ws.interface-crm.com:445/documents/found_me_doc/3b712de48137572f3849aabd5666a4e3/732a6fc77c7d4da42dd255f730783856de52d1a92ffca9461b5a3322e179c780.jpg",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.of(context).push(PopUpImage(widget
                                                .profile
                                                .userGeneralInfo
                                                .tagsList
                                                .objectTag[widget.indexu]
                                                .tags[widget.index]
                                                .tagInfo
                                                .pictureUrl ??
                                            "https://ws.interface-crm.com:445/documents/found_me_doc/3b712de48137572f3849aabd5666a4e3/732a6fc77c7d4da42dd255f730783856de52d1a92ffca9461b5a3322e179c780.jpg"));
                                      },
                                    )
                                  : widget.type == "medical"
                                      ? InkWell(
                                          child: Container(
                                            width: (screenWidth * 21.34) / 100,
                                            height: (screenWidth * 21.34) / 100,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: (screenHeight * 0.62) /
                                                      100),
                                              boxShadow: [
                                                new BoxShadow(
                                                  color: Colors.black38,
                                                  blurRadius: 5.0,
                                                  spreadRadius: 0.01,
                                                ),
                                              ],
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  widget
                                                          .profile
                                                          .userGeneralInfo
                                                          .tagsList
                                                          .medicalTag[
                                                              widget.indexu]
                                                          .tags[widget.index]
                                                          .tagInfo
                                                          .pictureUrl ??
                                                      "https://ws.interface-crm.com:445/documents/found_me_doc/3b712de48137572f3849aabd5666a4e3/de20e7222dadb5e8b9e8c06ef9cf3c99b1a55c369d10f213384a9c32e3589833.jpg",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                PopUpImage(widget
                                                        .profile
                                                        .userGeneralInfo
                                                        .tagsList
                                                        .medicalTag[
                                                            widget.indexu]
                                                        .tags[widget.index]
                                                        .tagInfo
                                                        .pictureUrl ??
                                                    "https://ws.interface-crm.com:445/documents/found_me_doc/3b712de48137572f3849aabd5666a4e3/de20e7222dadb5e8b9e8c06ef9cf3c99b1a55c369d10f213384a9c32e3589833.jpg"));
                                          },
                                        )
                                      : InkWell(
                                          child: Container(
                                            width: (screenWidth * 21.34) / 100,
                                            height: (screenWidth * 21.34) / 100,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.black,
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: (screenHeight * 0.62) /
                                                      100),
                                              boxShadow: [
                                                new BoxShadow(
                                                  color: Colors.black38,
                                                  blurRadius: 5.0,
                                                  spreadRadius: 0.01,
                                                ),
                                              ],
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  widget
                                                          .profile
                                                          .userGeneralInfo
                                                          .tagsList
                                                          .petTag[widget.indexu]
                                                          .pictureProfileUrl ??
                                                      "https://pics.drugstore.com/prodimg/574208/900.jpg",
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                PopUpImage(widget
                                                        .profile
                                                        .userGeneralInfo
                                                        .tagsList
                                                        .petTag[widget.indexu]
                                                        .pictureProfileUrl ??
                                                    "https://pics.drugstore.com/prodimg/574208/900.jpg"));
                                          },
                                        )
                            ],
                          ),
                          SizedBox(
                            width: (screenWidth * 5.33) / 100,
                          ),
                          Flexible(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                widget.type == "object"
                                    ? AutoSizeText(
                                        widget
                                                .profile
                                                .userGeneralInfo
                                                .tagsList
                                                .objectTag[widget.indexu]
                                                .tags[widget.index]
                                                .tagInfo
                                                .tagLabel ??
                                            " ",
                                        textScaleFactor: 1.0,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 21,
                                            color: ColorConstant.textColor,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : widget.type == "medical"
                                        ?
                                        // ? Row(
                                        //     children: [
                                        //       AutoSizeText(
                                        //         idMembers.firstWhere((element) =>
                                        //             element['idMember'] ==
                                        //             widget
                                        //                 .profile
                                        //                 .userGeneralInfo
                                        //                 .tagsList
                                        //                 .medicalTag[
                                        //                     widget.indexu]
                                        //                 .tags[widget.index]
                                        //                 .tagInfo
                                        //                 .idMember)['firstName'],
                                        //         textScaleFactor: 1.0,
                                        //         style: TextStyle(
                                        //             fontSize: 24,
                                        //             color:
                                        //                 ColorConstant.textColor,
                                        //             fontWeight:
                                        //                 FontWeight.w600),
                                        //       ),
                                        AutoSizeText(
                                            widget
                                                    .profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .medicalTag[widget.indexu]
                                                    .tags[widget.index]
                                                    .tagInfo
                                                    .tagLabel ??
                                                " ",

                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: ColorConstant.textColor,
                                                fontWeight: FontWeight.w600),
                                            //   ),
                                            // ],
                                          )
                                        : Row(
                                            children: [
                                              AutoSizeText(
                                                widget
                                                    .profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .petTag[widget.indexu]
                                                    .firstName,
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color:
                                                        ColorConstant.textColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              AutoSizeText(
                                                widget
                                                        .profile
                                                        .userGeneralInfo
                                                        .tagsList
                                                        .petTag[widget.indexu]
                                                        .tags[widget.index]
                                                        .tagInfo
                                                        .tagLabel ??
                                                    " ",
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontSize: 24,
                                                    color:
                                                        ColorConstant.textColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                widget.type == "object"
                                    ? MyText(
                                        value: widget.profile.userGeneralInfo.tagsList.objectTag[widget.indexu].tags[widget.index].tagInfo.idType != null
                                            ? widget.profile.parameters.tagTypesList[widget.profile.userGeneralInfo.tagsList.objectTag[widget.indexu].tags[widget.index].tagInfo.idType - 2]
                                                ['type_label']
                                            : '',
                                        fontSize: 14,
                                        color: ColorConstant.textColor,
                                        fontWeight: FontWeight.w500)
                                    : widget.type == "medical"
                                        ? MyText(
                                            value: widget.profile.userGeneralInfo.tagsList.medicalTag[widget.indexu].tags[widget.index].tagInfo.idType != null
                                                ? widget.profile.parameters.tagTypesList[widget.profile.userGeneralInfo.tagsList.medicalTag[widget.indexu].tags[widget.index].tagInfo.idType - 2]
                                                    ['type_label']
                                                : '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            color: ColorConstant.textColor,
                                            fontWeight: FontWeight.w500)
                                        : MyText(
                                            value: widget
                                                        .profile
                                                        .userGeneralInfo
                                                        .tagsList
                                                        .petTag[widget.indexu]
                                                        .tags[widget.index]
                                                        .tagInfo
                                                        .idType !=
                                                    null
                                                ? widget.profile.parameters
                                                    .tagTypesList[widget.profile.userGeneralInfo.tagsList.petTag[widget.indexu].tags[widget.index].tagInfo.idType - 2]['type_label']
                                                : '',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 14,
                                            color: ColorConstant.textColor,
                                            fontWeight: FontWeight.w500),
                                widget.type == "object"
                                    ? MyText(
                                        value: widget
                                            .profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagInfo
                                            .serialNumber,
                                        fontSize: 14,
                                        color: ColorConstant.pinkColor,
                                        fontWeight: FontWeight.w500)
                                    : widget.type == "medical"
                                        ? MyText(
                                            value: widget
                                                .profile
                                                .userGeneralInfo
                                                .tagsList
                                                .medicalTag[widget.indexu]
                                                .tags[widget.index]
                                                .tagInfo
                                                .serialNumber,
                                            fontSize: 14,
                                            color: ColorConstant.pinkColor,
                                            fontWeight: FontWeight.w500)
                                        : MyText(
                                            value: widget
                                                .profile
                                                .userGeneralInfo
                                                .tagsList
                                                .petTag[widget.indexu]
                                                .tags[widget.index]
                                                .tagInfo
                                                .serialNumber,
                                            fontSize: 14,
                                            color: ColorConstant.pinkColor,
                                            fontWeight: FontWeight.w500),
                              ])),
                          widget.type == 'medical'
                              ? Padding(
                                  padding: EdgeInsets.only(left: 0.0),
                                  child: Container(
                                    width: (screenWidth * 15.34) / 100,
                                    height: (screenWidth * 15.34) / 100,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "Assets/Images/Medical.png",
                                          ),
                                        )),
                                  ),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(left: 40.0),
                                  child: Container(),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
//            Contact Setting
                  Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 4.0) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    child: MyText(
                        value: "objecttag_label_message".tr(),
                        fontSize: 14.0,
                        color: ColorConstant.textColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: (screenHeight * 2.0) / 100,
                          right: screenWidth * 0.0627,
                          left: screenWidth * 0.0627),
                      child: GroupedCheckbox(
                          itemList: allItemList,
                          checkedItemList: checkedItemList,
                          disabled: ['Black'],
                          onChanged: (itemList) {
                            setState(() {
                              selectedItemList = itemList;
                            });
                          },
                          orientation: CheckboxOrientation.VERTICAL,
                          checkColor: Colors.white,
                          activeColor: Colors.green)),

                  Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 4.0) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    child: MyText(
                        value: "objecttag_label_switch".tr(),
                        fontSize: 14.0,
                        color: ColorConstant.textColor,
                        fontWeight: FontWeight.w500),
                  ),

                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                        top: (screenHeight * 4.0) / 100,
                      ),
                      // right: screenWidth * 0.0627,
                      // left: screenWidth * 0.0627),
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
                              //    qrCodeResult = 'DCEMM';
                              if (qrCodeResult.contains('found') == true) {
                                qrCodeResult = qrCodeResult.split('/').last;
                              }

                              if ((qrCodeResult != null) &&
                                  (qrCodeResult != "")) {
                                widget.profile.userGeneralInfo.update = true;

                                dispatchGoToAddEdit(widget.profile);
                              }
                            });
                          }),
                    ),
                  ),

                  Center(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: (screenHeight * 1.0) / 100,
                          right: screenWidth * 0.0627,
                          left: screenWidth * 0.0627),
                      child: MyText(
                        value: (qrCodeResult == null) || (qrCodeResult == "")
                            ? "SCAN"
                            : "",
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: ColorConstant.pinkColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  bool exist = false;
  static showOverlay(
      BuildContext context, String headerMessage, String message) {
    Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  dispatchGoToAddEdit(Profile profile) {
    int index, indexu;
    serialNumbers;
    // print(serialNumbers[0]['serial']);
    serialNumbers.forEach((element) {
      //  print(key);
      // print(value);
      if (element == qrCodeResult) {
        exist = true;
        Future.delayed(
          Duration.zero,
          () => showOverlay(context, "problem_infos".tr(),
              'This serial number is used for another Tag'),
        );
      }
    });
    if (exist == false) {
      profile.parameters.serial = qrCodeResult;
      profile.userGeneralInfo.switchTag = 'yes';
      profile.parameters.indexu = widget.indexu;
      profile.parameters.indext = widget.index;
      profile.parameters.typecheck = widget.type;
      dispatchVerifyTag(profile);
    }
  }

  dispatchVerifyTag(Profile profile) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      VerifyTagEvent(
        profile: profile,
      ),
    );
  }

  dispatchAddEditObjectTag(profile, int index) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      AddEditObjectTagEvent(
        profile: profile,
        index: index,
      ),
    );
  }

  void dispatchGoToHome(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/homeProvider',
      arguments: profile,
    );
  }
}
