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

class ExpandablePhysicianList extends StatefulWidget {
  final String title;
  final String type;
  final bool attachment;
  final List<Documents> documents;
  final bool alarm;
  bool update;
  final List<Reminders> reminders;
  final TextEditingController text;
  final bool dropdownValue;
  final PhysicianContact physicianContact;
  bool visibilite;
  List<bool> addBlockPhysician;
  List<PhysicianContact> physicien;
  int index;

  ExpandablePhysicianList(
      {Key key,
      this.title,
      this.type,
      this.update,
      this.attachment,
      this.addBlockPhysician,
      this.documents,
      this.index,
      this.alarm,
      this.reminders,
      this.text,
      this.dropdownValue,
      this.physicianContact,
      this.visibilite});

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandablePhysicianList> {
  FocusNode nbreFocus = FocusNode();

  bool checkerEmail1AlsoContact;
  bool checkerEmail2AlsoContact;
  bool checkerEmail1Switch;
  bool checkerEmail2Switch;

  @override
  void initState() {
    checkerEmail1Switch = regExpEmail.hasMatch(widget.physicianContact.mail);
    checkerEmail2Switch = regExpEmail.hasMatch(widget.physicianContact.mail2);
    checkerEmail1AlsoContact = widget.physicianContact.mail == ''
        ? true
        : regExpEmail.hasMatch(widget.physicianContact.mail ?? '');
    checkerEmail2AlsoContact = widget.physicianContact.mail2 == ""
        ? true
        : regExpEmail.hasMatch(widget.physicianContact.mail2 ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.addBlockPhysician[widget.index] =
              !widget.addBlockPhysician[widget.index];
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 12.5, bottom: 12.5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 11,
                  child: widget.addBlockPhysician[widget.index]
                      ? MyTextField(
                          inputType: TextInputType.multiline,
//                                  textAlign: TextAlign.start,

                          focusNode: null,
                          editTextBgColor: ColorConstant.textfieldColor,
                          hintTextColor: Colors.black,

                          title: "pets_label_name".tr(),
                          hintText: "pets_label_name".tr(),
                          //    initialValue: widget.physicianContact.speciality,

                          initialValue: widget.physicianContact.firstName +
                              ' ' +
                              widget.physicianContact.lastName,

                          onChanged: (value) {
                            widget.update = true;

                            setState(() {
                              var name = value.split(" ");
                              widget.physicianContact.firstName = name[0];
                              var lastname = '';
                              for (int i = 1; i < name.length; i++) {
                                lastname = lastname + ' ' + name[i];
                              }
                              widget.physicianContact.lastName = lastname;
                            });
                          },
                        )
                      : MyText(
                          value: widget.physicianContact.firstName +
                              ' ' +
                              widget.physicianContact.lastName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorConstant.textColor),
                ),

                /*  widget.attachment? Padding(
                padding: const EdgeInsets.only(right: 6.7),
                child: Image.asset("Assets/Images/attachment-green.png",height: 16,width: 16,),
              ):Container(),
              widget.alarm? Padding(
                padding: const EdgeInsets.only(right: 11.6),
                child: Image.asset("Assets/Images/alarm.png",height: 16,width: 16,),
              ):Container(),*/

                /*  expandFlag
                    ? Container()
                    : MyText(value:
                        widget.type,
                        style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorConstant.textColor),
                      ), */
                SizedBox(
                  width: 12,
                ),
                widget.dropdownValue
                    ? Expanded(
                        flex: 1,
                        child: Visibility(
                            visible: widget.visibilite,
                            child: Image.asset(
                              widget.addBlockPhysician[widget.index]
                                  ? "Assets/Images/arrow-up-gray.png"
                                  : "Assets/Images/arrow-down-gray.png",
                              height: 8,
                              width: 13.18,
                            )))
                    : Container(),
              ],
            ),
            widget.addBlockPhysician[widget.index]
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          MyText(
                              value: "editprofil_medical_label_type".tr(),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant.textColor),
                          SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: MyTextField(
                              inputType: TextInputType.multiline,
//                                  textAlign: TextAlign.start,

                              focusNode: null,
                              editTextBgColor: ColorConstant.textfieldColor,
                              hintTextColor: Colors.white54,
                              title: 'editprofil_medical_label_speciality'.tr(),
                              initialValue: widget.physicianContact.speciality,

                              // maxline: 5,
                              // textController: null,
                              onChanged: (value) {
                                widget.update = true;

                                widget.physicianContact.speciality = value;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 28,
                          ),
                        ],
                      ),
                      //
                      SizedBox(
                        height: 22,
                      ),
                      MyText(
                          value: "editprofil_medical_label_contactvia".tr(),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorConstant.textColor),

                      SizedBox(
                        height: 11,
                      ),
                      widget.physicianContact != null
                          ? ListView(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              children: [
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
                                          child: MyTextField(
                                            initialValue:
                                                widget.physicianContact.mail,
                                            maxline: 1,
                                            inputType: TextInputType.multiline,
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            hintText:
                                                "editprofil_general_subtitle_primaryemail"
                                                    .tr(),
                                            title:
                                                "editprofil_general_subtitle_primaryemail"
                                                    .tr(),
                                            onChanged: (value) {
                                              setState(() {
                                                widget.update = true;

                                                widget.physicianContact.mail =
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
                                                    activeColor:
                                                        Color(0xff34C759),
                                                    value: false)
                                                : CustomSwitch(
                                                    activeColor:
                                                        Color(0xff34C759),
                                                    value: widget
                                                                .physicianContact
                                                                .allowContactMail ==
                                                            1
                                                        ? true
                                                        : false,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        widget.update = true;

                                                        widget.physicianContact
                                                                .allowContactMail =
                                                            value == true
                                                                ? 1
                                                                : 0;
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
                                            padding: EdgeInsets.only(
                                                left: 2, top: 8.0),
                                            child: MyText(
                                              value: "registration_info_email"
                                                  .tr(),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
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
                                          child: MyTextField(
                                            initialValue:
                                                widget.physicianContact.mail2,
                                            maxline: 1,
                                            inputType: TextInputType.multiline,
                                            editTextBgColor:
                                                ColorConstant.textfieldColor,
                                            title:
                                                "editprofil_general_subtitle_secondaryemail"
                                                    .tr(),
                                            onChanged: (value) {
                                              setState(() {
                                                widget.update = true;

                                                widget.physicianContact.mail2 =
                                                    value;

                                                value == ""
                                                    ? checkerEmail2AlsoContact =
                                                        true
                                                    : checkerEmail2AlsoContact =
                                                        regExpEmail
                                                            .hasMatch(value);
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
                                                    activeColor:
                                                        Color(0xff34C759),
                                                    value: false)
                                                : CustomSwitch(
                                                    activeColor:
                                                        Color(0xff34C759),
                                                    value: widget
                                                                .physicianContact
                                                                .allowContactMail2 ==
                                                            1
                                                        ? true
                                                        : false,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        widget.update = true;

                                                        widget.physicianContact
                                                                .allowContactMail2 =
                                                            value == true
                                                                ? 1
                                                                : 0;
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
                                            padding: EdgeInsets.only(
                                                left: 2, top: 8.0),
                                            child: MyText(
                                              value: "registration_info_email"
                                                  .tr(),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstant.redColor,
                                            ),
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
                                    Container(
                                      child: KeyboardActions(
                                        autoScroll: false,
                                        disableScroll: true,
                                        config: KeyboardActionsConfig(
                                            keyboardActionsPlatform:
                                                KeyboardActionsPlatform.ALL,
                                            actions: [
                                              KeyboardActionsItem(
                                                  focusNode: nbreFocus),
                                            ]),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 11,
                                              child: MyTextField(
                                                initialValue: widget
                                                    .physicianContact.mobile,
                                                maxline: 1,
                                                keyboardType:
                                                    TextInputType.number,
                                                focusNode: nbreFocus,
                                                editTextBgColor: ColorConstant
                                                    .textfieldColor,
                                                hintTextColor: Colors.white54,
                                                title:
                                                    "pets_label_mobilecellnumber"
                                                        .tr(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    widget.update = true;

                                                    widget.physicianContact
                                                        .mobile = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: widget.physicianContact
                                                                .mobile ==
                                                            '' ||
                                                        widget.physicianContact
                                                                .mobile ==
                                                            null
                                                    ? DiseableCustomSwitch(
                                                        activeColor:
                                                            Color(0xff34C759),
                                                        value: false)
                                                    : CustomSwitch(
                                                        activeColor:
                                                            Color(0xff34C759),
                                                        value: widget
                                                                    .physicianContact
                                                                    .allowContactMobile ==
                                                                1
                                                            ? true
                                                            : false,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            widget.update =
                                                                true;

                                                            widget.physicianContact
                                                                    .allowContactMobile =
                                                                value == true
                                                                    ? 1
                                                                    : 0;
                                                          });
                                                        },
                                                      ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.0 ?? 12.5,
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Container(),

                      SizedBox(
                        height: 12,
                      ),

                      SizedBox(
                        height: 12.5,
                      ),
                      //Container(height: 0.45,color: ColorConstant.dividerColor.withOpacity(.30)),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
