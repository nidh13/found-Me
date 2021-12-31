import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_expansion_tile.dart'
    as custom;
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/animationViewTag.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ViewObjectTagDisplay extends StatefulWidget {
  final Profile profile;
  final String type;
  final int indexu;
  final int index;

  const ViewObjectTagDisplay({
    Key key,
    @required this.profile,
    @required this.type,
    @required this.indexu,
    @required this.index,
  }) : super(key: key);
  @override
  _ViewObjectTagDisplayState createState() => _ViewObjectTagDisplayState();
}

class _ViewObjectTagDisplayState extends State<ViewObjectTagDisplay> {
  var screenWidth, screenHeight;
  bool _lostEmailPoster = true;
  bool _lostPrintPoster = false;
  bool _objectRecordEmail = false;
  bool _objectRecordPrint = false;

  List<Documents> documentAttachment = [];
  List<Reminders> remindersList = [];
  int nombrebolckAttachment;

  bool _attachment = true;
 List<UserEmergencyContact> listActiveEmerg=[];
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

  @override
  void initState() {
    if (widget.type == "object") {
      widget.profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
          .tags[widget.index].otherInfo
          .forEach((element2) {
        element2.documents.forEach((docum) {
          print(element2.documents.length);
          documentAttachment.add(docum);

          nombrebolckAttachment = documentAttachment.length;
        });
      });

      widget.profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
          .tags[widget.index].otherInfo
          .forEach((element2) {
        element2.reminders.forEach((remind) {
          if (remind != null) {
            remindersList.add(remind);
          }
        });
      });
    } else {
      if (widget.type == "medical") {
        widget.profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
            .tags[widget.index].otherInfo
            .forEach((element2) {
          element2.documents.forEach((docum) {
            documentAttachment.add(docum);

            nombrebolckAttachment = documentAttachment.length;
          });
        });

        widget.profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
            .tags[widget.index].otherInfo
            .forEach((element2) {
          element2.reminders.forEach((remind) {
            if (remind != null) {
              remindersList.add(remind);
            }
          });
        });
      }
    }
    widget.type=='object'?   widget.profile.userGeneralInfo.tagsList.objectTag[widget.indexu]
            .tags[widget.index].emergencyContactUser
                                    .forEach((element) { 
if(element.active==1){
  listActiveEmerg.add(element);
}
                                    }):    widget.profile.userGeneralInfo.tagsList.medicalTag[widget.indexu]
            .tags[widget.index]
                                    .emergencyContactUser
                                    .forEach((element) { 
if(element.active==1){
  listActiveEmerg.add(element);
}
                                    });
    owner();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;
    String type = widget.type;

    if (type == "object") {
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
          extendBody: true,
          body: NestedScrollView(
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
                      indexu: widget.indexu,
                      index: widget.index,
                      type: widget.type,
                      idMembers: idMembers),
                ),
              ];
            },
            body: Column(
              children: [
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
                            value: "objecttag_bloctitle_contact".tr(),
                            fontSize: 18.0,
                            color: ColorConstant.pinkColor,
                            fontWeight: FontWeight.w600),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            top: screenHeight * 0.005,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627),
                        child: custom.ExpansionTile(
                          headerMargin: EdgeInsets.symmetric(horizontal: 0.0),
                          headerPadding: EdgeInsets.symmetric(horizontal: 0),
                          headerMinHeight: 0,
                          title: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: MyText(
                                value: "objecttag_blocinfo_contact".tr(),
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
   (profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo.mobile !=null||profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo.codePhone!='') && (profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo.mobile !=null||profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo.codePhone!='') ?SizedBox(): MyText(
                                            value: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo.codePhone+profile
                                            .userGeneralInfo
                                            .tagsList
                                            .objectTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo.mobile,
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
                      ),
                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowLiveChat
                                  .active ==
                              1
                          ? Container(
                              margin: EdgeInsets.only(
                                  right: screenWidth * 0.0627,
                                  left: screenWidth * 0.0627),
                              child: custom.ExpansionTile(
                                headerMargin:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                headerPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                headerMinHeight: 0,
                                title: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                      value: "objecttag_label_allowchat".tr(),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.textColor),
                                ),
                                trailing: Container(),
                                leading: Icon(
                                  Icons.check,
                                      color: ColorConstant.pinkColor,
                                ),
                                children: <Widget>[],
                              ),
                            )
                          : Container(),

                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowShareName
                                  .active ==
                              1
                          ? Container(
                              margin: EdgeInsets.only(
                                  right: screenWidth * 0.0627,
                                  left: screenWidth * 0.0627),
                              child: custom.ExpansionTile(
                                headerMargin:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                headerPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                headerMinHeight: 0,
                                title: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                      value: "objecttag_label_includename".tr(),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.textColor),
                                ),
                                trailing: Container(),
                                leading: Icon(
                                  Icons.check,
                                      color: ColorConstant.pinkColor,
                                ),
                                children: <Widget>[],
                              ),
                            )
                          : Container(),
                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowSharePhone
                                  .active ==
                              1
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: 0,
                                  right: screenWidth * 0.0627,
                                  left: screenWidth * 0.0627),
                              child: custom.ExpansionTile(
                                headerMargin:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                headerPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                headerMinHeight: 0,
                                title: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                      value:
                                          "objecttag_label_includenumber".tr(),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.textColor),
                                ),
                                trailing: Container(),
                                leading: Icon(
                                  Icons.check,
                                      color: ColorConstant.pinkColor,
                                ),
                                children: <Widget>[],
                              ),
                            )
                          : Container(),

                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowShareEmails
                                  .active ==
                              1
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: 0,
                                  right: screenWidth * 0.0627,
                                  left: screenWidth * 0.0627),
                              child: custom.ExpansionTile(
                                headerMargin:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                headerPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                headerMinHeight: 0,
                                title: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                      value:
                                          "objecttag_label_includeemail".tr(),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.textColor),
                                ),
                                trailing: Container(),
                                leading: Icon(
                                  Icons.check,
                                      color: ColorConstant.pinkColor,
                                ),
                                children: <Widget>[],
                              ),
                            )
                          : Container(),
//            Thank You Note
                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .tagInfo
                                  .tagCustumMessage !=
                              null
                          ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: (screenHeight * 4.064) / 100,
                                    right: (screenWidth * 57.0627) / 100,
                                  ),
                                  child: MyText(
                                      value:
                                          "objecttag_bloctitle_thanknote".tr(),
                                      fontSize: 18.0,
                                      color: ColorConstant.pinkColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                
                            
                                
                              ],
                            )
                          : Container(),

   profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .tagInfo
                                  .tagCustumMessage !=
                              null
                          ? Container(
                                  margin: EdgeInsets.only(
                                    top: (screenHeight * 1.064) / 100,
                                    left: (screenHeight * 4.064) / 100
                                //    right: (screenWidth * 57.0627) / 100,
                                  ),child:MyText(
                                      value: profile
                                              .userGeneralInfo
                                              .tagsList
                                              .objectTag[widget.indexu]
                                              .tags[widget.index]
                                              .tagInfo
                                              .tagCustumMessage ??
                                          '',
                                      fontSize: 14.0,
                                      color: ColorConstant.textColor,
                                      fontWeight: FontWeight.w600)): SizedBox(),
                      /*          Reward
                    Container(
                      margin: EdgeInsets.only(
                          top: (screenHeight * 4.064) / 100,
                          right: screenWidth * 0.0627,
                          left: screenWidth * 0.0627),
                      child: MyText(value:
                        "Reward",
                       
                            fontSize: 18.0,
                            color: ColorConstant.pinkColor,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: (screenHeight * 1.23) / 100,
                          right: screenWidth * 0.0627,
                          left: screenWidth * 0.0627),
                      child: Row(children: [
                        MyText(value:
                          "US dollars   \$20",
                         
                              fontSize: 14.0,
                              color: ColorConstant.textColor,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                            padding:
                                EdgeInsets.only(left: (screenWidth * 4.53) / 100),
                            child: ImageIcon(
                              AssetImage("Assets/Images/rewards.png"),
                              color: ColorConstant.iconGreenColor,
                              size: 19,
                            ))
                      ]),
                    ),
 */

//            Reminders

                      remindersList.length != 0
                          ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: (screenHeight * 4.064) / 100,
                                      right: (screenWidth * 63.064) / 100),
                                  child: MyText(
                                      value: "objecttag_label_reminders".tr(),
                                      fontSize: 18.0,
                                      color: ColorConstant.pinkColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: (screenHeight * 1.23) / 100,
                                      right: screenWidth * 0.0627,
                                      left: screenWidth * 0.0627),
                                  child: ListView.separated(
                                    separatorBuilder: (BuildContext context,
                                            int index) =>
                                        Container(
                                            height: 0.45,
                                            color: ColorConstant.dividerColor
                                                .withOpacity(.00)),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: remindersList.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 1.0, top: 12),
                                        ),
                                        SizedBox(width: 30),
                                        MyText(
                                            value: remindersList[index]
                                                .reminderLabel,
                                            fontSize: 14.0,
                                            color: ColorConstant.textColor,
                                            fontWeight: FontWeight.w600),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: (screenHeight * 3.7) / 100,
                                            right: screenWidth * 0,
                                          ),
                                          child: Row(children: [
                                            Flexible(
                                                child: MyText(
                                                    value: remindersList[index]
                                                            .reminderDate
                                                            .substring(8, 12) +
                                                        " " +
                                                        remindersList[index]
                                                            .reminderDate
                                                            .substring(5, 7) +
                                                        " " +
                                                        remindersList[index]
                                                            .reminderDate
                                                            .substring(12, 16) +
                                                        " " +
                                                        remindersList[index]
                                                            .reminderDate
                                                            .substring(17, 22),
                                                    fontSize: 12.0,
                                                    color: ColorConstant
                                                        .greyTextColor,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: (screenWidth * 4.53) /
                                                        100),
                                                child: ImageIcon(
                                                  AssetImage(
                                                      "Assets/Images/alarm.png"),
                                                  color: ColorConstant
                                                      .iconGreenColor,
                                                  size: 14,
                                                ))
                                          ]),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                      ]);
                                    },
                                  ),
                                )
                              ],
                            )
                          : Container(),

//            Attachment

                      documentAttachment.length != 0
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: (screenHeight * 4.0) / 100,
                                  right: screenWidth * 0.0627,
                                  left: screenWidth * 0.0627),
                              child: _Attachechment(profile),
                            )
                          : Container(),

//            Object Records
SizedBox(height: 12,),
                      Container(
                        margin: EdgeInsets.only(
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: MyText(
                                    value:
                                        "objecttag_bloctitle_exportobject".tr(),
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
                                      value:
                                          "objecttag_bloctitle_lostfoundposter"
                                              .tr(),
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

//            Contact Settings
                      Container(
                        margin: EdgeInsets.only(
                            top: (screenHeight * 4.064) / 100,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627),
                        child: MyText(
                            value: "objecttag_bloctitle_contact".tr(),
                            fontSize: 18.0,
                            color: ColorConstant.pinkColor,
                            fontWeight: FontWeight.w600),
                      ),

                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowLiveChat
                                  .active ==
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
                                    value: "objecttag_label_allowchat".tr(),
                                    fontSize: 14.0,
                                    color: ColorConstant.lightGreyTextColor,
                                    fontWeight: FontWeight.w600),
                              ]),
                            )
                          : Container(),

                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowLiveChat
                                  .active ==
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
                                    value: "objecttag_label_allowchat".tr(),
                                    fontSize: 14.0,
                                    color: ColorConstant.lightGreyTextColor,
                                    fontWeight: FontWeight.w600),
                              ]),
                            )
                          : Container(),

                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowShareName
                                  .active ==
                              1
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
                                    value: "objecttag_label_includename".tr(),
                                    fontSize: 14.0,
                                    color: ColorConstant.lightGreyTextColor,
                                    fontWeight: FontWeight.w600),
                              ]),
                            )
                          : Container(),

                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowSharePhone
                                  .active ==
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
                                    value: "objecttag_label_includenumber".tr(),
                                    fontSize: 14.0,
                                    color: ColorConstant.lightGreyTextColor,
                                    fontWeight: FontWeight.w600),
                              ]),
                            )
                          : Container(),

                      SizedBox(
                        height: 12,
                      ),
  profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .tagInfo
                                  .tagCustumMessage ==
                              null|| profile
                                  .userGeneralInfo
                                  .tagsList
                                  .objectTag[widget.indexu]
                                  .tags[widget.index]
                                  .tagInfo
                                  .tagCustumMessage==' '
                          ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: (screenHeight * 4.064) / 100,
                                    right: (screenWidth * 55.0627) / 100,
                                  ),
                                  child: MyText(
                                      value:
                                          "objecttag_bloctitle_thanknote".tr(),
                                      fontSize: 18.0,
                                      color: ColorConstant.pinkColor,
                                      fontWeight: FontWeight.w600),
                                ),
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
                                        value: "objecttag_bloctitle_nothanknote"
                                            .tr(),
                                        fontSize: 14.0,
                                        color: ColorConstant.lightGreyTextColor,
                                        fontWeight: FontWeight.w600),
                                  ]),
                                )
                              ],
                            )
                          : Container(),
                     
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 12.0, left: 12, right: 12),
                  child: _editTag(
                      widget.profile, widget.type, widget.indexu, widget.index),
                ),
              ],
            ),
          ),
        );
      });
    } else {
      if (type == "medical") {
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
                      indexu: widget.indexu,
                      index: widget.index,
                      type: widget.type,
                      idMembers: idMembers),
                ),
              ];
            },
            body: Column(
              children: [
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
                            value: "objecttag_bloctitle_contact".tr(),
                            fontSize: 18.0,
                            color: ColorConstant.pinkColor,
                            fontWeight: FontWeight.w600),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            top: screenHeight * 0.005,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627),
                        child: custom.ExpansionTile(
                          headerMargin: EdgeInsets.symmetric(horizontal: 0.0),
                          headerPadding: EdgeInsets.symmetric(horizontal: 0),
                          headerMinHeight: 0,
                          title: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0),
                            child: MyText(
                                value: "objecttag_blocinfo_contact".tr(),
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
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
   (profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo.mobile !=null||profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo.codePhone!='') && (profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo.mobile !=null||profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo.codePhone!='') ?SizedBox(): MyText(
                                            value: profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo.codePhone+profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[widget.index]
                                            .tagUserInfo.mobile,
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
                            
                          ],
                        ),
                      ),
                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowLiveChat
                                  .active ==
                              1
                          ? Container(
                              margin: EdgeInsets.only(
                                  right: screenWidth * 0.0627,
                                  left: screenWidth * 0.0627),
                              child: custom.ExpansionTile(
                                headerMargin:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                headerPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                headerMinHeight: 0,
                                title: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                      value: "objecttag_label_allowchat".tr(),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.textColor),
                                ),
                                trailing: Container(),
                                leading: Icon(
                                  Icons.check,
                                      color: ColorConstant.pinkColor,
                                ),
                                children: <Widget>[],
                              ),
                            )
                          : Container(),

                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowShareName
                                  .active ==
                              1
                          ? Container(
                              margin: EdgeInsets.only(
                                  right: screenWidth * 0.0627,
                                  left: screenWidth * 0.0627),
                              child: custom.ExpansionTile(
                                headerMargin:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                headerPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                headerMinHeight: 0,
                                title: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                      value: "objecttag_label_includename".tr(),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.textColor),
                                ),
                                trailing: Container(),
                                leading: Icon(
                                  Icons.check,
                                      color: ColorConstant.pinkColor,
                                ),
                                children: <Widget>[],
                              ),
                            )
                          : Container(),
                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowSharePhone
                                  .active ==
                              1
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: 0,
                                  right: screenWidth * 0.0627,
                                  left: screenWidth * 0.0627),
                              child: custom.ExpansionTile(
                                headerMargin:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                headerPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                headerMinHeight: 0,
                                title: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                      value:
                                          "objecttag_label_includenumber".tr(),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.textColor),
                                ),
                                trailing: Container(),
                                leading: Icon(
                                  Icons.check,
                                      color: ColorConstant.pinkColor,
                                ),
                                children: <Widget>[],
                              ),
                            )
                          : Container(),

                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowShareEmails
                                  .active ==
                              1
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: 0,
                                  right: screenWidth * 0.0627,
                                  left: screenWidth * 0.0627),
                              child: custom.ExpansionTile(
                                headerMargin:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                headerPadding:
                                    EdgeInsets.symmetric(horizontal: 0),
                                headerMinHeight: 0,
                                title: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  child: MyText(
                                      value:
                                          "objecttag_label_includeemail".tr(),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConstant.textColor),
                                ),
                                trailing: Container(),
                                leading: Icon(
                                  Icons.check,
                                      color: ColorConstant.pinkColor,
                                ),
                                children: <Widget>[],
                              ),
                            )
                          : Container(),

//            Thank You Note
                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[widget.index]
                                  .tagInfo
                                  .tagCustumMessage !=
                              null
                          ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: (screenHeight * 4.064) / 100,
                                    right: (screenWidth * 57.0627) / 100,
                                  ),
                                  child: MyText(
                                      value:
                                          "objecttag_bloctitle_thanknote".tr(),
                                      fontSize: 18.0,
                                      color: ColorConstant.pinkColor,
                                      fontWeight: FontWeight.w600),
                                ),
                               
                              ],
                            )
                          : Container(),
 profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[widget.index]
                                  .tagInfo
                                  .tagCustumMessage !=
                              null
                          ? Container(
                                  margin: EdgeInsets.only(
                                    top: (screenHeight * 1.064) / 100,
                                    left: (screenHeight * 4.064) / 100
                                //    right: (screenWidth * 57.0627) / 100,
                                  ),child:MyText(
                                      value: profile
                                              .userGeneralInfo
                                              .tagsList
                                              .medicalTag[widget.indexu]
                                              .tags[widget.index]
                                              .tagInfo
                                              .tagCustumMessage ??
                                          '',
                                      fontSize: 14.0,
                                      color: ColorConstant.textColor,
                                      fontWeight: FontWeight.w600)): SizedBox(),
                      /*          Reward
                  Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 4.064) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    child: MyText(value:
                      "Reward",
                     
                          fontSize: 18.0,
                          color: ColorConstant.pinkColor,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 1.23) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    child: Row(children: [
                      MyText(value:
                        "US dollars   \$20",
                       
                            fontSize: 14.0,
                            color: ColorConstant.textColor,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.only(left: (screenWidth * 4.53) / 100),
                          child: ImageIcon(
                            AssetImage("Assets/Images/rewards.png"),
                            color: ColorConstant.iconGreenColor,
                            size: 19,
                          ))
                    ]),
                  ),
 */

//            Reminders

                      remindersList.length != 0
                          ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: (screenHeight * 4.064) / 100,
                                      right: (screenWidth * 63.064) / 100),
                                  child: MyText(
                                      value: "objecttag_label_reminders".tr(),
                                      fontSize: 18.0,
                                      color: ColorConstant.pinkColor,
                                      fontWeight: FontWeight.w600),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: (screenHeight * 1.23) / 100,
                                      right: screenWidth * 0.0627,
                                      left: screenWidth * 0.0627),
                                  child: ListView.separated(
                                    separatorBuilder: (BuildContext context,
                                            int index) =>
                                        Container(
                                            height: 0.45,
                                            color: ColorConstant.dividerColor
                                                .withOpacity(.00)),
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: remindersList.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Stack(children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 1.0, top: 12),
                                        ),
                                        SizedBox(width: 30),
                                        MyText(
                                            value: remindersList[index]
                                                .reminderLabel,
                                            fontSize: 14.0,
                                            color: ColorConstant.textColor,
                                            fontWeight: FontWeight.w600),
                                        Container(
                                          margin: EdgeInsets.only(
                                            top: (screenHeight * 3.7) / 100,
                                            right: screenWidth * 0,
                                          ),
                                          child: Row(children: [
                                            Flexible(
                                              child: MyText(
                                                  value: remindersList[index]
                                                          .reminderDate
                                                          .substring(8, 12) +
                                                      " " +
                                                      remindersList[index]
                                                          .reminderDate
                                                          .substring(5, 7) +
                                                      " " +
                                                      remindersList[index]
                                                          .reminderDate
                                                          .substring(12, 16) +
                                                      " " +
                                                      remindersList[index]
                                                          .reminderDate
                                                          .substring(17, 22),
                                                  fontSize: 12.0,
                                                  color: ColorConstant
                                                      .greyTextColor,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(
                                                    left: (screenWidth * 4.53) /
                                                        100),
                                                child: ImageIcon(
                                                  AssetImage(
                                                      "Assets/Images/alarm.png"),
                                                  color: ColorConstant
                                                      .iconGreenColor,
                                                  size: 14,
                                                ))
                                          ]),
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                      ]);
                                    },
                                  ),
                                )
                              ],
                            )
                          : Container(),

//            Attachment

                      documentAttachment.length != 0
                          ? Container(
                              margin: EdgeInsets.only(
                                top: (screenHeight * 4.064) / 100,
                                left: (screenWidth * 100.064) / 100,
                              ),
                              child: _Attachechment(widget.profile),
                            )
                          : Container(),

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
                                    value:
                                        "objecttag_bloctitle_exportobject".tr(),
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
                                      value:
                                          "objecttag_bloctitle_lostfoundposter"
                                              .tr(),
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

//            Contact Settings
                      Container(
                        margin: EdgeInsets.only(
                            top: (screenHeight * 4.064) / 100,
                            right: screenWidth * 0.0627,
                            left: screenWidth * 0.0627),
                        child: MyText(
                            value: "objecttag_bloctitle_contact".tr(),
                            fontSize: 18.0,
                            color: ColorConstant.pinkColor,
                            fontWeight: FontWeight.w600),
                      ),

                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowLiveChat
                                  .active ==
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
                                    value: "objecttag_label_allowchat".tr(),
                                    fontSize: 14.0,
                                    color: ColorConstant.lightGreyTextColor,
                                    fontWeight: FontWeight.w600),
                              ]),
                            )
                          : Container(),

                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowLiveChat
                                  .active ==
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
                                    value: "objecttag_label_allowchat".tr(),
                                    fontSize: 14.0,
                                    color: ColorConstant.lightGreyTextColor,
                                    fontWeight: FontWeight.w600),
                              ]),
                            )
                          : Container(),

                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowShareName
                                  .active ==
                              1
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
                                    value: "objecttag_label_includename".tr(),
                                    fontSize: 14.0,
                                    color: ColorConstant.lightGreyTextColor,
                                    fontWeight: FontWeight.w600),
                              ]),
                            )
                          : Container(),

                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[widget.index]
                                  .preferenceUser
                                  .allowSharePhone
                                  .active ==
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
                                    value: "objecttag_label_includenumber".tr(),
                                    fontSize: 14.0,
                                    color: ColorConstant.lightGreyTextColor,
                                    fontWeight: FontWeight.w600),
                              ]),
                            )
                          : Container(),



                      profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[widget.index]
                                  .tagInfo
                                  .tagCustumMessage ==
                              null|| profile
                                  .userGeneralInfo
                                  .tagsList
                                  .medicalTag[widget.indexu]
                                  .tags[widget.index]
                                  .tagInfo
                                  .tagCustumMessage==' '
                          ? Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: (screenHeight * 4.064) / 100,
                                    right: (screenWidth * 55.0627) / 100,
                                  ),
                                  child: MyText(
                                      value:
                                          "objecttag_bloctitle_thanknote".tr(),
                                      fontSize: 18.0,
                                      color: ColorConstant.pinkColor,
                                      fontWeight: FontWeight.w600),
                                ),
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
                                        value: "objecttag_bloctitle_nothanknote"
                                            .tr(),
                                        fontSize: 14.0,
                                        color: ColorConstant.lightGreyTextColor,
                                        fontWeight: FontWeight.w600),
                                  ]),
                                )
                              ],
                            )
                          : Container(),

                      /*     Container(
                    margin: EdgeInsets.only(
                        top: (screenHeight * 1.23) / 100,
                        right: screenWidth * 0.0627,
                        left: screenWidth * 0.0627),
                    child:MyText(value:"hello")
                  ), */

                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 12.0, left: 12, right: 12),
                  child: _editTag(
                      widget.profile, widget.type, widget.indexu, widget.index),
                ),
              ],
            ),
          );
        });
      }
    }
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
              child: Column(children: [
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
                    value: "objecttag_btn_print".tr(),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorConstant.textColor),
              ]),
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
                      value: "objecttag_btn_email".tr(),
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
                      value: "objecttag_btn_print".tr(),
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
                      value: "objecttag_btn_email".tr(),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorConstant.textColor),
                ],
              ),
            ),
          ],
        ));
  }

  _Attachechment(Profile profile) {
    return Column(
      children: <Widget>[
        Container(
          child: InkWell(
              child: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 11),
                    child: MyText(
                        value: "editprofil_medical_label_attachment".tr(),
                        fontSize: 18.0,
                        color: ColorConstant.pinkColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  width: 22.2,
                )
              ],
            ),
          )),
        ),
        _attachment
            ? Container(
                padding: EdgeInsets.only(left: 5, top: 5),
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
                          itemCount: documentAttachment.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 1.0, top: 12),
                              ),
                              SizedBox(width: 30),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      documentAttachment[index].active = 0;
                                    },
                                    focusColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    child: Row(children: [
                                      Container(
                                        width: 37,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1.0,
                                                color: documentAttachment[index]
                                                            .active ==
                                                        1
                                                    ? ColorConstant
                                                        .iconGreenColor
                                                    : ColorConstant
                                                        .greyTextColor),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(4))),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Container(
                                                  width: 15,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 2.5,
                                                      horizontal: 3.0),
                                                  decoration: BoxDecoration(
                                                      color: documentAttachment[
                                                                      index]
                                                                  .active ==
                                                              1
                                                          ? ColorConstant
                                                              .iconGreenColor
                                                          : ColorConstant
                                                              .greyTextColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(3),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      3))),
                                                  child: Image.asset(
                                                    "Assets/Images/attachment.png",
                                                    height: 11,
                                                    width: 9,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 2.5,
                                                            horizontal: 3.0),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            3),
                                                                topRight: Radius
                                                                    .circular(
                                                                        3))),
                                                    child: documentAttachment[
                                                                    index]
                                                                .active ==
                                                            1
                                                        ? Image.asset(
                                                            "Assets/Images/eye-green.png",
                                                            height: 11,
                                                            width: 9,
                                                          )
                                                        : Image.asset(
                                                            "Assets/Images/eye-close.png",
                                                            height: 11,
                                                            width: 9,
                                                          ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 13,
                                      ),
                                      MyText(
                                          value: documentAttachment[index]
                                                  .documentName ??
                                              "",
                                          fontSize: 12.0,
                                          color: ColorConstant.textColor,
                                          fontWeight: FontWeight.w500),
                                    ]),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
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

  _editTag(Profile profile, String type, int indexu, int index) {
    return MyButton(
      title: "objecttag_btn_edittag".tr(),
      height: 46.0,
      titleSize: 14,
      cornerRadius: 8,
      fontWeight: FontWeight.w600,
      titleColor: Color(0xffEC1C40),
      btnBgColor: ColorConstant.boxColor,
      onPressed: () {
        /*       dispatchAddEditObjectTag( profile,  type, int indexu, int index)  */
        dispatchAddEditObjectTag(profile, type, indexu, index);
      },
    );
  }

/* 
  void dispatchAddEditObjectTag(Profile profile, int index) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      GoToAddEditObjectTagEvent(
        profile: profile,
        index: index,
      ),
    );
  } */

  void dispatchAddEditObjectTag(
      Profile profile, String type, int indexu, int index) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      GoToAddEditObjectTagEvent(
        profile: profile,
        type: type,
        indexu: indexu,
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
