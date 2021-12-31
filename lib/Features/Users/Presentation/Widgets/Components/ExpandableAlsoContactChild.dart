import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/customSwitchDiseable.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpandableAlsoContactListChild extends StatefulWidget {
  final UserEmergencyContact userEmergencyContactUser;
  final UserEmergencyContact userEmergencyContactMedicalUser;

  bool update;
  int index;
  List<bool> addAlsoBlockChild;
  bool switchValue;
  final visibile;

  bool dropdownValue;
  String relationVal;
  final List relationList;

  ExpandableAlsoContactListChild({
    Key key,
    this.userEmergencyContactUser,
    this.addAlsoBlockChild,
    this.userEmergencyContactMedicalUser,
    this.index,
    this.update,
    this.switchValue,
    this.visibile,
    this.dropdownValue,
    this.relationVal,
    this.relationList,
  });

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableAlsoContactListChild> {
  List<String> mailsList = [];
  FocusNode codeFocus = FocusNode();

  bool checkerEmail1Switch;
  bool checkerEmail2Switch;
  bool checkerEmail1;
  bool checkerEmail2;

  @override
  void initState() {
    checkerEmail1Switch =
        regExpEmail.hasMatch(widget.userEmergencyContactUser.mail);
    checkerEmail2Switch =
        regExpEmail.hasMatch(widget.userEmergencyContactUser.mail2);
    checkerEmail1 = regExpEmail.hasMatch(widget.userEmergencyContactUser.mail);
    checkerEmail2 = regExpEmail.hasMatch(widget.userEmergencyContactUser.mail2);
    checkerEmail1AlsoContact = widget.userEmergencyContactUser.mail == ''
        ? true
        : regExpEmail.hasMatch(widget.userEmergencyContactUser.mail ?? '');
    checkerEmail1AlsoContact = widget.userEmergencyContactUser.mail2 == ""
        ? true
        : regExpEmail.hasMatch(widget.userEmergencyContactUser.mail2 ?? '');
    checkerEmail2AlsoContact = widget.userEmergencyContactUser.mail2 == ""
        ? true
        : regExpEmail.hasMatch(widget.userEmergencyContactUser.mail2 ?? '');
    super.initState();
  }

  bool checkerEmail1AlsoContact;
  bool checkerEmail2AlsoContact;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: GlobalKey(),
        onTap: widget.dropdownValue == false
            ? null
            : () {
                setState(() {
                  widget.addAlsoBlockChild[widget.index] =
                      !widget.addAlsoBlockChild[widget.index];
                });
              },
        child: Container(
          padding: EdgeInsets.only(top: 15.5, bottom: 14.5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: widget.addAlsoBlockChild[widget.index]
                        ? Center(
                            child: Row(children: <Widget>[
                              widget.userEmergencyContactUser.firstName != ''
                                  ? Expanded(
                                      flex: 2,
                                      child: MyText(
                                          value: widget.userEmergencyContactUser
                                              .firstName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor))
                                  : Expanded(
                                      flex: 2,
                                      child: MyTextField(
                                        initialValue: widget
                                            .userEmergencyContactUser.firstName,
                                        title:
                                            "editprofil_general_label_firstname"
                                                .tr(),
                                        maxline: 1,
                                        inputType: TextInputType.number,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {
                                          widget.update = true;
                                          widget.userEmergencyContactUser
                                              .firstName = value;
                                          widget.userEmergencyContactMedicalUser
                                              .firstName = value;
                                        },
                                      ),
                                    ),
                              SizedBox(
                                width: 16,
                              ),
                              widget.userEmergencyContactUser.lastName != ''
                                  ? Expanded(
                                      flex: 2,
                                      child: MyText(
                                          value: widget.userEmergencyContactUser
                                              .lastName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor))
                                  : Expanded(
                                      flex: 2,
                                      child: MyTextField(
                                        initialValue: widget
                                            .userEmergencyContactUser.lastName,
                                        maxline: 1,
                                        title:
                                            "editprofil_general_label_lastname"
                                                .tr(),
                                        inputType: TextInputType.number,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {
                                          widget.update = true;
                                          widget.userEmergencyContactUser
                                              .lastName = value;
                                          widget.userEmergencyContactMedicalUser
                                              .lastName = value;
                                        },
                                      ),
                                    ),
                              SizedBox(
                                width: 10,
                              ),
                            ]),
                          )
                        : MyText(
                            value: widget.userEmergencyContactUser.firstName +
                                ' ' +
                                widget.userEmergencyContactUser.lastName,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: widget.dropdownValue
                                ? ColorConstant.textColor
                                : ColorConstant.greyChar),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  CustomSwitch(
                    activeColor: Color(0xff34C759),
                    value: widget.userEmergencyContactUser.active == 1
                        ? true
                        : false,
                    onChanged: (value) {
                      widget.update = true;

                      setState(() {
                        widget.userEmergencyContactUser.active =
                            value == true ? 1 : 0;

                        if (widget.userEmergencyContactUser.active == 0) {
                          setState(() {
                            widget.dropdownValue = false;
                            widget.addAlsoBlockChild[widget.index] = false;
                          });
                        } else {
                          setState(() {
                            widget.dropdownValue = true;
                          });
                        }
                      });
                    },
                  ),
                  !widget.visibile
                      ? SizedBox(
                          width: 12,
                        )
                      : SizedBox(
                          width: 8,
                        ),
                  widget.dropdownValue
                      ? Visibility(
                          visible: widget.visibile,
                          child: Image.asset(
                            widget.addAlsoBlockChild[widget.index]
                                ? "Assets/Images/arrow-up-gray.png"
                                : "Assets/Images/arrow-down-gray.png",
                            height: 8,
                            width: 13.18,
                          ))
                      : Container(),
                ],
              ),
              widget.addAlsoBlockChild[widget.index]
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
                                value: 'Emails',
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
                                  flex: 11,
                                  child: checkerEmail1 != false
                                      ? MyText(
                                          value: widget
                                              .userEmergencyContactUser.mail,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor)
                                      : MyTextField(
                                          initialValue: widget
                                              .userEmergencyContactUser.mail,
                                          maxline: 1,
                                          inputType: TextInputType.multiline,
                                          onFieledSubmit: (value) {
                                            setState(() {
                                              checkerEmail1 =
                                                  regExpEmail.hasMatch(widget
                                                      .userEmergencyContactUser
                                                      .mail);
                                            });
                                          },
                                          editTextBgColor:
                                              ColorConstant.textfieldColor,
                                          hintTextColor: Colors.white54,
                                          title:
                                              "editprofil_general_subtitle_primaryemail"
                                                  .tr(),
                                          onChanged: (value) {
                                            widget.update = true;

                                            setState(() {
                                              widget.userEmergencyContactUser
                                                  .mail = value;
                                              widget
                                                  .userEmergencyContactMedicalUser
                                                  .mail = value;
                                              value == ""
                                                  ? checkerEmail1AlsoContact =
                                                      true
                                                  : checkerEmail1AlsoContact =
                                                      regExpEmail
                                                          .hasMatch(value);
                                              checkerEmail1Switch =
                                                  regExpEmail.hasMatch(widget
                                                      .userEmergencyContactUser
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
                                            value:
                                                widget.userEmergencyContactUser
                                                            .allowMail1 ==
                                                        1
                                                    ? true
                                                    : false,
                                            onChanged: (value) {
                                              widget.update = true;

                                              setState(() {
                                                widget.userEmergencyContactUser
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
                                      color: ColorConstant.redColor,
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
                                  flex: 11,
                                  child: checkerEmail2 != false
                                      ? MyText(
                                          value: widget
                                              .userEmergencyContactUser.mail2,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor)
                                      : MyTextField(
                                          initialValue: widget
                                              .userEmergencyContactUser.mail2,
                                          maxline: 1,
                                          inputType: TextInputType.multiline,
                                          editTextBgColor:
                                              ColorConstant.textfieldColor,
                                          hintTextColor: Colors.white54,
                                          onFieledSubmit: (value) {
                                            setState(() {
                                              checkerEmail2 =
                                                  regExpEmail.hasMatch(widget
                                                      .userEmergencyContactUser
                                                      .mail2);
                                            });
                                          },
                                          title:
                                              "editprofil_general_subtitle_secondaryemail"
                                                  .tr(),
                                          onChanged: (value) {
                                            widget.update = true;

                                            setState(() {
                                              widget.userEmergencyContactUser
                                                  .mail2 = value;
                                              widget
                                                  .userEmergencyContactMedicalUser
                                                  .mail2 = value;

                                              value == ""
                                                  ? checkerEmail2AlsoContact =
                                                      true
                                                  : checkerEmail2AlsoContact =
                                                      regExpEmail
                                                          .hasMatch(value);
                                              checkerEmail2Switch =
                                                  regExpEmail.hasMatch(widget
                                                      .userEmergencyContactUser
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
                                            value:
                                                widget.userEmergencyContactUser
                                                            .allowMail2 ==
                                                        1
                                                    ? true
                                                    : false,
                                            onChanged: (value) {
                                              widget.update = true;

                                              setState(() {
                                                widget.userEmergencyContactUser
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
                                      color: ColorConstant.redColor,
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
                            (widget.userEmergencyContactUser.mail == '' ||
                                        widget.userEmergencyContactUser.mail ==
                                            null) &&
                                    (widget.userEmergencyContactUser.mail2 ==
                                            '' ||
                                        widget.userEmergencyContactUser.mail2 ==
                                            null)
                                ? DiseableCustomSwitch(
                                    activeColor: Color(0xff34C759),
                                    value: false)
                                : CustomSwitch(
                                    activeColor: Color(0xff34C759),
                                    value: widget.userEmergencyContactUser
                                                .allowChat ==
                                            1
                                        ? true
                                        : false,
                                    onChanged: (value) {
                                      widget.update = true;
                                      widget.userEmergencyContactUser
                                          .allowChat = value == true ? 1 : 0;
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
                                    color: ColorConstant.textColor))
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(children: <Widget>[
                          Expanded(
                            flex: 3,
                            child:
                                widget.userEmergencyContactUser.codePhone != ''
                                    ? MyText(
                                        value: widget
                                            .userEmergencyContactUser.codePhone,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ColorConstant.textColor)
                                    : MyTextField(
                                        initialValue: widget
                                            .userEmergencyContactUser.codePhone,
                                        keyboardType: TextInputType.number,
                                        focusNode: codeFocus,
                                        maxline: 1,
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {
                                          widget.update = true;
                                          widget.userEmergencyContactUser
                                              .codePhone = value;
                                          widget.userEmergencyContactMedicalUser
                                              .codePhone = value;
                                        },
                                      ),
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Expanded(
                            flex: 10,
                            child: widget.userEmergencyContactUser.mobile != ''
                                ? MyText(
                                    value:
                                        widget.userEmergencyContactUser.mobile,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                    color: ColorConstant.textColor)
                                : MyTextField(
                                    initialValue:
                                        widget.userEmergencyContactUser.mobile,
                                    inputType: TextInputType.number,
                                    maxline: 1,
                                    editTextBgColor:
                                        ColorConstant.textfieldColor,
                                    hintTextColor: Colors.white54,
                                    onChanged: (value) {
                                      widget.update = true;
                                      widget.userEmergencyContactUser.mobile =
                                          value;
                                      widget.userEmergencyContactMedicalUser
                                          .mobile = value;
                                    },
                                  ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          (widget.userEmergencyContactUser.mobile == '' ||
                                  widget.userEmergencyContactUser.mobile == null
                              ? DiseableCustomSwitch(
                                  activeColor: Color(0xff34C759), value: false)
                              : CustomSwitch(
                                  activeColor: Color(0xff34C759),
                                  value: widget.userEmergencyContactUser
                                              .allowMobile ==
                                          1
                                      ? true
                                      : false,
                                  onChanged: (value) {
                                    widget.update = true;
                                    widget.userEmergencyContactUser
                                        .allowMobile = value == true ? 1 : 0;
                                  },
                                )),
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
