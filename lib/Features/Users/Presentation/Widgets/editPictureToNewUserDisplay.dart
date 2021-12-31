import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Presentation/bloc/users_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:easy_localization/easy_localization.dart';

class EditPictureToNewUserDisplay extends StatefulWidget {
  final Profile profile;
  final String loading;
  EditPictureToNewUserDisplay({Key key, @required this.profile, this.loading})
      : super(key: key);
  @override
  _EditPictureToNewUserDisplayState createState() =>
      _EditPictureToNewUserDisplayState();
}

class _EditPictureToNewUserDisplayState
    extends State<EditPictureToNewUserDisplay> {
  var screenWidth, screenHeight;
  var item;
  var notification = 0;
  bool _switchLost = true;
  bool _switchEmergency = false;

  List<Color> _colors = [
    Color(0xffEC1C40),
    Color(0XFFED273C),
    Color(0xffEE3638),
    // Color(0xffF1502F),
    Color(0xffF47025)
  ];
  List<double> _stops = [0.1, 0.4, 0.6, 0.9];

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
              SizedBox(height:20),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 20.0,
                      horizontal: 20.0,
                    ),
                    height:screenHeight *0.38 ,
                    width: screenHeight *0.7,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(
                          color: Colors.white,
                          width: (screenHeight * 0.12) / 100),
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5.0,
                          spreadRadius: 0.01,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: GestureDetector(
                        onTap: () async {
                          dynamic cropped = await ImageCropper.cropImage(
                            aspectRatioPresets: [
                              CropAspectRatioPreset.square,
                              CropAspectRatioPreset.ratio3x2,
                              CropAspectRatioPreset.original,
                              CropAspectRatioPreset.ratio4x3,
                              CropAspectRatioPreset.ratio16x9
                            ],
                            androidUiSettings: AndroidUiSettings(
                                toolbarTitle: "pets_label_cropper".tr(),
                                toolbarColor: ColorConstant.pinkColor,
                                toolbarWidgetColor: Colors.white,
                                initAspectRatio: CropAspectRatioPreset.original,
                                lockAspectRatio: false),
                            iosUiSettings: IOSUiSettings(
                              minimumAspectRatio: 1.0,
                            ),
                            sourcePath: profile.parameters.file.path,
                            aspectRatio:
                                CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
                          );
                          if (cropped != null) {
                            // setState(() {
                            //   profile.parameters.file = cropped;
                            // });
                            profile.parameters.file = cropped;
                            profile.parameters.location = 'EditProfilePicture';
                            setState(() {
                              profile.userGeneralInfo.subUsers.last
                                      .userGeneralInfo.profilePictureUrl =
                                  profile.parameters.fileUrl;
                            });
                            profile.parameters.location = 'EditProfilePicture';
                            dispatchUploadFile(
                              profile,
                              profile.userGeneralInfo.subUsers.length - 1,
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.white,
                                  width: (screenHeight * 0.62) / 100),
                              image: DecorationImage(
                                  image: NetworkImage(
                                    profile.userGeneralInfo.subUsers.last
                                        .userGeneralInfo.profilePictureUrl,
                                  ),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ),
                  widget.loading == 'true'
                      ? SizedBox(
                          height: 245.0,
                          width: 245,
                          child: CircularProgressIndicator(
                            strokeWidth: 4,
                            backgroundColor: ColorConstant.pinkColor,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                ColorConstant.greyColor),
                          ))
                      : Container(),
                ],
              ),
              SizedBox(
                height: 22,
              ),
             
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.05, screenHeight * 0.036, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText(
                      value: 'editprofil_label_assPicturemsg1'.tr(),
                      color: ColorConstant.textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.05, 0, screenWidth * 0.05, 0),
                child: Divider(color: Colors.grey),
              ),
                Padding(
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.05, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyText(
                      value: 'editprofil_label_assPicturemsg2'.tr(),
                      color: ColorConstant.textColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.05, 0, screenWidth * 0.05, 0),
                child: Divider(color: Colors.grey),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.03,
                    screenHeight * 0.03,
                    screenWidth * 0.03,
                    screenHeight * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SvgPicture.asset(
                      'Assets/Images/zoom.svg',
                      color: ColorConstant.pinkColor,
                    ),
                     SvgPicture.asset(
                      'Assets/Images/move.svg',
                      color: ColorConstant.pinkColor,
                    ),
                    SvgPicture.asset(
                      'Assets/Images/rotate.svg',
                      color: ColorConstant.pinkColor,
                    ),

                   
                    // Image.asset('Assets/Images/Group1.png',
                    //     width: screenWidth * 0.4, height: screenHeight * 0.2),
                    // Image.asset('Assets/Images/Group2.png',
                    //     width: screenWidth * 0.4, height: screenHeight * 0.2),
                  ],
                ),
              ),
            
              
             
            
               Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16, bottom:20 ),
                child: ButtonTheme(
                  
                  height: screenHeight * 0.1,
                  minWidth:
                      MediaQuery.of(context).size.width ?? double.infinity,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                    ),
                    color: ColorConstant.pinkColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          value: '',
                        ),
                        MyText(
                          value: "pets_label_continue".tr(),
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        Image.asset(
                          "Assets/Images/IconArrowWhite.png",
                        ),
                      ],
                    ),
                    onPressed: () {
                      BlocProvider.of<UsersBloc>(context).dispatch(
                        GoToEditProfileSubUserEvent(
                            profile: profile,
                            index: profile.userGeneralInfo.subUsers.length - 1),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  _appbarView(Profile profile) {
    return Container(
      height: 128,
      decoration: BoxDecoration(
        color: ColorConstant.pinkColor,
      ),
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
                  BlocProvider.of<UsersBloc>(context).dispatch(
                    GoToAddPictureToNewUserEvent(
                      profile: profile,
                    ),
                  );
                }),
            MyText(
                value: "editprofil_label_phonelock".tr(),
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
                      builder: (context) => HelpDisplay(profile: profile)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void dispatchUploadFile(Profile profile, int index) {
    BlocProvider.of<UsersBloc>(context).dispatch(
      UploadFileEvent(profile: profile, index: index),
    );
  }

  void dispatchGoToHelp(Profile profile) {
    Navigator.of(context).pushReplacementNamed(
      '/helpProvider',
      arguments: profile,
    );
  }
}
