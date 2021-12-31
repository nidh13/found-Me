import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/customSwitchDiseable.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpandableEmergency extends StatefulWidget {
  final UserEmergencyContact userEmergencyContact;
  final UserEmergencyContact userEmergencyContactGeneral;
  final String title;
  final String type;
  final bool attachment;
  final bool alarm;
  final TextEditingController text;
  bool switchValue;
  final visibile;
  List<bool> addBlockEmergency;
  int index;
  bool dropdownValue;
  String relationVal;
  final List relationList;
  String role;
  ExpandableEmergency(
      {Key key,
      this.userEmergencyContact,
      this.title,
      this.type,
      this.index,
      this.attachment,
      this.addBlockEmergency,
      this.alarm,
      this.text,
      this.switchValue,
      this.visibile,
      this.dropdownValue,
      this.relationVal,
      this.relationList,
      this.userEmergencyContactGeneral,
      this.role});

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableEmergency> {
  FocusNode nbreFocus = FocusNode();

  List<String> mailsList = [];

  FocusNode codeFocus = FocusNode();

  bool checkerEmail1Switch;
  bool checkerEmail2Switch;
  bool checkerEmail1;
  bool checkerEmail2;
  bool checkerMobile;
  @override
  void initState() {
    checkerEmail1Switch =
        regExpEmail.hasMatch(widget.userEmergencyContact.mail);
    checkerEmail2Switch =
        regExpEmail.hasMatch(widget.userEmergencyContact.mail2);
    checkerEmail1 = regExpEmail.hasMatch(widget.userEmergencyContact.mail);
    checkerEmail2 = regExpEmail.hasMatch(widget.userEmergencyContact.mail2);
    checkerEmail1AlsoContact = widget.userEmergencyContact.mail == ''
        ? true
        : regExpEmail.hasMatch(widget.userEmergencyContact.mail ?? '');
    checkerEmail2AlsoContact = widget.userEmergencyContact.mail2 == ""
        ? true
        : regExpEmail.hasMatch(widget.userEmergencyContact.mail2 ?? '');
    checkerMobile = widget.userEmergencyContact.mobile == null ||
            widget.userEmergencyContact.mobile == ""
        ? false
        : true;
    super.initState();
  }

  bool checkerEmail1AlsoContact;
  bool checkerEmail2AlsoContact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.role == 'child'
            ? widget.dropdownValue == false
                ? null
                : () {
                    setState(() {
                      widget.addBlockEmergency[widget.index] =
                          !widget.addBlockEmergency[widget.index];
                    });
                  }
            : () {
                setState(() {
                  widget.addBlockEmergency[widget.index] =
                      !widget.addBlockEmergency[widget.index];
                });
              },
        child: Container(
          padding: EdgeInsets.only(top: 15.5, bottom: 14.5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: widget.addBlockEmergency[widget.index]
                        ? Center(
                            child: Row(children: <Widget>[
                              widget.userEmergencyContact.firstName != ''
                                  ? Expanded(
                                      flex: 2,
                                      child: MyText(
                                          value: widget
                                              .userEmergencyContact.firstName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor),
                                    )
                                  : Expanded(
                                      flex: 2,
                                      child: MyTextField(
                                        initialValue: widget
                                            .userEmergencyContact.firstName,
                                        title:
                                            "editprofil_general_label_firstname"
                                                .tr(),
                                        maxline: 1,
                                        inputType: TextInputType.number,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {
                                          widget.userEmergencyContact
                                              .firstName = value;
                                          widget.userEmergencyContactGeneral
                                              .firstName = value;
                                          print(widget
                                              .userEmergencyContact.firstName);
                                        },
                                      ),
                                    ),
                              SizedBox(
                                width: 16,
                              ),
                              widget.userEmergencyContact.lastName != ''
                                  ? Expanded(
                                      flex: 2,
                                      child: MyText(
                                          value: widget
                                              .userEmergencyContact.lastName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor),
                                    )
                                  : Expanded(
                                      flex: 2,
                                      child: MyTextField(
                                        initialValue: widget
                                            .userEmergencyContact.lastName,
                                        maxline: 1,
                                        title:
                                            "editprofil_general_label_lastname"
                                                .tr(),
                                        inputType: TextInputType.number,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {
                                          widget.userEmergencyContact.lastName =
                                              value;
                                          widget.userEmergencyContactGeneral
                                              .lastName = value;
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
                            color: widget.role == 'child'
                                ? widget.dropdownValue
                                    ? ColorConstant.textColor
                                    : ColorConstant.greyChar
                                : ColorConstant.textColor),
                  ),
                  widget.role == 'child'
                      ? CustomSwitch(
                          activeColor: Color(0xff34C759),
                          value: widget.userEmergencyContact.active == 1
                              ? true
                              : false,
                          onChanged: (value) {
                            setState(() {
                              widget.userEmergencyContact.active =
                                  value == true ? 1 : 0;

                              if (widget.userEmergencyContact.active == 0) {
                                setState(() {
                                  widget.dropdownValue = false;
                                  widget.addBlockEmergency[widget.index] =
                                      false;
                                });
                              } else {
                                setState(() {
                                  widget.dropdownValue = true;
                                });
                              }
                            });
                          },
                        )
                      : Container(),
                  SizedBox(
                    width: 12,
                  ),
                  !widget.visibile
                      ? SizedBox(
                          width: 12,
                        )
                      : SizedBox(
                          width: 1,
                        ),
                  widget.dropdownValue
                      ? Visibility(
                          visible: widget.visibile,
                          child: Image.asset(
                            widget.addBlockEmergency[widget.index]
                                ? "Assets/Images/arrow-up-gray.png"
                                : "Assets/Images/arrow-down-gray.png",
                            height: 8,
                            width: 13.18,
                          ))
                      : Container(),
                ],
              ),
              widget.addBlockEmergency[widget.index]
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8,
                        ),

                        SizedBox(
                          height: 8,
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
                                value: "editprofil_general_subtitle_email".tr(),
                                fontWeight: FontWeight.w700,
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

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8.0 ?? 12.5,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: checkerEmail1 != false
                                      ? MyText(
                                          value:
                                              widget.userEmergencyContact.mail,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor)
                                      : MyTextField(
                                          initialValue:
                                              widget.userEmergencyContact.mail,
                                          maxline: 1,
                                          inputType: TextInputType.multiline,
                                          editTextBgColor:
                                              ColorConstant.textfieldColor,
                                          hintTextColor: Colors.white54,
                                          onFieledSubmit: (value) {
                                            checkerEmail1 =
                                                regExpEmail.hasMatch(widget
                                                    .userEmergencyContact.mail);
                                          },
                                          title:
                                              "editprofil_general_subtitle_primaryemail"
                                                  .tr(),
                                          onChanged: (value) {
                                            widget.userEmergencyContact.mail =
                                                value;
                                            widget.userEmergencyContactGeneral
                                                .mail = value;
                                            setState(() {
                                              value == ""
                                                  ? checkerEmail1AlsoContact =
                                                      true
                                                  : checkerEmail1AlsoContact =
                                                      regExpEmail
                                                          .hasMatch(value);
                                              checkerEmail1Switch =
                                                  regExpEmail.hasMatch(widget
                                                      .userEmergencyContact
                                                      .mail);
                                            });
                                          },
                                        ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: checkerEmail1Switch == false
                                        ? DiseableCustomSwitch(
                                            activeColor: Color(0xff34C759),
                                            value: false)
                                        : CustomSwitch(
                                            activeColor: Color(0xff34C759),
                                            value: widget.userEmergencyContact
                                                        .allowMail1 ==
                                                    1
                                                ? true
                                                : false,
                                            onChanged: (value) {
                                              setState(() {
                                                widget.userEmergencyContact
                                                        .allowMail1 =
                                                    value == true ? 1 : 0;
                                              });
                                            },
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            checkerEmail1AlsoContact
                                ? Container()
                                : Padding(
                                    padding:
                                        EdgeInsets.only(left: 2.0, top: 8.0),
                                    child: MyText(
                                      value: "registration_info_email".tr(),
                                      fontSize: 12,
                                      color: Colors.red,
                                    ),
                                  ),
                            SizedBox(
                              height: 0.0 ?? 12.5,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8.0 ?? 12.5,
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: checkerEmail2 != false
                                      ? MyText(
                                          value:
                                              widget.userEmergencyContact.mail2,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor)
                                      : MyTextField(
                                          initialValue:
                                              widget.userEmergencyContact.mail2,
                                          maxline: 1,
                                          onFieledSubmit: (value) {
                                            checkerEmail2 =
                                                regExpEmail.hasMatch(widget
                                                    .userEmergencyContact
                                                    .mail2);
                                          },
                                          inputType: TextInputType.multiline,
                                          editTextBgColor:
                                              ColorConstant.textfieldColor,
                                          hintTextColor: Colors.white54,
                                          title:
                                              "editprofil_general_subtitle_secondaryemail"
                                                  .tr(),
                                          onChanged: (value) {
                                            widget.userEmergencyContact.mail2 =
                                                value;
                                            widget.userEmergencyContactGeneral
                                                .mail2 = value;

                                            setState(() {
                                              value == ""
                                                  ? checkerEmail2AlsoContact =
                                                      true
                                                  : checkerEmail2AlsoContact =
                                                      regExpEmail
                                                          .hasMatch(value);
                                              checkerEmail2Switch =
                                                  regExpEmail.hasMatch(widget
                                                      .userEmergencyContact
                                                      .mail2);
                                            });
                                          },
                                        ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: checkerEmail2Switch == false
                                        ? DiseableCustomSwitch(
                                            activeColor: Color(0xff34C759),
                                            value: false)
                                        : CustomSwitch(
                                            activeColor: Color(0xff34C759),
                                            value: widget.userEmergencyContact
                                                        .allowMail2 ==
                                                    1
                                                ? true
                                                : false,
                                            onChanged: (value) {
                                              setState(() {
                                                widget.userEmergencyContact
                                                        .allowMail2 =
                                                    value == true ? 1 : 0;
                                              });
                                            },
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            checkerEmail2AlsoContact
                                ? Container()
                                : Padding(
                                    padding:
                                        EdgeInsets.only(left: 2.0, top: 8.0),
                                    child: MyText(
                                      value: "registration_info_email".tr(),
                                      fontSize: 12,
                                      color: Colors.red,
                                    ),
                                  ),
                            SizedBox(
                              height: 0.0 ?? 12.5,
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
                        Row(
                          children: [
                            MyText(
                                value: "pets_label_livechat".tr(),
                                fontWeight: FontWeight.w700,
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
                            (widget.userEmergencyContact.mail == '' ||
                                        widget.userEmergencyContact.mail ==
                                            null) &&
                                    (widget.userEmergencyContact.mail2 == '' ||
                                        widget.userEmergencyContact.mail2 ==
                                            null)
                                ? DiseableCustomSwitch(
                                    activeColor: Color(0xff34C759),
                                    value: false)
                                : CustomSwitch(
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

                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 6,
                              child: MyText(
                                  value: "pets_label_mobilecellnumber".tr(),
                                  fontWeight: FontWeight.w700,
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
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: ColorConstant.textColor),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Container(
                          child: KeyboardActions(
                            autoScroll: false,
                            disableScroll: true,
                            config: KeyboardActionsConfig(
                                keyboardActionsPlatform:
                                    KeyboardActionsPlatform.ALL,
                                actions: [
                                  KeyboardActionsItem(focusNode: codeFocus),
                                  KeyboardActionsItem(focusNode: nbreFocus),
                                ]),
                            child: Row(children: <Widget>[
                              Expanded(
                                flex: 3,
                                child:
                                    widget.userEmergencyContact.codePhone != ''
                                        ? MyText(
                                            value: widget
                                                .userEmergencyContact.codePhone,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor)
                                        : MyTextField(
                                            initialValue: widget
                                                .userEmergencyContact.codePhone,
                                            keyboardType: TextInputType.number,
                                            focusNode: codeFocus,
                                            maxline: 1,
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            hintTextColor: Colors.white54,
                                            onChanged: (value) {
                                              widget.userEmergencyContact
                                                  .codePhone = value;
                                              widget.userEmergencyContactGeneral
                                                  .codePhone = value;
                                            },
                                          ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                flex: 10,
                                child: checkerMobile == true
                                    ? MyText(
                                        value:
                                            widget.userEmergencyContact.mobile,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ColorConstant.textColor)
                                    : MyTextField(
                                        initialValue:
                                            widget.userEmergencyContact.mobile,
                                        keyboardType: TextInputType.number,
                                        focusNode: nbreFocus,
                                        maxline: 1,
                                        onFieledSubmit: (value) {
                                          setState(() {
                                            value != ""
                                                ? checkerMobile = true
                                                : checkerMobile = false;
                                          });
                                        },
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {
                                          widget.userEmergencyContact.mobile =
                                              value;
                                          widget.userEmergencyContactGeneral
                                              .mobile = value;
                                        },
                                      ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                              widget.userEmergencyContact.mobile == '' ||
                                      widget.userEmergencyContact.mobile == null
                                  ? DiseableCustomSwitch(
                                      activeColor: Color(0xff34C759),
                                      value: false)
                                  : CustomSwitch(
                                      activeColor: Color(0xff34C759),
                                      value: widget.userEmergencyContact
                                                  .allowMobile ==
                                              1
                                          ? true
                                          : false,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.userEmergencyContact
                                                  .allowMobile =
                                              value == true ? 1 : 0;
                                        });
                                      },
                                    ),
                            ]),
                          ),
                        ),

                        //Container(height: 0.45,color: ColorConstant.dividerColor.withOpacity(.30)),
                      ],
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
