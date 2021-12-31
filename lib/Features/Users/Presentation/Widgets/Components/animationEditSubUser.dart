import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/alertDialogUpdate.dart';
import 'package:neopolis/Features/Users/Presentation/bloc/users_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popup_menu_image.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:easy_localization/easy_localization.dart';

class CustomSliverDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final bool hideTitleWhenExpanded;
  final Profile profile;
  String firstName;
  String lastName;
  String role;
  String loading;
  final int index;
  CustomSliverDelegate({
    @required this.expandedHeight,
    @required this.profile,
    @required this.firstName,
    @required this.lastName,
    @required this.role,
    @required this.index,
    @required this.loading,
    this.hideTitleWhenExpanded = true,
  });
  var screenWidth, screenHeight;

  File imageFile;
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  List<String> docPaths;
  String fileName;
  Map<String, String> paths;
  List<String> extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;
  File docFile;
  String url;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    viewFisrtNameLastName(String first, String last, bool isbar) {
      if (first != null && last == null) {
        return Text(
          first,
          textScaleFactor: 1.0,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 20,
              fontFamily: "SFProText",
              color:  ColorConstant.textColor,
              fontWeight: FontWeight.w600),
        );
      }
      if (first == null && last != null) {
        return Text(
          last,
          textScaleFactor: 1.0,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 20,
              fontFamily: "SFProText",
              color: ColorConstant.textColor,
              fontWeight: FontWeight.w600),
        );
      }
      if (first == null && last == null) {
        return Text(
          ' ',
          textScaleFactor: 1.0,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 20,
              fontFamily: "SFProText",
              color:  ColorConstant.textColor,
              fontWeight: FontWeight.w600),
        );
      }
      if (first != null && last != null) {
        return Text(
          first + ' ' + last,
          textScaleFactor: 1.0,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: 20,
              fontFamily: "SFProText",
              color: ColorConstant.textColor,
              fontWeight: FontWeight.w600),
        );
      }
    }

    showOverlayUpdate(BuildContext context, String headerMessage,
        String message, Profile profile, int index) {
      Navigator.of(context)
          .push(AlertDialogueUpdate(headerMessage, message, profile, index));
    }

    void stateChanged(bool isShow) {
      print('menu is ${isShow ? 'showing' : 'closed'}');
    }

    List<Asset> images = <Asset>[];
    List<Asset> resultList = <Asset>[];

    Documents document;
    void onClickMenu(
      MenuItemProvider item,
    ) async {
      if (item.type == "camera") {
        PickedFile pickedFile = await ImagePicker().getImage(
          source: ImageSource.camera,
          imageQuality: 20,
          maxWidth: 1080,
          maxHeight: 1080,
        );

        profile.userGeneralInfo.update = true;

        if (pickedFile != null) {
          imageFile = File(pickedFile.path);
          profile.userGeneralInfo.subUsers[index].userGeneralInfo
              .idProfilePicture = null;
          profile.parameters.file = imageFile;
          profile.parameters.location = 'ProfilePicture';
          BlocProvider.of<UsersBloc>(context).dispatch(
            UploadFileEvent(profile: profile, index: index),
          );
        }
      } else if (item.type == "gallery") {
        resultList = await MultiImagePicker.pickImages(
          maxImages: 1,
          // enableCamera: true,
          selectedAssets: images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarColor: "#" +
                profile.parameters
                        .themeColor[profile.userGeneralInfo.currentColor - 1]
                    ['color'],
            actionBarTitle: "Gallery",
            allViewTitle: "editprofil_label_allphotos".tr(),
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          ),
        );

        images = resultList;

        print(images[0].metadata);

        var path2 =
            await FlutterAbsolutePath.getAbsolutePath(images[0].identifier);
        var imageFile = File(path2);
        print('the file of image is ' + imageFile.toString());
        profile.userGeneralInfo.subUsers[index].userGeneralInfo
            .idProfilePicture = null;
        profile.parameters.file = imageFile;
        profile.parameters.location = 'ProfilePicture';
        BlocProvider.of<UsersBloc>(context).dispatch(
          UploadFileEvent(profile: profile, index: index),
        );
        // PickedFile pickedFile = await ImagePicker().getImage(
        //   source: ImageSource.gallery,
        //   imageQuality: 20,
        //   maxWidth: 1080,
        //   maxHeight: 1080,
        // );
        // if (pickedFile != null) {

        //       profile.userGeneralInfo.update = true;

        //                if (pickedFile != null) {
        //                             imageFile = File(pickedFile.path);
        //                             profile.userGeneralInfo.subUsers[index]
        //                                 .userGeneralInfo.idProfilePicture = null;
        //                             profile.parameters.file = imageFile;
        //                             profile.parameters.location =
        //                                 'ProfilePicture';
        //                             BlocProvider.of<UsersBloc>(context).dispatch(
        //                               UploadFileEvent(
        //                                   profile: profile, index: index),
        //                             );
        //                           }
        // }
      }
    }

    void onDismiss() {
      print('Menu is dismiss');
    }

    GlobalKey btnKey = GlobalKey();

    void maxColumn() {
      PopupMenu menu = PopupMenu(
          backgroundColor: ColorConstant.whiteTextColor,
          lineColor: ColorConstant.darkGray,
          maxColumn: 2,
          items: [
            MenuItem(
              type: "camera",
              image: Image.asset(
                "Assets/Images/camera-red.png",
                height: 14,
                width: 16.8,
              ),
            ),
            MenuItem(
                type: "gallery",
                image: Image.asset(
                  "Assets/Images/gallery-red.png",
                  height: 14,
                  width: 18.68,
                )),
          ],
          onClickMenu: onClickMenu,
          stateChanged: stateChanged,
          onDismiss: onDismiss);
      return menu.show(widgetKey: btnKey);
    }

    final appBarSize = expandedHeight - shrinkOffset;
    final cardTopPosition = expandedHeight / 2 - shrinkOffset + 20;
    final proportion = 2 - (expandedHeight / appBarSize);
    final percent = proportion < 0 || proportion > 1 ? 0.0 : proportion;
    screenWidth = MediaQuery.of(context).size.height;
    screenHeight = MediaQuery.of(context).size.width;
    PopupMenu.context = context;

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
                    color: ColorConstant.pinkColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () {
                          if (profile.userGeneralInfo.update == false) {
                            BlocProvider.of<UsersBloc>(context).dispatch(
                              GoToViewProfileSubUserEvent(
                                  profile: profile, index: index),
                            );
                          } else {
                            showOverlayUpdate(
                                context,
                                "messages_label_confirmationleave".tr(),
                                "messages_label_confirmationdesc".tr(),
                                profile,
                                index);
                          }
                        },
                        child: CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.transparent,
                            child: SvgPicture.asset(
                              'Assets/Images/arrowBack.svg',
                            ))),
                    Text("drawer_label_userprofile".tr(),
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
              child: StatefulBuilder(
                  // You need this, notice the parameters below:
                  builder: (BuildContext context, StateSetter setState) {
                    print(profile
                                                          .userGeneralInfo
                                                          .subUsers[index]
                                                          .userGeneralInfo
                                                          .profilePictureUrl);
                return Opacity(
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
                                 top: 4,
                                  right:  2),
                           

                              child: GestureDetector(
                                onTap: () async {
                                  print('ok');
                                     File _displayImage;

                                    final _url =   profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .userGeneralInfo.profilePictureUrl
                                             ;

                                    final response = await http.get(_url);

                                    // Get the image name
                                    final imageName = path.basename(_url);
                                    // Get the document directory path
                                    final appDir = await pathProvider
                                        .getApplicationDocumentsDirectory();

                                    // This is the saved image path
                                    // You can use it to display the saved image later.
                                    final localPath =
                                        path.join(appDir.path, imageName);

                                    // Downloading
                                    final imageFile = File(localPath);
                                    await imageFile
                                        .writeAsBytes(response.bodyBytes);

                                    _displayImage = imageFile;

                                  dynamic cropped = await ImageCropper.cropImage(
                                    aspectRatioPresets: [
                                      CropAspectRatioPreset.square,
                                      CropAspectRatioPreset.ratio3x2,
                                      CropAspectRatioPreset.original,
                                      CropAspectRatioPreset.ratio4x3,
                                      CropAspectRatioPreset.ratio16x9
                                    ],
                                    androidUiSettings: AndroidUiSettings(
                                        toolbarTitle: 'Cropper',
                                        toolbarColor: ColorConstant.pinkColor,
                                        toolbarWidgetColor: Colors.white,
                                        initAspectRatio:
                                            CropAspectRatioPreset.original,
                                        lockAspectRatio: false),
                                    iosUiSettings: IOSUiSettings(
                                      minimumAspectRatio: 1.0,
                                    ),
                                    sourcePath:  _displayImage.path,
                                    aspectRatio:
                                        CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
                                  );
                                  setState(() {
                                    if (cropped != null) {
                                      // setState(() {
                                      //   profile.parameters.file = cropped;
                                      // });
                                      profile.parameters.file = cropped;

                                      profile
                                          .userGeneralInfo
                                          .subUsers[index]
                                          .userGeneralInfo
                                          .idProfilePicture = null;
                                      profile.parameters.file = imageFile;
                                      profile.parameters.location =
                                          'ProfilePicture';
                                      BlocProvider.of<UsersBloc>(context)
                                          .dispatch(
                                        UploadFileEvent(
                                            profile: profile, index: index),
                                      );
                                    }
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black,
                                        border: Border.all(
                                            color: Colors.white, width: 4),
                                        boxShadow: [
                                          new BoxShadow(
                                            color: Colors.black38,
                                            blurRadius: 5.0,
                                            spreadRadius: 0.01,
                                          ),
                                        ]),
                                    child: Container(
                                        height:
                                            80,
                                        width:
                                            80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: imageFile == null
                                                  ? NetworkImage(
                                                      profile
                                                          .userGeneralInfo
                                                          .subUsers[index]
                                                          .userGeneralInfo
                                                          .profilePictureUrl,
                                                    )
                                                  : FileImage(imageFile)),
                                        ))),
                              ),
                            ),
                           loading=='true'?
                        Positioned(
                          bottom:4,
                          left: 4,
                          right:6,
                                child:  SizedBox(  height:  80,
                                      width: 80,child:CircularProgressIndicator(strokeWidth: 4,backgroundColor: ColorConstant.pinkColor,
                                          valueColor: new AlwaysStoppedAnimation<Color>(ColorConstant.greyColor),

                                      
  

                                      ))):Container(),
                              Positioned(
                                  top: 60,
                                  left: 55,
                              child: InkWell(
                                 key: btnKey,
                      onTap:maxColumn,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 16,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: ColorConstant.pinkColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black38,
                                          blurRadius: 6.0,
                                          spreadRadius: 0.01,
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.all(3.5),
                                    child: ImageIcon(
                                      AssetImage("Assets/Images/camera-red.png"),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
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
                              Flexible(
                                  child: viewFisrtNameLastName(
                                      firstName,
                                      lastName,
                                      appBarSize < 100
                                          ? true
                                          : false)),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                role ?? '',
                                textScaleFactor: 1.0,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "SFProText",
                                  color:  ColorConstant.pinkColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ])),
                      ],
                    ),
                  ),
                );
              })),
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
