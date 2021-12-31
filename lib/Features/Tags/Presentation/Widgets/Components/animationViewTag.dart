import 'package:flutter/material.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'dart:io';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popUpImage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/alertDialogUpdate.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final Profile profile;
  final int indexu;
  final int index;
  String type;
  List<Map<String, dynamic>> idMembers = [];

  CustomSliverDelegate({
    @required this.expandedHeight,
    @required this.profile,
    @required this.indexu,
    @required this.index,
    @required this.type,
    @required this.idMembers,
    this.hideTitleWhenExpanded = true,
  });
  var screenWidth, screenHeight;
  File imageFile;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    viewFisrtNameLastName(String first, String last, bool isbar) {
      if (first != null && last == null) {
        return Text(
          first,
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 20,
              fontFamily: "SFProText",
              color: isbar
                  ? ColorConstant.whiteTextColor
                  : ColorConstant.textColor,
              fontWeight: FontWeight.w600),
        );
      }
      if (first == null && last != null) {
        return Text(
          last,
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 20,
              fontFamily: "SFProText",
              color: isbar
                  ? ColorConstant.whiteTextColor
                  : ColorConstant.textColor,
              fontWeight: FontWeight.w600),
        );
      }
      if (first == null && last == null) {
        return Text(
          ' ',
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 20,
              fontFamily: "SFProText",
              color: isbar
                  ? ColorConstant.whiteTextColor
                  : ColorConstant.textColor,
              fontWeight: FontWeight.w600),
        );
      }
      if (first != null && last != null) {
        return Text(
          first + ' ' + last,
          textScaleFactor: 1.0,
          style: TextStyle(
              fontSize: 20,
              fontFamily: "SFProText",
              color: isbar
                  ? ColorConstant.whiteTextColor
                  : ColorConstant.textColor,
              fontWeight: FontWeight.w600),
        );
      }
    }

    showOverlayUpdate(
      BuildContext context,
      String headerMessage,
      String message,
      Profile profile,
      int index,
    ) {
      Navigator.of(context)
          .push(AlertDialogueUpdate(headerMessage, message, profile, index));
    }

    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset + 20;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    screenWidth = MediaQuery.of(context).size.height;
    screenHeight = MediaQuery.of(context).size.width;
    return type == 'object'
        ? SizedBox(
            height: expandedHeight + expandedHeight / 2,
            child: Stack(
              children: [
                SizedBox(
                    height: appBarSize < 100 ? 100 : appBarSize,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: ColorConstant.pinkColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<TagsBloc>(context).dispatch(
                                ListingTagEvent(
                                  profile: profile,
                                ),
                              );
                            },
                            child: CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.transparent,
                                child: SvgPicture.asset(
                                  'Assets/Images/arrowBack.svg',
                                )),
                          ),
                          Text("objecttag_btn_viewobject".tr(),
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: "SFProText",
                                  color: Colors.white)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HelpDisplay(profile: profile)),
                              );
                            },
                            child: SvgPicture.asset(
                              'Assets/Images/icHelp.svg',
                            ),
                          ),
                        ],
                      ),
                    )
                    //     Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     IconButton(
                    //       icon: Icon(Icons.arrow_back),
                    //       color: Colors.white,
                    //       iconSize: appBarSize < 100 ? 0 : 30,
                    //       onPressed: () {},
                    //     ),
                    //     Text('Pet Account',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w600,
                    //             fontSize: 18,
                    //             fontFamily: "SFProText",
                    //             color: Colors.white)),
                    //     Image.asset(
                    //       "Assets/Images/FAQ.png",
                    //       height: screenHeight * 0.09,
                    //       width: screenWidth * 0.1,
                    //     ),
                    //   ],
                    // )),
                    ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  top: cardTopPosition > 0 ? cardTopPosition : 0,
                  bottom: 30.0,
                  child: Opacity(
                    opacity: percent,
                                      child: Container(
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        right: screenWidth * 0.02,
                        left: screenWidth * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color:  Colors.white,
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
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top:  0),
                                child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                          border: Border.all(
                                              color: Colors.white, width: 4),
                                          boxShadow: [
                                            new BoxShadow(
                                              color:  Colors.black38,
                                              blurRadius: 5.0,
                                              spreadRadius: 0.01,
                                            ),
                                          ]),
                                      child: Container(
                                        height:  80,
                                        width:  80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .objectTag[indexu]
                                                      .tags[index]
                                                      .tagInfo
                                                      .pictureUrl ??
                                                  "https://ws.interface-crm.com:445/documents/found_me_doc/3b712de48137572f3849aabd5666a4e3/732a6fc77c7d4da42dd255f730783856de52d1a92ffca9461b5a3322e179c780.jpg",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(PopUpImage(profile
                                              .userGeneralInfo
                                              .tagsList
                                              .objectTag[indexu]
                                              .tags[index]
                                              .tagInfo
                                              .pictureUrl ??
                                          "https://ws.interface-crm.com:445/documents/found_me_doc/3b712de48137572f3849aabd5666a4e3/732a6fc77c7d4da42dd255f730783856de52d1a92ffca9461b5a3322e179c780.jpg"));
                                    }),
                              ),
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
                                profile.userGeneralInfo.tagsList.objectTag[indexu]
                                                .tags[index].tagInfo.tagLabel !=
                                            null &&
                                        profile
                                                .userGeneralInfo
                                                .tagsList
                                                .objectTag[indexu]
                                                .tags[index]
                                                .tagInfo
                                                .tagLabel !=
                                            ''
                                    ? Text(
                                        idMembers.firstWhere((element) =>
                                                element['idMember'] ==
                                                profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .objectTag[indexu]
                                                    .tags[index]
                                                    .tagInfo
                                                    .idMember)['firstName'] +
                                            '\'s' +
                                            profile
                                                .userGeneralInfo
                                                .tagsList
                                                .objectTag[indexu]
                                                .tags[index]
                                                .tagInfo
                                                .tagLabel,
                                        textScaleFactor: 1.0,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "SFProText",
                                            color: ColorConstant.textColor,
                                            fontWeight: FontWeight.w600),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  profile
                                              .userGeneralInfo
                                              .tagsList
                                              .objectTag[indexu]
                                              .tags[index]
                                              .tagInfo
                                              .idType !=
                                          null
                                      ? profile.parameters.tagTypesList[profile
                                              .userGeneralInfo
                                              .tagsList
                                              .objectTag[indexu]
                                              .tags[index]
                                              .tagInfo
                                              .idType -
                                          2]['type_label']
                                      : '',
                                  textScaleFactor: 1.0,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                       fontFamily: "SFProText",
                                        fontSize:  20,
                                        color: ColorConstant.textColor,
                                        fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '# ' +
                                      profile
                                          .userGeneralInfo
                                          .tagsList
                                          .objectTag[indexu]
                                          .tags[index]
                                          .tagInfo
                                          .serialNumber,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "SFProText",
                                    color:  ColorConstant.redColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ])),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : SizedBox(
            height: expandedHeight + expandedHeight / 2,
            child: Stack(
              children: [
                SizedBox(
                    height: appBarSize < 100 ? 100 : appBarSize,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: ColorConstant.pinkColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<TagsBloc>(context).dispatch(
                                ListingTagEvent(
                                  profile: profile,
                                ),
                              );
                            },
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.transparent,
                              child: SvgPicture.asset(
                                'Assets/Images/arrowBack.svg',
                              ),
                            ),
                          ),
                          Text("objecttag_btn_viewobject".tr(),
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  fontFamily: "SFProText",
                                  color: Colors.white)),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HelpDisplay(profile: profile)),
                              );
                            },
                            child: SvgPicture.asset(
                              'Assets/Images/icHelp.svg',
                            ),
                          ),
                        ],
                      ),
                    )
                    //     Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     IconButton(
                    //       icon: Icon(Icons.arrow_back),
                    //       color: Colors.white,
                    //       iconSize: appBarSize < 100 ? 0 : 30,
                    //       onPressed: () {},
                    //     ),
                    //     Text('Pet Account',
                    //         style: TextStyle(
                    //             fontWeight: FontWeight.w600,
                    //             fontSize: 18,
                    //             fontFamily: "SFProText",
                    //             color: Colors.white)),
                    //     Image.asset(
                    //       "Assets/Images/FAQ.png",
                    //       height: screenHeight * 0.09,
                    //       width: screenWidth * 0.1,
                    //     ),
                    //   ],
                    // )),
                    ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  top: cardTopPosition > 0 ? cardTopPosition : 0,
                  bottom: 30.0,
                  child: Opacity(
                    opacity: percent,
                                      child: Container(
                      margin: EdgeInsets.only(
                        top: screenHeight * 0.01,
                        right: screenWidth * 0.02,
                        left: screenWidth * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color:  Colors.white,
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
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top:  0),
                                child: InkWell(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.black,
                                          border: Border.all(
                                              color: Colors.white, width: 4),
                                          boxShadow: [
                                            new BoxShadow(
                                              color:  Colors.black38,
                                              blurRadius: 5.0,
                                              spreadRadius: 0.01,
                                            ),
                                          ]),
                                      child: Container(
                                          height: 80,
                                          width:  80,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(profile
                                                          .userGeneralInfo
                                                          .tagsList
                                                          .medicalTag[indexu]
                                                          .tags[index]
                                                          .tagInfo
                                                          .pictureUrl ??
                                                      "https://ws.interface-crm.com:445/documents/found_me_doc/3b712de48137572f3849aabd5666a4e3/de20e7222dadb5e8b9e8c06ef9cf3c99b1a55c369d10f213384a9c32e3589833.jpg")))),
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(PopUpImage(profile
                                              .userGeneralInfo
                                              .tagsList
                                              .medicalTag[indexu]
                                              .tags[index]
                                              .tagInfo
                                              .pictureUrl ??
                                          "https://ws.interface-crm.com:445/documents/found_me_doc/3b712de48137572f3849aabd5666a4e3/de20e7222dadb5e8b9e8c06ef9cf3c99b1a55c369d10f213384a9c32e3589833.jpg"));
                                    }),
                              ),
                            ],
                          ),
                          Flexible(
                              child: Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 2),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .medicalTag[indexu]
                                                  .tags[index]
                                                  .tagInfo
                                                  .tagLabel !=
                                              null &&
                                          profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .medicalTag[indexu]
                                                  .tags[index]
                                                  .tagInfo
                                                  .tagLabel !=
                                              ''
                                      ? Text(
                                          idMembers.firstWhere((element) =>
                                                  element['idMember'] ==
                                                  profile
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .medicalTag[indexu]
                                                      .tags[index]
                                                      .tagInfo
                                                      .idMember)['firstName'] +
                                              '\'s' +
                                              profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .medicalTag[indexu]
                                                  .tags[index]
                                                  .tagInfo
                                                  .tagLabel,
                                          textScaleFactor: 1.0,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize:
                                                  20,
                                              fontFamily: "SFProText",
                                              color:  ColorConstant.textColor,
                                              fontWeight: FontWeight.w600),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    profile
                                                .userGeneralInfo
                                                .tagsList
                                                .medicalTag[indexu]
                                                .tags[index]
                                                .tagInfo
                                                .idType !=
                                            null
                                        ? profile.parameters.tagTypesList[profile
                                                .userGeneralInfo
                                                .tagsList
                                                .medicalTag[indexu]
                                                .tags[index]
                                                .tagInfo
                                                .idType -
                                            2]['type_label']
                                        : '',
                                    textScaleFactor: 1.0,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                          fontFamily: "SFProText",
                                        fontSize:  20,
                                        color:ColorConstant.textColor,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '# ' +
                                        profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[indexu]
                                            .tags[index]
                                            .tagInfo
                                            .serialNumber,
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                      fontSize:  13,
                                      fontFamily: "SFProText",
                                      color: ColorConstant.redColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ]),
                          )),
                          profile.userGeneralInfo.tagsList.medicalTag[indexu]
                                      .tags[index].tagInfo.emergency ==
                                  1
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      left: 0),
                                  child: Image.asset("Assets/Images/Medical.png",
                                      color: ColorConstant.redColor,
                                      height: 42,
                                      width: 42),
                                )
                              : Padding(
                                  padding: EdgeInsets.only(left: 40.0),
                                  child: Container(),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  @override
  double get maxExtent => expandedHeight + expandedHeight / 2;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
