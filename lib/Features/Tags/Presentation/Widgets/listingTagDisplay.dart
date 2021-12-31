import 'dart:async';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_expansion_tile.dart'
    as custom;
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/my_tags_ItemPet.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/tagExpansionTileItem.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/my_tags_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class ListingTag extends StatefulWidget {
  final Profile profile;
  String viewtypeTag;
  ListingTag({Key key, @required this.profile, @required this.viewtypeTag})
      : super(key: key);
  @override
  ListingTagState createState() => new ListingTagState();
}

class ListingTagState extends State<ListingTag> {
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
  String cat;
  TextEditingController ObjectController = new TextEditingController();
  TextEditingController DescController = new TextEditingController();
  bool _isMedicalTag = false;
  bool _isObjectTag = false;
  bool _isPetTag = false;
  bool initiallyExpandedObject = false;
  bool initiallyExpandedMedical = false;
  bool initiallyExpandedPet = false;

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

  List<Map<String, dynamic>> idMedicalbyMemberes = [];
  List<Map<String, dynamic>> idObjectbyMemberes = [];
  List<Map<String, dynamic>> idPetbyMemberes = [];
  List<Map<String, dynamic>> idCategory = [];

  String thisMember;
  bool expansionTile = false;
  List<Map<String, dynamic>> idMembers = [];
  int indexSearch;
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

  String searchMember;
  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;

    screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;
    return new Scaffold(
        body: Stack(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  screenHeight * 20,
                  expansionTile ? screenHeight * 370 : screenHeight * 150,
                  screenHeight * 20,
                  0),
              child: StreamBuilder(
                  stream: emailStreamcontroller.stream,
                  builder: (context, snapshot) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: MyText(value: '  ', color: Colors.redAccent),
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
                          child: petTagsWidget(profile, initiallyExpandedPet),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    );
                  }),
            ),
          ),
          Container(
            height: screenHeight * 100,
            color: ColorConstant.pinkColor,

            //child: Padding(
            padding: EdgeInsets.fromLTRB(screenWidth * 16, screenHeight * 30,
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
                          ),
                        ),
                      ),
                    
                      MyText(
                          value: "listingtags_title".tr(),
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
                        color: Colors.white,
                      )),
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
                                      value: 'listingtags_filter_label_object'
                                          .tr(),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.darkGray)
                                  : MyText(
                                      value: idCategory.firstWhere((element) =>
                                          element['id'] ==
                                          categoryid)['type_label'],
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.darkGray)),
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
                              searchMember = newVal['idMember'];

                              profile.parameters.filterIdMembre =
                                  newVal['idMember'];
                              BlocProvider.of<TagsBloc>(context)
                                  .dispatch(FilterListingTagEvent(
                                profile: profile,
                              ));
                              print(profile.userGeneralInfo.idMember);
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
                                    color: ColorConstant.darkGray),
                          ),
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
                        child: MediaQuery(
                            data: MediaQuery.of(context).copyWith(
                              textScaleFactor: MediaQuery.of(context)
                                  .textScaleFactor
                                  .clamp(1.0, 1.0),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.visiblePassword,
                              controller: DescController,
                              onSubmitted: (String value) {
                                DescController.text = value;
                                profile.parameters.filterDescriptionSn = value;
                                BlocProvider.of<TagsBloc>(context)
                                    .dispatch(FilterListingTagEvent(
                                  profile: profile,
                                ));
                              },
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                isDense: true,
                                border: InputBorder.none,
                                hintText:
                                    "listingtags_filter_label_descriptionsn"
                                        .tr(),
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: ColorConstant.greyTextColor),
                              ),
                            ))),
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
                          color: ColorConstant.greyTextColor,
                          fontWeight: FontWeight.w500,
                        )),
                      ),
                      onTap: () {
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
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: MyText(
                              value: "listingtags_filter_label_category".tr(),
                              color: ColorConstant.filterTextColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0),
                        )),

                    SizedBox(
                      height: 12,
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
                                          color: ColorConstant.whiteTextColor)),
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
                                        color: ColorConstant.whiteTextColor),
                                  )
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

  medicalTagsWidget(Profile profile, bool initialExpan) {
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
            initiallyExpanded: initiallyExpandedMedical,
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
              /*       ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      Container(
                          height: 0.45,
                          color: ColorConstant.dividerColor.withOpacity(.00)),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: profile.userGeneralInfo.tagsList.medicalTag.length,
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    return MyTagItem(
                      headerTitle: profile
                          .userGeneralInfo.tagsList.medicalTag[index].firstName,
                      headerImage: profile.userGeneralInfo.tagsList
                          .medicalTag[index].pictureProfileUrl,
                      idMembers: profile
                          .userGeneralInfo.tagsList.medicalTag[index].idMember,
                      type: "medical",
                      children: profile
                          .userGeneralInfo.tagsList.medicalTag[index].tags,
                      profil: profile,
                    );
                  }), */

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
                    for (int i = 0;
                        i < profile.userGeneralInfo.tagsList.medicalTag.length;
                        i++) {
                      if (profile.userGeneralInfo.tagsList.medicalTag[i]
                              .idMember ==
                          searchMember) {
                        index = i;
                      }
                    }

                    return MyTagItem(
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
                      return MyTagItem(
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
/*                 ListView.separated(
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
                        headerTitle: profile
                            .userGeneralInfo.tagsList.petTag[index].firstName,
                        headerImage: profile.userGeneralInfo.tagsList
                            .petTag[index].pictureProfileUrl,
                        idPet: profile
                            .userGeneralInfo.tagsList.objectTag[index].idPet,
                        type: "Pets",
                        children:
                            profile.userGeneralInfo.tagsList.petTag[index].tags,
                        profil: profile,
                      );
                    }), */
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

  List<bool> initialPet = [];
  List<bool> initialObject = [];
  List<bool> initialMedical = [];

  @override
  void initState() {
    owner();
    category();
    _isMedicalTag = true;
    _isObjectTag = true;
    _isPetTag = true;

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
    emailStreamcontroller = StreamController<String>.broadcast();
    emailcontroller.addListener(() {
      emailStreamcontroller.sink.add(emailcontroller.text.trim());
    });
    widget.profile.userGeneralInfo.userTags.objectTag.forEach((element) {
      if (element != null) {
        if (element.tagInfo.serialNumber != null) {
          print(element.tagInfo.serialNumber);
          if (element.tagInfo.active == 1) {
            serialNumbers.add(element.tagInfo.serialNumber);
          }
        }
      }
    });
    if (widget.viewtypeTag == 'medical') {
      initiallyExpandedMedical = true;
      initiallyExpandedObject = false;
      initiallyExpandedPet = false;
    }
    if (widget.viewtypeTag == 'object') {
      initiallyExpandedMedical = false;
      initiallyExpandedObject = true;
      initiallyExpandedPet = false;
    }
    if (widget.viewtypeTag == 'pet') {
      initiallyExpandedMedical = false;
      initiallyExpandedObject = false;
      initiallyExpandedPet = true;
    }
    super.initState();
  }

  void dispatchGoToHome(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/homeProvider',
      arguments: profile,
    );
  }
}
