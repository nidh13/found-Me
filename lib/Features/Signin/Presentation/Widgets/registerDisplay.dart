import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Features/Signin/Presentation/bloc/login_bloc.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

class RegisterDisplay extends StatefulWidget {
  final String message;

  const RegisterDisplay({Key key, this.message}) : super(key: key);

  @override
  _RegisterDisplayState createState() => _RegisterDisplayState();
}

class _RegisterDisplayState extends State<RegisterDisplay> {
  bool _toggleVisibility = true;
  String message = 'null';
  String fName, lName, email, password;
  bool checkerFName = true;
  bool checkerLName = true;
  bool checkerEmail = true;
  bool checkerPassword = true;
  String checkerNameMessage = "registration_info_name".tr();
  String checkerEmailMessage = "registration_info_email".tr();
  String checkerPasswordMessage = "registration_info_pwd".tr();

  static showOverlay(
      BuildContext context, String headerMessage, String message) {
    Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  @override
  void initState() {
    if (widget.message != null) {
      Future.delayed(Duration.zero,
          () => showOverlay(context, "problem_infos".tr(), message));
    }

    super.initState();
  }

  bool is_8char = false,
      isspecialcar = false,
      is1upper = false,
      is1number = false;
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    double screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(16, 52, 16, 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                  child: Image.asset(
                "Assets/Images/logo.png",
                fit: BoxFit.fitHeight,
                height: screenHeight * 80,
                width: screenWidth * 201.64,
              )),
              SizedBox(
                height: (MediaQuery.of(context).size.height * 0.02 / 14) * 57,
              ),
              Text(
                "registration_title".tr(),
                textScaleFactor: 1.0,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SFProText',
                    fontSize: 28,
                    color: Color(0xffEC1C40)),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.width * 0.04 / 14.5) * 29,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                color: Color(0xff231F20),
                                fontFamily: 'SFProText',
                                fontWeight: FontWeight.w500,
                                fontSize: 21),
                            onChanged: (value) {
                              fName = value;
                              setState(() {
                                checkerFName = regExpName.hasMatch(fName);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "registration_input_firstname".tr(),
                              hintStyle: TextStyle(
                                  color: ColorConstant.textFieldTextGreyColor,
                                  fontFamily: 'SFProText',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        checkerFName
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.only(top: 12.0),
                                child: Center(
                                  child: Text(
                                    checkerNameMessage,
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: ColorConstant.pinkColor,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.04 / 14.5) *
                        11.5,
                  ),
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                            textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                color: Color(0xff231F20),
                                fontFamily: 'SFProText',
                                fontWeight: FontWeight.w500,
                                fontSize: 21),
                            onChanged: (value) {
                              lName = value;
                              setState(() {
                                checkerLName = regExpName.hasMatch(lName);
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "registration_input_lastname".tr(),
                              hintStyle: TextStyle(
                                //  color: Color(0xff4A4A4A),
                                  color: ColorConstant.textFieldTextGreyColor,
                                  fontFamily: 'SFProText',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                        checkerLName
                            ? Container()
                            : Padding(
                                padding: EdgeInsets.only(top: 12.0),
                                child: Center(
                                  child: Text(
                                    checkerNameMessage,
                                    textScaleFactor: 1.0,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: ColorConstant.pinkColor,
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height * 0.02 / 14) * 29,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MediaQuery(
                    data: MediaQuery.of(context).copyWith(
                      textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),
                    ),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(
                          color: Color(0xff231F20),
                          fontFamily: 'SFProText',
                          fontWeight: FontWeight.w500,
                          fontSize:
                          (MediaQuery.of(context).size.width * 0.04 / 14.5) *
                              21),
                      onChanged: (value) {
                        email = value;
                        setState(() {
                          checkerEmail = regExpEmail.hasMatch(email);
                        });
                      },
                      decoration: InputDecoration(
                          hintText: "registration_input_email".tr(),
                          hintStyle: TextStyle(
                              color: ColorConstant.textFieldTextGreyColor,
                              fontFamily: 'SFProText',
                              fontWeight: FontWeight.w500,
                              fontSize: 18)),
                    ),
                  ),
                  checkerEmail
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(top: 12.0),
                          child: Center(
                            child: Text(
                              checkerEmailMessage,
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                fontSize: 16,
                                color: ColorConstant.pinkColor,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height * 0.02 / 14) * 23.5,
              ),
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MediaQuery(
                          data: MediaQuery.of(context).copyWith(
                textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),
                          )
                          , child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(
                            color: Color(0xff231F20),
                            fontFamily: 'SFProText',
                            fontWeight: FontWeight.w500,
                            fontSize: 21),
                        onChanged: (value) {
                          password = value;
                          setState(() {
                            checkerPassword = regExpPassword.hasMatch(password);
                            validPassword2(value);
                          });
                        },
                        obscureText: _toggleVisibility,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: _toggleVisibility
                                  ? Icon(
                                Icons.visibility_off,
                              )
                                  : Icon(
                                Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _toggleVisibility = !_toggleVisibility;
                                });
                              }),
                          hintText: "registration_input_pwd".tr(),
                          hintStyle: TextStyle(
                              color: ColorConstant.textFieldTextGreyColor,
                              fontFamily: 'SFProText',
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      )),
                      checkerPassword && is1upper
                          ? Container()
                          : Padding(
                              padding: EdgeInsets.only(top: 12.0),
                              child: Center(
                                  child: RichText(
                                textScaleFactor: 1.0,
                                text: TextSpan(
                                    text: "registration_info_pwd1".tr(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xffEC1C40),
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "registration_info_pwd2".tr(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: is_8char
                                                ? ColorConstant.greenColor
                                                : Color(0xffEC1C40),
                                          )),
                                      TextSpan(
                                          text: "registration_info_pwd3".tr(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: is1upper
                                                ? ColorConstant.greenColor
                                                : Color(0xffEC1C40),
                                          )),
                                      new TextSpan(
                                          text: "registration_info_pwd4".tr(),
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: is1number
                                                ? ColorConstant.greenColor
                                                : Color(0xffEC1C40),
                                          )),
                                      new TextSpan(
                                        text: "registration_info_pwd5".tr(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: isspecialcar
                                              ? ColorConstant.greenColor
                                              : Color(0xffEC1C40),
                                        ),
                                      ),
                                    ]),
                              )),
                            ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height * 0.02 / 14) * 24,
              ),
              ButtonTheme(
                height: screenWidth * 64.0,
                minWidth: MediaQuery.of(context).size.width ?? double.infinity,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: RaisedButton(
                  color: Color(0xffEC1C40),
                  child: Text(
                    "Register Now".tr(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontFamily: 'SFProText',
                      color: Colors.white,
                      letterSpacing: screenWidth * 0.2,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    if (checkerFName &&
                        checkerLName &&
                        checkerEmail &&
                        checkerPassword &&
                        fName != null &&
                        lName != null &&
                        email != null &&
                        password != null) {
                      dispatchRegister(
                        fName,
                        lName,
                        email,
                        password,
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height * 0.02 / 14) * 37.5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: [
                      SvgPicture.asset(
                        "Assets/Images/facebook.svg",
                      ),
                      SizedBox(width: 4),
                      Text(
                        "registration_btn_fb".tr(),
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontFamily: 'SFProText',
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff231F20)),
                      ),
                    ],
                  ),
                  Container(
                    height: screenHeight * 25,
                    width: screenWidth * 1,
                    color: Color(0xff231F20),
                  ),
                  InkWell(
                    onTap: () {
                      dispatchLoginGoogle();
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "Assets/Images/google.svg",
                        ),
                        SizedBox(width: 4),
                        Text(
                          "registration_btn_google".tr(),
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              fontFamily: 'SFProText',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff231F20)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height * 0.02 / 14) * 54.4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "registration_info_signin".tr(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff505050),
                        fontSize:
                            (MediaQuery.of(context).size.width * 0.04 / 14.5) *
                                12),
                  ),
                  GestureDetector(
                    onTap: () {
                      dispatchGoToLogin();
                    },
                    child: Text(
                      "registration_href_signin".tr(),
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          color: Color(0xffEC1C40),
                          fontSize: (MediaQuery.of(context).size.width *
                                  0.04 /
                                  14.5) *
                              12),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height * 0.02 / 14) * 19,
              ),
              Center(
                  child: Text(
                "registration_info_termspolicy1".tr(),
                textScaleFactor: 1.0,
                style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.w500,
                    fontSize:
                        (MediaQuery.of(context).size.width * 0.04 / 14.5) * 12,
                    color: Color(0xff505050)),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "registration_info_termspolicy2".tr(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff505050),
                        fontSize:
                            (MediaQuery.of(context).size.width * 0.04 / 14.5) *
                                12),
                  ),
                  GestureDetector(
                    onTap: () {
                      dispatchGoToTermsOfUse();
                    },
                    child: Text(
                      "registration_href_termsofuse".tr(),
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          color: Color(0xffEC1C40),
                          fontSize: (MediaQuery.of(context).size.width *
                                  0.04 /
                                  14.5) *
                              12),
                    ),
                  ),
                  Text(
                    "registration_info_termspolicy3".tr(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontWeight: FontWeight.w500,
                        color: Color(0xff505050),
                        fontSize:
                            (MediaQuery.of(context).size.width * 0.04 / 14.5) *
                                12),
                  ),
                  GestureDetector(
                    onTap: () {
                      dispatchGoToPrivacyPolicy();
                    },
                    child: Text(
                      "registration_href_privacypolicy".tr(),
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          color: Color(0xffEC1C40),
                          fontSize: (MediaQuery.of(context).size.width *
                                  0.04 /
                                  14.5) *
                              12),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: (MediaQuery.of(context).size.height * 0.02 / 14) * 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void showOverlay_regis(
  //     BuildContext context, String headerMessage, String message) {
  //   Navigator.of(context).push(AlertDialogueReg(headerMessage, message));
  // }

  void dispatchRegister(
      String fName, String lName, String email, String password) {
    BlocProvider.of<LoginBloc>(context).dispatch(
      SignupEvent(
        firstName: fName,
        lastName: lName,
        email: email,
        password: password,
      ),
    );
  }

  void dispatchGoToLogin() {
    BlocProvider.of<LoginBloc>(context).dispatch(GoToSigninEvent());
  }

  void dispatchLoginGoogle() {
    BlocProvider.of<LoginBloc>(context).dispatch(SigningGoogleEvent());
  }

  void dispatchGoToTermsOfUse() {
    BlocProvider.of<LoginBloc>(context).dispatch(GoToTermsOfUseEvent());
  }

  void dispatchGoToPrivacyPolicy() {
    BlocProvider.of<LoginBloc>(context).dispatch(GoToPrivacyPolicyEvent());
  }
}
