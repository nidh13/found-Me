import 'package:flutter/material.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'dart:io';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/AlertDialogueUpdate.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popUpImage.dart';
import 'package:easy_localization/easy_localization.dart';

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final Profile profile;
  final int indexPet;
  List<Map<String, dynamic>> idMembers;
  CustomSliverDelegate({
    @required this.expandedHeight,
    @required this.profile,
    @required this.indexPet,
    @required this.idMembers,
    this.hideTitleWhenExpanded = true,
  });
  var screenWidth, screenHeight;
  File imageFile;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    getNamePetAndOwner(String name, String owner, String petType, bool isbar) {
      if (name != null && owner != null && petType != null) {
        return Text(
            name != ''
                ? name +
                    " " +
                    "reminders_label_is".tr() +
                    " " +
                    owner +
                    "reminders_label_s".tr() +
                    " " +
                    petType
                : '',
            textScaleFactor: 1.0,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 24,
                color: ColorConstant.textColor,
                fontWeight: FontWeight.w600));
      }
      if (name != null && petType != null && owner == null) {
        return Text(
            name != ''
                ? name + " " + "reminders_label_is".tr() + " " + petType
                : '',
            textScaleFactor: 1.0,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 24,
                color: ColorConstant.textColor,
                fontWeight: FontWeight.w600));
      }
      if (name != null && petType == null && owner == null) {
        return Text(name,
            textScaleFactor: 1.0,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 24,
                color: ColorConstant.textColor,
                fontWeight: FontWeight.w600));
      }
      if (name == null && petType == null && owner == null) {
        return Text(
          '',
          textScaleFactor: 1.0,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 24,
            color:
                ColorConstant.textColor,
            fontWeight: FontWeight.w600,
          ),
        );
      }
      if (name != null && petType == null && owner != null) {
        return Text(name,
            textScaleFactor: 1.0,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 24,
                color: isbar
                    ? ColorConstant.whiteTextColor
                    : ColorConstant.textColor,
                fontWeight: FontWeight.w600));
      }
      if (name == null && petType != null && owner != null) {
        return Text('',
            textScaleFactor: 1.0,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 24,
                color: isbar
                    ? ColorConstant.whiteTextColor
                    : ColorConstant.textColor,
                fontWeight: FontWeight.w600));
      }
      if (name == null && petType == null && owner != null) {
        return Text('',
            textScaleFactor: 1.0,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 24,
                color: isbar
                    ? ColorConstant.whiteTextColor
                    : ColorConstant.textColor,
                fontWeight: FontWeight.w600));
      }
      if (name == null && petType != null && owner == null) {
        return Text('',
            textScaleFactor: 1.0,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: 24,
                color:  ColorConstant.textColor,
                fontWeight: FontWeight.w600));
      }
    }

    showOverlayUpdate(
      BuildContext context,
      String headerMessage,
      String message,
      int index,
      Profile profile,
    ) {
      Navigator.of(context).push(AlertDialogueUpdate(
        context,
        headerMessage,
        message,
        index,
        profile,
      ));
    }

    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset + 20;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    screenWidth = MediaQuery.of(context).size.height;
    screenHeight = MediaQuery.of(context).size.width;
    return SizedBox(
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
                    color: ColorConstant.pinkColor
                 ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacementNamed(
                            '/homeProvider',
                            arguments: profile,
                          );
                        },
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                              'Assets/Images/arrowBack.svg',
                            ))),
                    // MyText(value:"View my pet profile",
                       
                    //         fontWeight: FontWeight.w600,
                    //         fontSize: 18,
                           
                    //         color: Colors.white),
                    // GestureDetector(
                    //   onTap: () {
                    //     Navigator.of(context).pushReplacementNamed(
                    //       '/homeProvider',
                    //       arguments: profile,
                    //     );
                    //   },
                    //   child: CircleAvatar(
                    //       radius: 20,
                    //       backgroundColor: Colors.transparent,
                    //       child: SvgPicture.asset(
                    //         'Assets/Images/arrowBack.svg',
                    //       ))),
                  MyText(
                      value: "pets_label_viewpetprofile".tr(),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white),
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
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: cardTopPosition > 0 ? cardTopPosition : 0,
            bottom:30.0,
            child: Opacity(
              opacity: percent,
                          child: Container(
                margin: EdgeInsets.only(
                  top: screenHeight * 0.01,
                  right: screenWidth * 0.02,
                  left: screenWidth * 0.02,
                ),
                decoration: BoxDecoration(
                  color:
                     Colors.white,
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
                        InkWell(
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black,
                                border:
                                    Border.all(color: Colors.white, width: 4),
                                boxShadow: [
                                  new BoxShadow(
                                    color:  Colors.black38,
                                    blurRadius: 5.0,
                                    spreadRadius: 0.01,
                                  ),
                                ]),
                            child: Container(
                              height:80,
                              width: 80,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(profile
                                              .userGeneralInfo
                                              .petsInfos[indexPet]
                                              .generalInfo
                                              .picturePet ==
                                          null
                                      ? "https://s3.amazonaws.com/vetterpc-images/pet_placeholderimage.jpg"
                                      : profile
                                              .userGeneralInfo
                                              .petsInfos[indexPet]
                                              .generalInfo
                                              .picturePet ??
                                          "https://s3.amazonaws.com/vetterpc-images/pet_placeholderimage.jpg"),
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              PopUpImage(profile
                                          .userGeneralInfo
                                          .petsInfos[indexPet]
                                          .generalInfo
                                          .picturePet !=
                                      null
                                  ? profile.userGeneralInfo.petsInfos[indexPet]
                                      .generalInfo.picturePet
                                  : "https://s3.amazonaws.com/vetterpc-images/pet_placeholderimage.jpg"),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      width: (screenWidth * 3.33) / 100,
                    ),
                    profile.userGeneralInfo.petsInfos[indexPet].generalInfo
                                    .name ==
                                null ||
                            profile.userGeneralInfo.petsInfos[indexPet]
                                    .generalInfo.name ==
                                ''
                        ? Text(
                            '                                             ',
                            textScaleFactor: 1.0,
                          )
                        : Flexible(
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                getNamePetAndOwner(
                                    profile.userGeneralInfo.petsInfos[indexPet]
                                        .generalInfo.name,
                                    profile.userGeneralInfo.petsInfos[indexPet]
                                                .generalInfo.idMember !=
                                            null
                                        ? idMembers.firstWhere((element) =>
                                                element['idMember'] ==
                                                profile
                                                    .userGeneralInfo
                                                    .petsInfos[indexPet]
                                                    .generalInfo
                                                    .idMember)['firstName'] ??
                                            null
                                        : null,
                                    profile.userGeneralInfo.petsInfos[indexPet]
                                                .generalInfo.idType !=
                                            null
                                        ? profile.parameters.petTypesList[profile
                                                .userGeneralInfo
                                                .petsInfos[indexPet]
                                                .generalInfo
                                                .idType -
                                            1]['pet_type_label']
                                        : null,
                                    appBarSize < 100 ? true : false),
                              ])),
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
