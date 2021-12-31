import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Pets/Presentation/bloc/pets_bloc.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_expansion_tile.dart'
    as custom;
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/ExpandableViewPetMedical.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/ExpandableOtherListPet.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/animationsView.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Core/Utils/text.dart';

class ViewProfilePetDisplay extends StatefulWidget {
  final Profile profile;
  final int index;
  const ViewProfilePetDisplay(
      {Key key, @required this.profile, @required this.index})
      : super(key: key);
  @override
  _ViewProfilePetDisplayState createState() => _ViewProfilePetDisplayState();
}

class _ViewProfilePetDisplayState extends State<ViewProfilePetDisplay> {
  var screenWidth, screenHeight;
  bool _lostEmailPoster = true;
  bool _lostPrintPoster = false;
  bool _objectRecordEmail = false;
  bool _objectRecordPrint = false;
  bool _isRabblesTag = false;
  bool _isCountyTag = false;
  bool _isXRay = false;
  bool _isLetterOfDoctor = false;
  double _petItemWidth = 0.0;
  int _petIndicatorIndex = 0;
  final List<String> petList = [
    "Np",
    "Mp",
    "Ap",
    "Kp",
    "Dp",
    "Sp",
    "Xp",
    "Op",
    "Wp",
  ];
  ScrollController _petScrollController = new ScrollController();
  List<Map<String, dynamic>> idMembers = [];

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
  }


 void scrollListenerWithItemHeight() {
    double itemHeight =
        _petItemWidth; // including padding above and below the list item
    double scrollOffset = _petScrollController.offset / 3;
    int firstVisibleItemIndex =
        scrollOffset < itemHeight ? 0 : ((scrollOffset) ~/ itemHeight);
    _petIndicatorIndex = _petItemWidth == 0.0
        ? firstVisibleItemIndex
        : firstVisibleItemIndex + 1;
    print("scrollOffset        " + scrollOffset.toString());
    setState(() {
      _petIndicatorIndex = scrollOffset == 0.0
          ? firstVisibleItemIndex
          : firstVisibleItemIndex + 1;
    });
  }
 
  List<UserEmergencyContact> listActiveEmerg = [];

  List<Map<String, dynamic>> listActive = [];
  List<Map<String, dynamic>> listInactive = [];
  @override
  void initState() {
    widget.profile.userGeneralInfo.petsInfos[widget.index].preferencePet
        .toJson()
        .forEach((key, value) {
      if (value['value'] == '1') {
        listActive.add(value);
      } else {
        listInactive.add(value);
      }
    });
   widget.profile
                                    .userGeneralInfo
                                    .petsInfos[widget.index]
                                    .emergencyContact
                                    .forEach((element) { 
if(element.active==1){
  listActiveEmerg.add(element);
}
                                    });
    _petScrollController.addListener(scrollListenerWithItemHeight);
    owner();
    super.initState();
  }

  getNamePetAndOwner(String name, String owner, String petType) {
    if (name != null && owner != null && petType != null) {
      return MyText(
          value: name != ''
              ? name +
                  ' ' +
                  "reminders_label_is".tr() +
                  ' \n' +
                  owner +
                  "reminders_label_s".tr() +
                  petType
              : '',
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600);
    }
    if (name != null && petType != null && owner == null) {
      return MyText(
          value: name != ''
              ? name + ' ' + "reminders_label_is".tr() + ' ' + petType
              : '',
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600);
    }
    if (name != null && petType == null && owner == null) {
      return MyText(
          value: name,
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600);
    }
    if (name == null && petType == null && owner == null) {
      return MyText(
          value: '',
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600);
    }
    if (name != null && petType == null && owner != null) {
      return MyText(
          value: name,
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600);
    }
    if (name == null && petType != null && owner != null) {
      return MyText(
          value: '',
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600);
    }
    if (name == null && petType == null && owner != null) {
      return MyText(
          value: '',
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600);
    }
    if (name == null && petType != null && owner == null) {
      return MyText(
          value: '',
          fontSize: 24,
          color: ColorConstant.textColor,
          fontWeight: FontWeight.w600);
    }
  }

  bool vaccines = false;
  _vaccine(Profile profile) {
    return Container(
      margin: EdgeInsets.only(
          top: screenHeight * 0.005,
          right: screenWidth * 0.0627,
          left: screenWidth * 0.0627),
      child: Column(
        children: <Widget>[
          Container(
            child: InkWell(
                onTap: () {
                  setState(() {
                    vaccines = !vaccines;
                  });
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 2.0,
                          ),
                          child: Icon(
                            Icons.check,
                                      color: ColorConstant.pinkColor,
                          )),
                      Expanded(
                        child: MyText(
                            value: "pets_label_vaccines".tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: ColorConstant.textColor),
                      ),
                      SizedBox(
                        width: 22.2,
                      )
                    ],
                  ),
                )),
          ),
          vaccines
              ? Container(
                  padding: EdgeInsets.only(left: 5, top: 0),
                  child: Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 10.5, right: 20.5, ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) => Container(
                                    height: 0.45,
                                    color: ColorConstant.dividerColor
                                        .withOpacity(.00)),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: profile.userGeneralInfo
                                .petsInfos[widget.index].vaccins.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 1.0, ),
                                ),
                                SizedBox(width: 30),
                                profile.userGeneralInfo.petsInfos[widget.index].vaccins[index].label != ''
                                    ? ExpandableListViewDes(
                                        type: 'Vaccines',
                                        profile: profile,
                                        index: index,
                                        vaccines: profile
                                            .userGeneralInfo
                                            .petsInfos[widget.index]
                                            .vaccins[index],
                                        title: profile
                                            .userGeneralInfo
                                            .petsInfos[widget.index]
                                            .vaccins[index]
                                            .label,
                                        desc: profile
                                            .userGeneralInfo
                                            .petsInfos[widget.index]
                                            .vaccins[index]
                                            .description,
                                        attachment: profile
                                                    .userGeneralInfo
                                                    .petsInfos[widget.index]
                                                    .vaccins[index]
                                                    .documents
                                                    .length ==
                                                0
                                            ? false
                                            : true,
                                        documents: profile
                                            .userGeneralInfo
                                            .petsInfos[widget.index]
                                            .vaccins[index]
                                            .documents,
                                        alarm: profile
                                                    .userGeneralInfo
                                                    .petsInfos[widget.index]
                                                    .vaccins[index]
                                                    .reminders
                                                    .length ==
                                                0
                                            ? false
                                            : true,
                                        reminders: profile.userGeneralInfo.petsInfos[widget.index].vaccins[index].reminders,
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
      ),
    );
  }

  bool otherPetInfo = false;
  _otherPetInfo(Profile profile) {
    return Container(
      margin: EdgeInsets.only(
          top: screenHeight * 0.005,
          right: screenWidth * 0.0627,
          left: screenWidth * 0.0627),
      child: Column(
        children: <Widget>[
          Container(
            child: InkWell(
                onTap: () {
                  setState(() {
                    otherPetInfo = !otherPetInfo;
                  });
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 2.0,
                          ),
                          child: Icon(
                            Icons.check,
                                      color: ColorConstant.pinkColor,
                          )),
                      Expanded(
                        child: MyText(
                            value: "pets_label_otherinfo".tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: ColorConstant.textColor),
                      ),
                      SizedBox(
                        width: 22.2,
                      )
                    ],
                  ),
                )),
          ),
          otherPetInfo
              ? Container(
                  padding: EdgeInsets.only(left: 5, top: 0),
                  child: Container(
                    child: Padding(
                      padding:
                          EdgeInsets.only(left: 10.5, right: 20.5, ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) => Container(
                                    height: 0.45,
                                    color: ColorConstant.dividerColor
                                        .withOpacity(.00)),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: profile.userGeneralInfo
                                .petsInfos[widget.index].otherInfo.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              return Stack(children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 1.0, ),
                                ),
                                SizedBox(width: 30),
                                profile.userGeneralInfo.petsInfos[widget.index]
                                            .otherInfo[index].label !=
                                        ''
                                    ? ExpandableOtherViewDes(
                                        type: 'OtherInfo',
                                        profile: profile,
                                        index: index,
                                        otherInfo: profile
                                            .userGeneralInfo
                                            .petsInfos[widget.index]
                                            .otherInfo[index],
                                        title: profile
                                            .userGeneralInfo
                                            .petsInfos[widget.index]
                                            .otherInfo[index]
                                            .label,
                                        desc: profile
                                            .userGeneralInfo
                                            .petsInfos[widget.index]
                                            .otherInfo[index]
                                            .description,
                                        attachment: profile
                                                    .userGeneralInfo
                                                    .petsInfos[widget.index]
                                                    .otherInfo[index]
                                                    .documents
                                                    .length ==
                                                0
                                            ? false
                                            : true,
                                        documents: profile
                                            .userGeneralInfo
                                            .petsInfos[widget.index]
                                            .otherInfo[index]
                                            .documents,
                                        alarm: profile.userGeneralInfo.petsInfos[widget.index].otherInfo[index].reminders.length == 0
                                            ? false
                                            : true,
                                        reminders: profile
                                            .userGeneralInfo
                                            .petsInfos[widget.index]
                                            .otherInfo[index]
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;

    int indexPet = widget.index;

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
                  indexPet: indexPet,
                  idMembers: idMembers),
            ),
          ];
        },
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  profile.userGeneralInfo.userTags.petTag.length != 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 24.0, top: 0),
                          child: profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.name !=
                                  null
                              ? MyText(
                                  value: profile
                                          .userGeneralInfo
                                          .petsInfos[indexPet]
                                          .generalInfo
                                          .name +
                                      "pets_label_spettags".tr(),
                                  fontSize: 18.0,
                                  color: ColorConstant.pinkColor,
                                  fontWeight: FontWeight.w600)
                              : MyText(
                                  value: "pets_label_petsspettags".tr(),
                                  fontSize: 18.0,
                                  color: ColorConstant.pinkColor,
                                  fontWeight: FontWeight.w600),
                        )
                      : Container(),
                  SizedBox(
                    height: 0,
                  ),
                  profile.userGeneralInfo.petsInfos[indexPet].petTag.length != 0
                      ? Container(
                          height: 135,
                          //   color: Colors.white,
                          width: double.maxFinite,
                          child: ListView.builder(
                              shrinkWrap: true,
                              controller: _petScrollController,
                              scrollDirection: Axis.horizontal,
                              itemCount: profile.userGeneralInfo
                                  .petsInfos[indexPet].petTag.length,
                              itemBuilder: (BuildContext context, int index) {
                                _petItemWidth = screenWidth * 0.32;
                                if (petList.length <= index) {
                                  return Container(
                                    width: screenWidth * 0.40,
                                  );
                                }

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
                                          //  spreadRadius: 7.0,
                                          blurRadius: 5.0,
                                        ),
                                      ]),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
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
                                                  .imgBackgroundColor
                                                  .withOpacity(0.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: Offset(0,
                                                      0), // changes position of shadow
                                                ),
                                              ],
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6)),
                                              image: profile
                                                          .userGeneralInfo
                                                          .petsInfos[indexPet]
                                                          .petTag[index]
                                                          .tagInfo
                                                          .pictureUrl !=
                                                      null
                                                  ? DecorationImage(
                                                      image: NetworkImage(
                                                          profile
                                                              .userGeneralInfo
                                                              .userTags
                                                              .petTag[index]
                                                              .tagInfo
                                                              .pictureUrl),
                                                      fit: BoxFit.cover)
                                                  : profile
                                                              .userGeneralInfo
                                                              .petsInfos[indexPet]
                                                              .generalInfo
                                                              .idType !=
                                                          null
                                                      ? profile.parameters.petTypesList[profile.userGeneralInfo.petsInfos[indexPet].generalInfo.idType - 1]['pet_type_label'] == "dog"
                                                          ? DecorationImage(image: AssetImage("Assets/Images/cat.png"))
                                                          : profile.parameters.petTypesList[profile.userGeneralInfo.petsInfos[indexPet].generalInfo.idType - 1]['pet_type_label'] == "dog"
                                                              ? DecorationImage(image: AssetImage("Assets/Images/dog.png"))
                                                              : DecorationImage(image: AssetImage("Assets/Images/otherpet.png"))
                                                      : DecorationImage(image: AssetImage("Assets/Images/otherpet.png"))),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        // Flexible(
                                        //   child: MyText(
                                        //       value: profile
                                        //               .userGeneralInfo
                                        //               .petsInfos[indexPet]
                                        //               .petTag[index]
                                        //               .tagInfo
                                        //               .tagLabel ??
                                        //           " ",
                                        //       maxLines: 1,
                                        //       overflow: TextOverflow.ellipsis,
                                        //       color: ColorConstant.pinkColor,
                                        //       fontSize: 10,
                                        //       fontWeight: FontWeight.w600),
                                        // ),
                                        Flexible(
                                          child: MyText(
                                              value: "pets_label_code".tr() + "-" +
                                                  profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .petTag[index]
                                                      .tagInfo
                                                      .serialNumber,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              color: ColorConstant.darkGray,
                                              fontSize: 8,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Container(),
                      profile    .userGeneralInfo.petsInfos[indexPet].petTag.length < 3
                        ? Container()
                        :
                             
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List<Widget>.generate(
                                    (profile    .userGeneralInfo.petsInfos[indexPet].petTag.length /
                                            2)
                                        .round(), (int index) {
                                  return Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _petIndicatorIndex == index 
                                          ? ColorConstant.activeIndicatorColor
                                          : ColorConstant.indicatorColor,
                                    ),
                                  );
                                }).toList(),
                              
                            
                          ),
                 
//            Contact Setting
                  profile.userGeneralInfo.petsInfos[indexPet].emergencyContact
                                  .length !=
                              0 ||
                          listActive.length != 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 4.064) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: MyText(
                              value: "pets_label_contactsetting".tr(),
                              fontSize: 18.0,
                              color: ColorConstant.pinkColor,
                              fontWeight: FontWeight.w600),
                        )
                      : Container(),
SizedBox(height: 10,),
                  profile.userGeneralInfo.petsInfos[indexPet].emergencyContact
                              .length !=
                          0
                      ? Container(
                          margin: EdgeInsets.only(
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627,
                          ),
                          child: custom.ExpansionTile(
                            headerMargin: EdgeInsets.symmetric(horizontal: 0.0),
                            headerPadding: EdgeInsets.symmetric(horizontal: 0),
                            headerMinHeight: 0,
                            title: MyText(
                                value: "pets_label_contactscanned".tr(),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: ColorConstant.textColor),
                            trailing: Container(),
                            leading: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 2.0,
                                ),
                                child: Icon(
                                  Icons.check,
                                      color: ColorConstant.pinkColor,
                                )),
                            children: <Widget>[
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: listActiveEmerg
                                    .length,
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
                                              value: listActiveEmerg[index]
                                                      .firstName +
                                                  ' ' +
                                                 listActiveEmerg[index]
                                                      .lastName,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstant.textColor,
                                            ),
listActiveEmerg[index]
                                                  .tel==null||listActiveEmerg[index]
                                                  .tel==''?SizedBox(): MyText(
                                              value: profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .emergencyContact[index]
                                                  .tel,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstant.textColor,
                                            ),
                                            MyText(
                                              value: listActiveEmerg[index]
                                                  .mail,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstant.textColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10,)
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(),
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
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.textColor,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Container(),

//            Pet Information
                  Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 4.064) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    child: MyText(
                        value: "pets_label_petinformation".tr(),
                        fontSize: 18.0,
                        color: ColorConstant.pinkColor,
                        fontWeight: FontWeight.w600),
                  ),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                              .name !=
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.005,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 2.0,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                      color: ColorConstant.pinkColor,
                                  )),
                              Flexible(
                                child: MyText(
                                    value: "pets_label_name".tr() + ": ",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.textColor),
                              ),
                              Flexible(
                                child: MyText(
                                  value: profile.userGeneralInfo
                                      .petsInfos[indexPet].generalInfo.name,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.textColor,
                                ),
                              ),
                            ],
                          ))
                      : Container(),

                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                              .idMember !=
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.005,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 2.0,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                      color: ColorConstant.pinkColor,
                                  )),
                              Flexible(
                                child: MyText(
                                    value: "pets_label_owner".tr() + ": ",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.textColor),
                              ),
                              Flexible(
                                  child: MyText(
                                      value: profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .generalInfo
                                                  .idMember !=
                                              null
                                          ? idMembers.firstWhere((element) =>
                                                  element['idMember'] ==
                                                  profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .idMember)['firstName'] ??
                                              ' '
                                          : ' ',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.textColor))
                            ],
                          ))
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                              .idType !=
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.005,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 2.0,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                      color: ColorConstant.pinkColor,
                                  )),
                              Flexible(
                                child: MyText(
                                    value: "pets_label_type".tr() + ": ",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.textColor),
                              ),
                              Flexible(
                                  child: MyText(
                                      value: profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .generalInfo
                                                  .idType !=
                                              null
                                          ? profile.parameters.petTypesList[
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .idType -
                                                  1]['pet_type_label']
                                          : ' ',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.textColor))
                            ],
                          ))
                      : Container(),

                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                              .idGender !=
                          null
                      ? Container(
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.005,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 2.0,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                      color: ColorConstant.pinkColor,
                                  )),
                              Flexible(
                                child: MyText(
                                    value: "pets_label_sex".tr() + ": ",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.textColor),
                              ),
                              Flexible(
                                  child: MyText(
                                      value: profile
                                                  .userGeneralInfo
                                                  .petsInfos[indexPet]
                                                  .generalInfo
                                                  .idGender !=
                                              null
                                          ? profile.parameters.genderList[
                                              profile
                                                      .userGeneralInfo
                                                      .petsInfos[indexPet]
                                                      .generalInfo
                                                      .idGender -
                                                  1]['gendre_label']
                                          : '',
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.textColor))
                            ],
                          ))
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .heightweight.heightCm ==
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.heightweight.heightInch ==
                              null
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.005,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 2.0,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                      color: ColorConstant.pinkColor,
                                  )),
                              Flexible(
                                child: MyText(
                                    value: "pets_label_height".tr() + ": ",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.textColor),
                              ),
                              Flexible(
                                child: profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .heightweight
                                                .heightInch !=
                                            null &&
                                        profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .heightweight
                                                .heightCm !=
                                            null
                                    ? MyText(
                                        value: profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .heightweight
                                                .heightInch
                                                .toString() +
                                            "”" +
                                            " (" +
                                            profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .heightweight
                                                .heightCm
                                                .toString() +
                                            " " +
                                            "pets_label_cm".tr() +
                                            ")",
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.textColor)
                                    : profile.userGeneralInfo.petsInfos[indexPet].generalInfo.heightweight.heightInch != null &&
                                            profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .heightweight
                                                    .heightCm ==
                                                null
                                        ? MyText(
                                            value: profile.userGeneralInfo.petsInfos[indexPet].generalInfo.heightweight.heightInch.toString() + "”",
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.textColor)
                                        : MyText(
                                            value: profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .heightweight
                                                    .heightCm
                                                    .toString() +
                                                " " +
                                                "pets_label_cm".tr(),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.textColor,
                                          ),
                              ),
                            ],
                          )),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .heightweight.weightKg ==
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.heightweight.weightLbs ==
                              null
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.005,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 2.0,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                      color: ColorConstant.pinkColor,
                                  )),
                              Flexible(
                                child: MyText(
                                    value: "pets_label_weight".tr() + ": ",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.textColor),
                              ),
                              Flexible(
                                child: profile.userGeneralInfo.petsInfos[indexPet].generalInfo.heightweight.weightKg != null &&
                                        profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .heightweight
                                                .weightLbs !=
                                            null
                                    ? MyText(
                                        value: profile.userGeneralInfo.petsInfos[indexPet].generalInfo.heightweight.weightKg.toString() +
                                            " " +
                                            "pets_label_kg".tr() +
                                            " (" +
                                            profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .heightweight
                                                .weightLbs
                                                .toString() +
                                            " " +
                                            "pets_label_lbs".tr() +
                                            ")",
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.textColor)
                                    : profile.userGeneralInfo.petsInfos[indexPet].generalInfo.heightweight.weightKg != null &&
                                            profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .heightweight
                                                    .weightLbs ==
                                                null
                                        ? MyText(
                                            value: profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .heightweight
                                                    .weightKg
                                                    .toString() +
                                                " " +
                                                "pets_label_kg".tr(),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.textColor)
                                        : MyText(
                                            value: profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .heightweight
                                                    .weightLbs
                                                    .toString() +
                                                " " +
                                                "pets_label_lbs".tr(),
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.textColor,
                                          ),
                              ),
                            ],
                          )),
                  (profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                      .microscopic.michrochipNumber ==
                                  null ||
                              profile
                                      .userGeneralInfo
                                      .petsInfos[indexPet]
                                      .generalInfo
                                      .microscopic
                                      .michrochipNumber ==
                                  '') &&
                          (profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.microscopic.note ==
                                  null ||
                              profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.microscopic.note ==
                                  '')
                      ? Container()
                      : Container(
                          margin: EdgeInsets.only(
                              top: screenHeight * 0.0123,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: custom.ExpansionTile(
                            headerMargin: EdgeInsets.symmetric(horizontal: 0.0),
                            headerPadding: EdgeInsets.symmetric(horizontal: 0),
                            headerMinHeight: 0,
                            title: MyText(
                                value: "pets_label_microchiped".tr(),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                                color: ColorConstant.textColor),
                            trailing: Container(),
                            leading: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 2.0,
                                ),
                                child: Icon(
                                  Icons.check,
                                      color: ColorConstant.pinkColor,
                                )),
                            children: <Widget>[
                              Container(
                                width: screenWidth,
                                margin: EdgeInsets.only(
                                    left: (screenWidth * 14) / 100, top: 0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .microscopic
                                                    .michrochipNumber ==
                                                null ||
                                            profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .microscopic
                                                    .michrochipNumber ==
                                                ''
                                        ? Container()
                                        : MyText(
                                            value: profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .microscopic
                                                .michrochipNumber,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.textColor),
                                    profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .microscopic
                                                    .note ==
                                                null ||
                                            profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .microscopic
                                                    .note ==
                                                ''
                                        ? Container()
                                        : MyText(
                                            value: profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .microscopic
                                                .note,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.textColor),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .breed !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.breed !=
                              ''
                      ? Container(
                          margin: EdgeInsets.only(
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 2.0,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                      color: ColorConstant.pinkColor,
                                  )),
                              Flexible(
                                child: MyText(
                                    value: "pets_label_breed".tr() + ": ",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.textColor),
                              ),
                              Flexible(
                                  child: MyText(
                                      value: profile
                                          .userGeneralInfo
                                          .petsInfos[indexPet]
                                          .generalInfo
                                          .breed,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.textColor))
                            ],
                          ))
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .color !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.color !=
                              ''
                      ? Container(
                          margin: EdgeInsets.only(
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 2.0,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                      color: ColorConstant.pinkColor,
                                  )),
                              Flexible(
                                child: MyText(
                                    value: "pets_label_color".tr() + ": ",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.textColor),
                              ),
                              Flexible(
                                  child: MyText(
                                      value: profile
                                          .userGeneralInfo
                                          .petsInfos[indexPet]
                                          .generalInfo
                                          .color,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.textColor))
                            ],
                          ))
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .distinctsSigns !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.distinctsSigns !=
                              ''
                      ? Container(
                          margin: EdgeInsets.only(
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 2.0,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                      color: ColorConstant.pinkColor,
                                  )),
                              Flexible(
                                child: MyText(
                                    value: "pets_label_distinctivesigns".tr() +
                                        ": ",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.textColor),
                              ),
                              Flexible(
                                  child: MyText(
                                      value: profile
                                          .userGeneralInfo
                                          .petsInfos[indexPet]
                                          .generalInfo
                                          .distinctsSigns,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.textColor))
                            ],
                          ))
                      : Container(),
//            Pet medical & Diet
                  profile.userGeneralInfo.petsInfos[indexPet].vaccins.length !=
                              0 ||
                          profile.userGeneralInfo.petsInfos[indexPet].otherInfo
                                  .length !=
                              0 ||
                          (profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.diet !=
                                  null &&
                              profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.diet !=
                                  '')
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 4.064) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: MyText(
                              value: "pets_label_petdiet".tr() + ": ",
                              fontSize: 18.0,
                              color: ColorConstant.pinkColor,
                              fontWeight: FontWeight.w600),
                        )
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].vaccins.length !=
                          0
                      ? Row(
                          children: <Widget>[
                            Flexible(
                              child: _vaccine(profile),
                            ),
                          ],
                        )
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].otherInfo
                              .length !=
                          0
                      ? Row(
                          children: <Widget>[
                            Flexible(
                              child: _otherPetInfo(profile),
                            ),
                          ],
                        )
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .diet !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.diet !=
                              ''
                      ? Container(
                          margin: EdgeInsets.only(
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 2.0,
                                  ),
                                  child: Icon(
                                    Icons.check,
                                      color: ColorConstant.pinkColor,
                                  )),
                              Flexible(
                                child: MyText(
                                    value: "pets_label_diet".tr() + ": ",
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConstant.textColor),
                              ),
                              Flexible(
                                  child: MyText(
                                      value: profile.userGeneralInfo
                                          .petsInfos[indexPet].generalInfo.diet,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: ColorConstant.textColor))
                            ],
                          ))
                      : Container(),
//            Thank You Note
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .thankYouMsg !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.thankYouMsg !=
                              ''
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 4.064) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: MyText(
                              value: "pets_label_thankyou".tr() + ": ",
                              fontSize: 18.0,
                              color: ColorConstant.pinkColor,
                              fontWeight: FontWeight.w600),
                        )
                      : Container(),
                  Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 0.99) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 2.0,
                      ),
                      child: MyText(
                          value: profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.thankYouMsg ??
                              ' ',
                          fontSize: 14.0,
                          color: ColorConstant.textColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),

//            Object Records
                  Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 4.064) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: MyText(
                                value: "pets_label_objectrecords".tr(),
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
                  _objectRecordWidget(),

//            Lost and Found Poster
                  Container(
                      margin: EdgeInsets.only(
                          top: (screenHeight * 4.064) / 100,
                          right: screenWidth * 0.0627,
                          left: screenWidth * 0.0627),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: MyText(
                                  value: "pets_label_poster".tr(),
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
                          ])),
                  _lost_And_foundPoster_Widget(),

                  Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 4.064) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    height: 1.0,
                    color: ColorConstant.textColor.withOpacity(0.3),
                  ),

//            Information not supplied
                  Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 4.064) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
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
                  profile.userGeneralInfo.userTags.petTag.length == 0
                      ? Padding(
                          padding: const EdgeInsets.only(left: 24.0, top: 20),
                          child: profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.name !=
                                  null
                              ? MyText(
                                  value: profile
                                          .userGeneralInfo
                                          .petsInfos[indexPet]
                                          .generalInfo
                                          .name +
                                      "pets_label_spettags".tr(),
                                  fontSize: 18.0,
                                  color: ColorConstant.pinkColor,
                                  fontWeight: FontWeight.w600,
                                )
                              : MyText(
                                  value: "pets_label_pettags".tr(),
                                  fontSize: 18.0,
                                  color: ColorConstant.pinkColor,
                                  fontWeight: FontWeight.w600),
                        )
                      : Container(),
//            Contact Settings
                  profile.userGeneralInfo.petsInfos[indexPet].emergencyContact
                                  .length ==
                              0 ||
                          listInactive.length != 0
                      ? Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 4.064) / 100,
                              right: screenWidth * 0.0627,
                              left: screenWidth * 0.0627),
                          child: MyText(
                              value: "pets_label_contactsetting".tr(),
                              fontSize: 18.0,
                              color: ColorConstant.pinkColor,
                              fontWeight: FontWeight.w600),
                        )
                      : Container(),

                  profile.userGeneralInfo.petsInfos[indexPet].emergencyContact
                              .length ==
                          0
                      ? Container(
                          margin: EdgeInsets.only(
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627,
                          ),
                          child: custom.ExpansionTile(
                            headerMargin: EdgeInsets.symmetric(horizontal: 0.0),
                            headerPadding: EdgeInsets.symmetric(horizontal: 0),
                            headerMinHeight: 0,
                            title: MyText(
                                value: "pets_label_contactscanned".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                            trailing: Container(),
                            leading: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 2.0,
                              ),
                              child: Icon(
                                Icons.clear,
                                color: ColorConstant.lightGreyTextColor,
                                size: 18,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                      SizedBox(height: 8,),
                  listInactive.length > 0
                      ? ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: listInactive.length,
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
                                      Icons.clear,
                                      color: ColorConstant.lightGreyTextColor,
                                      size: 18,
                                    ),
                                  ),
                                  MyText(
                                      value: listInactive[index]
                                          ['acces_label_txt'],
                                      fontSize: 14.0,
                                      color: ColorConstant.lightGreyTextColor,
                                      fontWeight: FontWeight.w600),
                                ],
                              ),
                            );
                          },
                        )
                      : Container(),
//            Pet Information
           ((   profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .distinctsSigns ==
                              null ||
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.distinctsSigns ==
                              '')&&( profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                              .name ==
                          null)&&( profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                              .idMember ==
                          null)&&( profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                              .idType ==
                          null)&&( profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .heightweight.heightCm !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.heightweight.heightInch !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.heightweight.heightFt !=
                              null)&&(  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .heightweight.weightKg !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.heightweight.weightLbs !=
                              null)&&(profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                      .microscopic.michrochipNumber !=
                                  null &&
                              profile
                                      .userGeneralInfo
                                      .petsInfos[indexPet]
                                      .generalInfo
                                      .microscopic
                                      .michrochipNumber !=
                                  '') ||
                          (profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.microscopic.note !=
                                  null &&
                              profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.microscopic.note !=
                                  '')&&( profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .color ==
                              null ||
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.color ==
                              '')&&( profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .breed ==
                              null ||
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.breed ==
                              '' )&&( profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .distinctsSigns ==
                              null ||
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.distinctsSigns ==
                              ''))   ?    Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 4.064) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    child: MyText(
                        value: "pets_label_petinformation".tr(),
                        fontSize: 18.0,
                        color: ColorConstant.pinkColor,
                        fontWeight: FontWeight.w600),
                  ):Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                              .name ==
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
                                value: "pets_label_name".tr() + " ",
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),

                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                              .idMember ==
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
                                value: "pets_label_owner".tr() + " ",
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                              .idType ==
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
                                value: "pets_label_type".tr() + " ",
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),

                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
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
                                value: "pets_label_gender".tr() + " ",
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .heightweight.heightCm !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.heightweight.heightInch !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.heightweight.heightFt !=
                              null
                      ? Container()
                      : Container(
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
                                value: "pets_label_height".tr() + " ",
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        ),

                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .heightweight.weightKg !=
                              null &&
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.heightweight.weightLbs !=
                              null
                      ? Container()
                      : Container(
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
                                value: "pets_label_weight".tr() + " ",
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        ),

                  (profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                      .microscopic.michrochipNumber !=
                                  null &&
                              profile
                                      .userGeneralInfo
                                      .petsInfos[indexPet]
                                      .generalInfo
                                      .microscopic
                                      .michrochipNumber !=
                                  '') ||
                          (profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.microscopic.note !=
                                  null &&
                              profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.microscopic.note !=
                                  '')
                      ? Container()
                      : Container(
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
                                value: "pets_label_microchiped".tr() + " ",
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        ),

                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .breed ==
                              null ||
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.breed ==
                              '' 
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
                                value: "pets_label_breed".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .color ==
                              null ||
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.color ==
                              ''
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
                                value: "pets_label_color".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .distinctsSigns ==
                              null ||
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.distinctsSigns ==
                              ''
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
                                value: "pets_label_distinctivesigns".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),

                 
                 

//            Pet Medical & Diet
               ( profile.userGeneralInfo.petsInfos[indexPet].vaccins.length ==
                              0 &&
                          profile.userGeneralInfo.petsInfos[indexPet].otherInfo
                                  .length ==
                              0 &&
                          (profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.diet ==
                                  null ||
                              profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.diet ==
                                  ''))
                      ?     Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 4.064) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    child: MyText(
                        value: "pets_label_petdiet".tr(),
                        fontSize: 18.0,
                        color: ColorConstant.pinkColor,
                        fontWeight: FontWeight.w600),
                  ):Container(),

                  profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                  .diet ==
                              null ||
                          profile.userGeneralInfo.petsInfos[indexPet]
                                  .generalInfo.diet ==
                              ''
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
                                value: "pets_label_diet".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].vaccins.length ==
                          0
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
                                value: "pets_label_vaccines".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),
                  profile.userGeneralInfo.petsInfos[indexPet].otherInfo
                              .length ==
                          0
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
                                value: "pets_label_otherinfo".tr(),
                                fontSize: 14.0,
                                color: ColorConstant.lightGreyTextColor,
                                fontWeight: FontWeight.w600),
                          ]),
                        )
                      : Container(),
                  SizedBox(
                    height: (screenHeight * 8.6) / 100,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, left: 12, right: 12),
              child: MyButton(
                title: "pets_btn_edit".tr(),
                height: 46.0,
                titleSize: 14,
                cornerRadius: 8,
                fontWeight: FontWeight.w600,
                titleColor: Color(0xffEC1C40),
                btnBgColor: ColorConstant.boxColor,
                onPressed: () {
                  BlocProvider.of<PetsBloc>(context).dispatch(
                    GoToEditProfilePetDisplayEvent(
                        profile: widget.profile, index: indexPet),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  _lost_And_foundPoster_Widget() {
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
                  _lostPrintPoster = !_lostPrintPoster;
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
                        color: _lostPrintPoster
                            ? ColorConstant.pinkColor
                            : ColorConstant.boxColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "Assets/Images/print-red.png",
                      color: _lostPrintPoster
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
                      value: "editprofil_medical_btn_print".tr(),
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
                  _lostEmailPoster = !_lostEmailPoster;
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
                        color: _lostEmailPoster
                            ? ColorConstant.pinkColor
                            : ColorConstant.boxColor,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Center(
                      child: Image.asset(
                        "Assets/Images/email-red.png",
                        color: _lostEmailPoster
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
        ));
  }

  _objectRecordWidget() {
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
                      value: "editprofil_medical_btn_print".tr(),
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
        ));
  }

  void dispatchGoToHelp(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/helpProvider',
      arguments: profile,
    );
  }
}
