import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/customSwitchDiseable.dart';
import 'package:neopolis/Core/Utils/inputChecker.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpandableEmergency extends StatefulWidget {
  final UserEmergencyContact userEmergencyContactPet;

  int indexPet;
  int index;
  Profile profile;
  final String title;
  final String type;
  final bool attachment;
  final bool alarm;
  final TextEditingController text;
  bool switchValue;
  final visibile;
  List<bool> addBlockEmergency;
  bool dropdownValue;
  String relationVal;
  final List relationList;
  bool updated;
  ExpandableEmergency({
    Key key,
    this.indexPet,
    this.addBlockEmergency,
    this.userEmergencyContactPet,
    this.profile,
    this.title,
    this.type,
    this.attachment,
    this.alarm,
    this.text,
    this.index,
    this.updated,
    this.switchValue,
    this.visibile,
    this.dropdownValue,
    this.relationVal,
    this.relationList,
  });

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableEmergency> {
  List<String> mailsList = [];
  FocusNode codeFocus = FocusNode();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  bool checkerEmail1Contact;
  bool checkerEmail2Contact;
  bool checkerEmail1Switch;
  bool checkerEmail2Switch;
  bool checkerEmail1;
  bool checkerEmail2;
  bool checkerPhone;
  bool checkerCodePhone;
  @override
  void initState() {
    checkerEmail1Switch =
        regExpEmail.hasMatch(widget.userEmergencyContactPet.mail);
    checkerEmail2Switch =
        regExpEmail.hasMatch(widget.userEmergencyContactPet.mail2);
    checkerEmail1 = regExpEmail.hasMatch(widget.userEmergencyContactPet.mail);
    checkerEmail2 = regExpEmail.hasMatch(widget.userEmergencyContactPet.mail2);
    checkerEmail1Contact = widget.userEmergencyContactPet.mail == ''
        ? true
        : regExpEmail.hasMatch(widget.userEmergencyContactPet.mail ?? '');
    checkerEmail2Contact = widget.userEmergencyContactPet.mail2 == ""
        ? true
        : regExpEmail.hasMatch(widget.userEmergencyContactPet.mail2 ?? '');
    super.initState();
    checkerPhone = false;
    checkerCodePhone = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.dropdownValue == false
            ? null
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
                              widget.userEmergencyContactPet.firstName != ''
                                  ? Expanded(
                                      flex: 2,
                                      child: MyText(
                                          value: widget.userEmergencyContactPet
                                              .firstName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor),
                                    )
                                  : Expanded(
                                      flex: 2,
                                      child: MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                  .textScaleFactor
                                                  .clamp(1.0, 1.0),
                                        ),
                                        child: MyTextField(
                                          initialValue: widget
                                              .userEmergencyContactPet
                                              .firstName,
                                          maxline: 1,
                                          title: "registration_input_firstname"
                                              .tr(),
                                          inputType: TextInputType.number,
                                          editTextBgColor:
                                              ColorConstant.textfieldColor,
                                          hintTextColor: Colors.white54,
                                          onChanged: (value) {
                                            widget.updated = true;
                                            widget.userEmergencyContactPet
                                                .firstName = value;
                                          },
                                        ),
                                      )),
                              SizedBox(
                                width: 16,
                              ),
                              widget.userEmergencyContactPet.lastName != ''
                                  ? Expanded(
                                      flex: 2,
                                      child: MyText(
                                          value: widget
                                              .userEmergencyContactPet.lastName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor),
                                    )
                                  : Expanded(
                                      flex: 2,
                                      child: MediaQuery(
                                        data: MediaQuery.of(context).copyWith(
                                          textScaleFactor:
                                              MediaQuery.of(context)
                                                  .textScaleFactor
                                                  .clamp(1.0, 1.0),
                                        ),
                                        child: MyTextField(
                                          initialValue: widget
                                              .userEmergencyContactPet.lastName,
                                          maxline: 1,
                                          title: "registration_input_lastname"
                                              .tr(),
                                          inputType: TextInputType.number,
                                          editTextBgColor:
                                              ColorConstant.textfieldColor,
                                          hintTextColor: Colors.white54,
                                          onChanged: (value) {
                                            widget.updated = true;
                                            widget.userEmergencyContactPet
                                                .lastName = value;
                                          },
                                        ),
                                      )),
                              SizedBox(
                                width: 10,
                              ),
                            ]),
                          )
                        : MyText(
                            value: widget.userEmergencyContactPet.firstName +
                                ' ' +
                                widget.userEmergencyContactPet.lastName,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: widget.dropdownValue
                                ? ColorConstant.textColor
                                : ColorConstant.greyChar),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  !widget.visibile
                      ? SizedBox(
                          width: 12,
                        )
                      : SizedBox(
                          width: 8,
                        ),
                  CustomSwitch(
                    activeColor: Color(0xff34C759),
                    value: widget.userEmergencyContactPet.active == 1
                        ? true
                        : false,
                    onChanged: (value) {
                      widget.updated = true;

                      setState(() {
                        widget.userEmergencyContactPet.active =
                            value == true ? 1 : 0;

                        if (widget.userEmergencyContactPet.active == 0) {
                          setState(() {
                            widget.dropdownValue = false;
                            widget.addBlockEmergency[widget.index] = false;
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
                                value: "registration_input_email".tr(),
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
                                                .userEmergencyContactPet.mail,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor)
                                        : MediaQuery(
                                            data:
                                                MediaQuery.of(context).copyWith(
                                              textScaleFactor:
                                                  MediaQuery.of(context)
                                                      .textScaleFactor
                                                      .clamp(1.0, 1.0),
                                            ),
                                            child: MyTextField(
                                              initialValue: widget
                                                  .userEmergencyContactPet.mail,
                                              maxline: 1,
                                              onFieledSubmit: (value) {
                                                checkerEmail1 =
                                                    regExpEmail.hasMatch(widget
                                                        .userEmergencyContactPet
                                                        .mail);
                                              },
                                              inputType:
                                                  TextInputType.multiline,
                                              editTextBgColor:
                                                  ColorConstant.textfieldColor,
                                              hintTextColor: Colors.white54,
                                              title:
                                                  "pets_label_primarymail".tr(),
                                              onChanged: (value) {
                                                widget.updated = true;
                                                widget.userEmergencyContactPet
                                                    .mail = value;
                                                setState(() {
                                                  value == ""
                                                      ? checkerEmail1Contact =
                                                          true
                                                      : checkerEmail1Contact =
                                                          regExpEmail
                                                              .hasMatch(value);
                                                  checkerEmail1Switch =
                                                      regExpEmail.hasMatch(
                                                    widget
                                                        .userEmergencyContactPet
                                                        .mail,
                                                  );
                                                });
                                              },
                                            ),
                                          )),
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
                                            value: widget
                                                        .profile
                                                        .userGeneralInfo
                                                        .petsInfos[
                                                            widget.indexPet]
                                                        .emergencyContact[
                                                            widget.index]
                                                        .allowMail1 ==
                                                    1
                                                ? true
                                                : false,
                                            onChanged: (value) {
                                              widget.updated = true;
                                              widget
                                                  .profile
                                                  .userGeneralInfo
                                                  .petsInfos[widget.indexPet]
                                                  .emergencyContact[
                                                      widget.index]
                                                  .allowMail1 = value ==
                                                      true
                                                  ? 1
                                                  : 0;
                                            },
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            checkerEmail1Contact
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
                                                .userEmergencyContactPet.mail2,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: ColorConstant.textColor)
                                        : MediaQuery(
                                            data:
                                                MediaQuery.of(context).copyWith(
                                              textScaleFactor:
                                                  MediaQuery.of(context)
                                                      .textScaleFactor
                                                      .clamp(1.0, 1.0),
                                            ),
                                            child: MyTextField(
                                              initialValue: widget
                                                  .userEmergencyContactPet
                                                  .mail2,
                                              maxline: 1,
                                              keyboardType: TextInputType.text,
                                              focusNode: codeFocus,
                                              onFieledSubmit: (value) {
                                                checkerEmail2 =
                                                    regExpEmail.hasMatch(widget
                                                        .userEmergencyContactPet
                                                        .mail2);
                                              },
                                              textInputAction:
                                                  TextInputAction.done,
                                              inputType:
                                                  TextInputType.multiline,
                                              editTextBgColor:
                                                  ColorConstant.textfieldColor,
                                              hintTextColor: Colors.white54,
                                              title: "pets_label_secondarymail"
                                                  .tr(),
                                              onChanged: (value) {
                                                widget.updated = true;
                                                widget.userEmergencyContactPet
                                                    .mail2 = value;

                                                setState(() {
                                                  value == ""
                                                      ? checkerEmail2Contact =
                                                          true
                                                      : checkerEmail2Contact =
                                                          regExpEmail
                                                              .hasMatch(value);
                                                  checkerEmail2Switch =
                                                      regExpEmail.hasMatch(widget
                                                          .userEmergencyContactPet
                                                          .mail2);
                                                });
                                              },
                                            ),
                                          )),
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
                                            value: widget
                                                        .profile
                                                        .userGeneralInfo
                                                        .petsInfos[
                                                            widget.indexPet]
                                                        .emergencyContact[
                                                            widget.index]
                                                        .allowMail2 ==
                                                    1
                                                ? true
                                                : false,
                                            onChanged: (value) {
                                              widget.updated = true;
                                              widget
                                                  .profile
                                                  .userGeneralInfo
                                                  .petsInfos[widget.indexPet]
                                                  .emergencyContact[
                                                      widget.index]
                                                  .allowMail2 = value ==
                                                      true
                                                  ? 1
                                                  : 0;
                                            },
                                          ),
                                  ),
                                ),
                              ],
                            ),
                            checkerEmail2Contact
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
                            (widget.userEmergencyContactPet.mail == '' ||
                                        widget.userEmergencyContactPet.mail ==
                                            null) &&
                                    (widget.userEmergencyContactPet.mail2 ==
                                            '' ||
                                        widget.userEmergencyContactPet.mail2 ==
                                            null)
                                ? DiseableCustomSwitch(
                                    activeColor: Color(0xff34C759),
                                    value: false)
                                : CustomSwitch(
                                    activeColor: Color(0xff34C759),
                                    value: widget
                                                .profile
                                                .userGeneralInfo
                                                .petsInfos[widget.indexPet]
                                                .emergencyContact[widget.index]
                                                .allowChat ==
                                            1
                                        ? true
                                        : false,
                                    onChanged: (value) {
                                      widget.updated = true;
                                      widget
                                          .profile
                                          .userGeneralInfo
                                          .petsInfos[widget.indexPet]
                                          .emergencyContact[widget.index]
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
                                  KeyboardActionsItem(focusNode: focusNode1),
                                  KeyboardActionsItem(focusNode: focusNode2),
                                ]),
                            child: Row(children: <Widget>[
                              Expanded(
                                  flex: 3,
                                  child: checkerCodePhone == true
                                      ? MyText(
                                          value: widget.userEmergencyContactPet
                                              .codePhone,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor)
                                      : MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                    .textScaleFactor
                                                    .clamp(1.0, 1.0),
                                          ),
                                          child: MyTextField(
                                            initialValue: widget
                                                .userEmergencyContactPet
                                                .codePhone,
                                            title: 'Mobile',
                                            keyboardType: TextInputType.number,
                                            maxline: 1,
                                            onFieledSubmit: (value) {
                                              checkerCodePhone = true;
                                            },
                                            focusNode: focusNode1,
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            hintTextColor: Colors.white54,
                                            onChanged: (value) {
                                              setState(() {
                                                widget.updated = true;
                                                widget.userEmergencyContactPet
                                                    .codePhone = value;
                                              });
                                            },
                                          ),
                                        )),
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                  flex: 10,
                                  child: checkerPhone == true
                                      ? MyText(
                                          value: widget
                                              .userEmergencyContactPet.mobile,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor)
                                      : MediaQuery(
                                          data: MediaQuery.of(context).copyWith(
                                            textScaleFactor:
                                                MediaQuery.of(context)
                                                    .textScaleFactor
                                                    .clamp(1.0, 1.0),
                                          ),
                                          child: MyTextField(
                                            initialValue: widget
                                                .userEmergencyContactPet.mobile,
                                            title: "pets_label_cellnumber".tr(),
                                            keyboardType: TextInputType.number,
                                            maxline: 1,
                                            onFieledSubmit: (value) {
                                              checkerPhone = true;
                                            },
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            hintTextColor: Colors.white54,
                                            focusNode: focusNode2,
                                            onChanged: (value) {
                                              setState(() {
                                                widget.updated = true;
                                                widget.userEmergencyContactPet
                                                    .mobile = value;
                                              });
                                            },
                                          ),
                                        )),
                              SizedBox(
                                width: 16,
                              ),
                              (widget.userEmergencyContactPet.mobile == '' ||
                                          widget.userEmergencyContactPet
                                                  .mobile ==
                                              null) &&
                                      (widget.userEmergencyContactPet
                                                  .codePhone ==
                                              '' ||
                                          widget.userEmergencyContactPet
                                                  .codePhone ==
                                              null)
                                  ? DiseableCustomSwitch(
                                      activeColor: Color(0xff34C759),
                                      value: false)
                                  : CustomSwitch(
                                      activeColor: Color(0xff34C759),
                                      value: widget
                                                  .profile
                                                  .userGeneralInfo
                                                  .petsInfos[widget.indexPet]
                                                  .emergencyContact[
                                                      widget.index]
                                                  .allowMobile ==
                                              1
                                          ? true
                                          : false,
                                      onChanged: (value) {
                                        widget.updated = true;
                                        widget
                                                .profile
                                                .userGeneralInfo
                                                .petsInfos[widget.indexPet]
                                                .emergencyContact[widget.index]
                                                .allowMobile =
                                            value == true ? 1 : 0;
                                      },
                                    ),
                            ]),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ));
  }
}
