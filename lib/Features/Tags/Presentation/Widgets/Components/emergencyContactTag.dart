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

class ExpandableEmergencyTag extends StatefulWidget {
  UserEmergencyContact userEmergencyContact;
  final String title;
  final String type;
  bool update;
  final bool attachment;
  final bool alarm;
  final TextEditingController text;
  bool switchValue;
  bool expandFlag;
  final visibile;
  int index;
  bool dropdownValue;
  List<bool> addBlockEmergency;
  String relationVal;
  final List relationList;

  ExpandableEmergencyTag({
    Key key,
    this.userEmergencyContact,
    this.title,
    this.index,
    this.type,
    this.update,
    this.addBlockEmergency,
    this.expandFlag,
    this.attachment,
    this.alarm,
    this.text,
    this.switchValue,
    this.visibile,
    this.dropdownValue,
    this.relationVal,
    this.relationList,
  });

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableEmergencyTag> {
  List<String> mailsList = [];
  bool checkerEmail1Switch;
  bool checkerEmail2Switch;
  bool checkerEmail1;
  bool checkerEmail2;
  bool checkerMobile = false;
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
                checkerMobile=widget.userEmergencyContact.mobile==null|| widget.userEmergencyContact.mobile==""?false:true;

    checkerEmail2AlsoContact = widget.userEmergencyContact.mail2 == ""
        ? true
        : regExpEmail.hasMatch(widget.userEmergencyContact.mail2 ?? '');
    super.initState();
    
  }

  FocusNode nbreFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  bool checkerEmail1AlsoContact;
  bool checkerEmail2AlsoContact;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       // key: GlobalKey(),
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
                                        maxline: 1,
                                        inputType: TextInputType.number,
                                        title:
                                            "editprofil_general_label_firstname"
                                                .tr(),
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {
                                          widget.update = true;
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
                                          widget.update = true;

                                          widget.userEmergencyContact.lastName =
                                              value;
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
                          width: 1,
                        ),
                  CustomSwitch(
                    activeColor: Color(0xff34C759),
                    value:
                        widget.userEmergencyContact.active == 1 ? true : false,
                    onChanged: (value) {
                      widget.update = true;

                      setState(() {
                        widget.userEmergencyContact.active =
                            value == true ? 1 : 0;

                        if (widget.userEmergencyContact.active == 0) {
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
                                  flex: 11,
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
                                          onFieledSubmit: (value) {
                                            checkerEmail1 =
                                                regExpEmail.hasMatch(widget
                                                    .userEmergencyContact.mail);
                                          },
                                          hintTextColor: Colors.white54,
                                          title:
                                              'editprofil_general_subtitle_primaryemail'
                                                  .tr(),
                                          onChanged: (value) {
                                            setState(() {
                                              widget.update = true;

                                              widget.userEmergencyContact.mail =
                                                  value;

                                              value == ""
                                                  ? checkerEmail1AlsoContact =
                                                      true
                                                  : checkerEmail1AlsoContact =
                                                      regExpEmail
                                                          .hasMatch(value);

                                              checkerEmail1Switch =
                                                  regExpEmail.hasMatch(value);
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
                                              widget.update = true;

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
                                    padding: EdgeInsets.only(left: 2, top: 8.0),
                                    child: MyText(
                                      value: 'registration_info_email'.tr(),
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
                                          value:
                                              widget.userEmergencyContact.mail2,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                          color: ColorConstant.textColor)
                                      : MyTextField(
                                       
                                          initialValue:
                                              widget.userEmergencyContact.mail2,
                                          maxline: 1,
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.done,
                                        //  inputType: TextInputType.multiline,
                                          editTextBgColor:
                                              ColorConstant.textfieldColor,
                                          hintTextColor: Colors.white54,
                                          onFieledSubmit: (value) {
                                            checkerEmail2 =
                                                regExpEmail.hasMatch(widget
                                                    .userEmergencyContact
                                                    .mail2);
                                          },
                                          title:
                                              'editprofil_general_subtitle_secondaryemail'
                                                  .tr(),
                                          onChanged: (value) {
                                            widget.update = true;
                                            setState(() {
                                              value == ""
                                                  ? checkerEmail2AlsoContact =
                                                      true
                                                  : checkerEmail2AlsoContact =
                                                      regExpEmail
                                                          .hasMatch(value);

                                              widget.userEmergencyContact
                                                  .mail2 = value;

                                              checkerEmail2Switch =
                                                  regExpEmail.hasMatch(value);
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
                                              widget.update = true;

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
                                    padding: EdgeInsets.only(left: 2, top: 8.0),
                                    child: MyText(
                                      value: 'registration_info_email'.tr(),
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
                                      widget.update = true;

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
                                  KeyboardActionsItem(focusNode: phoneFocus),
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
                                            focusNode: phoneFocus,
                                            maxline: 1,
                                            title: "pets_label_mobile".tr(),
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            hintTextColor: Colors.white54,
                                            onChanged: (value) {
                                              widget.update = true;

                                              widget.userEmergencyContact
                                                  .codePhone = value;
                                            },
                                          ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Expanded(
                                flex: 10,
                                child:checkerMobile==true 
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
                                        onFieledSubmit: (value) {
     setState(() {
                                       value!=""?checkerMobile=true:checkerMobile=false;
     
                                          });                                        },
                                        maxline: 1,
                                        title: "pets_label_cellnumber".tr(),
                                        editTextBgColor:
                                            ColorConstant.textfieldColor,
                                        hintTextColor: Colors.white54,
                                        onChanged: (value) {
                                          setState(() {
                                            widget.update = true;
                                          
                                            widget.userEmergencyContact.mobile =
                                                value;
                                          });
                                        },
                                      ),
                              ),
                              SizedBox(
                                width: 16,
                              ),
                                                         widget.userEmergencyContact.mobile == ''||widget.userEmergencyContact.mobile == null
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
                                        widget.update = true;

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
