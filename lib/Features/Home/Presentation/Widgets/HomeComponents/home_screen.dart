import 'package:better_player/better_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Home/Presentation/Widgets/HomeComponents/petsPopup.dart';
import 'package:neopolis/Features/Home/Presentation/Widgets/HomeComponents/usersPopup.dart';
import 'package:neopolis/Features/Home/Presentation/Widgets/HomeComponents/reviewsPopup.dart';
import 'package:neopolis/Features/Home/Presentation/Widgets/HomeComponents/productPopup.dart';
import 'package:neopolis/Features/Home/Presentation/Widgets/HomeComponents/blogPopup.dart';
import 'package:neopolis/Features/Home/Presentation/Widgets/HomeComponents/videosPopup.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:neopolis/Features/Home/Presentation/bloc/home_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:barcode_scan/barcode_scan.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class HomeScreen extends StatefulWidget {
  final Profile profile;

  const HomeScreen({Key key, @required this.profile}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var screenWidth, screenHeight, screenWidthUnit;
  int _topBannerCurrentIndex = 0;
  int _userIndicatorIndex = 0;
  double _userItemWidth = 0.0;
  int _petIndicatorIndex = 0;
  double _petItemWidth = 0.0;
  int isfirst = 0;
  String serialNumber;
  String qrCodeResult;
  int camera = -1;
  bool backCamera = true;

  final List<String> imgList = [
    "Assets/Images/banner.png",
    "Assets/Images/videoBanner.png",
    "Assets/Images/blogBanner.png",
  ];

  ScrollController _userScrollController = new ScrollController();
  ScrollController _petScrollController = new ScrollController();
  final List<String> userList = [
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
  List<UserEmergencyContact> listEmergency = [];

  List<UserEmergencyContact> listEmergencyContact() {
    widget.profile.userGeneralInfo.userEmergencyContact.forEach((element) {
      listEmergency.add(element);
    });
  }

  List<Map<String, String>> serialNumbers = [];

  YoutubePlayerController _controller;
  List<Profile> subUsers = [];
  List<Tags> tags = [];

  @override
  void initState() {
    super.initState();
    widget.profile.userGeneralInfo.tagsList.objectTag.forEach((element) {
      element.tags.forEach((element2) {
        if (element2.tagInfo.active == 1) {
          // mapSerial.addAll(
          //     {'Serial': element2.tagInfo.serialNumber, 'type': 'object'});
          // serialNumbers.add(mapSerial);
          serialNumbers
              .add({'Serial': element2.tagInfo.serialNumber, 'type': 'object'});
          tags.add(element2);
        } else {
          print("supprimé" + element2.tagInfo.serialNumber);
          serialNumbers.remove(element2.tagInfo.serialNumber);
          tags.remove(element2);
        }
      });
    });

    widget.profile.userGeneralInfo.tagsList.petTag.forEach((element) {
      element.tags.forEach((element2) {
        if (element2.tagInfo.active == 1) {
          serialNumbers
              .add({'Serial': element2.tagInfo.serialNumber, 'type': 'pet'});
        } else {
          print("supprimé" + element2.tagInfo.serialNumber);
          serialNumbers.remove(element2.tagInfo.serialNumber);
        }
      });
    });
    widget.profile.userGeneralInfo.tagsList.medicalTag.forEach((element) {
      element.tags.forEach((element2) {
        if (element2.tagInfo.active == 1) {
          serialNumbers.add(
              {'Serial': element2.tagInfo.serialNumber, 'type': 'medical'});
        } else {
          print("supprimé" + element2.tagInfo.serialNumber);
          serialNumbers.remove(element2.tagInfo.serialNumber);
        }
      });
    });

    widget.profile.userGeneralInfo.subUsers.forEach((element) {
      if (element.userGeneralInfo.roleLabel == 'Administrator') {
        subUsers.insert(0, element);
      } else {
        subUsers.add(element);
      }
    });
    widget.profile.userGeneralInfo.subUsers = subUsers;

    listEmergencyContact();
    _userScrollController.addListener(scrollListenerWithItemHeight);
    _petScrollController.addListener(petScrollListenerWithItemHeight);
    // WidgetsBinding.instance.addPostFrameCallback(
    //     (_) => isfirst == 0 ? _showWelcomeOverlay(context) : null);

    OneSignal.shared.setNotificationOpenedHandler((notification) {
      print('playerIdz: ');

      Navigator.of(context).pushReplacementNamed(
        '/notificationsProvider',
        arguments: widget.profile,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  // use this one if the listItem's height is known
  // or width in case of a horizontal list
  void scrollListenerWithItemHeight() {
    double itemHeight =
        _userItemWidth; // including padding above and below the list item
    double scrollOffset = _userScrollController.offset / 3;
    int firstVisibleItemIndex =
        scrollOffset < itemHeight ? 0 : ((scrollOffset) ~/ itemHeight);
    _userIndicatorIndex = _userItemWidth == 0.0
        ? firstVisibleItemIndex
        : firstVisibleItemIndex + 1;
    print("scrollOffset        " + scrollOffset.toString());
    setState(() {
      _userIndicatorIndex = scrollOffset == 0.0
          ? firstVisibleItemIndex
          : firstVisibleItemIndex + 1;
    });
  }

  // use this one if the listItem's height is known
  // or width in case of a horizontal list
  void petScrollListenerWithItemHeight() {
    double itemHeight =
        _petItemWidth; // including padding above and below the list item
    double scrollOffset = _petScrollController.offset / 3;
    int firstVisibleItemIndex =
        scrollOffset < itemHeight ? 0 : ((scrollOffset) ~/ itemHeight);
    _petIndicatorIndex = firstVisibleItemIndex + 1;
    setState(() {
      _petIndicatorIndex = scrollOffset == 0.0
          ? firstVisibleItemIndex
          : firstVisibleItemIndex + 1;
    });
  }

  viewFisrtNameLastName(String first, String last) {
    if (first != null && last == null) {
      return MyText(
        value: first,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: ColorConstant.pinkColor,
        textAlign: TextAlign.center,
      );
    }
    if (first == null && last != null) {
      return MyText(
        value: last,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: ColorConstant.pinkColor,
        textAlign: TextAlign.center,
      );
    }
    if (first == null && last == null) {
      return MyText(
        value: '',
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: ColorConstant.pinkColor,
        textAlign: TextAlign.center,
      );
    }
    if (first != null && last != null) {
      return MyText(
        value: first + ' ' + last,
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: ColorConstant.pinkColor,
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;

    screenWidthUnit = MediaQuery.of(context).size.width * 0.04 / 14.5;

    return homeMainWidget(profile, imgList);
  }

  // void _showWelcomeOverlay(BuildContext context) {
  //   Navigator.of(context).push(WelcomeOverlay());
  //   isfirst++;
  // }

  homeMainWidget(Profile profile, List<String> images) {
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(item), fit: BoxFit.cover)),
              ),
            ))
        .toList();
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Column(
        children: [
//          Image slider
          Container(
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider(
              items: imageSliders,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _topBannerCurrentIndex = index;
                    });
                  }),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.map((url) {
              int index = imgList.indexOf(url);

              return Container(
                width: 8.0,
                height: 8.0,
                margin: EdgeInsets.symmetric(
                    vertical: (screenHeight * 1.6) / 100, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _topBannerCurrentIndex == index
                      ? ColorConstant.activeIndicatorColor
                      : ColorConstant.indicatorColor,
                ),
              );
            }).toList(),
          ),

          Container(
            margin: EdgeInsets.only(
              top: (screenHeight * 2.59) / 100,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
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
                        );
                        //barcode scnner
                        setState(() {
                          qrCodeResult = codeSanner.rawContent;
                          serialNumber = qrCodeResult;
                        });
                        if (serialNumber.contains('found') == true) {
                          serialNumber = serialNumber.split('/').last;
                        }
                        serialNumber != null && serialNumber != ''
                            ? dispatchGoToAddEdit(profile)
                            : null;
                      },
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          value: "homescree_label_addtag".tr(),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: ColorConstant.pinkColor,
                        ),
                        SizedBox(height: (screenHeight * 0.8) / 100),
                        InkWell(
                            onTap: () {
                              /////////////// tap to add a tag .... //////////:
                            },
                            child: MyText(
                              value: "homescree_info_addtag".tr(),
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            )),
                        Center(
                          child: SizedBox(
                            height: 30,
                            width: screenWidth / 3,
                            //  height: 20,
                            child: Center(
                              child: MyTextField(
                                maxline: 1,
                                inputType: TextInputType.number,
                                title: "pets_label_serialnumber".tr(),
                                editTextBgColor: ColorConstant.textfieldColor,
                                hintTextColor: Colors.white54,
                                onFieledSubmit: (value) {
                                  serialNumber = value;

                                  serialNumber != null && serialNumber != ''
                                      ? dispatchGoToAddEdit(profile)
                                      : null;
                                },
                                onChanged: (value) {},
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

//                View My Tags
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: (screenHeight * 4.31) / 100,
                        bottom: screenWidth * 0.05 / 2,
                        left: screenWidth * 0.03,
                      ),
                      child: MyText(
                          value: "objecttag_label_viewtags".tr(),
                          color: ColorConstant.pinkColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.03,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              profile.parameters.location =
                                  "drawer_label_mytags".tr();
                              profile.parameters.viewTag = 'medical';
                              Navigator.of(context).pushReplacementNamed(
                                '/tagsProvider',
                                arguments: profile,
                              );

                              /////////////// tap to view a medical tag .... //////////:
                            },
                            child: Card(
                              color: ColorConstant.lightGrey,
                              elevation: 2.3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                width: screenWidth * 0.275,
                                padding: EdgeInsets.symmetric(
                                    vertical: screenWidth * 0.04),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: ColorConstant.lightGrey,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("Assets/Images/Medical.png",
                                        color: ColorConstant.pinkColor,
                                        height: screenWidth * 0.05 * 3,
                                        width: screenWidth * 0.05 * 3),
                                    SizedBox(height: screenWidth * 0.05 / 3),
                                    MyText(
                                        value: "homescree_label_medical".tr(),
                                        color: Colors.grey,
                                        fontSize: screenWidth * 0.05 - 6,
                                        fontWeight: FontWeight.bold),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              profile.parameters.location =
                                  "drawer_label_mytags".tr();
                              profile.parameters.viewTag = 'object';
                              Navigator.of(context).pushReplacementNamed(
                                '/tagsProvider',
                                arguments: profile,
                              );

                              /////////////// tap to view a object tag .... //////////:
                            },
                            child: Card(
                              color: ColorConstant.lightGrey,
                              elevation: 2.3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                width: screenWidth * 0.275,
                                padding: EdgeInsets.symmetric(
                                    vertical: screenWidth * 0.04),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: ColorConstant.lightGrey),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("Assets/Images/Objects.png",
                                        color: ColorConstant.pinkColor,
                                        height: screenWidth * 0.05 * 3,
                                        width: screenWidth * 0.05 * 3),
                                    SizedBox(height: screenWidth * 0.05 / 3),
                                    MyText(
                                        value: "homescree_label_object".tr(),
                                        color: Colors.grey,
                                        fontSize: screenWidth * 0.05 - 6,
                                        fontWeight: FontWeight.bold),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              profile.parameters.location =
                                  "drawer_label_mytags".tr();
                              profile.parameters.viewTag = 'pet';
                              Navigator.of(context).pushReplacementNamed(
                                '/tagsProvider',
                                arguments: profile,
                              );
                              /////////////// tap to view a pet tag .... //////////:
                            },
                            child: Card(
                              color: ColorConstant.lightGrey,
                              elevation: 2.3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                width: screenWidth * 0.275,
                                padding: EdgeInsets.symmetric(
                                    vertical: screenWidth * 0.04),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: ColorConstant.lightGrey),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("Assets/Images/Pets.png",
                                        color: ColorConstant.pinkColor,
                                        height: screenWidth * 0.05 * 3,
                                        width: screenWidth * 0.05 * 3),
                                    SizedBox(height: screenWidth * 0.05 / 3),
                                    MyText(
                                        value: "homescree_label_pet".tr(),
                                        color: Colors.grey,
                                        fontSize: screenWidth * 0.05 - 6,
                                        fontWeight: FontWeight.bold)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

//                Users
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              //  top: (screenHeight * 5.35) / 100,
                              //  bottom: screenWidth * 0.05 / 2,
                              left: (screenWidth * 4.0) / 100),
                          child: MyText(
                              value: "homescree_subtitle_users".tr(),
                              color: ColorConstant.pinkColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: screenWidth * 0.07,
                              bottom: screenWidth * 0.05 / 2,
                              right: (screenWidth * 4.0) / 100),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(UsersPopup(profile));
                            },
                            child: MyText(
                                value: "homescree_href_seeall".tr() + " >",
                                fontWeight: FontWeight.w400,
                                color: ColorConstant.pinkColor,
                                fontSize: screenWidth * 0.03),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Container(
                      height: 150 /*screenHeight * 0.21*/,
                      width: double.maxFinite,
                      child: ListView.builder(
                          controller: _userScrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              profile.userGeneralInfo.subUsers.length + 2,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return Padding(
                                padding: EdgeInsets.only(
                                  left: screenWidth * 0.05,
                                ),
                                child: Card(
                                  color: ColorConstant.lightGrey,
                                  elevation: 2.3,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Container(
                                    width: screenWidth * 0.275,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                      onTap: profile
                                                  .userGeneralInfo.roleLabel ==
                                              'Administrator'
                                          ? () {
                                              dispatchGoToAddNewUser(profile);
                                            }
                                          : null,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenWidth * 0.06),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: screenWidth * 0.05 * 3,
                                              width: screenWidth * 0.05 * 3,
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                      "Assets/Images/add.png",
                                                      color: profile
                                                                  .userGeneralInfo
                                                                  .roleLabel ==
                                                              'Administrator'
                                                          ? ColorConstant
                                                              .pinkColor
                                                          : ColorConstant
                                                              .greyChar,
                                                      height: screenWidth *
                                                          0.05 *
                                                          2,
                                                      width: screenWidth *
                                                          0.05 *
                                                          2)
                                                ],
                                              ),
                                            ),
                                            Flexible(
                                                child: SizedBox(
                                                    height:
                                                        screenWidth * 0.06)),
                                            Flexible(
                                              child: MyText(
                                                value:
                                                    "homescree_btn_addnew".tr(),
                                                color: profile.userGeneralInfo
                                                            .roleLabel ==
                                                        'Administrator'
                                                    ? ColorConstant.pinkColor
                                                    : ColorConstant.greyChar,
                                                fontSize:
                                                    screenWidth * 0.05 - 7,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            if (index == 1) {
                              return InkWell(
                                onTap: () {
                                  profile.parameters.location = 'profile';
                                  Navigator.of(context).pushReplacementNamed(
                                    '/profileProvider',
                                    arguments: profile,
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Card(
                                      color: ColorConstant.lightGrey,
                                      elevation: 2.3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Container(
                                        width: screenWidth * 0.275,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height: (screenWidth * 19.2) /
                                                      100,
                                                  width: (screenWidth * 19.2) /
                                                      100,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 3.0),
                                                      boxShadow: [
                                                        new BoxShadow(
                                                          color: Colors.black,
                                                          blurRadius: 2.0,
                                                          spreadRadius: 0.01,
                                                        ),
                                                      ],
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                            profile
                                                                .userGeneralInfo
                                                                .profilePictureUrl,
                                                          ),
                                                          fit: BoxFit.cover)),
                                                ),
                                                Flexible(
                                                    child: SizedBox(
                                                        height: (screenHeight *
                                                                1.12) /
                                                            100)),
                                                Flexible(
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 4.0,
                                                                right: 4),
                                                        child: viewFisrtNameLastName(
                                                            profile
                                                                .userGeneralInfo
                                                                .firstName,
                                                            profile
                                                                .userGeneralInfo
                                                                .lastName))),
                                              ],
                                            ),
                                            profile.userGeneralInfo.roleLabel ==
                                                    'Administrator'
                                                ? Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      height: 14,
                                                      width: screenWidth * 1.0,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        15.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15.0)),
                                                        color: ColorConstant
                                                            .pinkColor,
                                                      ),
                                                      child: MyText(
                                                        value: profile
                                                            .userGeneralInfo
                                                            .roleLabel,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 8,
                                                      ),
                                                    ),
                                                  )
                                                : Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Container(
                                                      height: 14,
                                                      width: screenWidth * 1.0,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        15.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15.0)),
                                                      ),
                                                      child: MyText(
                                                        value: profile
                                                                .userGeneralInfo
                                                                .roleLabel ??
                                                            ' ',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: profile
                                                                    .userGeneralInfo
                                                                    .roleLabel ==
                                                                'Administrator'
                                                            ? Colors.white
                                                            : ColorConstant
                                                                .pinkColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 8,
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      )),
                                ),
                              );
                            }
                            return InkWell(
                              onTap: profile.userGeneralInfo.roleLabel ==
                                      'Administrator'
                                  ? () {
                                      dispatchGoToEditSubUser(
                                          profile, index - 2);
                                    }
                                  : null,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Card(
                                    color: ColorConstant.lightGrey,
                                    elevation: 2.3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      width: screenWidth * 0.275,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: <Widget>[
                                          Column(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                height:
                                                    (screenWidth * 19.2) / 100,
                                                width:
                                                    (screenWidth * 19.2) / 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 3.0),
                                                    boxShadow: [
                                                      new BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 2.0,
                                                        spreadRadius: 0.01,
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          profile
                                                              .userGeneralInfo
                                                              .subUsers[
                                                                  index - 2]
                                                              .userGeneralInfo
                                                              .profilePictureUrl,
                                                        ),
                                                        fit: BoxFit.cover)),
                                              ),
                                              Flexible(
                                                  child: SizedBox(
                                                      height: (screenHeight *
                                                              1.12) /
                                                          100)),
                                              Flexible(
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0,
                                                              right: 4),
                                                      child: viewFisrtNameLastName(
                                                          profile
                                                              .userGeneralInfo
                                                              .subUsers[
                                                                  index - 2]
                                                              .userGeneralInfo
                                                              .firstName,
                                                          profile
                                                              .userGeneralInfo
                                                              .subUsers[
                                                                  index - 2]
                                                              .userGeneralInfo
                                                              .lastName))),
                                            ],
                                          ),
                                          profile
                                                      .userGeneralInfo
                                                      .subUsers[index - 2]
                                                      .userGeneralInfo
                                                      .roleLabel ==
                                                  'Administrator'
                                              ? Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                    height: 14,
                                                    width: screenWidth * 1.0,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          15.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      15.0)),
                                                      color: ColorConstant
                                                          .pinkColor,
                                                    ),
                                                    child: MyText(
                                                      value: profile
                                                          .userGeneralInfo
                                                          .subUsers[index - 2]
                                                          .userGeneralInfo
                                                          .roleLabel,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 8,
                                                    ),
                                                  ),
                                                )
                                              : Align(
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  child: Container(
                                                      height: 14,
                                                      width: screenWidth * 1.0,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        15.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        15.0)),
                                                      ),
                                                      child: MyText(
                                                        value: profile
                                                                .userGeneralInfo
                                                                .subUsers[
                                                                    index - 2]
                                                                .userGeneralInfo
                                                                .roleLabel ??
                                                            ' ',
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        color: ColorConstant
                                                            .pinkColor,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 8,
                                                      )))
                                        ],
                                      ),
                                    )),
                              ),
                            );
                            /*
                                                            if (userList.length + 1 <= index) {
                                                              return Container(
                                                                width: screenWidth * 0.32,
                                                              );
                                                            }
                                
                                                            return Container(
                                                              width: screenWidth * 0.32,
                                                              //                                margin: EdgeInsets.only(right: screenWidth * 0.05 / 3),
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(15.0),
                                                              ),
                                                              child: Card(
                                                                color: ColorConstant.lightGrey,
                                                                elevation: 2.3,
                                                                shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.circular(15.0),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Container(
                                                                      height: (screenWidth * 19.2) / 100,
                                                                      width: (screenWidth * 19.2) / 100,
                                                                      decoration: BoxDecoration(
                                                                          color: Colors.white,
                                                                          shape: BoxShape.circle,
                                                                          border: Border.all(
                                                                              color: Colors.white, width: 3.0),
                                                                          boxShadow: [
                                                                            new BoxShadow(
                                                                              color: Colors.black,
                                                                              blurRadius: 2.0,
                                                                              spreadRadius: 0.01,
                                                                            ),
                                                                          ],
                                                                          image: DecorationImage(
                                                                              image: AssetImage(
                                                                                  "Assets/Images/top_pager.png"),
                                                                              fit: BoxFit.cover)),
                                                                    ),
                                                                    Flexible(
                                                                        child: SizedBox(
                                                                            height:
                                                                                (screenHeight * 1.11) / 100)),
                                                                    Flexible(
                                                                      child:   MyText(
                      value:
                                                                        "${userList[index - 1]}",
                                                                        maxLines: 1,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: ColorConstant.pinkColor,
                                                                            fontSize: 10,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                            */
                          }),
                    ),
                    profile.userGeneralInfo.subUsers.length < 3
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _userIndicatorIndex == 0
                                      ? ColorConstant.activeIndicatorColor
                                      : ColorConstant.indicatorColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List<Widget>.generate(
                                    (profile.userGeneralInfo.subUsers.length /
                                            3)
                                        .round(), (int index) {
                                  return Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _userIndicatorIndex == index + 1
                                          ? ColorConstant.activeIndicatorColor
                                          : ColorConstant.indicatorColor,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                  ],
                ),

                //                Pets
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              //    top: (screenHeight * 5.35) / 100,
                              //   bottom: screenWidth * 0.05 / 2,
                              left: (screenWidth * 4.0) / 100),
                          child: MyText(
                              value: "homescree_subtitle_pet".tr(),
                              color: ColorConstant.pinkColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: screenWidth * 0.07,
                              bottom: screenWidth * 0.05 / 2,
                              right: (screenWidth * 4.0) / 100),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(PetsPopup(profile));
                            },
                            child: MyText(
                                value: "homescree_href_seeall".tr() + " >",
                                fontWeight: FontWeight.w400,
                                color: ColorConstant.pinkColor,
                                fontSize: screenWidth * 0.03),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Container(
                      height: 150 /*screenHeight * 0.21*/,
                      width: double.maxFinite,
                      child: ListView.builder(
                          // controller: _petsScrollController,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              profile.userGeneralInfo.petsInfos.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            _userItemWidth = screenWidth * 0.32;
                            if (index == 0) {
                              return Padding(
                                  padding: EdgeInsets.only(
                                    left: screenWidth * 0.05,
                                  ),
                                  child: Card(
                                    color: ColorConstant.lightGrey,
                                    elevation: 2.3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      width: screenWidth * 0.275,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: InkWell(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(15.0)),
                                        onTap: () {
                                          profile.parameters.newPet = true;
                                          PetsInfos petInfo = PetsInfos(
                                              memberInfo: MemberInfo(
                                                  firstName: profile
                                                      .userGeneralInfo
                                                      .firstName,
                                                  lastName: profile
                                                      .userGeneralInfo.lastName,
                                                  mail: profile
                                                      .userGeneralInfo.mail,
                                                  mail2: profile
                                                      .userGeneralInfo.mail2,
                                                  mobile: profile
                                                      .userGeneralInfo.mobile,
                                                  codePhone: profile
                                                      .userGeneralInfo
                                                      .codePhone),
                                              petTag: List<PetTag>(),
                                              preferencePet: PreferenceUser(
                                                allowLiveChat: Allow(
                                                    accesLabelTxt: profile
                                                        .userGeneralInfo
                                                        .preferenceUser
                                                        .allowLiveChat
                                                        .accesLabelTxt,
                                                    value: '1'),
                                                allowShareEmails: Allow(
                                                    accesLabelTxt: profile
                                                        .userGeneralInfo
                                                        .preferenceUser
                                                        .allowShareEmails
                                                        .accesLabelTxt,
                                                    value: '1'),
                                                allowShareName: Allow(
                                                    accesLabelTxt: profile
                                                        .userGeneralInfo
                                                        .preferenceUser
                                                        .allowShareName
                                                        .accesLabelTxt,
                                                    value: '1'),
                                                allowSharePhone: Allow(
                                                    accesLabelTxt: profile
                                                        .userGeneralInfo
                                                        .preferenceUser
                                                        .allowSharePhone
                                                        .accesLabelTxt,
                                                    value: '1'),
                                                allowSharePicture: Allow(
                                                    accesLabelTxt: profile
                                                        .userGeneralInfo
                                                        .preferenceUser
                                                        .allowSharePicture
                                                        .accesLabelTxt,
                                                    value: '1'),
                                                includeMail1: Allow(
                                                    accesLabelTxt: profile
                                                        .userGeneralInfo
                                                        .preferenceUser
                                                        .includeMail1
                                                        .accesLabelTxt,
                                                    value: '1'),
                                                includeMail2: Allow(
                                                    accesLabelTxt: profile
                                                        .userGeneralInfo
                                                        .preferenceUser
                                                        .includeMail2
                                                        .accesLabelTxt,
                                                    value: profile
                                                        .userGeneralInfo
                                                        .preferenceUser
                                                        .includeMail2
                                                        .value),
                                                includeMobile: Allow(
                                                    accesLabelTxt: profile
                                                        .userGeneralInfo
                                                        .preferenceUser
                                                        .includeMobile
                                                        .accesLabelTxt,
                                                    value: '1'),
                                              ),
                                              emergencyContact: listEmergency,
                                              generalInfo: GeneralInfo(
                                                  delete: 0,
                                                  active: 1,
                                                  birthInfo: BirthDateInfo(),
                                                  picturePet:
                                                      'https://s3.amazonaws.com/vetterpc-images/pet_placeholderimage.jpg',
                                                  idPet: null,
                                                  idPicture: null,
                                                  dateBirth:
                                                      "Fri, 29 Jan 2018 00:00:00 GMT",
                                                  heightweight: Heightweight(),
                                                  microscopic: Microscopic()),
                                              otherInfo: List<OtherInfo>(),
                                              vaccins: List<Vaccins>());
                                          profile.userGeneralInfo.petsInfos
                                              .add(petInfo);
                                          profile.userGeneralInfo.update = true;
                                          dispatchGoToAddEditPetProfile(
                                              profile,
                                              profile.userGeneralInfo.petsInfos
                                                      .length -
                                                  1);
                                          // dispatchGoToAddNewUser(profile);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              vertical: screenWidth * 0.06),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                height: screenWidth * 0.05 * 3,
                                                width: screenWidth * 0.05 * 3,
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Image.asset(
                                                        "Assets/Images/add.png",
                                                        color: ColorConstant
                                                            .pinkColor,
                                                        height: screenWidth *
                                                            0.05 *
                                                            2,
                                                        width: screenWidth *
                                                            0.05 *
                                                            2)
                                                  ],
                                                ),
                                              ),
                                              Flexible(
                                                  child: SizedBox(
                                                      height:
                                                          screenWidth * 0.06)),
                                              Flexible(
                                                child: MyText(
                                                  value: "homescree_btn_addnew"
                                                      .tr(),
                                                  color:
                                                      ColorConstant.pinkColor,
                                                  fontSize:
                                                      screenWidth * 0.05 - 7,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ));
                            }

                            return InkWell(
                                onTap: () {
                                  dispatchGoToViewPetProfile(
                                      profile, index - 1);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Card(
                                      color: ColorConstant.lightGrey,
                                      elevation: 2.3,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Container(
                                        width: screenWidth * 0.275,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Container(
                                                  height: (screenWidth * 19.2) /
                                                      100,
                                                  width: (screenWidth * 19.2) /
                                                      100,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                    border: Border.all(
                                                        color: Colors.white,
                                                        width: 3.0),
                                                    boxShadow: [
                                                      new BoxShadow(
                                                        color: Colors.black,
                                                        blurRadius: 2.0,
                                                        spreadRadius: 0.01,
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                      image: profile
                                                                  .userGeneralInfo
                                                                  .petsInfos[
                                                                      index - 1]
                                                                  .generalInfo
                                                                  .picturePet ==
                                                              null
                                                          ? Image.asset(
                                                              'Assets/Images/defaultPet.png')
                                                          : NetworkImage(profile
                                                              .userGeneralInfo
                                                              .petsInfos[
                                                                  index - 1]
                                                              .generalInfo
                                                              .picturePet),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Flexible(
                                                    child: SizedBox(
                                                        height: (screenHeight *
                                                                1.11) /
                                                            100)),
                                                Flexible(
                                                  child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4.0,
                                                              right: 4),
                                                      child:
                                                          viewFisrtNameLastName(
                                                        profile
                                                            .userGeneralInfo
                                                            .petsInfos[
                                                                index - 1]
                                                            .generalInfo
                                                            .name,
                                                        '',
                                                      )),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                ));
                          }),
                    ),
                    profile.userGeneralInfo.petsInfos.length < 3
                        ? Container()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 8.0,
                                height: 8.0,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _petIndicatorIndex == 0
                                      ? ColorConstant.activeIndicatorColor
                                      : ColorConstant.indicatorColor,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List<Widget>.generate(
                                    (profile.userGeneralInfo.petsInfos.length /
                                            3)
                                        .round(), (int index) {
                                  return Container(
                                    width: 8.0,
                                    height: 8.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 2.0),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: _petIndicatorIndex == index + 1
                                          ? ColorConstant.activeIndicatorColor
                                          : ColorConstant.indicatorColor,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                  ],
                ),
                //                Featured Product
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: screenWidth * 0.07,
                              bottom: screenWidth * 0.05 / 2,
                              left: (screenWidth * 4.0) / 100),
                          child: MyText(
                              value: "homescree_subtitle_featuredprod".tr(),
                              color: ColorConstant.pinkColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: screenWidth * 0.07,
                              bottom: screenWidth * 0.05 / 2,
                              right: (screenWidth * 4.0) / 100),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(ProductPopup(profile));

                              /////// tap to see all  Featured Product ////////
                            },
                            child: MyText(
                                value: "homescree_href_seeall".tr() + " >",
                                fontWeight: FontWeight.w400,
                                color: ColorConstant.pinkColor,
                                fontSize: screenWidth * 0.03),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Container(
                      height: 140,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: profile.parameters
                              .homeParameters['featured_products'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              child: Container(
                                width: screenWidth * 0.3,
                                margin: index == 0
                                    ? EdgeInsets.only(
                                        left: screenWidth * 0.05,
                                      )
                                    : index ==
                                            profile
                                                    .parameters
                                                    .homeParameters[
                                                        'featured_products']
                                                    .length -
                                                1
                                        ? EdgeInsets.only(
                                            right: screenWidth * 0.032,
                                            left: screenWidth * 0.018,
                                          )
                                        : EdgeInsets.only(
                                            left: screenWidth * 0.018,
                                          ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: InkWell(
                                  onTap: () async {
                                    print('ici');
                                    await launch(profile.parameters
                                            .homeParameters['featured_products']
                                        [index]['link']);

                                    /////// tap to see the description of feature product ///////
                                  },
                                  child: Card(
                                    color: ColorConstant.lightGrey,
                                    elevation: 2.3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 101,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(15.0),
                                                  topRight:
                                                      Radius.circular(15.0)),
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                    profile.parameters
                                                                .homeParameters[
                                                            'featured_products']
                                                        [index]['data'],
                                                  ),
                                                  fit: BoxFit.cover)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.02),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              MyText(
                                                  value: profile.parameters
                                                                  .homeParameters[
                                                              'featured_products']
                                                          [index][
                                                      'featured_product_title'],
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 10),
                                              MyText(
                                                  value:
                                                      "50\u0024".toUpperCase(),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  color: Colors.grey,
                                                  fontSize: 10),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),

                //                Customer Reviews
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 5.36) / 100,
                              bottom: screenWidth * 0.05 / 2,
                              left: (screenWidth * 4.0) / 100),
                          child: MyText(
                              value: "homescree_subtitle_reviews".tr(),
                              color: ColorConstant.pinkColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: screenWidth * 0.07,
                              bottom: screenWidth * 0.05 / 2,
                              right: (screenWidth * 4.0) / 100),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(ReviewsPopup(profile));
                            },
                            child: MyText(
                                value: "homescree_href_seeall".tr() + " >",
                                fontWeight: FontWeight.w400,
                                color: ColorConstant.pinkColor,
                                fontSize: screenWidth * 0.03),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Container(
                      height: screenHeight * 0.23,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.01,
                      ),
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: profile
                              .parameters.homeParameters['reviews'].length,
                          itemBuilder: (BuildContext context, int index) {
                            if (profile.parameters.homeParameters['reviews']
                                    [index]['active'] ==
                                1)
                              return InkWell(
                                onTap: () {
                                  /////// tap to see customer reviews ////////
                                },
                                child: Container(
                                  margin: index == 0
                                      ? EdgeInsets.only(
                                          left: screenWidth * 0.05, right: 8)
                                      : index ==
                                              profile
                                                      .parameters
                                                      .homeParameters['reviews']
                                                      .length -
                                                  1
                                          ? EdgeInsets.only(
                                              left: 8,
                                            )
                                          : EdgeInsets.zero,
                                  child: Card(
                                    color: Colors.white,
                                    elevation: 2.3,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        side: BorderSide(
                                            width: 0.1, color: Colors.black26)),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: screenWidth * 0.7,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 77,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: ColorConstant.lightGrey,
                                                borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(15.0),
                                                  topRight:
                                                      Radius.circular(15.0),
                                                ),
                                              ),
                                              alignment: Alignment.centerLeft,
                                              padding: EdgeInsets.only(
                                                  top: screenHeight * 0.01,
                                                  left: screenWidth * 0.02,
                                                  right: screenWidth * 0.02),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: MyText(
                                                        value: profile
                                                                    .parameters
                                                                    .homeParameters[
                                                                'reviews']
                                                            [index]['client'],
                                                        color: ColorConstant
                                                            .pinkColor,
                                                        fontSize:
                                                            screenWidth * 0.05 -
                                                                6),
                                                  ),
                                                  Flexible(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          top: screenHeight *
                                                              0.01),
                                                      child: MyText(
                                                          value: profile
                                                                      .parameters
                                                                      .homeParameters[
                                                                  'reviews'][index]
                                                              ['reviews_title'],
                                                          maxLines: 5,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          color: Colors.black,
                                                          fontSize:
                                                              screenWidth *
                                                                      0.05 -
                                                                  6),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 23,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenWidth * 0.02),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  MyText(
                                                      value: profile
                                                              .parameters
                                                              .homeParameters[
                                                                  'reviews']
                                                                  [index]
                                                                  ['rank']
                                                              .toString() +
                                                          "/5.0",
                                                      color: Colors.black,
                                                      fontSize:
                                                          screenWidth * 0.05 -
                                                              6),
                                                  Container(
                                                    child: RatingBar(
                                                      initialRating: profile
                                                                  .parameters
                                                                  .homeParameters[
                                                              'reviews'][index]
                                                          ['rank'],
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemSize:
                                                          screenWidth * 0.1 -
                                                              10,
                                                      itemCount: 5,
                                                      ratingWidget:
                                                          RatingWidget(
                                                        full: Icon(
                                                          Icons.star,
                                                          color: Colors.yellow,
                                                          size: 5.0,
                                                        ),
                                                        half: Icon(
                                                          Icons.star_half,
                                                          color: Colors.yellow,
                                                          size: 5.0,
                                                        ),
                                                        empty: Icon(
                                                          Icons.star_border,
                                                          color: Colors.yellow,
                                                          size: 5.0,
                                                        ),
                                                      ),
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 1.0),
                                                      ignoreGestures: true,
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            return Container();
                          }),
                    )
                  ],
                ),

                //                Videos
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 5.35) / 100,
                              bottom: screenWidth * 0.05 / 2,
                              left: (screenWidth * 4.0) / 100),
                          child: MyText(
                              value: "homescree_subtitle_videos".tr(),
                              color: ColorConstant.pinkColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: screenWidth * 0.07,
                              bottom: screenWidth * 0.05 / 2,
                              right: (screenWidth * 4.0) / 100),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(VideosPopup(profile));
                            },
                            child: MyText(
                                value: "homescree_href_seeall".tr() + " >",
                                color: ColorConstant.pinkColor,
                                fontSize: screenWidth * 0.03),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Container(
                      height: 175,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.01,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            profile.parameters.homeParameters['videos'].length,
                        itemBuilder: (BuildContext context, int index) {
                          if (profile.parameters
                              .homeParameters['videos'][index]['link']
                              .contains('youtube')) {
                            _controller = YoutubePlayerController(
                              initialVideoId: getVideoID(
                                profile.parameters.homeParameters['videos']
                                    [index]['link'],
                              ),
                              flags: YoutubePlayerFlags(
                                controlsVisibleAtStart: true,
                                disableDragSeek: true,
                                hideControls: false,
                                autoPlay: false,
                              ),
                            );
                          }
                          return Padding(
                            padding: index == 0
                                ? EdgeInsets.only(
                                    left: screenWidth * 0.05, right: 15)
                                : index ==
                                        profile
                                                .parameters
                                                .homeParameters['videos']
                                                .length -
                                            1
                                    ? EdgeInsets.only(
                                        right: screenWidth * 0.032,
                                      )
                                    : EdgeInsets.only(
                                        right: screenWidth * 0.05 / 3),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Container(
                                color: Colors.black,
                                height: 175,
                                width: screenWidth * 0.8,
                                alignment: Alignment.centerLeft,
                                child: profile.parameters
                                        .homeParameters['videos'][index]['link']
                                        .contains('youtube')
                                    ? Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          YoutubePlayer(
                                            controller: _controller,
                                            aspectRatio: 16 / 9,
                                            thumbnail: Container(
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    "https://img.youtube.com/vi/t28fnnyxHhU/hqdefault.jpg",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 0.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  width: screenWidth * 0.85,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                            bottomRight:
                                                                Radius.circular(
                                                                    10.0),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    10.0)),
                                                    color: Color(0x90231F20),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0,
                                                            bottom: 4),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        MyText(
                                                            value: profile
                                                                        .parameters
                                                                        .homeParameters[
                                                                    'videos'][index]
                                                                ['video_title'],
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize:
                                                                screenWidth *
                                                                        0.05 -
                                                                    6),
                                                        SizedBox(
                                                          height: screenWidth *
                                                              0.05 /
                                                              3,
                                                        ),
                                                        MyText(
                                                            value: profile
                                                                        .parameters
                                                                        .homeParameters[
                                                                    'videos']
                                                                [index]['date'],
                                                            color: Colors.white,
                                                            fontSize:
                                                                screenWidth *
                                                                        0.05 -
                                                                    6),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container(
                                        child: AspectRatio(
                                          aspectRatio: 16 / 9,
                                          child: BetterPlayer.network(
                                            profile.parameters
                                                    .homeParameters['videos']
                                                [index]['link'],
                                            betterPlayerConfiguration:
                                                BetterPlayerConfiguration(
                                              controlsConfiguration:
                                                  BetterPlayerControlsConfiguration(
                                                enableFullscreen: true,
                                                enablePlayPause: true,
                                                showControlsOnInitialize: false,
                                              ),
                                              autoPlay: false,
                                              deviceOrientationsOnFullScreen: [
                                                DeviceOrientation.landscapeLeft,
                                                DeviceOrientation.landscapeRight
                                              ],
                                              fullScreenByDefault: false,
                                              deviceOrientationsAfterFullScreen: [
                                                DeviceOrientation.landscapeLeft,
                                                DeviceOrientation
                                                    .landscapeRight,
                                              ],
                                              aspectRatio: 16 / 9,
                                              allowedScreenSleep: false,
                                              placeholder: Image.network(
                                                profile.parameters
                                                        .homeParameters[
                                                    'videos'][index]['data'],
                                              ),
                                              showPlaceholderUntilPlay: true,
                                              overlay: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: screenWidth * 0.85,
                                                    padding: EdgeInsets.all(
                                                        screenWidth * 0.05 / 4),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          10.0),
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      10.0)),
                                                      color: Color(0x90231F20),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12.0,
                                                              bottom: 4),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          MyText(
                                                              value: profile
                                                                      .parameters
                                                                      .homeParameters['videos'][index]
                                                                  [
                                                                  'video_title'],
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize:
                                                                  screenWidth *
                                                                          0.05 -
                                                                      6),
                                                          SizedBox(
                                                            height:
                                                                screenWidth *
                                                                    0.05 /
                                                                    3,
                                                          ),
                                                          MyText(
                                                              value: profile
                                                                          .parameters
                                                                          .homeParameters[
                                                                      'videos'][index]
                                                                  ['date'],
                                                              color:
                                                                  Colors.white,
                                                              fontSize:
                                                                  screenWidth *
                                                                          0.05 -
                                                                      6),
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),

                //                Blog
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                              top: (screenHeight * 5.35) / 100,
                              bottom: screenWidth * 0.05 / 2,
                              left: (screenWidth * 4.0) / 100),
                          child: MyText(
                              value: "homescree_subtitle_blog".tr(),
                              color: ColorConstant.pinkColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: screenWidth * 0.07,
                              bottom: screenWidth * 0.05 / 2,
                              right: (screenWidth * 4.0) / 100),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(BlogPopup(profile));
                            },
                            child: MyText(
                                value: "homescree_href_seeall".tr() + " >",
                                fontWeight: FontWeight.w400,
                                color: ColorConstant.pinkColor,
                                fontSize: screenWidth * 0.03),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                    Container(
                      height: 200,
                      child: ListView.builder(
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.01,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              profile.parameters.homeParameters['blogs'].length,
                          itemBuilder: (BuildContext context, int index) {
                            print(profile.parameters.homeParameters['blogs']
                                [index]['data']);
                            return Container(
                              width: screenWidth * 0.95,
                              child: InkWell(
                                onTap: () async {
                                  await launch(profile.parameters
                                      .homeParameters['blogs'][index]['link']);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.0),
                                      topRight: Radius.circular(10.0)),
                                  child: Container(
                                    width: screenWidth * 0.90,
                                    margin: index == 0
                                        ? EdgeInsets.only(
                                            left: screenWidth * 0.05, right: 15)
                                        : index ==
                                                profile
                                                        .parameters
                                                        .homeParameters['blogs']
                                                        .length -
                                                    1
                                            ? EdgeInsets.only(
                                                right: screenWidth * 0.032,
                                              )
                                            : EdgeInsets.only(
                                                right: screenWidth * 0.05 / 3),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: screenWidth * 0.85,
                                          height: 160,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                profile.parameters
                                                        .homeParameters['blogs']
                                                    [index]['data'],
                                              ),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                Colors.black.withOpacity(0.2),
                                                BlendMode.darken,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 5,
                                                left: 5.0,
                                                right: 5.0,
                                                bottom: 1.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: MyText(
                                                      value: profile.parameters
                                                                  .homeParameters[
                                                              'blogs'][index]
                                                          ['blogs_title'],
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Colors.black,
                                                      fontSize:
                                                          screenWidth * 0.03,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    /////// tap to read more ////////
                                                  },
                                                  child: MyText(
                                                      value:
                                                          "homescree_href_readmore"
                                                                  .tr() +
                                                              " >",
                                                      color: ColorConstant
                                                          .pinkColor,
                                                      fontSize:
                                                          screenWidth * 0.03),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),

                //                Referral
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: screenWidth * 0.07,
                          bottom: screenWidth * 0.05 / 2,
                          left: (screenWidth * 4.0) / 100),
                      child: MyText(
                          value: "homescree_subtitle_referral".tr(),
                          color: ColorConstant.pinkColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 175,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.01,
                      ),
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: profile
                              .parameters.homeParameters['referral'].length,
                          itemBuilder: (BuildContext context, int index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Container(
                                width: screenWidth * 0.85,
                                alignment: Alignment.centerLeft,
                                margin: index == 0
                                    ? EdgeInsets.only(
                                        left: screenWidth * 0.05, right: 15)
                                    : index ==
                                            profile
                                                    .parameters
                                                    .homeParameters['referral']
                                                    .length -
                                                1
                                        ? EdgeInsets.only(
                                            right: screenWidth * 0.032,
                                          )
                                        : EdgeInsets.only(
                                            right: screenWidth * 0.05 / 3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                profile.parameters
                                                        .homeParameters[
                                                    'referral'][index]['data'],
                                              ),
                                              fit: BoxFit.cover,
                                              colorFilter: ColorFilter.mode(
                                                  Colors.black.withOpacity(0.2),
                                                  BlendMode.darken))),
                                    ),
                                    Align(
                                        alignment: Alignment.center,
                                        child: InkWell(
                                          onTap: () {
                                            /////// tap to play the video ////////
                                          },
                                          child: Icon(
                                            Icons.play_circle_filled,
                                            color: Colors.white,
                                            size: screenWidth * 0.15,
                                          ),
                                        )),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        padding: EdgeInsets.all(
                                            screenWidth * 0.05 / 4),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(10.0),
                                              bottomLeft:
                                                  Radius.circular(10.0)),
                                          color: Color(0x90231F20),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            MyText(
                                                value: profile.parameters
                                                            .homeParameters[
                                                        'referral'][index]
                                                    ['referral_title'],
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize:
                                                    screenWidth * 0.05 - 6),
                                            SizedBox(
                                              height: screenWidth * 0.05 / 3,
                                            ),
                                            MyText(
                                                value: profile.parameters
                                                        .homeParameters[
                                                    'referral'][index]['date'],
                                                color: Colors.white,
                                                fontSize:
                                                    screenWidth * 0.05 - 6),
                                          ],
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),

                //                Confidentiality & Security
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          top: (screenHeight * 5.35) / 100,
                          bottom: screenWidth * 0.05 / 2,
                          left: (screenWidth * 4.0) / 100),
                      child: MyText(
                          value: "homescree_subtitle_confidandsecurity".tr(),
                          color: ColorConstant.pinkColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Container(
                      height: 175,
                      width: double.maxFinite,
                      alignment: Alignment.centerLeft,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                width: screenWidth * 0.86,
                                margin: index == 0
                                    ? EdgeInsets.only(
                                        left: screenWidth * 0.05, right: 15)
                                    : index == 9
                                        ? EdgeInsets.only(
                                            right: screenWidth * 0.032,
                                          )
                                        : EdgeInsets.only(
                                            right: screenWidth * 0.5 / 14),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Card(
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      Expanded(
                                          flex: 25,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: screenWidth * 0.05),
                                            decoration: BoxDecoration(
                                              color: ColorConstant.pinkColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10.0),
                                                  topRight:
                                                      Radius.circular(10.0)),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Container(
                                                  height: 30.0,
                                                  width: 30.0,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "Assets/Images/Confidentiality.png"))),
                                                ),
                                                Flexible(
                                                    child: SizedBox(
                                                  width: screenWidth * 0.03,
                                                )),
                                                MyText(
                                                    value:
                                                        "homescree_bloctitle_confidandprivacy"
                                                            .tr(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    color: Colors.white,
                                                    fontSize:
                                                        screenWidth * 0.04,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ],
                                            ),
                                          )),
                                      Expanded(
                                          flex: 75,
                                          child: Container(
                                            width: screenWidth * 1.0,
                                            decoration: BoxDecoration(
                                              color: ColorConstant.lightGrey,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10.0),
                                                  bottomRight:
                                                      Radius.circular(10.0)),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: screenWidth * 0.05,
                                                      right: screenWidth * 0.02,
                                                      top: 10),
                                                  child: MyText(
                                                    value:
                                                        "editprofil_general_content_preference"
                                                            .tr(),
                                                    fontSize:
                                                        screenWidth * 0.033,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: screenWidth * 0.05,
                                                      right: screenWidth * 0.02,
                                                      top: 15),
                                                  child: MyText(
                                                    value:
                                                        "homescree_content_datasecurity"
                                                            .tr(),
                                                    fontSize:
                                                        screenWidth * 0.033,
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: screenWidth * 0.05,
                                                      right:
                                                          screenWidth * 0.02),
                                                  child: MyText(
                                                    value:
                                                        "homescree_content_appsecurity"
                                                            .tr(),
                                                    fontSize:
                                                        screenWidth * 0.033,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ))
                                    ],
                                  ),
                                ));
                          }),
                    )
                  ],
                ),
              ],
            ),
          ),

          SizedBox(
            height: (screenHeight * 9.0) / 100,
          ),

          //          Footer
          Container(
            height: (screenHeight * 14.16) / 100,
            color: ColorConstant.boxColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: (screenWidth * 30.43) / 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Images/footer-logo-1.png"),
                          fit: BoxFit.contain)),
                ),
                Container(
                  width: (screenWidth * 14.15) / 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Images/footer-logo-2.png"),
                          fit: BoxFit.contain)),
                ),
                Container(
                  width: (screenWidth * 32.05) / 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("Assets/Images/footer-logo-3.png"),
                          fit: BoxFit.contain)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  String getVideoID(String url) {
    int index;
    index = url.indexOf('=');
    url = url.replaceRange(0, index + 1, '');
    index = url.indexOf('&');
    url = url.replaceRange(index, url.length, '');
    return url;
  }

  void dispatchGoToAddNewUser(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/usersProvider',
      arguments: {
        'profile': profile,
        'route': 'GoToAddNewUser',
      },
    );
  }

  void dispatchGoToEditSubUser(Profile profile, int index) {
    Navigator.of(context).pushReplacementNamed(
      '/usersProvider',
      arguments: {
        'profile': profile,
        'route': 'GoToEditSubUser',
        'index': index
      },
    );
  }

  void dispatchGoToAddEditPetProfile(Profile profile, int index) {
    Navigator.of(context).pushReplacementNamed(
      '/petsProvider',
      arguments: {
        'profile': profile,
        'index': index,
        'route': 'GoToAddEditPetProfile'
      },
    );
  }

  void dispatchGoToViewPetProfile(Profile profile, int index) {
    Navigator.of(context).pushReplacementNamed(
      '/petsProvider',
      arguments: {
        'profile': profile,
        'index': index,
        'route': 'GoToViewPetProfile'
      },
    );
  }

  bool exist = false;

  dispatchGoToAddEdit(Profile profile) {
    int index, indexu;

    serialNumbers.forEach((element) {
      print(element['type']);

      //  print(key);
      // print(value);
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
          profile.parameters.typecheck = 'object';
          profile.parameters.indexu = indexu;
          profile.parameters.indext = index;
          profile.parameters.location = "AddEditTag";
          Navigator.of(context).pushReplacementNamed(
            '/tagsProvider',
            arguments: profile,
          );
        } else if (element['type'] == 'pet') {
          for (int i = 0; i < profile.userGeneralInfo.petsInfos.length; i++) {
            for (int j = 0;
                j < profile.userGeneralInfo.petsInfos[i].petTag.length;
                j++) {
              if (profile.userGeneralInfo.petsInfos[i].petTag[j].tagInfo
                      .serialNumber ==
                  serialNumber) {
                indexu = i;
                index = j;
                break;
              }
            }
          }
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(
              '/petsProvider',
              arguments: {
                'profile': profile,
                'index': indexu,
                'route': 'GoToViewPetProfile',
              },
            );
          });
          print(index);
          print(indexu);
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
          profile.parameters.typecheck = 'medical';
          profile.parameters.indexu = indexu;
          profile.parameters.indext = index;
          profile.parameters.location = "AddEditTag";
          Navigator.of(context).pushReplacementNamed(
            '/tagsProvider',
            arguments: profile,
          );
        } else {}
      }
    });
    if (exist == false) {
      profile.parameters.serial = serialNumber;

      profile.parameters.serial = serialNumber;
      profile.parameters.location = 'VerifyTag';
      Navigator.of(context).pushReplacementNamed(
        '/tagsProvider',
        arguments: profile,
      );
    }
  }
}

// dispatchGoToAddEdit(Profile profile) {
//   int index;

//   if (serialNumbers.contains(serialNumber) == true) {
//     index = profile.userGeneralInfo.userTags.objectTag.indexWhere(
//       (element) => element.tagInfo.serialNumber == serialNumber,
//     );
//     BlocProvider.of<HomeBloc>(context).dispatch(
//       GoToAddEditObjectHomeTagEvent(
//         profile: profile,
//         index: index,
//       ),
//     );
//   } else {
//     ObjectTag objectTag = ObjectTag(
//       currency: profile.userGeneralInfo.currency,
//       otherInfo: List<OtherInfo>(),
//       preferenceUser: profile.userGeneralInfo.preferenceUser,
//       emergencyContactUser: profile.userGeneralInfo.userEmergencyContact,
//       tagUserInfo: TagUserInfo(
//         idUser: profile.userGeneralInfo.idUser,
//         firstName: profile.userGeneralInfo.firstName,
//         lastName: profile.userGeneralInfo.lastName,
//         mail: profile.userGeneralInfo.mail,
//         mobile: profile.userGeneralInfo.mobile,
//         codePhone: profile.userGeneralInfo.codePhone,
//       ),
//       tagInfo: TagInfo(
//         idTag: null,
//         serialNumber: serialNumber,
//         idTagCategorie: null,
//         active: 1,
//         archive: 0,
//         idMember: profile.userGeneralInfo.idMember,
//       ),
//     );

//     index = profile.userGeneralInfo.userTags.objectTag.length + 1;
//     profile.userGeneralInfo.userTags.objectTag.add(objectTag);
//     BlocProvider.of<HomeBloc>(context).dispatch(
//       GoToAddEditObjectHomeTagEvent(
//         profile: profile,
//         index: null,
//       ),
//     );
//   }
// }
