import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Core/Utils/parameters.dart';
import 'package:neopolis/Features/Home/Presentation/bloc/home_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:neopolis/Core/Utils/alertDialogueSuccess.dart';

import 'package:neopolis/help/helpDisplay.dart';

class ResetPasswordDisplay extends StatefulWidget {
  final Profile profile;

  const ResetPasswordDisplay({
    Key key,
    @required this.profile,
  }) : super(key: key);

  @override
  ResetPasswordDisplayState createState() => new ResetPasswordDisplayState();
}

class ResetPasswordDisplayState extends State<ResetPasswordDisplay> {
  TextEditingController newPasswordController = new TextEditingController();
  TextEditingController currentpassController = new TextEditingController();

  bool isLoading = false;
  List<Color> _colors = [ColorConstant.pinkColor, ColorConstant.orangeColor];
  List<double> _stops = [0.0, 1.5];
  TextEditingController passwordcontroller = new TextEditingController();
  bool _toggleVisisbility = true;
  var screenWidth, screenHeight;

  bool fileExists = false;
  bool is_8char = false,
      isspecialcar = false,
      is1upper = false,
      is1number = false;
  bool checkerOldPassword = true;
  bool checkerNewPassword = true;
  String oldPassword, newPassword;

  String codecolor = "#EC1C40";
  StreamController<String> newPasswordStreamcontroller;

  static showOverlay(
      BuildContext context, String headerMessage, String message) {
    Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  static showOverlaySucess(BuildContext context, String message) {
    Navigator.of(context).push(AlertDialogSuccess(message, context));
  }

  @override
  void initState() {
    super.initState();
    newPasswordStreamcontroller = StreamController<String>.broadcast();

    newPasswordController.text = "";
    currentpassController.text = "";
    currentpassController.addListener(() {});

    newPasswordController.addListener(() {
      newPasswordStreamcontroller.sink.add(newPasswordController.text.trim());
    });
    newPasswordStreamcontroller = StreamController<String>.broadcast();
    if (widget.profile.userGeneralInfo.message ==
        'password modification success') {
      Future.delayed(
          Duration.zero,
          () => showOverlaySucess(
              context, 'Your password has been successfully changed'));
    } else if (widget.profile.userGeneralInfo.message ==
            "resetpwd_info_error1".tr() ||
        widget.profile.userGeneralInfo.message == "resetpwd_info_error2".tr() ||
        widget.profile.userGeneralInfo.message == "resetpwd_info_error3".tr() ||
        widget.profile.userGeneralInfo.message == "resetpwd_info_error4".tr() ||
        widget.profile.userGeneralInfo.message == "resetpwd_info_error5".tr() ||
        widget.profile.userGeneralInfo.message == "resetpwd_info_error6".tr() ||
        widget.profile.userGeneralInfo.message == "resetpwd_info_error7".tr()) {
      Future.delayed(
          Duration.zero,
          () => showOverlay(context, "problem_infos".tr(),
              widget.profile.userGeneralInfo.message));
    }
  }

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;

    screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;

    return new Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 128,
                  decoration: BoxDecoration(color: ColorConstant.pinkColor),
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            dispatchGoToHome(profile);
                          }, //_backtohome,
                          child: Image.asset(
                            "Assets/Images/back.png",
                            height: 13.5,
                            width: 20.24,
                          )),
                      MyText(
                          value: "resetpwd_title".tr(),
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HelpDisplay(profile: profile)));
                        },
                        child: Image.asset(
                          "Assets/Images/question.png",
                          height: 28,
                          width: 28,
                        ),
                      ),
                    ],
                  ),
                  // ),
                ),
                SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                  child: MyText(
                                    value: "resetpwd_label_current".tr(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: ColorConstant.pinkColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 7),
                              StreamBuilder(builder: (context, snapshot) {
                                return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                  .textScaleFactor
                                                  .clamp(1.0, 1.0),
                                        ),
                                        child: TextFormField(
                                          controller: currentpassController,
                                          decoration: InputDecoration(
                                            focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        ColorConstant.pinkColor,
                                                    width: 1.0)),
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          obscureText: true,
                                          style: TextStyle(
                                            color: Color(0xff231F20),
                                            fontWeight: FontWeight.w600,
                                          ),
                                          onChanged: (value) {
                                            setState(() {
                                              oldPassword = value;
                                              checkerOldPassword =
                                                  regExpPassword
                                                      .hasMatch(value);
                                            });
                                          },
                                          onSaved: (String value) {
                                            currentpassController.text = value;
                                          },
                                        ),
                                      ),
                                    ]);
                              }),
                              SizedBox(height: 6.5),
                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                  child: MyText(
                                    value: "resetpwd_label_currentinfo".tr(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    color: ColorConstant.redColor,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ),
                            ]),
                        SizedBox(height: 25),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                  child: MyText(
                                    value: "resetpwd_label_new".tr(),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: ColorConstant.pinkColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 7),
                              Stack(children: [
                                TextFormField(
                                  controller: newPasswordController,
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (value) {
                                    return validPassword(value);
                                  },
                                  style: TextStyle(
                                      color: Color(0xff231F20),
                                      fontWeight: FontWeight.w500),
                                  obscureText: _toggleVisisbility,
                                  onSaved: (String value) {
                                    passwordcontroller.text = value;
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: ColorConstant.pinkColor,
                                            width: 1.0)),
                                    suffixIcon: IconButton(
                                        icon: _toggleVisisbility
                                            ? Icon(
                                                Icons.visibility_off,
                                                // color: Color(0xff2471A3),
                                              )
                                            : Icon(
                                                Icons.visibility,
                                                //color: Color(0xff2471A3),
                                              ),
                                        onPressed: () {
                                          setState(() {
                                            _toggleVisisbility =
                                                !_toggleVisisbility;
                                          });
                                        }),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      newPassword = value;
                                      checkerNewPassword =
                                          regExpPassword.hasMatch(value);
                                    });
                                    validPassword2(value);
                                  },
                                ),
                                isLoading
                                    ? Stack(
                                        children: [
                                          SizedBox(
                                            height: screenHeight * 35,
                                          ),
                                          Center(
                                            child: SizedBox(
                                              height: 60.0,
                                              width: 60.0,
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation(
                                                        Color.fromRGBO(
                                                            255, 112, 184, 1)),

                                                strokeWidth: 3.0,

                                                //backgroundColor: Hexcolor(codecolor),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                              ]),
                            ])
                      ]),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    padding: EdgeInsets.only(left: 16),
                    child: MyText(
                        value: "resetpwd_info".tr() + ":",
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ColorConstant.textColor,
                        textAlign: TextAlign.left),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                            padding: EdgeInsets.only(top: 4),
                            child: Row(children: <Widget>[
                              Icon(is_8char ? Icons.check : Icons.close,
                                  size: 14,
                                  color: is_8char
                                      ? ColorConstant.greenColor
                                      : ColorConstant.redColor),
                              SizedBox(width: 5),
                              MyText(
                                  value: "resetpwd_info_min".tr(),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: is_8char
                                      ? ColorConstant.greenColor
                                      : ColorConstant.redColor,
                                  textAlign: TextAlign.left),
                            ])),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                            padding: EdgeInsets.only(top: 3),
                            child: Row(children: <Widget>[
                              Icon(isspecialcar ? Icons.check : Icons.close,
                                  size: 14,
                                  color: isspecialcar
                                      ? ColorConstant.greenColor
                                      : ColorConstant.redColor),
                              SizedBox(width: 5),
                              MyText(
                                  value: "resetpwd_info_special".tr(),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: isspecialcar
                                      ? ColorConstant.greenColor
                                      : ColorConstant.redColor,
                                  textAlign: TextAlign.left),
                            ])),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                            padding: EdgeInsets.only(top: 3),
                            child: Row(children: <Widget>[
                              Icon(is1upper ? Icons.check : Icons.close,
                                  size: 14,
                                  color: is1upper
                                      ? ColorConstant.greenColor
                                      : ColorConstant.redColor),
                              SizedBox(width: 5),
                              MyText(
                                  value: "resetpwd_info_upper".tr(),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: is1upper
                                      ? ColorConstant.greenColor
                                      : ColorConstant.redColor,
                                  textAlign: TextAlign.left),
                            ])),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Container(
                            padding: EdgeInsets.only(top: 3),
                            child: Row(children: <Widget>[
                              Icon(is1number ? Icons.check : Icons.close,
                                  size: 14,
                                  color: is1number
                                      ? ColorConstant.greenColor
                                      : ColorConstant.redColor),
                              SizedBox(width: 5),
                              MyText(
                                  value: "resetpwd_info_number".tr(),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: is1number
                                      ? ColorConstant.greenColor
                                      : ColorConstant.redColor,
                                  textAlign: TextAlign.left),
                            ])),
                      ),
                      Container(
                        width: double.infinity,
                        child: MyText(
                          value: "resetpwd_info_2".tr(),
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorConstant.textColor,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 80, 16, 0),
                  child: ButtonTheme(
                    height: screenWidth * 64.0,
                    minWidth:
                        MediaQuery.of(context).size.width ?? double.infinity,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: RaisedButton(
                      color: checkerOldPassword &&
                              checkerNewPassword &&
                              oldPassword != null &&
                              newPassword != null
                          ? ColorConstant.pinkColor
                          : Colors.grey,
                      child: MyText(
                        value: "resetpwd_btn_reset".tr(),
                        color: Colors.white,
                        fontSize: screenWidth * 18,
                        fontWeight: FontWeight.w600,
                      ),
                      onPressed: () {
                        if (checkerOldPassword &&
                            checkerNewPassword &&
                            oldPassword != null &&
                            newPassword != null) {
                          dispatchResetPassword(
                            profile,
                            currentpassController.text.trim(),
                            newPasswordController.text.trim(),
                          );
                        }
                      },
                    ),
                  ),
                ),
                // FlatButton(
                //   onPressed: () {
                //     setState(() {
                //       EasyLocalization.of(context).locale == Locale('en', 'US')
                //           ? EasyLocalization.of(context).locale =
                //               Locale('fr', 'FR')
                //           : EasyLocalization.of(context).locale =
                //               Locale('en', 'US');
                //     });
                //   },
                //   child: MyText(value:"Change Language"),
                // ),
                // Center(child: MyText(value:"lang".tr())),
              ],
            ),
          ],
        ),
      ),
    );
  }

  validPassword2(String value) {
    RegExp numberRegex = RegExp(onedigit);
    RegExp uppercaseRegex = RegExp(uppercasePattern);
    RegExp specialRegex = RegExp(specialCaracPattern);

    if (value.length > 7) {
      setState(() {
        is_8char = true;
      });
    } else {
      setState(() {
        is_8char = false;
      });
    }
    if (numberRegex.hasMatch(value)) {
      setState(() {
        is1number = true;
      });
    } else {
      setState(() {
        is1number = false;
      });
    }
    if (uppercaseRegex.hasMatch(value)) {
      setState(() {
        is1upper = true;
      });
    } else {
      setState(() {
        is1upper = false;
      });
    }
    if (specialRegex.hasMatch(value)) {
      setState(() {
        isspecialcar = true;
      });
    } else {
      setState(() {
        isspecialcar = false;
      });
    }
  }

  bool validateNewPassword() {
    if (is1number && is1upper && isspecialcar && is_8char) return true;
    return false;
  }

  // Config.ShowOverlay(context, "problem_infos".tr(), data["message"].toString());
  // print(data["message"].toString());

  @override
  void dispose() {
    super.dispose();
    newPasswordStreamcontroller.close();
  }

  void dispatchGoToHome(Profile profile) {
    BlocProvider.of<HomeBloc>(context).dispatch(
      GoToHomeEvent(
        profile: profile,
      ),
    );
  }

  void dispatchResetPassword(
      Profile profile, String oldPassword, String newPassword) {
    ResetPasswordParams resetPasswordParams = ResetPasswordParams(
      profile: profile,
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    BlocProvider.of<HomeBloc>(context).dispatch(
      ResetPasswordEvent(
        resetPasswordParams: resetPasswordParams,
      ),
    );
  }
}
