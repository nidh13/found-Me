import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpandableContactList extends StatefulWidget {
  bool switchValue;
  final bool dropdownValue;
  String relationVal;
  bool visibile;

  final List relationList;
  final UserEmergencyContact userEmergencyContact;

  ExpandableContactList(
      {Key key,
      this.switchValue,
      this.dropdownValue,
      this.relationVal,
      this.relationList,
      this.userEmergencyContact,
      this.visibile});

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableContactList> {
  bool expandFlag = false;
  FocusNode nbreFocus = FocusNode();
  FocusNode codeFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            expandFlag = !expandFlag;
          });
        },
        child: widget.userEmergencyContact != null
            ? Container(
                padding: EdgeInsets.only(top: 15.5, bottom: 14.5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: expandFlag
                              ? Center(
                                  child: Row(children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: MyTextField(
                                        initialValue: widget
                                            .userEmergencyContact.firstName,
                                        maxline: 1,
                                        inputType: TextInputType.number,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {
                                          widget.userEmergencyContact
                                              .firstName = value;
                                          print(widget
                                              .userEmergencyContact.firstName);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: MyTextField(
                                        initialValue: widget
                                            .userEmergencyContact.lastName,
                                        maxline: 1,
                                        inputType: TextInputType.number,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {
                                          widget.userEmergencyContact.lastName =
                                              value;
                                          print(widget
                                              .userEmergencyContact.lastName);
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ]),
                                )
                              : MyText(
                                  value: widget.userEmergencyContact.firstName +
                                      ' ' +
                                      widget.userEmergencyContact.lastName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorConstant.textColor),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        widget.dropdownValue
                            ? Visibility(
                                visible: widget.visibile,
                                child: Image.asset(
                                  expandFlag
                                      ? "Assets/Images/arrow-up-gray.png"
                                      : "Assets/Images/arrow-down-gray.png",
                                  height: 8,
                                  width: 13.18,
                                ))
                            : Container(),
                      ],
                    ),
                    expandFlag
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8,
                              ),

                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  MyText(
                                      value: "pets_label_livechat".tr(),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      color: ColorConstant.textColor),
                                  Expanded(
                                    child: Image.asset(
                                      "Assets/Images/info.png",
                                      height: 14,
                                      width: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  CustomSwitch(
                                    activeColor: Color(0xff34C759),
                                    value:
                                        widget.userEmergencyContact.allowChat ==
                                                1
                                            ? true
                                            : false,
                                    onChanged: (value) {
                                      setState(() {
                                        widget.userEmergencyContact.allowChat =
                                            value == true ? 1 : 0;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 0.40,
                                color: ColorConstant.dividerColor,
                              ),
                              //
                              SizedBox(
                                height: 22,
                              ),

                              Row(
                                children: [
                                  MyText(
                                      value: "editprofil_general_subtitle_email"
                                          .tr(),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      color: ColorConstant.textColor),
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Image.asset(
                                    "Assets/Images/info.png",
                                    height: 14,
                                    width: 14,
                                  ),
                                ],
                              ),

                              ListView(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.zero,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 8.0 ?? 12.5,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 11,
                                              child: MyTextField(
                                                initialValue: widget
                                                    .userEmergencyContact.mail,
                                                maxline: 1,
                                                inputType:
                                                    TextInputType.multiline,
                                                editTextBgColor: ColorConstant
                                                    .textfieldColor,
                                                hintTextColor: Colors.white54,
                                                title: '',
                                                onChanged: (value) {
                                                  widget.userEmergencyContact
                                                      .mail = value;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: CustomSwitch(
                                                  activeColor:
                                                      Color(0xff34C759),
                                                  value:
                                                      widget.userEmergencyContact
                                                                  .allowMail1 ==
                                                              1
                                                          ? true
                                                          : false,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      widget
                                                          .userEmergencyContact
                                                          .allowMail1 = value ==
                                                              true
                                                          ? 1
                                                          : 0;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 0.0 ?? 12.5,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 8.0 ?? 12.5,
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 11,
                                              child: MyTextField(
                                                initialValue: widget
                                                    .userEmergencyContact.mail2,
                                                maxline: 1,
                                                inputType:
                                                    TextInputType.multiline,
                                                editTextBgColor: ColorConstant
                                                    .textfieldColor,
                                                hintTextColor: Colors.white54,
                                                title: '',
                                                onChanged: (value) {
                                                  widget.userEmergencyContact
                                                      .mail2 = value;
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: CustomSwitch(
                                                  activeColor:
                                                      Color(0xff34C759),
                                                  value:
                                                      widget.userEmergencyContact
                                                                  .allowMail2 ==
                                                              1
                                                          ? true
                                                          : false,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      widget
                                                          .userEmergencyContact
                                                          .allowMail2 = value ==
                                                              true
                                                          ? 1
                                                          : 0;
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 0.0 ?? 12.5,
                                        ),
                                      ],
                                    )
                                  ]),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 0.40,
                                color: ColorConstant.dividerColor,
                              ),

                              SizedBox(
                                height: 12,
                              ),
                              //    MyText(value:'Text',textScaleFactor: 1.0,),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 6,
                                    child: MyText(
                                        value:
                                            "pets_label_mobilecellnumber".tr(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ColorConstant.textColor),
                                  ),
                                  Image.asset(
                                    "Assets/Images/info.png",
                                    height: 14,
                                    width: 14,
                                  ),
                                  SizedBox(
                                    width: 82,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: MyText(
                                        value: "pets_label_text".tr(),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14,
                                        color: ColorConstant.textColor),
                                  )
                                ],
                              ),
                              Row(children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: MyTextField(
                                    initialValue:
                                        widget.userEmergencyContact.codePhone,
                                    keyboardType: TextInputType.number,
                                    focusNode: codeFocus,
                                    maxline: 1,
                                    editTextBgColor:
                                        ColorConstant.textfieldColor,
                                    hintTextColor: Colors.white54,
                                    onChanged: (value) {
                                      setState(() {
                                        widget.userEmergencyContact.codePhone =
                                            value;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  flex: 10,
                                  child: MyTextField(
                                    initialValue:
                                        widget.userEmergencyContact.mobile,
                                    keyboardType: TextInputType.number,
                                    focusNode: nbreFocus,
                                    maxline: 1,
                                    editTextBgColor:
                                        ColorConstant.textfieldColor,
                                    hintTextColor: Colors.white54,
                                    onChanged: (value) {
                                      widget.userEmergencyContact.mobile =
                                          value;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                CustomSwitch(
                                  activeColor: Color(0xff34C759),
                                  value:
                                      widget.userEmergencyContact.allowMobile ==
                                              1
                                          ? true
                                          : false,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.userEmergencyContact.allowMobile =
                                          value == true ? 1 : 0;
                                    });
                                  },
                                ),
                              ]),

                              //Container(height: 0.45,color: ColorConstant.dividerColor.withOpacity(.30)),
                            ],
                          )
                        : Container(),
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.only(top: 15.5, bottom: 14.5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: expandFlag
                              ? Center(
                                  child: Row(children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: MyTextField(
                                        initialValue: '',
                                        maxline: 1,
                                        inputType: TextInputType.number,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {},
                                      ),
                                    ),
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: MyTextField(
                                        initialValue: '',
                                        maxline: 1,
                                        inputType: TextInputType.number,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {},
                                      ),
                                    )
                                  ]),
                                )
                              : MyText(
                                  value: ' ',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: ColorConstant.textColor),
                        ),
                        SizedBox(
                          width: 26,
                        ),
                        Visibility(
                          visible: !widget.visibile,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Material(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.red, //button colour
                              child: InkWell(
                                splashColor:
                                    Colors.red, // inkwell onPress colour
                                child: SizedBox(
                                    width: 24,
                                    height: 24, //customisable size of 'button'
                                    child: Center(
                                        child: FaIcon(
                                      FontAwesomeIcons.minus,
                                      color: Colors.white,
                                      size: 16,
                                    ))
                                    /*Icon(Icons.delete, )*/
                                    ),
                                onTap: () {
                                  setState(() {});
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        widget.dropdownValue
                            ? Visibility(
                                visible: widget.visibile,
                                child: Image.asset(
                                  expandFlag
                                      ? "Assets/Images/arrow-up-gray.png"
                                      : "Assets/Images/arrow-down-gray.png",
                                  height: 8,
                                  width: 13.18,
                                ))
                            : Container(),
                      ],
                    ),
                    expandFlag
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8,
                              ),

                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  MyText(
                                      value: "pets_label_livechat".tr(),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      color: ColorConstant.textColor),
                                  Expanded(
                                    child: Image.asset(
                                      "Assets/Images/info.png",
                                      height: 14,
                                      width: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  CustomSwitch(
                                    activeColor: Color(0xff34C759),
                                    value:
                                        widget.userEmergencyContact.allowChat ==
                                                1
                                            ? true
                                            : false,
                                    onChanged: (value) {
                                      setState(() {
                                        widget.userEmergencyContact.allowChat =
                                            value == true ? 1 : 0;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 0.40,
                                color: ColorConstant.dividerColor,
                              ),
                              //
                              SizedBox(
                                height: 22,
                              ),

                              Row(
                                children: [
                                  MyText(
                                      value: "editprofil_general_subtitle_email"
                                          .tr(),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 14,
                                      color: ColorConstant.textColor),
                                  SizedBox(
                                    width: 22,
                                  ),
                                  Image.asset(
                                    "Assets/Images/info.png",
                                    height: 14,
                                    width: 14,
                                  ),
                                ],
                              ),

                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                height: 0.40,
                                color: ColorConstant.dividerColor,
                              ),

                              SizedBox(
                                height: 12,
                              ),
                              //    MyText(value:'Text',textScaleFactor: 1.0,),
                              SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 6,
                                    child: MyText(
                                        value:
                                            "pets_label_mobilecellnumber".tr(),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ColorConstant.textColor),
                                  ),
                                  Image.asset(
                                    "Assets/Images/info.png",
                                    height: 14,
                                    width: 14,
                                  ),
                                  SizedBox(
                                    width: 82,
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: MyText(
                                        value: "pets_label_text".tr(),
                                        fontWeight: FontWeight.w900,
                                        fontSize: 14,
                                        color: ColorConstant.textColor),
                                  )
                                ],
                              ),
                              Row(children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: MyTextField(
                                    initialValue: '',
                                    inputType: TextInputType.number,
                                    maxline: 1,
                                    editTextBgColor:
                                        ColorConstant.textfieldColor,
                                    hintTextColor: Colors.white54,
                                    onChanged: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                Expanded(
                                  flex: 10,
                                  child: MyTextField(
                                    initialValue: '',
                                    inputType: TextInputType.number,
                                    maxline: 1,
                                    editTextBgColor:
                                        ColorConstant.textfieldColor,
                                    hintTextColor: Colors.white54,
                                    onChanged: (value) {},
                                  ),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                CustomSwitch(
                                  activeColor: Color(0xff34C759),
                                  value:
                                      widget.userEmergencyContact.allowMobile ==
                                              1
                                          ? true
                                          : false,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.userEmergencyContact.allowMobile =
                                          value == true ? 1 : 0;
                                    });
                                  },
                                ),
                              ]),

                              //Container(height: 0.45,color: ColorConstant.dividerColor.withOpacity(.30)),
                            ],
                          )
                        : Container(),
                  ],
                ),
              ));
  }
}
