import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';

import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Reminders/Presentation/Widgets/Components/tagExpansionTileItem.dart';
import 'package:neopolis/Features/Reminders/Presentation/Widgets/Components/my_tags_item.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:easy_localization/easy_localization.dart';

class ListingReminders extends StatefulWidget {
  final Profile profile;

  ListingReminders({Key key, @required this.profile}) : super(key: key);
  @override
  ListingRemindersState createState() => new ListingRemindersState();
}

class ListingRemindersState extends State<ListingReminders> {
  TextEditingController fnamecontroller = new TextEditingController();
  StreamController<String> emailStreamcontroller;
  TextEditingController emailcontroller = new TextEditingController();

  List<Color> _colors = [ColorConstant.pinkColor, ColorConstant.orangeColor];
  List<double> _stops = [0.0, 1.5];
  var screenWidth, screenHeight;
  String serialNumber;
  List<String> serialNumbers = [];
  String qrCodeResult;
  int camera = -1;
  bool backCamera = true;
  bool attachment = true;
  bool emergency = true;
  TextEditingController ObjectController = new TextEditingController();
  TextEditingController DescController = new TextEditingController();
  bool _isMedicalTag = false;
  bool _isObjectTag = false;
  bool _isPetTag = false;
  bool _isKidsTag = false;

  //Medical tag
  bool isMedicalTag = false;
  bool medicalTag = true;
  final ScrollController medicalScroll = ScrollController();

  //Object tag
  bool isObjectTag = false;
  bool objectTag = true;
  final ScrollController objectScroll = ScrollController();
  List<dynamic> list = [];

  List<dynamic> listM = [];

  List<dynamic> listP = [];
  List<dynamic> listTag = [];

  //Pet tag
  bool isPetTag = false;
  bool petTag = true;
  String membre = '';
  final ScrollController petScroll = ScrollController();

  List<Map<String, dynamic>> idMedicalbyMemberes = [];
  List<Map<String, dynamic>> idObjectbyMemberes = [];
  List<Map<String, dynamic>> idPetbyMemberes = [];
  List<Map<String, dynamic>> idCategory = [];

  String thisMember;
  medicalTagbyowner() {
    widget.profile.userGeneralInfo.userTags.medicalTag.forEach((element) {
      listM.add(element);
    });
    if (widget.profile.userGeneralInfo.userTags.medicalTag.length != 0) {
      idMedicalbyMemberes.add({
        'profile': widget.profile,
        'firstName': widget.profile.userGeneralInfo.firstName,
        'picture': widget.profile.userGeneralInfo.profilePictureUrl,
        'idMember': widget.profile.userGeneralInfo.idMember,
        'list': listM
      });
    }

    widget.profile.userGeneralInfo.subUsers.forEach((element) {
      element.userGeneralInfo.userTags.medicalTag.forEach((element2) {
        listM.add(element2);
      });
      if (element.userGeneralInfo.userTags.medicalTag.length != 0) {
        idMedicalbyMemberes.add({
          'profile': widget.profile,
          'firstName': element.userGeneralInfo.firstName,
          'idMember': element.userGeneralInfo.idMember,
          'picture': element.userGeneralInfo.profilePictureUrl ?? " ",
          "list": listM,
        });
      }
    });
  }

  objectTagbyowner() {
    widget.profile.userGeneralInfo.userTags.objectTag.forEach((element) {
      list.add(element);
    });

    if (widget.profile.userGeneralInfo.userTags.objectTag.length != 0) {
      idObjectbyMemberes.add({
        'usertags': widget.profile.userGeneralInfo.userTags,
        'firstName': widget.profile.userGeneralInfo.firstName,
        'picture': widget.profile.userGeneralInfo.profilePictureUrl,
        'idMember': widget.profile.userGeneralInfo.idMember,
        'list': list
      });
    }

    widget.profile.userGeneralInfo.subUsers.forEach((element) {
      element.userGeneralInfo.userTags.objectTag.forEach((element2) {
        list.add(element2);
      });
      if (element.userGeneralInfo.userTags.objectTag.length != null) {
        idObjectbyMemberes.add({
          'usertags': element.userGeneralInfo.userTags,
          'firstName': element.userGeneralInfo.firstName,
          'idMember': element.userGeneralInfo.idMember,
          'picture': element.userGeneralInfo.profilePictureUrl ?? " ",
          "list": list,
        });
      }
    });
  }

  petTagbyowner() {
    widget.profile.userGeneralInfo.petsInfos.forEach((element) {
      element.petTag.forEach((element2) {
        listP.add(element2);
      });

      if (widget.profile.userGeneralInfo.petsInfos.length != 0) {
        idPetbyMemberes.add({
          'usertags': widget.profile.userGeneralInfo.petsInfos,
          'firstName': element.generalInfo.name,
          'picture': element.generalInfo.picturePet,
          'idMember': element.generalInfo.idMember,
          'list': listP
        });
      }
    });
  }

  category() {
    widget.profile.parameters.tagTypesList.forEach((element) {
      idCategory.add(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;

    screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;

    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 100),
        child: Container(
          height: screenHeight * 100,
          decoration: BoxDecoration(color: ColorConstant.pinkColor),

          //child: Padding(
          padding: EdgeInsets.fromLTRB(screenWidth * 16, screenHeight * 40,
              screenWidth * 16, screenHeight * 30),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      dispatchGoToHome(profile);
                    },
                    child: Image.asset(
                      "Assets/Images/back.png",
                      height: screenHeight * 13.5,
                      width: screenWidth * 20.24,
                    )),
                Text(
                  "drawer_label_remindersalarms".tr(),
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    fontFamily: "SFProText",
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HelpDisplay(profile: profile)),
                    );
                  },
                  child: Image.asset(
                    "Assets/Images/FAQ.png",
                    height: screenHeight * 25,
                    width: screenWidth * 30,
                  ),
                ),
              ]),

          // ),
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(children: <Widget>[
              SizedBox(height: screenHeight * 100),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenHeight * 20, 0, screenHeight * 20, 0),
                child: StreamBuilder(
                    stream: emailStreamcontroller.stream,
                    builder: (context, snapshot) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              '  ',
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontFamily: 'SFProText',
                                  color: Colors.redAccent),
                            ),
                          ),
                          Visibility(
                            visible: _isMedicalTag,
                            child: medicalTagsWidget(profile),
                          ),
                          Visibility(
                            visible: _isObjectTag,
                            child: objectTagsWidget(profile),
                          ),
                          Visibility(
                            visible: _isPetTag,
                            child: petTagsWidget(profile),
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      );
                    }),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  medicalTagsWidget(Profile profile) {
    print(listM);
    return Container(
      margin: EdgeInsets.only(
          top: screenHeight * 0.0498,
          right: screenWidth * 0.06,
          left: screenWidth * 0.06),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
      child: Theme(
        data: ThemeData(
            accentColor: Colors.white,
            primaryColor: Colors.white,
            unselectedWidgetColor: Colors.white),
        child: TagExpansionTileItem(
          title: "editprofil_medical_subtitle_medicaltags".tr(),
          type: "medical",
          children: profile.userGeneralInfo.remindersList.medicalTag.length != 0
              ? profile.userGeneralInfo.remindersList.medicalTag
                  .map(
                    (e) => Container(
                        color: Colors.white.withOpacity(0.98),
                        margin: EdgeInsets.only(
                            top: screenHeight * 1.015,
                            left: screenWidth * 0.0027,
                            right: screenWidth * 1.0027),
                        child: MyTagItem(
                            profil: widget.profile,
                            headerTitle: e.firstName ?? " ",
                            headerImage: e.pictureProfileUrl ?? " ",
                            type: "medical",
                            children: e.reminders)),
                  )
                  .toList()
              : [],
        ),
      ),
    );
  }

  objectTagsWidget(Profile profile) {
    return Container(
      margin: EdgeInsets.only(
          top: screenHeight * 0.0498,
          right: screenWidth * 0.06,
          left: screenWidth * 0.06),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
      child: Theme(
        data: ThemeData(
            accentColor: Colors.white,
            primaryColor: Colors.white,
            unselectedWidgetColor: Colors.white),
        child: TagExpansionTileItem(
          title: "editprofil_medical_subtitle_objecttags".tr(),
          type: "Object",
          children: profile.userGeneralInfo.remindersList.objectTag.length != 0
              ? profile.userGeneralInfo.remindersList.objectTag
                  .map(
                    (e) => Container(
                      color: Colors.white.withOpacity(0.98),
                      margin: EdgeInsets.only(
                          top: screenHeight * 1.015,
                          left: screenWidth * 0.0027,
                          right: screenWidth * 1.0027),
                      child: MyTagItem(
                        profil: widget.profile,
                        headerTitle: e.firstName ?? " ",
                        headerImage: e.pictureProfileUrl ?? " ",
                        type: "Object",
                        children: e.reminders,
                      ),
                    ),
                  )
                  .toList()
              : [],
        ),
      ),
    );
  }

  petTagsWidget(Profile profile) {
    print(listP);
    return Container(
      margin: EdgeInsets.only(
          top: screenHeight * 0.0498,
          right: screenWidth * 0.06,
          left: screenWidth * 0.06),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
      ),
      child: Theme(
        data: ThemeData(
            accentColor: Colors.white,
            primaryColor: Colors.white,
            unselectedWidgetColor: Colors.white),
        child: TagExpansionTileItem(
            title: "editprofil_medical_subtitle_pettags".tr(),
            type: "Pets",
            children: profile.userGeneralInfo.remindersList.petTag.length != 0
                ? profile.userGeneralInfo.remindersList.petTag
                    .map(
                      (e) => Container(
                          color: Colors.white.withOpacity(0.98),
                          margin: EdgeInsets.only(
                              top: screenHeight * 1.015,
                              left: screenWidth * 0.0027,
                              right: screenWidth * 1.0027),
                          child: MyTagItem(
                              profil: widget.profile,
                              headerTitle: e.petName ?? " ",
                              headerImage: e.pictureProfileUrl ?? " ",
                              type: "Pets",
                              children: e.reminders)),
                    )
                    .toList() /* :[] */
                : []),
      ),
    );
  }

  @override
  void initState() {
    medicalTagbyowner();
    petTagbyowner();
    objectTagbyowner();
    category();
    _isMedicalTag = true;
    _isObjectTag = true;
    _isPetTag = true;

    emailStreamcontroller = StreamController<String>.broadcast();
    emailcontroller.addListener(() {
      emailStreamcontroller.sink.add(emailcontroller.text.trim());
    });

    super.initState();
  }

  void dispatchGoToHome(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/homeProvider',
      arguments: profile,
    );
  }
}
