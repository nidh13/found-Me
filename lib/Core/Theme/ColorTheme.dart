import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Core/Utils/alertDialog.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Home/Presentation/bloc/home_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/help/helpDisplay.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:neopolis/Core/Error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';

class ThemeColorDisplay extends StatefulWidget {
  final Profile profile;

  const ThemeColorDisplay({
    Key key,
    @required this.profile,
  }) : super(key: key);

  @override
  ThemeColorDisplayState createState() => new ThemeColorDisplayState();
}

class ThemeColorDisplayState extends State<ThemeColorDisplay> {
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Future<Profile> editProfile(Profile profile) async {
    String idUser = profile.userGeneralInfo.idUser;
    String idLanguage = profile.userGeneralInfo.userIdLanguage;
    String idSession = profile.userGeneralInfo.idSession;

    print(DateTime.now());

    final response = await http.post(
      "https://foundme-dev.hotline.direct/update_profile?id_user=$idUser&userIdLanguage=$idLanguage",
      headers: {
        'Content-Type': 'application/json',
        'idSession': idSession,
      },
      body: json.encode(profile.toJson()),
    );

    var body = json.encode(profile.toJson());
    print(body);
    if (response.statusCode == 202) {
      profile.userGeneralInfo.message = 'Success';
      print('end ' + DateTime.now().toString());

      return profile;
    } else if (response.statusCode != 202) {
      profile.userGeneralInfo.message = 'Error';
      return profile;
    } else {
      throw ServerExeption();
    }
  }

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;

    screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;

    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(128),
        child: Container(
          height: 128,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: ColorConstant.pinkColor),
          padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                      '/homeProvider',
                      arguments: profile,
                    );
                    //  dispatchGoToHome(profile);
                  }, //_backtohome,
                  child: Image.asset(
                    "Assets/Images/back.png",
                    height: 13.5,
                    width: 20.24,
                  )),
              SizedBox(width: 15.9 * screenWidth),
              Text("colortheme_label_title".tr(),
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white)),
              IconButton(
                icon: SvgPicture.asset(
                  "Assets/Images/FAQ.svg",
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HelpDisplay(profile: profile)),
                  );
                },
              ),
              SizedBox(height: 14),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Center(
              //    alignment:Alignment.center ,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('colortheme_label_msg1'.tr(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "SFProText",
                        fontSize: 16,
                        color: Color(0xff999999))),
              ),
            ),
            Center(
              child: Text('colortheme_label_msg2'.tr(),
                  textScaleFactor: 1.0,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "SFProText",
                      fontSize: 16,
                      color: Color(0xff999999))),
            ),
            SizedBox(
              height: 35,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        new BoxShadow(
                          color: Colors.black26,

                          offset: Offset(1.0, 3.0),
                          //  spreadRadius: 7.0,
                          blurRadius: 3.0,
                        ),
                      ]),
                  child: CircleAvatar(
                      radius: 45, backgroundColor: ColorConstant.pinkColor

                      //Color(0xff04A6BC),
                      ),
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              'colortheme_label_currenttheme'.tr(),
              textScaleFactor: 1.0,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontFamily: "SFProText",
                fontSize: 16,
                color: Color(0xff999999),
              ),
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ColorConstant.pinkColor != Color(0xff854d9c)
                    ? GestureDetector(
                        onTap: () async {
                          setState(() {
                            profile.userGeneralInfo.currentColor = 1;
                            String codeCouleur = "0xff" +
                                profile.parameters.themeColor[
                                    profile.userGeneralInfo.currentColor -
                                        1]['color'];
                            // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                            ColorConstant.pinkColor =
                                Color(int.parse(codeCouleur));
                            editProfile(profile);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black26,

                                    offset: Offset(1.0, 3.0),
                                    //  spreadRadius: 7.0,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff854d9c),
                            )),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            profile.userGeneralInfo.currentColor = 2;
                            String codeCouleur = "0xff" +
                                profile.parameters.themeColor[
                                    profile.userGeneralInfo.currentColor -
                                        1]['color'];
                            // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                            ColorConstant.pinkColor =
                                Color(int.parse(codeCouleur));
                            editProfile(profile);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black26,

                                    offset: Offset(1.0, 3.0),
                                    //  spreadRadius: 7.0,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff04A6BC),
                            )),
                      ),
                ColorConstant.pinkColor != Color(0xff313131)
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            profile.userGeneralInfo.currentColor = 7;
                            String codeCouleur = "0xff" +
                                profile.parameters.themeColor[
                                    profile.userGeneralInfo.currentColor -
                                        1]['color'];
                            // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                            ColorConstant.pinkColor =
                                Color(int.parse(codeCouleur));
                            editProfile(profile);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black26,

                                    offset: Offset(1.0, 3.0),
                                    //  spreadRadius: 7.0,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff313131),
                            )),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            profile.userGeneralInfo.currentColor = 2;
                            String codeCouleur = "0xff" +
                                profile.parameters.themeColor[
                                    profile.userGeneralInfo.currentColor -
                                        1]['color'];
                            // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                            ColorConstant.pinkColor =
                                Color(int.parse(codeCouleur));
                            editProfile(profile);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black26,

                                    offset: Offset(1.0, 3.0),
                                    //  spreadRadius: 7.0,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff04A6BC),
                            )),
                      ),
                ColorConstant.pinkColor != Color(0xffec519a)
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            profile.userGeneralInfo.currentColor = 3;
                            String codeCouleur = "0xff" +
                                profile.parameters.themeColor[
                                    profile.userGeneralInfo.currentColor -
                                        1]['color'];
                            // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                            ColorConstant.pinkColor =
                                Color(int.parse(codeCouleur));
                            editProfile(profile);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black26,

                                    offset: Offset(1.0, 3.0),
                                    //  spreadRadius: 7.0,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xffec519a),
                            )),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            profile.userGeneralInfo.currentColor = 2;
                            String codeCouleur = "0xff" +
                                profile.parameters.themeColor[
                                    profile.userGeneralInfo.currentColor -
                                        1]['color'];
                            // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                            ColorConstant.pinkColor =
                                Color(int.parse(codeCouleur));
                            editProfile(profile);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black26,

                                    offset: Offset(1.0, 3.0),
                                    //  spreadRadius: 7.0,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff04A6BC),
                            )),
                      ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ColorConstant.pinkColor != Color(0xff707070)
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            profile.userGeneralInfo.currentColor = 4;
                            String codeCouleur = "0xff" +
                                profile.parameters.themeColor[
                                    profile.userGeneralInfo.currentColor -
                                        1]['color'];
                            // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                            ColorConstant.pinkColor =
                                Color(int.parse(codeCouleur));
                            editProfile(profile);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black26,

                                    offset: Offset(1.0, 3.0),
                                    //  spreadRadius: 7.0,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff707070),
                            )),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            profile.userGeneralInfo.currentColor = 2;
                            String codeCouleur = "0xff" +
                                profile.parameters.themeColor[
                                    profile.userGeneralInfo.currentColor -
                                        1]['color'];
                            // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                            ColorConstant.pinkColor =
                                Color(int.parse(codeCouleur));
                            editProfile(profile);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black26,

                                    offset: Offset(1.0, 3.0),
                                    //  spreadRadius: 7.0,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff04A6BC),
                            )),
                      ),
                ColorConstant.pinkColor != Color(0xff676B39)
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            profile.userGeneralInfo.currentColor = 5;
                            String codeCouleur = "0xff" +
                                profile.parameters.themeColor[
                                    profile.userGeneralInfo.currentColor -
                                        1]['color'];
                            // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                            ColorConstant.pinkColor =
                                Color(int.parse(codeCouleur));
                            editProfile(profile);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black26,

                                    offset: Offset(1.0, 3.0),
                                    //  spreadRadius: 7.0,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff676B39),
                            )),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            profile.userGeneralInfo.currentColor = 2;
                            String codeCouleur = "0xff" +
                                profile.parameters.themeColor[
                                    profile.userGeneralInfo.currentColor -
                                        1]['color'];
                            // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                            ColorConstant.pinkColor =
                                Color(int.parse(codeCouleur));
                            editProfile(profile);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black26,

                                    offset: Offset(1.0, 3.0),
                                    //  spreadRadius: 7.0,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff04A6BC),
                            )),
                      ),
                ColorConstant.pinkColor != Color(0xff243E90)
                    ? GestureDetector(
                        onTap: () {
                          setState(() {
                            profile.userGeneralInfo.currentColor = 6;
                            String codeCouleur = "0xff" +
                                profile.parameters.themeColor[
                                    profile.userGeneralInfo.currentColor -
                                        1]['color'];
                            // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                            ColorConstant.pinkColor =
                                Color(int.parse(codeCouleur));
                            editProfile(profile);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black26,

                                    offset: Offset(1.0, 3.0),
                                    //  spreadRadius: 7.0,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff243E90),
                            )),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            profile.userGeneralInfo.currentColor = 1;
                            String codeCouleur = "0xff" +
                                profile.parameters.themeColor[profile
                                    .userGeneralInfo.currentColor]['color'];
                            // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                            ColorConstant.pinkColor =
                                Color(int.parse(codeCouleur));
                            editProfile(profile);
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black26,

                                    offset: Offset(1.0, 3.0),
                                    //  spreadRadius: 7.0,
                                    blurRadius: 3.0,
                                  ),
                                ]),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Color(0xff04A6BC),
                            )),
                      ),
              ],
            ),
            SizedBox(
              height: 35,
            ),
            ColorConstant.pinkColor != Color(0xffEC1C40)
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        profile.userGeneralInfo.currentColor = 8;
                        ColorConstant.primaryColor = Color(0xff000000);
                        String codeCouleur = "0xff" +
                            profile.parameters.themeColor[
                                    profile.userGeneralInfo.currentColor - 1]
                                ['color'];
                        // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                        ColorConstant.pinkColor = Color(int.parse(codeCouleur));
                        editProfile(profile);
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.black26,

                                offset: Offset(1.0, 3.0),
                                //  spreadRadius: 7.0,
                                blurRadius: 3.0,
                              ),
                            ]),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xffEC1C40),
                        )),
                  )
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        profile.userGeneralInfo.currentColor = 1;
                        String codeCouleur = "0xff" +
                            profile.parameters.themeColor[
                                profile.userGeneralInfo.currentColor]['color'];
                        // color=Color(0xff+profile.parameters.themeColor[ profile.userGeneralInfo.currentColor]['color']);
                        ColorConstant.pinkColor = Color(int.parse(codeCouleur));
                        editProfile(profile);
                      });
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.black26,

                                offset: Offset(1.0, 3.0),
                                //  spreadRadius: 7.0,
                                blurRadius: 3.0,
                              ),
                            ]),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xff04A6BC),
                        )),
                  ),
          ],
        ),
      ),
    );
  }

  // Config.ShowOverlay(context, "problem_infos".tr(), data["message"].toString());
  // print(data["message"].toString());

  @override
  void dispose() {
    super.dispose();
  }

  void dispatchGoToHome(Profile profile) {
    BlocProvider.of<HomeBloc>(context).dispatch(
      GoToHomeEvent(
        profile: profile,
      ),
    );
  }
}
