import 'dart:async';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_expansion_tile.dart'
    as custom;
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/my_tags_ItemPet.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/tagExpansionTileItem.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/my_tags_itemSwitch.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class SwitchObjectTag extends StatefulWidget {
  final Profile profile;

  SwitchObjectTag({Key key, @required this.profile}) : super(key: key);
  @override
  SwitchObjectTagState createState() => new SwitchObjectTagState();
}

class SwitchObjectTagState extends State<SwitchObjectTag> {
  TextEditingController fnamecontroller = new TextEditingController();
  StreamController<String> emailStreamcontroller;
  TextEditingController emailcontroller = new TextEditingController();

  List<Color> _colors = [ColorConstant.pinkColor, ColorConstant.orangeColor];
  List<double> _stops = [0.0, 1.5];
  var screenWidth, screenHeight;
  String serialNumber;
  String qrCodeResult;
  int camera = -1;
  bool backCamera = true;
  bool attachment = true;
  bool emergency = true;
  bool initiallyExpandedObject = false;
  bool initiallyExpandedMedical = false;
  bool initiallyExpandedPet = false;
  TextEditingController ObjectController = new TextEditingController();
  TextEditingController DescController = new TextEditingController();
  bool _isMedicalTag = false;
  bool _isObjectTag = false;
  bool _isPetTag = false;
  bool _isKidsTag = false;
  int categoryid = 2;

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

  String cat = "";

  List<Map<String, dynamic>> idMedicalbyMemberes = [];
  List<Map<String, dynamic>> idObjectbyMemberes = [];
  List<Map<String, dynamic>> idPetbyMemberes = [];
  List<Map<String, dynamic>> idCategory = [];

  String thisMember;

  List<Map<String, dynamic>> idMembers = [];
  bool expansionTile = false;

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
  }

  category() {
    widget.profile.parameters.tagTypesList.forEach((element) {
      print(element);
      idCategory.add(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;

    screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;

    return Scaffold(
        body: Stack(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          SingleChildScrollView(
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(height: screenHeight * 105),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        screenHeight * 20,
                        expansionTile ? screenHeight * 280 : screenHeight * 50,
                        screenHeight * 20,
                        0),
                    child: StreamBuilder(
                        stream: emailStreamcontroller.stream,
                        builder: (context, snapshot) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    left: screenWidth * 10,
                                    right: screenWidth * 10),
                                child: Center(
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: "objecttag_btn_switchqrdesc".tr(),
                                      style: TextStyle(
                                          fontFamily: "SFProText",
                                          fontSize: 14,
                                          color: ColorConstant.textColor),
                                    ),
                                    textScaleFactor: 1.0,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  margin:
                                      EdgeInsets.only(left: screenWidth * 120),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        InkWell(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, screenHeight * 0.001, 0, 0),
                                            child: Stack(
                                              children: [
                                                SvgPicture.asset(
                                                  "Assets/Images/ScButton.svg",
                                                  color:
                                                      ColorConstant.pinkColor,
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
                                          ),
                                          onTap: () async {
                                            ScanResult codeSanner =
                                                await BarcodeScanner.scan(
                                              options: ScanOptions(
                                                useCamera: camera,
                                              ),
                                            ); //barcode scnner
                                            setState(() {
                                              qrCodeResult =
                                                  codeSanner.rawContent;
                                              /*    if ((qrCodeResult != null) ||
                                (qrCodeResult != "")) {
                              widget.profile.userGeneralInfo.update = true;
                          
                            
                              } */
                                              if (serialNumber
                                                      .contains('found') ==
                                                  true) {
                                                
                                                              serialNumber=serialNumber.split('/').last;

                              
                            
                                              }
                                              serialNumber != null &&
                                                      serialNumber != ''
                                                  ? dispatchGoToAddEdit(profile)
                                                  : null;
                                            });
                                          },
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              screenHeight * 10.03,
                                              screenHeight * 0.003,
                                              0,
                                              0),
                                          child: Container(
                                              child: MyText(
                                                  value: "pets_label_scan".tr(),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 24,
                                                  color:
                                                      ColorConstant.pinkColor)),
                                        ),
                                      ])),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: MyText(
                                      value: "pets_label_serialnumber".tr(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstant.pinkColor),
                                ),
                              ),
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
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorConstant.pinkColor,
                                              width: 1.0)),

                                      //  prefixIcon: Icon(Icons.call),
                                      // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                      hintText: serialNumber,
                                      // hintStyle: TextStyle(fontSize: screenWidth*21)
                                    ),
                                  )),
                              SizedBox(
                                height: 30,
                              ),
                              Visibility(
                                visible: _isMedicalTag,
                                child: medicalTagsWidget(
                                    profile, initiallyExpandedMedical),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: _isObjectTag,
                                child: objectTagsWidget(
                                    profile, initiallyExpandedObject),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Visibility(
                                visible: _isPetTag,
                                child: petTagsWidget(
                                    profile, initiallyExpandedPet),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      screenWidth * 1,
                                      screenHeight * 15,
                                      screenWidth * 1,
                                      screenHeight * 20),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(9.0),
                                      color: ColorConstant.pinkColor,
                                    ),
                                    width: screenWidth * 343.0,
                                    height: screenHeight * 64,
                                    child: FlatButton(
                                      onPressed: () {
                                        serialNumber != null &&
                                                serialNumber != ''
                                            ? dispatchGoToAddEdit(profile)
                                            : null;
                                        //  switchFilterTag(profile);
                                      },

                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(
                                            0,
                                            screenHeight * 10,
                                            0,
                                            screenHeight * 10),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              MyText(
                                                  value: "pets_label_continue"
                                                      .tr(),
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
                                  ))
                            ],
                          );
                        }),
                  ),
                ]),
          ),
          Container(
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
                    child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          "Assets/Images/back.png",
                          height: screenHeight * 13.5,
                          width: screenWidth * 20.24,
                        ))),
              
                MyText(
                    value: "drawer_label_switchtag".tr(),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white),
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
              ],
            ),
            // ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                screenWidth * 24, screenHeight * 80, screenWidth * 24, 0),
            child: Container(
              margin: EdgeInsets.only(
                  top: (screenHeight * 2.96) / 100,
                  right: screenWidth * 0.0627,
                  left: screenWidth * 0.0627),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(9.0)),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 0.01,
                  ),
                ],
              ),
              child: Theme(
                data: ThemeData(
                    accentColor: Colors.white,
                    primaryColor: Colors.white,
                    unselectedWidgetColor: Colors.white),
                child: custom.ExpansionTile(
                  initiallyExpanded: false,
                  onExpansionChanged: (value) {
                    setState(() {
                      expansionTile = value;
                    });
                  },
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                        headerMargin: EdgeInsets.symmetric(horizontal: screenWidth * 0.0027),
                  title: Container(
                      padding: EdgeInsets.only(left: screenWidth * 0.04),
                      child: MyText(
                          value: "listingtags_filter_title".tr(),
                          textAlign: TextAlign.center,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  children: <Widget>[
//                          Object
                    Container(
                      width: screenWidth * 274,
                      height: screenHeight * 35,
                      padding: EdgeInsets.only(right: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: idCategory
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Center(
                                    child: MyText(
                                        value: e['type_label'] != null
                                            ? e['type_label']
                                            : " ",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.textColor),
                                  ),
                                  value: e,
                                ),
                              )
                              .toList(),
                          onChanged: (newVal) {
                            setState(() {
                              categoryid = newVal['id'];
                              profile.parameters.location = 'switch';

                              profile.parameters.filterType = categoryid;
                              BlocProvider.of<TagsBloc>(context)
                                  .dispatch(FilterListingTagEvent(
                                profile: profile,
                              ));
                            });
                          },
                          isExpanded: true,
                          hint: Center(
                            child: profile.parameters.filterType == null
                                ? MyText(
                                    value:
                                        'listingtags_filter_label_object'.tr(),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.darkGray)
                                : MyText(
                                    value: idCategory.firstWhere((element) =>
                                        element['id'] ==
                                        categoryid)['type_label'],
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.darkGray),
                          ),
                        ),
                      ),
                    ),
//                          People
                    Container(
                      width: screenWidth * 274,
                      height: screenHeight * 35,
                      margin: EdgeInsets.only(top: screenHeight * 7.008),
                      padding: EdgeInsets.only(right: 5.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          items: idMembers
                              .map(
                                (e) => DropdownMenuItem(
                                  child: Center(
                                    child: MyText(
                                        value: e['firstName'] != null
                                            ? e['firstName']
                                            : " ",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.textColor),
                                  ),
                                  value: e,
                                ),
                              )
                              .toList(),
                          onChanged: (newVal) {
                            setState(() {
                              profile.userGeneralInfo.idMember =
                                  newVal['idMember'];
                              profile.parameters.location = 'switch';

                              profile.parameters.filterIdMembre =
                                  newVal['idMember'];
                              BlocProvider.of<TagsBloc>(context)
                                  .dispatch(FilterListingTagEvent(
                                profile: profile,
                              ));
                            });
                          },
                          isExpanded: true,
                          hint: Center(
                              child: profile.parameters.filterIdMembre == null
                                  ? MyText(
                                      value: 'pets_label_name'.tr(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.darkGray)
                                  : MyText(
                                      value: idMembers.firstWhere((element) =>
                                          element['idMember'] ==
                                          profile.userGeneralInfo
                                              .idMember)['firstName'],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.darkGray)),
                        ),
                      ),
                    ),
//                          People
                    Container(
                        width: screenWidth * 274,
                        margin: EdgeInsets.only(top: screenHeight * 7.008),
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: TextField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: DescController,
                          onSubmitted: (String value) {
                            setState(() {
                              DescController.text = value;
                              profile.parameters.location = 'switch';

                              profile.parameters.filterDescriptionSn = value;
                              BlocProvider.of<TagsBloc>(context)
                                  .dispatch(FilterListingTagEvent(
                                profile: profile,
                              ));
                            });
                          },
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText:
                                "listingtags_filter_label_descriptionsn".tr(),
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: ColorConstant.greyTextColor),
                          ),
                        )),
                    GestureDetector(
                      child: Container(
                        width: screenWidth * 274,
                        height: screenHeight * 35,
                        margin: EdgeInsets.only(top: screenHeight * 7.008),
                        padding: EdgeInsets.only(right: 5.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Center(
                            child: MyText(
                                value: "objecttag_btn_reset".tr(),
                                fontSize: 14,
                                color: ColorConstant.greyTextColor)),
                      ),
                      onTap: () {
                        profile.parameters.location = 'switch';
                        BlocProvider.of<TagsBloc>(context)
                            .dispatch(FilterListingTagEvent(
                          profile: profile,
                        ));
                      },
                    ),
                    Container(
                        width: screenWidth * 374,
                        margin: EdgeInsets.only(top: screenHeight * 2.008),
                        padding: EdgeInsets.only(
                            bottom: (screenHeight * 0.68) / 100),
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.white, width: 1.0))),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyText(
                              value: "listingtags_filter_label_category".tr(),
                              color: ColorConstant.filterTextColor,
                              fontSize: 14.0),
                        )),
                    SizedBox(
                      height: 10,
                    ),

                    Container(
                        width: screenWidth * 274,
                        margin: EdgeInsets.only(
                          top: screenHeight * 6.23,
                          bottom: screenHeight * 3.23,
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: [
                                  GestureDetector(
                                      child: Container(
                                        width: 55.17,
                                        height: 48,
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenHeight * 8.015),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "Assets/Images/iconMedicalSearch.PNG"),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: _isMedicalTag
                                                ? ColorConstant.whiteTextColor
                                                : ColorConstant.boxColor,
                                            boxShadow: [
                                              _isMedicalTag
                                                  ? BoxShadow(
                                                      color: Colors.pink,
                                                      blurRadius: 6.0)
                                                  : BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 6.0)
                                            ]),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _isMedicalTag = !_isMedicalTag;
                                          _isObjectTag = _isObjectTag;
                                          _isPetTag = _isPetTag;
                                          _isKidsTag = false;
                                          cat = "medical";
                                        });
                                      }),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: MyText(
                                          value:
                                              'editprofil_general_label_medical'
                                                  .tr(),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: ColorConstant.whiteTextColor))
                                ],
                              ),
                              SizedBox(width: 3),
                              Column(
                                children: [
                                  GestureDetector(
                                      child: Container(
                                        width: 55.17,
                                        height: 48,
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenHeight * 8.015),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "Assets/Images/iconObjectSearch.PNG"),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: _isObjectTag
                                                ? ColorConstant.whiteTextColor
                                                : ColorConstant.boxColor,
                                            boxShadow: [
                                              _isObjectTag
                                                  ? BoxShadow(
                                                      color: Colors.pink,
                                                      blurRadius: 6.0)
                                                  : BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 6.0)
                                            ]),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _isMedicalTag = _isMedicalTag;
                                          _isObjectTag = !_isObjectTag;
                                          _isPetTag = _isPetTag;
                                          cat = "object";
                                        });
                                      }),
                                  Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: MyText(
                                          value: 'homescree_label_object'.tr(),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: ColorConstant.whiteTextColor))
                                ],
                              ),
                              SizedBox(width: 3),
                              Column(
                                children: [
                                  GestureDetector(
                                      child: Container(
                                        width: 55.17,
                                        height: 48,
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenHeight * 8.015),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "Assets/Images/iconPetSearch.png"),
                                                fit: BoxFit.cover),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: _isPetTag
                                                ? ColorConstant.whiteTextColor
                                                : ColorConstant.boxColor,
                                            boxShadow: [
                                              _isPetTag
                                                  ? BoxShadow(
                                                      color: Colors.pink,
                                                      blurRadius: 6.0)
                                                  : BoxShadow(
                                                      color: Colors.black26,
                                                      blurRadius: 6.0)
                                            ]),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          _isMedicalTag = _isMedicalTag;
                                          _isObjectTag = _isObjectTag;
                                          _isPetTag = !_isPetTag;
                                          cat = "Pet";
                                        });
                                      }),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: MyText(
                                        value: 'homescree_label_pet'.tr(),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: ColorConstant.whiteTextColor),
                                  )
                                ],
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ])); // onPressed: () => _SomeFunction(),
  }

  medicalTagsWidget(Profile profile, bool initExpandedMedical) {
    print(profile.userGeneralInfo.tagsList.toJson());
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
            key: GlobalKey(),
            initiallyExpanded: initExpandedMedical,
            onExpansionChanged: (value) {
              setState(() {
                initiallyExpandedMedical = value;
                if (initiallyExpandedMedical == false) {
                  for (int i = 0; i < initialMedical.length; i++) {
                    initialMedical[i] = false;
                  }
                }
                if (value == true) {
                  setState(() {
                    initiallyExpandedObject = false;
                    initiallyExpandedPet = false;
                  });
                }
              });
            },
            title: "editprofil_medical_subtitle_medicaltags".tr(),
            type: "medical",
            children: <Widget>[
              ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor.withOpacity(.00)),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: profile.userGeneralInfo.tagsList.medicalTag.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
/* profile.userGeneralInfo.tagsList.medicalTag.firstWhere((element) => element['sn']  */

                    return MyTagItemSwitch(
                        key: GlobalKey(),
                        initiallyExpanded: initialMedical[index],
                        onExpansionChanged: (value) {
                          setState(() {
                            initialMedical[index] = value;
                            for (int i = 0; i < initialMedical.length; i++) {
                              if (i != index) {
                                initialMedical[i] = false;
                              }
                            }
                          });
                        },
                        headerTitle: profile.userGeneralInfo.tagsList
                            .medicalTag[index].firstName,
                        headerImage: profile.userGeneralInfo.tagsList
                            .medicalTag[index].pictureProfileUrl,
                        idMembers: profile.userGeneralInfo.tagsList
                            .medicalTag[index].idMember,
                        type: "medical",
                        children: profile
                            .userGeneralInfo.tagsList.medicalTag[index].tags,
                        profil: profile,
                        indexu: index);
                  }),
            ]),
      ),
    );
  }

  objectTagsWidget(Profile profile, bool initialEx) {
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
              key: GlobalKey(),
              initiallyExpanded: initialEx,
              onExpansionChanged: (value) {
                setState(() {
                  initiallyExpandedObject = value;
                  if (initiallyExpandedObject == false) {
                    for (int i = 0; i < initialObject.length; i++) {
                      initialObject[i] = false;
                    }
                  }
                  if (value == true) {
                    setState(() {
                      initiallyExpandedMedical = false;
                      initiallyExpandedPet = false;
                    });
                  }
                });
              },
              title: "editprofil_medical_subtitle_objecttags".tr(),
              type: "object",
              children: <Widget>[
                ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(
                            height: 0.45,
                            color: ColorConstant.dividerColor.withOpacity(.00)),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount:
                        profile.userGeneralInfo.tagsList.objectTag.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return MyTagItemSwitch(
                          key: GlobalKey(),
                          initiallyExpanded: initialObject[index],
                          onExpansionChanged: (value) {
                            setState(() {
                              initialObject[index] = value;
                              for (int i = 0; i < initialObject.length; i++) {
                                if (i != index) {
                                  initialObject[i] = false;
                                }
                              }
                            });
                          },
                          headerTitle: profile.userGeneralInfo.tagsList
                              .objectTag[index].firstName,
                          headerImage: profile.userGeneralInfo.tagsList
                              .objectTag[index].pictureProfileUrl,
                          idMembers: profile.userGeneralInfo.tagsList
                              .objectTag[index].idMember,
                          type: "object",
                          children: profile
                              .userGeneralInfo.tagsList.objectTag[index].tags,
                          profil: profile,
                          indexu: index);
                    }),
              ])),
    );
  }

  petTagsWidget(Profile profile, bool initialExp) {
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
              key: GlobalKey(),
              initiallyExpanded: initialExp,
              onExpansionChanged: (value) {
                setState(() {
                  initiallyExpandedPet = value;
                });
                if (initiallyExpandedPet == false) {
                  for (int i = 0; i < initialPet.length; i++) {
                    initialPet[i] = false;
                  }
                }
                if (value == true) {
                  setState(() {
                    initiallyExpandedObject = false;
                    initiallyExpandedMedical = false;
                  });
                }
              },
              title: "editprofil_medical_subtitle_pettags".tr(),
              type: "Pets",
              children: <Widget>[
                ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Container(
                            height: 0.45,
                            color: ColorConstant.dividerColor.withOpacity(.00)),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: profile.userGeneralInfo.tagsList.petTag.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return MyTagItemPet(
                          key: GlobalKey(),
                          initiallyExpanded: initialPet[index],
                          onExpansionChanged: (value) {
                            setState(() {
                              initialPet[index] = value;
                              for (int i = 0; i < initialPet.length; i++) {
                                if (i != index) {
                                  initialPet[i] = false;
                                }
                              }
                            });
                          },
                          switchPet: 'switch',
                          headerTitle: profile
                              .userGeneralInfo.tagsList.petTag[index].firstName,
                          headerImage: profile.userGeneralInfo.tagsList
                              .petTag[index].pictureProfileUrl,
                          idPet: profile
                              .userGeneralInfo.tagsList.petTag[index].idPet,
                          type: "Pets",
                          children: profile
                              .userGeneralInfo.tagsList.petTag[index].tags,
                          profil: profile,
                          indexu: index);
                    }),
              ])),
    );
  }

  // switchFilterTag(Profile profile) {
  //   String idMember;

  //   int index, indexu;

  //   if (serialNumbers.contains(serialNumber) == true) {
  //     profile.userGeneralInfo.tagsList.objectTag.forEach((elemnt) {
  //       index = elemnt.tags.lastIndexWhere(
  //           (elemnt2) => elemnt2.tagInfo.serialNumber == serialNumber);
  //     });
  //     profile.userGeneralInfo.tagsList.objectTag.forEach((element) {
  //       idMember = element.tags[index].tagInfo.idMember;
  //     });
  //     indexu = profile.userGeneralInfo.tagsList.objectTag
  //         .indexWhere((element) => element.idMember == idMember);

  //     print("geeeeeeeeeeeeeeeeee$indexu");
  //     print("qqqqqqqqqqqqqqqqqqqqqqq$index");
  //   } else {
  //     // showOverlay(context, "Problems Info ", "cannot find serial number Tag");
  //   }
  // }

  static showOverlay(
      BuildContext context, String headerMessage, String message) {
    Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  dispatchgettoSwitchObjectTag(
      Profile profile, String type, int indexu, int index) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      GoTogetSwitchObjectTagEvent(
        profile: profile,
        type: type,
        indexu: indexu,
        index: index,
      ),
    );
  }

  List<bool> initialPet = [];
  List<bool> initialObject = [];
  List<bool> initialMedical = [];
  List<Map<String, String>> serialNumbers = [];

  @override
  void initState() {
    owner();
    category();
    _isMedicalTag = true;
    _isObjectTag = true;
    _isPetTag = true;
    widget.profile.parameters.filterType = null;
    emailStreamcontroller = StreamController<String>.broadcast();
    emailcontroller.addListener(() {
      emailStreamcontroller.sink.add(emailcontroller.text.trim());
    });

    widget.profile.userGeneralInfo.tagsList != null
        ? widget.profile.userGeneralInfo.tagsList.petTag.forEach((element) {
            initialPet.add(false);
          })
        : null;
    widget.profile.userGeneralInfo.tagsList != null
        ? widget.profile.userGeneralInfo.tagsList.medicalTag.forEach((element) {
            initialMedical.add(false);
          })
        : null;
    widget.profile.userGeneralInfo.tagsList != null
        ? widget.profile.userGeneralInfo.tagsList.objectTag.forEach((element) {
            initialObject.add(false);
          })
        : null;
    widget.profile.userGeneralInfo.tagsList.objectTag.forEach((element) {
      element.tags.forEach((element2) {
        if (element2.tagInfo.active == 1) {
          // mapSerial.addAll(
          //     {'Serial': element2.tagInfo.serialNumber, 'type': 'object'});
          // serialNumbers.add(mapSerial);
          serialNumbers
              .add({'Serial': element2.tagInfo.serialNumber, 'type': 'object'});
        } else {
          serialNumbers.remove(element2.tagInfo.serialNumber);
        }
      });
    });

    widget.profile.userGeneralInfo.tagsList.petTag.forEach((element) {
      element.tags.forEach((element2) {
        if (element2.tagInfo.active == 1) {
          serialNumbers
              .add({'Serial': element2.tagInfo.serialNumber, 'type': 'pet'});
        } else {
          serialNumbers.remove(element2.tagInfo.serialNumber);
        }
      });

      widget.profile.userGeneralInfo.tagsList.medicalTag.forEach((element) {
        element.tags.forEach((element2) {
          if (element2.tagInfo.active == 1) {
            serialNumbers.add(
                {'Serial': element2.tagInfo.serialNumber, 'type': 'medical'});
          } else {
            serialNumbers.remove(element2.tagInfo.serialNumber);
          }
        });
      });
    });

    super.initState();
  }

  bool exist = false;

  dispatchGoToAddEdit(Profile profile) {
    int index, indexu;

    serialNumbers.forEach((element) {
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
            GoTogetSwitchObjectTagEvent(
              profile: profile,
              type: 'object',
              indexu: indexu,
              index: index,
            ),
          );
        } else if (element['type'] == 'pet') {
          for (int i = 0;
              i < profile.userGeneralInfo.tagsList.petTag.length;
              i++) {
            for (int j = 0;
                j < profile.userGeneralInfo.tagsList.petTag[i].tags.length;
                j++) {
              if (profile.userGeneralInfo.tagsList.petTag[i].tags[j].tagInfo
                      .serialNumber ==
                  serialNumber) {
                indexu = i;
                index = j;
                break;
              }
            }
          }
          BlocProvider.of<TagsBloc>(context).dispatch(
            GoTogetSwitchObjectTagEvent(
              profile: profile,
              type: 'pets',
              indexu: indexu,
              index: index,
            ),
          );
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
            GoTogetSwitchObjectTagEvent(
              profile: profile,
              type: 'medical',
              indexu: indexu,
              index: index,
            ),
          );
        } else {}
      }
    });

    if (exist == false) {
      showOverlay(
          context, "problem_infos".tr(), "pets_label_invalidserialnumber".tr());

      //   profile.parameters.serial = serialNumber;
      //   profile.userGeneralInfo.switchTag = 'yes';
      //   profile.parameters.indexu = indexu;
      //   profile.parameters.indext = index;
      //   dispatchVerifyTag(profile);
    }
  }

  dispatchVerifyTag(Profile profile) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      VerifyTagEvent(
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

  void dispatchGoToHome(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/homeProvider',
      arguments: profile,
    );
  }
}
