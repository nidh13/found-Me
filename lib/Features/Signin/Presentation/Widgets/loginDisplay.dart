import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Features/Signin/Presentation/bloc/login_bloc.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

class LoginDisplay extends StatefulWidget {
  final String message;

  const LoginDisplay({
    Key key,
    this.message,
  }) : super(key: key);

  @override
  _LoginDisplayState createState() => _LoginDisplayState();
}

class _LoginDisplayState extends State<LoginDisplay> {
  String email = 'foundme.neodev@gmail.com';
  //String email = 'razifertani1@gmail.com';
  String password = 'NeoDev12345#';
  String type = 'simpleLogin';
  //String password = ''; // Razi123@
  String message = 'null';
  bool checkerEmail = true;
  bool checkerPassword = true;
  String checkerEmailMessage = "registration_info_email".tr();
  String checkerPasswordMessage = "registration_info_pwd".tr();
  bool toggleVisibility = true;

  static showOverlay(
      BuildContext context, String headerMessage, String message) {
    Navigator.of(context).push(AlertDialogue(headerMessage, message));
  }

  Future<String> getType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    type = prefs.getString('type');
    return type;
  }

  @override
  void initState() {
    super.initState();

    if (widget.message != null && widget.message != 'null') {
      Future.delayed(Duration.zero,
          () => showOverlay(context, "problem_infos".tr(), widget.message));
    }
  }

  bool is_8char = false,
      isspecialcar = false,
      is1upper = true,
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
    //double screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    //double screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;
    var padding = MediaQuery.of(context).padding;
    double screenWidth =
        (MediaQuery.of(context).size.width - padding.right - padding.left) *
            0.04 /
            14.5;
    double screenHeight =
        (MediaQuery.of(context).size.height - padding.top - padding.bottom) *
            0.02 /
            14;
    print(screenWidth);
    print(screenHeight);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(screenWidth * 16, screenWidth * 52,
              screenWidth * 16, screenWidth * 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image.asset(
                  "Assets/Images/logo.png",
                  height: screenHeight * 80,
                  width: screenWidth * 201.64,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40, bottom: 37),
                child: Center(
                    child: Image.asset(
                  "Assets/Images/art.png",
                  fit: BoxFit.cover,
                  height: screenWidth * 145.95,
                  width: screenWidth * 197.57,
                )),
              ),
              Text(
                "Login_title".tr(),
                textScaleFactor: 1.0,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SFProText',
                    fontSize: 28,
                    color: Color(0xff231F20)),
              ),
              SizedBox(
                height: screenHeight * 29,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),
                      ),
                      child: TextFormField(
                    initialValue: email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                      setState(() {
                        checkerEmail = regExpEmail.hasMatch(email);
                      });
                    },
                    style: TextStyle(
                        color: Color(0xff231F20),
                        fontFamily: 'SFProText',
                        fontWeight: FontWeight.w500,
                        fontSize: 21),
                    decoration: InputDecoration(
                        hintText: "Login_input_email".tr(),
                        hintStyle: TextStyle(
                            color: ColorConstant.textFieldTextGreyColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 18)),
                  )),
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
                                color: ColorConstant.redColor,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
              SizedBox(
                height: screenHeight * 18,
              ),
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(1.0, 1.0),
                        ),
                        child: TextFormField(
                          initialValue: password,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            password = value;
                            setState(() {
                              checkerPassword = regExpPassword.hasMatch(password);
                              validPassword2(value);
                            });
                          },
                          style: TextStyle(
                              color: Color(0xff231F20),
                              fontFamily: 'SFProText',
                              fontWeight: FontWeight.w500,
                              fontSize: 21),
                          obscureText: toggleVisibility,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                icon: toggleVisibility
                                    ? Icon(
                                  Icons.visibility_off,
                                )
                                    : Icon(
                                  Icons.visibility,
                                ),
                                onPressed: () {
                                  setState(() {
                                    toggleVisibility = !toggleVisibility;
                                  });
                                }),
                            hintText: "Login_input_pwd".tr(),
                            hintStyle: TextStyle(
                              color: ColorConstant.textFieldTextGreyColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
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
                                      fontSize: 16,
                                      color: Color(0xffEC1C40),
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: "registration_info_pwd2".tr(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: is_8char
                                                ? ColorConstant.greenColor
                                                : Color(0xffEC1C40),
                                          )),
                                      TextSpan(
                                          text: "registration_info_pwd3".tr(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: is1upper
                                                ? ColorConstant.greenColor
                                                : Color(0xffEC1C40),
                                          )),
                                      new TextSpan(
                                          text: "registration_info_pwd4".tr(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: is1number
                                                ? ColorConstant.greenColor
                                                : Color(0xffEC1C40),
                                          )),
                                      new TextSpan(
                                        text: "registration_info_pwd5".tr(),
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: isspecialcar
                                              ? ColorConstant.greenColor
                                              : Color(0xffEC1C40),
                                        ),
                                      ),
                                    ]),
                              )
                                  //  Text(
                                  //   checkerPasswordMessage,
                                  //   textScaleFactor: 1.0,
                                  //   style: TextStyle(
                                  //     fontSize: 16,
                                  //     color: Colors.red,
                                  //   ),
                                  // ),
                                  ),
                            ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: screenWidth * 10.5,
              ),
              GestureDetector(
                  onTap: () {
                    dispatchGoToForgotPassword();
                  },
                  child: Text(
                    "Login_href_forgotpwd".tr(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: 'SFProText',
                      fontSize: 14,
                      color: Color(0xffEC1C40),
                    ),
                  )),
              SizedBox(
                height: screenHeight * 35,
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
                    "Login_title".tr(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: screenWidth * 0.2,
                      fontSize: screenWidth * 18,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SFProText',
                    ),
                  ),
                  onPressed: () {
                    if (checkerEmail &&
                        checkerPassword &&
                        email != null &&
                        password != null) {
                      dispatchLogin(email, password, "simpleLogin");
                    }
                  },
                ),
              ),
              SizedBox(
                height: screenHeight * 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      dispatchLoginFacebook();
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "Assets/Images/facebook.svg",
                        ),
                        SizedBox(width: 4),
                        Text(
                          "login_btn_fb".tr(),
                          textScaleFactor: 1.0,
                          style: TextStyle(
                              fontFamily: 'SFProText',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff231F20)),
                        ),
                      ],
                    ),
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
                          "Login_btn_google".tr(),
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
                height: screenHeight * 68,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "login_info_createaccount".tr(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SFProText',
                        color: Color(0xff999999),
                        fontSize: 14),
                  ),
                  GestureDetector(
                    onTap: () {
                      dispatchGoToSignup();
                    },
                    child: Text(
                      "login_href_createaccount".tr(),
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFamily: 'SFProText',
                          decoration: TextDecoration.underline,
                          color: Color(0xffEC1C40),
                          fontSize: 14),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 50,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void dispatchLogin(String email, String password, String type) {
    BlocProvider.of<LoginBloc>(context).dispatch(SigninEvent(
      email: email,
      password: password,
      type: type,
      isConnected: false,
    ));
  }

  void dispatchLoginFacebook() {
    BlocProvider.of<LoginBloc>(context).dispatch(SigningFacebookEvent());
  }

  void dispatchLoginGoogle() {
    BlocProvider.of<LoginBloc>(context).dispatch(SigningGoogleEvent());
  }

  void dispatchGoToSignup() {
    BlocProvider.of<LoginBloc>(context).dispatch(GoToSignupEvent());
  }

  void dispatchGoToForgotPassword() {
    BlocProvider.of<LoginBloc>(context).dispatch(GoToForgotPasswordEvent());
  }
  //facebook

}
