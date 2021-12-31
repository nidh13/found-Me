import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Presentation/bloc/users_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:easy_localization/easy_localization.dart';

class AddPictureToNewUserDisplay extends StatefulWidget {
  final Profile profile;
  String loading;
  AddPictureToNewUserDisplay({Key key, @required this.profile, this.loading})
      : super(key: key);
  @override
  _AddPictureToNewUserDisplayState createState() =>
      _AddPictureToNewUserDisplayState();
}

class _AddPictureToNewUserDisplayState
    extends State<AddPictureToNewUserDisplay> {
  var screenWidth, screenHeight;

  List<Color> _colors = [
    Color(0xffEC1C40),
    Color(0XFFED273C),
    Color(0xffEE3638),
    // Color(0xffF1502F),
    Color(0xffF47025)
  ];
  List<double> _stops = [0.1, 0.4, 0.6, 0.9];
  List<Asset> images = <Asset>[];
  List<Asset> resultList = <Asset>[];
  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    // screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    //screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              128,
            ),
            child: _appbarView(profile)),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //   _appbarView(profile),
              SizedBox(
                height: 22,
              ),
              _homeView(profile),
            ],
          ),
        ));
  }

  _appbarView(Profile profile) {
    return Container(
      height: 128,
      decoration: BoxDecoration(color: ColorConstant.pinkColor),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 50, 16, 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
                icon: SvgPicture.asset(
                  'Assets/Images/arrowBack.svg',
                ),
                onPressed: () {
                  setState(() {
                    profile.userGeneralInfo.subUsers.removeLast();
                    profile.parameters.newUser = false;
                  });

                  BlocProvider.of<UsersBloc>(context).dispatch(
                    GoToAddNewUserEvent(
                      profile: profile,
                    ),
                  );
                }),
            MyText(
                value: "editprofil_label_newuser".tr(),
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white),
            InkWell(
              child: SvgPicture.asset(
                'Assets/Images/icHelp.svg',
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HelpDisplay(profile: profile)));
              },
            ),
          ],
        ),
      ),
    );
  }

  _homeView(Profile profile) {
    File imageFile;

    return Padding(
      padding: EdgeInsets.only(left: 26, right: 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 36,
          ),
          Center(
            //check me
            child: MyText(
                value: "editprofil_label_createnewaccount".tr(),
                fontSize: 16.0,
                color: Color.fromRGBO(153, 153, 153,
                    1)) /*Text(
              "editprofil_label_createnewaccount".tr(),
              textScaleFactor: 1.0,
              style: TextStyle(
                  fontSize: 16.0, color: Color.fromRGBO(153, 153, 153, 1)),
            )*/
            ,
          ),
          SizedBox(
            height: 38,
          ),
          Row(
            children: <Widget>[
              Flexible(
                  child: MyText(
                      value: "editprofil_label_addpicture".tr(),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: ColorConstant.pinkColor)),
              SizedBox(
                width: 14,
              ),
              Image.asset(
                "Assets/Images/info.png",
                height: 14,
                width: 14,
              ),
            ],
          ),
          MyText(
              value: "editprofil_label_requirecards".tr(),
              fontSize: 12,
              color: ColorConstant.darkGray,
              fontWeight: FontWeight.w400),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () async {
              resultList = await MultiImagePicker.pickImages(
                maxImages: 1,
                // enableCamera: true,
                selectedAssets: images,
                cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
                materialOptions: MaterialOptions(
                  actionBarColor: "#" +
                      profile.parameters.themeColor[
                          profile.userGeneralInfo.currentColor - 1]['color'],
                  actionBarTitle: "editprofil_label_gallery".tr(),
                  allViewTitle: "editprofil_label_allphotos".tr(),
                  useDetailsView: false,
                  selectCircleStrokeColor: "#000000",
                ),
              );

              images = resultList;

              print(images[0].metadata);

              var path2 = await FlutterAbsolutePath.getAbsolutePath(
                  images[0].identifier);
              var imageFile = File(path2);

              profile.parameters.file = imageFile;
              profile.parameters.location = 'ProfilePictureSubUser';
              setState(() {
                profile.userGeneralInfo.subUsers.last.userGeneralInfo
                    .profilePictureUrl = widget.profile.parameters.fileUrl;
              });
              dispatchUploadFile(
                profile,
                profile.userGeneralInfo.subUsers.length - 1,
              );
            },
            child: Container(
              height: 49,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 17, right: 17.8),
                child: Row(
                  children: [
                    Image.asset(
                      "Assets/Images/gallery-red.png",
                      color: ColorConstant.pinkColor,
                      height: 36,
                      width: 27,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                        child: MyText(
                            value: "editprofil_label_chooseimage".tr(),
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorConstant.textColor),
                      ),
                    ),
                    Image.asset(
                      "Assets/Images/arrow-right-red.png",
                      color: ColorConstant.pinkColor,
                      height: 13.18,
                      width: 8,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          GestureDetector(
              onTap: () async {
                PickedFile pickedFile = await ImagePicker().getImage(
                  source: ImageSource.camera,
                  maxWidth: 1080,
                  maxHeight: 1080,
                );
                if (pickedFile != null) {
                  setState(() {
                    imageFile = File(pickedFile.path);

                    profile.parameters.file = imageFile;

                    profile.parameters.location = 'ProfilePictureSubUser';
                    setState(() {
                      profile.userGeneralInfo.subUsers.last.userGeneralInfo
                              .profilePictureUrl =
                          widget.profile.parameters.fileUrl;
                    });
                    dispatchUploadFile(
                      profile,
                      profile.userGeneralInfo.subUsers.length - 1,
                    );
                  });
                }
              },
              child: Container(
                height: 49,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 17, right: 17.8),
                  child: Row(
                    children: [
                      Image.asset(
                        "Assets/Images/camera-red.png",
                        color: ColorConstant.pinkColor,
                        height: 36,
                        width: 27,
                      ),
                      Expanded(
                        child: Padding(
                        padding: const EdgeInsets.only(left:8.0),
                          child: MyText(
                              value: "editprofil_label_takepicture".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant.textColor),
                        ),
                      ),
                      Image.asset(
                        "Assets/Images/arrow-right-red.png",
                        color: ColorConstant.pinkColor,
                        height: 13.18,
                        width: 8,
                      ),
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: 16,
          ),
          SizedBox(
            height: 40,
          ),
          widget.loading == 'true'
              ? Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30),
                  child: LinearProgressIndicator(
                      backgroundColor: ColorConstant.pinkColor,
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          ColorConstant.greyColor)),
                )
              : Container()
        ],
      ),
    );
  }

  void dispatchGoToHelp(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/helpProvider',
      arguments: profile,
    );
  }

  void dispatchUploadFile(Profile profile, int index) {
    BlocProvider.of<UsersBloc>(context).dispatch(
      UploadFileEvent(profile: profile, index: index),
    );
  }
}
