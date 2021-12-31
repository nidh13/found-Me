import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/alert_reminder.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popup_menu.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Features/Profile/Presentation/bloc/profile_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/alert_Update_Reminder.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpandableInsuranceList extends StatefulWidget {
  final InsuranceInfo insuranceInfo;
  final List<Documents> documents;
  bool visibileInsurance;
  final bool dropdownValue;
  final Profile profile;
  final int index;
  List<bool> addblockInsurance;
  bool update;
  ExpandableInsuranceList(
      {Key key,
      this.documents,
      this.visibileInsurance,
      this.addblockInsurance,
      this.insuranceInfo,
      this.dropdownValue,
      this.profile,
      this.index,
      this.update});

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableInsuranceList> {
  bool _visiRiminders = false;
  bool _visiAttachments = false;

  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  List<String> docPaths;
  String fileName;
  String path;
  Map<String, String> paths;
  List<String> extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;
  FileType fileType;
  File docFile;
  void _openFileExplorer() async {
    setState(() => isLoadingPath = true);
    try {
      if (isMultiPick) {
        path = null;
        paths = await FilePicker.getMultiFilePath(
            type: fileType != null ? fileType : FileType.any,
            allowedExtensions: extensions);
      } else {
        path = await FilePicker.getFilePath(
            type: fileType != null ? fileType : FileType.any,
            allowedExtensions: extensions);
        docFile = File(path);
        paths = null;
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    }
    if (!mounted) return;
    setState(() {
      isLoadingPath = false;
      fileName = path != null
          ? path.split('/').last
          : paths != null
              ? paths.keys.toString()
              : '...';
      print(fileName);
      widget.profile.parameters.location = 'InsuranceInfo';
      widget.profile.parameters.locationIndex = widget.index;
      widget.profile.parameters.file = docFile;
      dispatchUploadFile(widget.profile);

      Documents document = Documents(public: 0, active: 1);

      setState(() {
        document.data = widget.profile.parameters.fileUrl;

        document.documentName = fileName;
        widget.documents.add(document);
      });

      widget.profile.parameters.fileUrl !=
              'https://pbs.twimg.com/profile_images/774273386134532096/yNOyEVgS_400x400.jpg'
          ? setState(() {
              print('Reloaded');
            })
          : Timer(Duration(seconds: 4), () {
              setState(() {
                print('Timer');
              });
            });
    });
  }

  String url;
  Documents document;
  File imageFile;
  void onClickMenu(MenuItemProvider item) async {
    if (item.type == "camera") {
      PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 20,
        maxWidth: 200,
        maxHeight: 200,
      );
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        widget.profile.parameters.location = 'InsuranceInfo';
        widget.profile.parameters.locationIndex = widget.index;
        widget.profile.parameters.file = imageFile;
        dispatchUploadFile(widget.profile);
        Documents document = Documents(public: 0, active: 1);
        setState(() {
          document.data = widget.profile.parameters.fileUrl;
          widget.documents.add(document);
        });
      }
      widget.profile.parameters.fileUrl !=
              'https://pbs.twimg.com/profile_images/774273386134532096/yNOyEVgS_400x400.jpg'
          ? setState(() {
              print('Reloaded');
            })
          : Timer(Duration(seconds: 4), () {
              setState(() {
                print('Timer');
              });
            });
    } else if (item.type == "gallery") {
      PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 20,
        maxWidth: 200,
        maxHeight: 200,
      );
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        widget.profile.parameters.location = 'InsuranceInfo';
        widget.profile.parameters.locationIndex = widget.index;
        widget.profile.parameters.file = imageFile;
        dispatchUploadFile(widget.profile);
        Documents document = Documents(public: 0, active: 1);
        setState(() {
          document.data = widget.profile.parameters.fileUrl;

          widget.documents.add(document);
        });
      }
      widget.profile.parameters.fileUrl !=
              'https://pbs.twimg.com/profile_images/774273386134532096/yNOyEVgS_400x400.jpg'
          ? setState(() {
              print('Reloaded');
            })
          : Timer(Duration(seconds: 4), () {
              setState(() {
                print('Timer');
              });
            });
    } else {
      _openFileExplorer();
    }
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  void maxColumn() {
    PopupMenu menu = PopupMenu(
        backgroundColor: Colors.white,
        lineColor: ColorConstant.darkGray,
        maxColumn: 3,
        items: [
          MenuItem(
            type: "camera",
            image: Image.asset(
              "Assets/Images/camera-red.png",
              height: 14,
              width: 16.8,
            ),
          ),
          MenuItem(
              type: "gallery",
              image: Image.asset(
                "Assets/Images/gallery-red.png",
                height: 14,
                width: 18.68,
              )),
          MenuItem(
              type: "file",
              image: Image.asset(
                "Assets/Images/attachment-red.png",
                height: 14,
                width: 12.25,
              )),
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    return menu.show(widgetKey: btnKey);
  }

  bool attachment = false;
  bool alarm = false;
  int nbReminderFixe = 5;
  int nbrReminder = 0;
  String convertTime(int time, String mn) {
    if (time > 12) {
      time = time - 12;
      return time.toString() + mn.toString() + " " + "reminders_label_pm".tr();
    } else if (time == 00) {
      time = time + 12;
      return time.toString() + mn.toString() + " " + "reminders_label_am".tr();
    } else if (time == 12) {
      return time.toString() + mn.toString() + " " + "reminders_label_pm".tr();
    } else {
      return time.toString() + mn.toString() + " " + "reminders_label_am".tr();
    }
  }

  static showOverlayUpdate(BuildContext context, Profile profile, int index,
      Reminders reminders) async {
    await Navigator.of(context)
        .push(UpdateDialogueReminder(profile, index, reminders));
  }

  @override
  Widget build(BuildContext context) {
    bool active = widget.insuranceInfo.active == 1 ? true : false;
    PopupMenu.context = context;

    return GestureDetector(
        onTap: () {
          setState(() {
            active
                ? widget.addblockInsurance[widget.index] =
                    !widget.addblockInsurance[widget.index]
                : Container();
          });
        },
        child: Container(
          padding: EdgeInsets.only(top: 12.5, bottom: 12.5),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: widget.addblockInsurance[widget.index]
                          ? Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: MyTextField(
                                initialValue:
                                    widget.insuranceInfo.insuranceCampanyName,
                                inputType: TextInputType.multiline,
//                                  textAlign: TextAlign.start,
                                maxline: 1,
                                focusNode: null,
                                editTextBgColor: ColorConstant.textfieldColor,
                                hintTextColor: Colors.white54,
                                title:' Description',
                                // maxline: 5,
                                textController: null,
                                onChanged: (value) {
                                  widget.update = true;
                                  widget.insuranceInfo.insuranceCampanyName =
                                      value;
                                },
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: MyText(
                                  value:
                                      widget.insuranceInfo.insuranceCampanyName,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: ColorConstant.textColor),
                            )),
                  widget.addblockInsurance[widget.index]
                      ? Container()
                      : active
                          ? widget.insuranceInfo.documents.length != 0
                              ? Visibility(
                                  visible: widget.visibileInsurance,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 6.7),
                                    child: Image.asset(
                                      "Assets/Images/attachment-green.png",
                                      height: 16,
                                      width: 16,
                                    ),
                                  ))
                              : Container()
                          : Container(),
                  widget.addblockInsurance[widget.index]
                      ? Container()
                      : active
                          ? widget.insuranceInfo.reminders.length != 0
                              ? Visibility(
                                  visible: widget.visibileInsurance,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 11.6),
                                    child: Image.asset(
                                      "Assets/Images/alarm.png",
                                      height: 16,
                                      width: 16,
                                    ),
                                  ))
                              : Container()
                          : Container(),
                  widget.addblockInsurance[widget.index]
                      ? Container()
                      : Visibility(
                          visible: widget.visibileInsurance,
                          child: CustomSwitch(
                            activeColor: Color(0xff34C759),
                            value:
                                widget.insuranceInfo.active == 1 ? true : false,
                            onChanged: (value) {
                              setState(() {
                                widget.update = true;

                                widget.insuranceInfo.active =
                                    value == true ? 1 : 0;
                              });
                            },
                          )),
                  SizedBox(
                    width: 12,
                  ),
                  active
                      ? Visibility(
                          visible: widget.visibileInsurance,
                          child: Image.asset(
                            widget.addblockInsurance[widget.index]
                                ? "Assets/Images/arrow-up-gray.png"
                                : "Assets/Images/arrow-down-gray.png",
                            height: 8,
                            width: 13.18,
                          ))
                      : Container(),
                ],
              ),
              widget.addblockInsurance[widget.index]
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 12.5,
                        ),
                        Container(
                            height: 0.45,
                            color: ColorConstant.dividerColor.withOpacity(.30)),
                        SizedBox(
                          height: 12.5,
                        ),
                        Container(
                          height: 119,
                          padding: EdgeInsets.fromLTRB(10, 9, 11, 9),
                          decoration: BoxDecoration(
                            color: ColorConstant.textfieldColor,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset:
                                    Offset(0, 0), // changes position of shadow
                              ),
                            ],
                          ),
                          child: MyTextField(
                            initialValue:
                                widget.insuranceInfo.additionalInformations,
                            inputType: TextInputType.text,
                            editTextBgColor: ColorConstant.textfieldColor,
                            hintTextColor: Colors.white54,
                            title: 'Notes',
                            onChanged: (value) {
                              widget.update = true;

                              widget.insuranceInfo.additionalInformations =
                                  value;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 22,
                        ),
                        Row(
                          children: [
                            MyText(
                                value:
                                    "editprofil_medical_label_attachment".tr(),
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: ColorConstant.textColor),
                            SizedBox(
                              width: 26,
                            ),
                            Image.asset(
                              "Assets/Images/info.png",
                              height: 14,
                              width: 14,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 11,
                        ),
                        widget.insuranceInfo.documents != null
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    widget.insuranceInfo.documents.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  bool public = widget.insuranceInfo
                                              .documents[index].public ==
                                          1
                                      ? true
                                      : false;
                                  return new Container(
                                    height: 48,
                                    padding: const EdgeInsets.only(bottom: 6.0),
                                    // padding: EdgeInsets.zero,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        widget.insuranceInfo.documents[index]
                                                    .data !=
                                                null
                                            ? widget.insuranceInfo
                                                        .documents[index].data
                                                        .contains(
                                                      '.pdf',
                                                    ) ==
                                                    false
                                                ? InkWell(
                                                    onTap: () async {
                                                      url = widget
                                                          .insuranceInfo
                                                          .documents[index]
                                                          .data;
                                                      if (await canLaunch(
                                                          url)) {
                                                        await launch(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
                                                    child: Container(
                                                      height: 42,
                                                      width: 42,
                                                      decoration: BoxDecoration(
                                                          color: ColorConstant
                                                              .imgBackgroundColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  widget
                                                                      .insuranceInfo
                                                                      .documents[
                                                                          index]
                                                                      .data),
                                                              fit: BoxFit
                                                                  .cover)),
                                                    ),
                                                  )
                                                : InkWell(
                                                    onTap: () async {
                                                      url = widget
                                                          .insuranceInfo
                                                          .documents[index]
                                                          .data;
                                                      if (await canLaunch(
                                                          url)) {
                                                        await launch(url);
                                                      } else {
                                                        throw 'Could not launch $url';
                                                      }
                                                    },
                                                    child: Container(
                                                        height: 42,
                                                        width: 42,
                                                        decoration: BoxDecoration(
                                                            color: ColorConstant
                                                                .imgBackgroundColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            5)),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    'https://nlmt.fr/wp-content/uploads/2016/11/fichier.png'),
                                                                fit: BoxFit
                                                                    .cover))),
                                                  )
                                            : Container(),
                                        SizedBox(
                                          width: 13,
                                        ),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: widget
                                                              .insuranceInfo
                                                              .documents[index]
                                                              .documentName !=
                                                          null
                                                      ? MyText(
                                                          value: widget
                                                              .insuranceInfo
                                                              .documents[index]
                                                              .documentName,
                                                          fontSize: 12,
                                                          color: ColorConstant
                                                              .textColor,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          maxLines: 1,
                                                          textAlign:
                                                              TextAlign.start,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      : Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            right: 12.0,
                                                          ),
                                                          child: MyTextField(
                                                            initialValue: '',
                                                            maxline: 1,
                                                            editTextBgColor:
                                                                ColorConstant
                                                                    .textfieldColor,
                                                            hintTextColor:
                                                                Colors.white54,
                                                            title: '',
                                                            onChanged: (value) {
                                                              widget.update =
                                                                  true;

                                                              widget
                                                                  .insuranceInfo
                                                                  .documents[
                                                                      index]
                                                                  .documentName = value;
                                                            },
                                                          ),
                                                        ),
                                                ),
                                                public
                                                    ? _visiAttachments != null
                                                        ? Visibility(
                                                            visible:
                                                                !_visiAttachments,
                                                            child: Image.asset(
                                                              "Assets/Images/eye-green.png",
                                                              height: 12,
                                                              width: 17.85,
                                                            ))
                                                        : Container()
                                                    : _visiAttachments != null
                                                        ? Visibility(
                                                            visible:
                                                                !_visiAttachments,
                                                            child: Image.asset(
                                                              "Assets/Images/eye-close.png",
                                                              height: 16,
                                                              width: 20,
                                                            ))
                                                        : Container(),
                                                SizedBox(
                                                  width: 13,
                                                ),
                                                _visiAttachments != null
                                                    ? Visibility(
                                                        visible:
                                                            !_visiAttachments,
                                                        child: CustomSwitch(
                                                          activeColor:
                                                              Color(0xff34C759),
                                                          value: public,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              widget
                                                                  .insuranceInfo
                                                                  .documents[
                                                                      index]
                                                                  .public = value ==
                                                                      true
                                                                  ? 1
                                                                  : 0;
                                                            });
                                                          },
                                                        ),
                                                      )
                                                    : Container(),
                                                _visiAttachments != null
                                                    ? Visibility(
                                                        visible:
                                                            _visiAttachments,
                                                        child: Material(
                                                            // pause button (round)
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50), // change radius size
                                                            color: Colors
                                                                .red, //button colour
                                                            child: InkWell(
                                                                splashColor: Colors
                                                                    .red, // inkwell onPress colour
                                                                child: SizedBox(
                                                                    width: 24,
                                                                    height:
                                                                        24, //customisable size of 'button'
                                                                    child: Center(
                                                                        child: FaIcon(
                                                                      FontAwesomeIcons
                                                                          .minus,
                                                                      color: Colors
                                                                          .white,
                                                                      size: 16,
                                                                    ))
                                                                    /*Icon(Icons.delete, )*/
                                                                    ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    widget.update =
                                                                        true;

                                                                    widget
                                                                        .insuranceInfo
                                                                        .documents
                                                                        .removeAt(
                                                                            index);
                                                                  });
                                                                })))
                                                    : Container(),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                //Container(height: 10,width: 10,color: Colors.red,)
                                                _visiAttachments != null
                                                    ? Visibility(
                                                        visible:
                                                            !_visiAttachments,
                                                        child: MyText(
                                                            value: public
                                                                ? "objecttag_label_public"
                                                                    .tr()
                                                                : "objecttag_label_private"
                                                                    .tr(),
                                                            fontSize: 7,
                                                            color: ColorConstant
                                                                .switchTextColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      )
                                                    : Container(),
                                                SizedBox(
                                                  width: 11,
                                                )
                                              ],
                                            )
                                          ],
                                        )),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Container(),
                        /*  MyText(value:widget.attachments[0].public.toString()),*/
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12.5),
                          child: Container(
                              height: 0.45,
                              color:
                                  ColorConstant.dividerColor.withOpacity(.30)),
                        ),
                        widget.insuranceInfo.documents.length == 0
                            ? Row(children: <Widget>[
                                Expanded(
                                  flex: 12,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ButtonTheme(
                                        height: 36.0,
                                        minWidth: 333.5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: RaisedButton(
                                          key: btnKey,
                                          disabledColor: Colors.grey,
                                          disabledTextColor: Colors.white,
                                          color: Colors.white,
                                          textColor: Color(0xffEC1C40),
                                          child: MyText(
                                              value: '+ ' +
                                                  "pets_label_addattachments"
                                                      .tr(),
                                              color: ColorConstant.primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          onPressed: maxColumn,
                                        )),
                                  ),
                                ),
                              ])
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: !_visiAttachments,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTheme(
                                            height: 36.0,
                                            minWidth: 133.5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: RaisedButton(
                                              key: btnKey,
                                              disabledColor: Colors.grey,
                                              disabledTextColor: Colors.white,
                                              color: Colors.white,
                                              textColor: Color(0xffEC1C40),
                                              child: MyText(
                                                  value:
                                                      'editprofil_general_btn_addnew'
                                                          .tr(),
                                                  color: ColorConstant
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500),
                                              onPressed: maxColumn,
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                      visible: !_visiAttachments,
                                      child: Expanded(
                                          flex: 5,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: MyButton(
                                              title:
                                                  'editprofil_general_btn_delete'
                                                      .tr(),
                                              height: 36.0,
                                              titleSize: 14,
                                              fontWeight: FontWeight.w500,
                                              titleColor: Color(0xffEC1C40),
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _visiAttachments =
                                                      !_visiAttachments;
                                                });
                                              },
                                            ),
                                          ))),
                                  Visibility(
                                    visible: _visiAttachments,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTheme(
                                            height: 36.0,
                                            minWidth: 280.5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: RaisedButton(
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.white,
                                                color: Colors.white,
                                                textColor: Color(0xffEC1C40),
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiAttachments =
                                                        !_visiAttachments;
                                                  });
                                                })),
                                        /* child: MyButton(
                            title: 'addnew',
                            height: 36.0,
                            titleSize: 14,
                            fontWeight: FontWeight.w500,
                            titleColor: Color(0xffEC1C40),
                            miniWidth: 133.5,
                            btnBgColor: Colors.white,
                            onPressed: () => {},
                          ),*/
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                        SizedBox(
                          height: 29,
                        ),
                        MyText(
                            value: "editprofil_medical_label_reminders".tr(),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: ColorConstant.textColor),
                        SizedBox(
                          height: 11,
                        ),
                        widget.insuranceInfo.reminders != null
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount:
                                    widget.insuranceInfo.reminders.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                    onTap: () async {
                                      await showOverlayUpdate(
                                          context,
                                          widget.profile,
                                          widget.index,
                                          widget
                                              .insuranceInfo.reminders[index]);
                                      setState(() {});
                                    },
                                    child: new Container(
                                      height: 67,
                                      padding:
                                          EdgeInsets.fromLTRB(12, 6, 10, 0),
                                      margin: EdgeInsets.only(bottom: 12),
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 2,
                                            offset: Offset(0,
                                                0), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Flexible(
                                                  child: MyText(
                                                    value: widget
                                                        .insuranceInfo
                                                        .reminders[index]
                                                        .reminderLabel,
                                                    fontSize: 9,
                                                    color: ColorConstant
                                                        .boldTextColor,
                                                    fontWeight: FontWeight.w600,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 2,
                                                ),
                                                widget
                                                            .insuranceInfo
                                                            .reminders[index]
                                                            .reminderDate !=
                                                        null
                                                    ? MyText(
                                                        value: widget
                                                                .insuranceInfo
                                                                .reminders[
                                                                    index]
                                                                .reminderDate
                                                                .substring(
                                                                    8, 12) +
                                                            " " +
                                                            widget
                                                                .insuranceInfo
                                                                .reminders[
                                                                    index]
                                                                .reminderDate
                                                                .substring(
                                                                    5, 7) +
                                                            " " +
                                                            widget
                                                                .insuranceInfo
                                                                .reminders[index]
                                                                .reminderDate
                                                                .substring(12, 16),
                                                        fontSize: 18,
                                                        color: ColorConstant.pinkColor,
                                                        fontWeight: FontWeight.w600)
                                                    : MyText(value: "--- -- ----", fontSize: 18, color: ColorConstant.pinkColor, fontWeight: FontWeight.w600),
                                                SizedBox(
                                                  height: 1,
                                                ),
                                                Row(
                                                  children: [
                                                    widget
                                                                .insuranceInfo
                                                                .reminders[
                                                                    index]
                                                                .reminderDate !=
                                                            null
                                                        ? MyText(
                                                            value: convertTime(
                                                              int.parse(widget
                                                                  .insuranceInfo
                                                                  .reminders[
                                                                      index]
                                                                  .reminderDate
                                                                  .substring(
                                                                      17, 19)),
                                                              widget
                                                                  .insuranceInfo
                                                                  .reminders[
                                                                      index]
                                                                  .reminderDate
                                                                  .substring(
                                                                      19, 22),
                                                            ),
                                                            fontSize: 12,
                                                            color: ColorConstant
                                                                .boldSmallTextColor,
                                                            fontWeight:
                                                                FontWeight.w500)
                                                        : MyText(
                                                            value: '--:--',
                                                            fontSize: 12,
                                                            color: ColorConstant
                                                                .boldSmallTextColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                    SizedBox(
                                                      width: 13.9,
                                                    ),
                                                    Image.asset(
                                                      "Assets/Images/repeat.png",
                                                      height: 10.19,
                                                      width: 8.34,
                                                    ),
                                                    SizedBox(
                                                      width: 3.8,
                                                    ),
                                                    Flexible(
                                                      child: MyText(
                                                          value: widget
                                                              .insuranceInfo
                                                              .reminders[index]
                                                              .reminderDescription,
                                                          fontSize: 12,
                                                          color: ColorConstant
                                                              .boldSmallTextColor,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: !_visiRiminders,
                                            child: CustomSwitch(
                                              activeColor: Color(0xff34C759),
                                              value: widget
                                                          .insuranceInfo
                                                          .reminders[index]
                                                          .active ==
                                                      1
                                                  ? true
                                                  : false,
                                              onChanged: (value) {
                                                widget.update = true;

                                                setState(() {
                                                  widget
                                                          .insuranceInfo
                                                          .reminders[index]
                                                          .active =
                                                      value == true ? 1 : 0;
                                                });
                                              },
                                            ),
                                          ),
                                          Visibility(
                                              visible: _visiRiminders,
                                              child: Material(
                                                  // pause button (round)
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50), // change radius size
                                                  color: Colors
                                                      .red, //button colour
                                                  child: InkWell(
                                                      splashColor: Colors
                                                          .red, // inkwell onPress colour
                                                      child: SizedBox(
                                                          width: 24,
                                                          height:
                                                              24, //customisable size of 'button'
                                                          child: Center(
                                                              child: FaIcon(
                                                            FontAwesomeIcons
                                                                .minus,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ))
                                                          /*Icon(Icons.delete, )*/
                                                          ),
                                                      onTap: () {
                                                        setState(() {
                                                          widget.update = true;

                                                          nbrReminder--;
                                                          widget.insuranceInfo
                                                              .reminders
                                                              .removeAt(index);
                                                          if (widget
                                                                  .insuranceInfo
                                                                  .reminders
                                                                  .length ==
                                                              0) {
                                                            _visiRiminders =
                                                                !_visiRiminders;
                                                          }
                                                        });
                                                      }))),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(),
                        widget.insuranceInfo.reminders.length == 0
                            ? Row(children: <Widget>[
                                Expanded(
                                  flex: 12,
                                  child: Align(
                                    alignment: Alignment.bottomCenter,
                                    child: ButtonTheme(
                                        height: 36.0,
                                        minWidth: 333.5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: RaisedButton(
                                          disabledColor: Colors.grey,
                                          disabledTextColor: Colors.white,
                                          color: Colors.white,
                                          textColor: Color(0xffEC1C40),
                                          child: MyText(
                                              value: '+ ' +
                                                  "pets_label_addreminders"
                                                      .tr(),
                                              color: ColorConstant.primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                          onPressed: () async {
                                            await showOverlay(
                                                context,
                                                widget.profile,
                                                widget.index,
                                                widget.index,
                                                widget.insuranceInfo.reminders);
                                            setState(() {
                                              nbrReminder = widget.insuranceInfo
                                                  .reminders.length;
                                            });
                                          },
                                        )),
                                  ),
                                ),
                              ])
                            : Row(
                                children: <Widget>[
                                  Visibility(
                                    visible: !_visiRiminders,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTheme(
                                            height: 36.0,
                                            minWidth: 133.5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: RaisedButton(
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.white,
                                                color: Colors.white,
                                                textColor: Color(0xffEC1C40),
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_addnew'
                                                            .tr(),
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                onPressed:
                                                    nbrReminder < nbReminderFixe
                                                        ? () async {
                                                            await showOverlay(
                                                                context,
                                                                widget.profile,
                                                                widget.index,
                                                                widget.index,
                                                                widget
                                                                    .insuranceInfo
                                                                    .reminders);
                                                            setState(() {
                                                              nbrReminder = widget
                                                                  .insuranceInfo
                                                                  .reminders
                                                                  .length;
                                                            });
                                                          }
                                                        : null)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                      visible: !_visiRiminders,
                                      child: Expanded(
                                          flex: 5,
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: MyButton(
                                              title:
                                                  'editprofil_general_btn_delete'
                                                      .tr(),
                                              height: 36.0,
                                              titleSize: 14,
                                              fontWeight: FontWeight.w500,
                                              titleColor: Color(0xffEC1C40),
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _visiRiminders =
                                                      !_visiRiminders;
                                                });
                                              },
                                            ),
                                          ))),
                                  Visibility(
                                    visible: _visiRiminders,
                                    child: Expanded(
                                      flex: 5,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: ButtonTheme(
                                            height: 36.0,
                                            minWidth: 280.5,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: RaisedButton(
                                                disabledColor: Colors.grey,
                                                disabledTextColor: Colors.white,
                                                color: Colors.white,
                                                textColor: Color(0xffEC1C40),
                                                child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                                onPressed: () {
                                                  setState(() {
                                                    _visiRiminders =
                                                        !_visiRiminders;
                                                  });
                                                })),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ));
  }

  static showOverlay(BuildContext context, Profile profile, int index,
      int indexSubUser, List reminderList) async {
    await Navigator.of(context).push(
        AlertDialogueReminder(profile, index, indexSubUser, reminderList));
  }

  void dispatchUploadFile(Profile profile) {
    BlocProvider.of<ProfileBloc>(context).dispatch(
      UploadFileEvent(
        profile: profile,
      ),
    );
  }
}
