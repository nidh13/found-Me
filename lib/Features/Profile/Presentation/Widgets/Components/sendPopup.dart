import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:easy_localization/easy_localization.dart';

class SendPopup extends ModalRoute<void> {
  final Profile profile;

  SendPopup(this.profile);

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  double screenWidth;
  double screenHeight;

  List nameList = ['Df', 'Vb'];
  var nameData;
  var eyeData;
  String selected = "🇺🇸" + " " + "English";
  final ScrollController nameScroll = ScrollController();
  List<String> name = ["g", "f", "h", "e", "t"];
  List<Map<String, dynamic>> idCategory = [];
  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: SafeArea(
        child: _buildOverlayContent(context, profile),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context, Profile profile) {
    return OrientationBuilder(builder: (context, orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.all(20.0),
          width: screenWidth * 0.85,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: ColorConstant.pinkColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10.0),
                    )),
                height: 51,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 12, left: 13, right: 13),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text("editprofil_label_emailrecord".tr(),
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontWeight: FontWeight.w600,
                                fontSize: 21,
                                color: Colors.white)),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          height: 16,
                          width: 16,
                          child: Image.asset(
                            "Assets/Images/close-white.png",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: 17, bottom: 17, left: 16, right: 16),
                child: Column(
                  children: [
                    MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        textScaleFactor: MediaQuery.of(context)
                            .textScaleFactor
                            .clamp(1.0, 1.0),
                      ),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            color: Color(0xff231F20),
                            fontFamily: 'SFProText',
                            fontWeight: FontWeight.w500),
                        onChanged: (String value) {},
                        decoration: InputDecoration(
                          //  prefixIcon: Icon(Icons.call),
                          // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                          hintText: "editprofil_medical_btn_email".tr(),
                          // hintStyle: TextStyle(fontSize: screenWidth*21)
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("editprofil_general_label_printmessage".tr(),
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: ColorConstant.textColor)),
                    SizedBox(
                      height: 18,
                    ),
                    SizedBox(
                      height: 20.5,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            "editprofil_general_label_translatemessage".tr(),
                            textScaleFactor: 1.0,
                            style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: ColorConstant.textColor),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 0, top: 0),
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 0, right: 110.5, bottom: 13),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 12.5,
                              ),
                              Container(
                                height: 24,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton(
                                    items: [
                                      {
                                        "editprofil_general_label_language"
                                            .tr(): "English",
                                        "editprofil_general_label_flag".tr():
                                            "🇺🇸"
                                      },
                                      {
                                        "editprofil_general_label_language"
                                            .tr(): "Francais",
                                        "editprofil_general_label_flag".tr():
                                            "🇫🇷"
                                      },
                                      {
                                        "editprofil_general_label_language"
                                            .tr(): "Italiano",
                                        "editprofil_general_label_flag".tr():
                                            "🇮🇹"
                                      },
                                      {
                                        "editprofil_general_label_language"
                                            .tr(): "Deutsche",
                                        "editprofil_general_label_flag".tr():
                                            "🇩🇪"
                                      },
                                      {
                                        "editprofil_general_label_language"
                                            .tr(): "日本人",
                                        "editprofil_general_label_flag".tr():
                                            "🇯🇵"
                                      },
                                      {
                                        "editprofil_general_label_language"
                                            .tr(): "Svenska",
                                        "editprofil_general_label_flag".tr():
                                            "🇸🇪"
                                      }
                                    ]
                                        .map(
                                          (e) => DropdownMenuItem(
                                            child: Text(
                                              e['flag'] + " " + e['language'],
                                              textScaleFactor: 1.0,
                                              style: TextStyle(
                                                  fontFamily: 'SourceSansPro',
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ColorConstant.textColor),
                                            ),
                                            value: e,
                                          ),
                                        )
                                        .toList(),
                                    onChanged: (newVal) {
                                      setState(() {
                                        selected = newVal['flag'] +
                                            " " +
                                            newVal['language'];
                                      });
                                      setState(() {});
                                    },
                                    isExpanded: true,
                                    hint: Text(selected,
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: ColorConstant.darkGray)),
                                  ),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: ColorConstant.textfieldColor,
                                  borderRadius: BorderRadius.circular(5.0),
                                  // border: Border.all(style: BorderStyle.solid, width: 0.70),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 30.5,
                    ),
                    MyButton(
                      title: "editprofil_label_send".tr(),
                      height: 40,
                      titleSize: 14,
                      fontWeight: FontWeight.w500,
                      titleColor: Colors.white,
                      btnBgColor: ColorConstant.greenColor,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
