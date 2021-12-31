import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popup_menu.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/cupertino_Time.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/customCalendar.dart';
import 'package:neopolis/Features/Users/Presentation/bloc/users_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/alert_Update_Reminder.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpandableMisclaneousList extends StatefulWidget {
  final Profile profile;
  final int index;
  final Miscilanious miscilanious;
  final bool attachment;
  final bool alarm;
  final TextEditingController text;
  bool switchValue;
  List<bool> addBlockMisc;
  final bool dropdownValue;
  bool visibilite;
  int indexSubUser;
  ExpandableMisclaneousList(
      {Key key,
      this.profile,
      this.index,
      this.addBlockMisc,
      this.indexSubUser,
      this.miscilanious,
      this.attachment,
      this.alarm,
      this.text,
      this.switchValue,
      this.dropdownValue,
      this.visibilite});

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableMisclaneousList> {
  List attachment = [];
  bool _visiAttachments = false;
  bool _visiRiminders = false;
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  int nbrReminder = 0;
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
      widget.profile.parameters.location = 'miscilanious';
      widget.profile.parameters.locationIndex = widget.index;
      widget.profile.parameters.file = docFile;

      dispatchUploadFile(widget.profile, widget.indexSubUser);

      Documents document = Documents(public: 0, active: 1);

      setState(() {
        document.data = widget.profile.parameters.fileUrl;

        document.documentName = fileName;
        widget.miscilanious.documents.add(document);
      });

      widget.profile.parameters.fileUrl !=
              'https://pbs.twimg.com/profile_images/774273386134532096/yNOyEVgS_400x400.jpg'
          ? setState(() {
              print('Reloaded');
            })
          : Timer(Duration(seconds: 2), () {
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
        widget.profile.parameters.location = 'miscilanious';
        widget.profile.parameters.locationIndex = widget.index;
        widget.profile.parameters.file = imageFile;
        dispatchUploadFile(widget.profile, widget.indexSubUser);
        Documents document = Documents(public: 0, active: 1);
        setState(() {
          document.data = widget.profile.parameters.fileUrl;
          widget.miscilanious.documents.add(document);
        });
      }
      widget.profile.parameters.fileUrl !=
              'https://pbs.twimg.com/profile_images/774273386134532096/yNOyEVgS_400x400.jpg'
          ? setState(() {
              print('Reloaded');
            })
          : Timer(Duration(seconds: 2), () {
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
        widget.profile.parameters.location = 'miscilanious';
        widget.profile.parameters.locationIndex = widget.index;
        widget.profile.parameters.file = imageFile;
        dispatchUploadFile(widget.profile, widget.indexSubUser);
        Documents document = Documents(public: 0, active: 1);
        setState(() {
          document.data = widget.profile.parameters.fileUrl;
          widget.miscilanious.documents.add(document);
        });
      }
      widget.profile.parameters.fileUrl !=
              'https://pbs.twimg.com/profile_images/774273386134532096/yNOyEVgS_400x400.jpg'
          ? setState(() {
              print('Reloaded');
            })
          : Timer(Duration(seconds: 2), () {
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

  int nbReminderFixe = 5;
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

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    bool public = widget.miscilanious.allow == 1 ? true : false;
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.switchValue
              ? widget.addBlockMisc[widget.index] =
                  !widget.addBlockMisc[widget.index]
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
                  child: widget.addBlockMisc[widget.index]
                      ? Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: MyTextField(
                            initialValue: widget.miscilanious.label,
                            inputType: TextInputType.multiline,
                            focusNode: null,
                            editTextBgColor: ColorConstant.textfieldColor,
                            hintTextColor: Colors.white54,
                            title: 'Description',
                            onChanged: (value) {
                              widget.miscilanious.label = value;
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: MyText(
                              value: widget.miscilanious.label,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant.textColor),
                        ),
                ),
                SizedBox(
                  width: 10,
                ),
                !widget.visibilite
                    ? SizedBox(
                        width: 20,
                      )
                    : SizedBox(
                        width: 1,
                      ),
                widget.visibilite
                    ? public
                        ? Image.asset(
                            "Assets/Images/eye-green.png",
                            height: 12,
                            width: 17.85,
                          )
                        : Image.asset(
                            "Assets/Images/eye-close.png",
                            height: 16,
                            width: 20,
                          )
                    : Container(),
                SizedBox(
                  width: 5.8,
                ),
                widget.visibilite
                    ? Column(
                        children: [
                          CustomSwitch(
                            activeColor: Color(0xff34C759),
                            value: public,
                            onChanged: (value) {
                              setState(() {
                                widget.miscilanious.allow =
                                    value == true ? 1 : 0;
                              });
                            },
                          ),
                          MyText(
                              value: public
                                  ? "objecttag_label_public".tr()
                                  : "objecttag_label_private".tr(),
                              fontSize: 7,
                              color: ColorConstant.switchTextColor,
                              fontWeight: FontWeight.w400)
                        ],
                      )
                    : Container(),
                widget.visibilite
                    ? public
                        ? Container(
                            padding: EdgeInsets.only(left: 11),
                            child: Image.asset(
                              widget.addBlockMisc[widget.index]
                                  ? "Assets/Images/arrow-up-gray.png"
                                  : "Assets/Images/arrow-down-gray.png",
                              height: 8,
                              width: 13.18,
                            ),
                          )
                        : Container()
                    : Container(),
              ],
            ),
            widget.switchValue
                ? widget.addBlockMisc[widget.index]
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 12.5,
                          ),
                          Container(
                              height: 0.45,
                              color:
                                  ColorConstant.dividerColor.withOpacity(.30)),
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
                                  offset: Offset(
                                      0, 0), // changes position of shadow
                                ),
                              ],
                            ),
                            child: MyTextField(
                              initialValue: widget.miscilanious.description,
                              inputType: TextInputType.multiline,
                              editTextBgColor: ColorConstant.textfieldColor,
                              hintTextColor: Colors.white54,
                              title: 'Notes',
                              onChanged: (value) {
                                widget.miscilanious.description = value;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Row(
                            children: [
                              MyText(
                                  value: "editprofil_medical_label_attachment"
                                      .tr(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
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
                            height: 16,
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.miscilanious.documents.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              bool public =
                                  widget.miscilanious.documents[index].public ==
                                          1
                                      ? true
                                      : false;

                              return new Container(
                                height: 48,
                                padding: const EdgeInsets.only(bottom: 6.0),
                                // padding: EdgeInsets.zero,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.miscilanious.documents[index].data !=
                                            null
                                        ? widget.miscilanious.documents[index]
                                                    .data
                                                    .contains(
                                                  '.pdf',
                                                ) ==
                                                false
                                            ? InkWell(
                                                onTap: () async {
                                                  url = widget.miscilanious
                                                      .documents[index].data;
                                                  if (await canLaunch(url)) {
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
                                                              Radius.circular(
                                                                  5)),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              widget
                                                                  .miscilanious
                                                                  .documents[
                                                                      index]
                                                                  .data),
                                                          fit: BoxFit.cover)),
                                                ),
                                              )
                                            : InkWell(
                                                onTap: () async {
                                                  url = widget.miscilanious
                                                      .documents[index].data;
                                                  if (await canLaunch(url)) {
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
                                                                Radius.circular(
                                                                    5)),
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                'https://nlmt.fr/wp-content/uploads/2016/11/fichier.png'),
                                                            fit:
                                                                BoxFit.cover))),
                                              )
                                        : Container(),
                                    SizedBox(
                                      width: 13,
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: widget
                                                          .miscilanious
                                                          .documents[index]
                                                          .documentName !=
                                                      null
                                                  ? MyText(
                                                      value: widget
                                                          .miscilanious
                                                          .documents[index]
                                                          .documentName,
                                                      fontSize: 12,
                                                      color: ColorConstant
                                                          .textColor,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      softWrap: true,
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )
                                                  : Padding(
                                                      padding: EdgeInsets.only(
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
                                                          widget
                                                              .miscilanious
                                                              .documents[index]
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
                                                        visible: public,
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
                                                    visible: !_visiAttachments,
                                                    child: CustomSwitch(
                                                      activeColor:
                                                          Color(0xff34C759),
                                                      value: public,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          print(widget
                                                              .miscilanious
                                                              .documents[index]
                                                              .public);
                                                          widget
                                                              .miscilanious
                                                              .documents[index]
                                                              .public = value ==
                                                                  true
                                                              ? 1
                                                              : 0;
                                                          print(widget
                                                              .miscilanious
                                                              .documents[index]
                                                              .public);
                                                        });
                                                      },
                                                    ),
                                                  )
                                                : Container(),
                                            _visiAttachments != null
                                                ? Visibility(
                                                    visible: _visiAttachments,
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
                                                                    child:
                                                                        FaIcon(
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
                                                                widget
                                                                    .miscilanious
                                                                    .documents
                                                                    .removeAt(
                                                                        index);
                                                                print(
                                                                    "value of visible ");
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
                                                    visible: !_visiAttachments,
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
                                                            FontWeight.w400),
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
                          ),
                          attachment.length == 0
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.only(bottom: 12.5),
                                  child: Container(
                                      height: 0.45,
                                      color: ColorConstant.dividerColor
                                          .withOpacity(.30)),
                                ),
                          widget.miscilanious.documents.length == 0
                              ? Container(
                                  key: btnKey,
                                  child: MyButton(
                                    title: "editprofil_general_btn_addnew".tr(),
                                    height: 36.0,
                                    titleSize: 14,
                                    fontWeight: FontWeight.w500,
                                    titleColor: ColorConstant.primaryColor,
                                    btnBgColor: Colors.white,
                                    onPressed: maxColumn,
                                  ),
                                )
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
                                                child: MyText(
                                                  value:
                                                      "editprofil_general_btn_addnew"
                                                          .tr(),
                                                  color: ColorConstant
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
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
                                                    "editprofil_general_btn_delete"
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
                                                  disabledTextColor:
                                                      Colors.white,
                                                  color: Colors.white,
                                                  child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    color:
                                                        ColorConstant.pinkColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
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
                            height: 22,
                          ),
                          Row(
                            children: [
                              MyText(
                                  value:
                                      "editprofil_medical_label_reminders".tr(),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
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
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.miscilanious.reminders.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              nbrReminder =
                                  widget.miscilanious.reminders.length;
                              return new GestureDetector(
                                  onTap: () async {
                                    await showOverlayUpdate(
                                        context,
                                        widget.profile,
                                        widget.index,
                                        widget.miscilanious.reminders[index]);
                                    setState(() {});
                                  },
                                  child: Container(
                                    height: 67,
                                    padding: EdgeInsets.fromLTRB(12, 6, 10, 0),
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
                                                        .miscilanious
                                                        .reminders[index]
                                                        .reminderLabel,
                                                    softWrap: true,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    fontSize: 9,
                                                    color: ColorConstant
                                                        .boldTextColor,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              widget.miscilanious.reminders[index].reminderDate !=
                                                      null
                                                  ? MyText(
                                                      value: widget
                                                              .miscilanious
                                                              .reminders[index]
                                                              .reminderDate
                                                              .substring(
                                                                  8, 12) +
                                                          " " +
                                                          widget
                                                              .miscilanious
                                                              .reminders[index]
                                                              .reminderDate
                                                              .substring(5, 7) +
                                                          " " +
                                                          widget
                                                              .miscilanious
                                                              .reminders[index]
                                                              .reminderDate
                                                              .substring(
                                                                  12, 16),
                                                      fontSize: 18,
                                                      color: ColorConstant
                                                          .pinkColor,
                                                      fontWeight:
                                                          FontWeight.w600)
                                                  : MyText(
                                                      value: "--- -- ----",
                                                      fontSize: 18,
                                                      color: ColorConstant.pinkColor,
                                                      fontWeight: FontWeight.w600),
                                              SizedBox(
                                                height: 1,
                                              ),
                                              Row(
                                                children: [
                                                  widget
                                                              .miscilanious
                                                              .reminders[index]
                                                              .reminderDate !=
                                                          null
                                                      ? MyText(
                                                          value: convertTime(
                                                            int.parse(widget
                                                                .miscilanious
                                                                .reminders[
                                                                    index]
                                                                .reminderDate
                                                                .substring(
                                                                    17, 19)),
                                                            widget
                                                                .miscilanious
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
                                                              FontWeight.w500),
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
                                                            .miscilanious
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
                                                        .miscilanious
                                                        .reminders[index]
                                                        .active ==
                                                    1
                                                ? true
                                                : false,
                                            onChanged: (value) {
                                              print("VALUE : " +
                                                  widget.miscilanious
                                                      .reminders[index].active
                                                      .toString());
                                              setState(() {
                                                widget
                                                        .miscilanious
                                                        .reminders[index]
                                                        .active =
                                                    value == true ? 1 : 0;
                                              });
                                              print("VALUE : " +
                                                  widget.miscilanious
                                                      .reminders[index].active
                                                      .toString());
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
                                                color:
                                                    Colors.red, //button colour
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
                                                        nbrReminder--;
                                                        _visiRiminders =
                                                            !_visiRiminders;

                                                        widget.miscilanious
                                                            .reminders
                                                            .removeAt(index);
                                                        print(
                                                            "value of visible ");
                                                      });
                                                    }))),
                                      ],
                                    ),
                                  ));
                            },
                          ),
                          widget.miscilanious.reminders.length == 0
                              ? MyButton(
                                  title: "editprofil_general_btn_addnew".tr(),
                                  height: 36.0,
                                  titleSize: 14,
                                  fontWeight: FontWeight.w500,
                                  titleColor: ColorConstant.primaryColor,
                                  btnBgColor: Colors.white,
                                  onPressed: nbrReminder < nbReminderFixe
                                      ? () async {
                                          //  widget.miscilanious.reminders.add(value);

                                          await showOverlay(
                                              context,
                                              widget.profile,
                                              widget.index,
                                              widget.indexSubUser,
                                              widget.miscilanious.reminders);

                                          setState(() {
                                            nbrReminder = widget
                                                .miscilanious.reminders.length;
                                          });
                                        }
                                      : null,
                                )
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
                                                child: MyText(
                                                  value:
                                                      "editprofil_general_btn_addnew"
                                                          .tr(),
                                                  color: ColorConstant
                                                      .primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                                onPressed: nbrReminder <
                                                        nbReminderFixe
                                                    ? () async {
                                                        await showOverlay(
                                                            context,
                                                            widget.profile,
                                                            widget.index,
                                                            widget.indexSubUser,
                                                            widget.miscilanious
                                                                .reminders);

                                                        setState(() {
                                                          nbrReminder = widget
                                                              .miscilanious
                                                              .reminders
                                                              .length;
                                                          print(nbrReminder);
                                                        });
                                                      }
                                                    : null,
                                              )),
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
                                                    "editprofil_general_btn_delete"
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
                                                  disabledTextColor:
                                                      Colors.white,
                                                  color: Colors.white,
                                                  child: MyText(
                                                    value:
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    color:
                                                        ColorConstant.pinkColor,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      _visiRiminders =
                                                          !_visiRiminders;
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
                            height: 9.5,
                          ),
                        ],
                      )
                    : Container()
                : Container(),
          ],
        ),
      ),
    );
  }

  static showOverlay(BuildContext context, Profile profile, int index,
      int indexSubUser, List reminderList) async {
    await Navigator.of(context).push(
        AlertDialogueReminder(profile, index, indexSubUser, reminderList));
  }

  static showOverlayUpdate(BuildContext context, Profile profile, int index,
      Reminders reminders) async {
    await Navigator.of(context)
        .push(UpdateDialogueReminder(profile, index, reminders));
  }

  void dispatchUploadFile(Profile profile, int index) {
    BlocProvider.of<UsersBloc>(context).dispatch(
      UploadFileEvent(profile: profile, index: index),
    );
  }
}

class AlertDialogueReminder extends ModalRoute {
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
  Reminders reminders;
  int index;
  int indexSubUser;
  Profile profile;
  List reminderList;
  AlertDialogueReminder(
      Profile profile, int index, int indexSubUser, List reminderList) {
    this.reminders = reminders;
    this.profile = profile;
    this.index = index;
    this.indexSubUser = indexSubUser;
    this.reminderList = reminderList;
  }

  DateTime _time = DateTime.now();
  bool _clicked = false;
  int _selectTime(int hr, int ampm) {
    if (ampm == 1) {
      if (hr != 12) {
        hr = hr + 12;
      }
      return hr;
    } else if (hr == 12) {
      hr = 00;
      return hr;
    } else {
      return 0 + hr;
    }
  }

  TextEditingController nameController;
  TextEditingController dosageController;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  //NewEntryBloc _newEntryBloc;
  FixedExtentScrollController scrollRecurringController;
  int _hourColorIndex = 0;
  int selectedHour = 1;
  int selectedYear;
  int selectedMonth;
  int selectedDay;

  double itemExtent = 45.0;
  FixedExtentScrollController scrollHourController;
  FixedExtentScrollController scrollMinuteController;
  FixedExtentScrollController scrollAmPmController;

  int _minuteColorIndex = 10;
  int selectedMinute = 00;

  int _amPmColorIndex = 1;
  int amPm = 0;

  int _recurringColorIndex = 2;
  double height = 230;
// List<String> date =["1","2","3"];
  static List<String> hour = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12"
  ];
  static List<String> minute = [
    "00",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49",
    "50",
    "51",
    "52",
    "53",
    "54",
    "55",
    "56",
    "57",
    "58",
    "59"
  ];

  var _newEntryBloc;

  int recurring = 0;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Reminders reminder = new Reminders(
      active: 1,
      id: null,
      reminderDate: "Fri, " +
          DateTime.now().day.toString() +
          ' ' +
          DateFormat.MMMM().format(DateTime.now()).toString().substring(0, 3) +
          ' ' +
          DateTime.now().year.toString() +
          " 00:00:00 GMT",
      reminderDescription: "reminders_label_houly".tr(),
      reminderLabel: '',
      rappelId: 1,
      rappelReminder: "reminders_label_houly".tr());
  Widget _buildOverlayContent(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return Container(
        height: screenHeight * 1.0,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                width: screenWidth * 0.99,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 128,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          gradient: LinearGradient(
                              colors: [
                                ColorConstant.pinkColor,
                                ColorConstant.gradientOrangeColor
                              ],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              tileMode: TileMode.clamp),
                        ),
                        child: Row(children: <Widget>[
                          // IconButton(
                          //   icon: Image.asset(
                          //     "assets/image/arrow-white-back.png",
                          //     height: 13.5,
                          //     width: 21,
                          //   ),
                          //   onPressed: () {
                          //     Navigator.pop(context, true);
                          //   },
                          // ),
                          Expanded(
                            child: MyText(
                                value: "drawer_label_remindersalarms".tr(),
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ])),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 17, right: 17, top: 14.5),
                        child: MyText(
                          value: "reminders_label_setdesc".tr(),
                          color: ColorConstant.pinkColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: MediaQuery.of(context)
                              .textScaleFactor
                              .clamp(1.0, 1.0),
                        ),
                        child: TextFormField(
                          maxLength: 30,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          controller: nameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                          onChanged: (value) {
                            reminder.reminderLabel = value;
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 17, right: 17, top: 14.5),
                        child: MyText(
                          value: "reminders_label_setdatetime".tr(),
                          color: ColorConstant.pinkColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 34.0),
                      child: CustomCalendar(
                        initialCalendarMode: Mt_DatePickerMode.day,
                        firstDate: new DateTime(DateTime.now().year),
                        lastDate: new DateTime(DateTime.now().year + 5),
                        initialDate: DateTime.now(),
                        onDateChanged: (date) {
                          print("Date ${date.toString()}");
                          setState(() {
                            selectedYear = date.year;
                            selectedMonth = date.month;
                            selectedDay = date.day;
                          });
                          print(date.year); //"Fri, 29 Jan 2020 00:00:00 GMT",
                          print(date.month);
                          DateFormat.MMMM().format(date);
                          print(reminder.reminderDate);
                          print(' date mois ' + DateFormat.MMMM().format(date));
                          reminder.reminderDate = reminder.reminderDate
                              .replaceRange(
                                  8,
                                  11,
                                  DateFormat.MMMM()
                                      .format(date)
                                      .substring(0, 3));

                          reminder.reminderDate = reminder.reminderDate
                              .replaceRange(
                                  5,
                                  7,
                                  date.day.toString().length == 1
                                      ? ' ' + date.day.toString()
                                      : date.day.toString());
                          print(reminder.reminderDate.substring(13, 16));
                          print(date.year.toString());
                          reminder.reminderDate = reminder.reminderDate
                              .replaceRange(12, 16, date.year.toString());

                          print(date.day);
                          print(reminder.reminderDate);
                        },
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: height,
                            width: 50,
                            child: CupertinoPicker(
                              scrollController: scrollHourController,
                              itemExtent: itemExtent,
                              borderSize: 1.0,
                              borderWidth: 40,
                              borderColor: ColorConstant.blackBorder,
                              children: <Widget>[
                                for (var i = 0; i < hour.length; i++)
                                  Center(
                                    child: MyText(
                                        value: hour[i].toString(),
                                        fontSize: selectedHour.compareTo(
                                                    int.parse(hour[i])) ==
                                                0
                                            ? 22
                                            : 18,
                                        color: selectedHour.compareTo(
                                                    int.parse(hour[i])) ==
                                                0
                                            ? ColorConstant.pinkColor
                                            : Colors.black),
                                  ),
                              ],
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  print(selectedHour);
                                  selectedHour = index + 1;
                                });
                              },
                              looping: true,
                            ),
                          ),
                          SizedBox(
                            width: 19,
                          ),
                          MyText(
                              value: ":",
                              color: ColorConstant.greyTextColor,
                              fontSize: 23,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            width: 19,
                          ),
                          Container(
                            width: 50,
                            height: height,
                            child: CupertinoPicker(
                              scrollController: scrollMinuteController,
                              itemExtent: itemExtent,
                              borderSize: 1.0,
                              borderWidth: 40,
                              borderColor: ColorConstant.blackBorder,
                              children: <Widget>[
                                for (var i = 0; i < minute.length; i++)
                                  Center(
                                    child: MyText(
                                        value: minute[i].toString(),
                                        fontSize: selectedMinute.compareTo(
                                                    int.parse(minute[i])) ==
                                                0
                                            ? 22
                                            : 18,
                                        color: selectedMinute.compareTo(
                                                    int.parse(minute[i])) ==
                                                0
                                            ? ColorConstant.pinkColor
                                            : Colors.black),
                                  ),
                              ],
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  selectedMinute = index;
                                  print(minute[selectedMinute].toString());

                                  reminder.reminderDate = reminder.reminderDate
                                      .replaceRange(20, 22,
                                          minute[selectedMinute].toString());
                                });
                              },
                              looping: true,
                            ),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Container(
                            width: 50,
                            child: CupertinoPicker(
                              scrollController: scrollAmPmController,
                              itemExtent: itemExtent,
                              borderSize: 1.0,
                              borderWidth: 40,
                              borderColor: ColorConstant.blackBorder,
                              children: <Widget>[
                                Center(
                                  child: MyText(
                                      value: "reminders_label_am".tr(),
                                      fontSize: amPm == 0 ? 22 : 17,
                                      color: amPm == 0
                                          ? ColorConstant.pinkColor
                                          : Colors.black),
                                ),
                                Center(
                                  child: MyText(
                                      value: "reminders_label_pm".tr(),
                                      fontSize: amPm == 1 ? 22 : 17,
                                      color: amPm == 1
                                          ? ColorConstant.pinkColor
                                          : Colors.black),
                                ),
                              ],
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  amPm = index;

                                  // ss=index==Colors.green;
                                });

                                //   ss=Colors.green;//:Colors.yellow;
                              },
                              //looping: true,
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 17, right: 17, top: 15),
                      height: 1,
                      decoration: BoxDecoration(
                        color: ColorConstant.blackBorder,
                      ),
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 17, right: 17, top: 14.5),
                            child: MyText(
                              value: "reminders_label_recurring".tr(),
                              color: ColorConstant.pinkColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 178,
                            width: 80,
                            child: CupertinoPicker(
                              scrollController: scrollRecurringController,
                              itemExtent: 50,

                              children: <Widget>[
                                Center(
                                  child: MyText(
                                      value: "reminders_label_recurring".tr(),
                                      fontSize: recurring == 0 ? 22 : 17,
                                      color: recurring == 0
                                          ? Colors.pink
                                          : Colors.black),
                                ),
                                Center(
                                  child: MyText(
                                      value: "reminders_label_weekly".tr(),
                                      fontSize: recurring == 1 ? 22 : 17,
                                      color: recurring == 1
                                          ? ColorConstant.pinkColor
                                          : Colors.black),
                                ),
                                Center(
                                  child: MyText(
                                      value: "reminders_label_monthly".tr(),
                                      fontSize: recurring == 2 ? 22 : 17,
                                      color: recurring == 2
                                          ? ColorConstant.pinkColor
                                          : Colors.black),
                                ),
                                Center(
                                  child: MyText(
                                      value: "reminders_label_yearly".tr(),
                                      fontSize: recurring == 3 ? 22 : 17,
                                      color: recurring == 3
                                          ? ColorConstant.pinkColor
                                          : Colors.black),
                                ),
                              ],
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  recurring = index;
                                  if (recurring == 0) {
                                    reminder.reminderDescription =
                                        "reminders_label_recurring".tr();
                                    reminder.rappelReminder =
                                        "reminders_label_recurring".tr();
                                    reminder.rappelId = 1;
                                  }
                                  if (recurring == 1) {
                                    reminder.reminderDescription =
                                        "reminders_label_weekly".tr();
                                    reminder.rappelId = 2;
                                    reminder.rappelReminder =
                                        "reminders_label_weekly".tr();
                                  } else if (recurring == 2) {
                                    reminder.reminderDescription =
                                        "reminders_label_monthly".tr();
                                    reminder.rappelReminder =
                                        "reminders_label_monthly".tr();

                                    reminder.rappelId = 3;
                                  } else if (recurring == 3) {
                                    reminder.reminderDescription =
                                        "reminders_label_yearly".tr();
                                    reminder.rappelReminder =
                                        "reminders_label_yearly".tr();

                                    reminder.rappelId = 4;
                                  }
                                  // ss=index==Colors.green;
                                });
                                //   ss=Colors.green;//:Colors.yellow;
                              },
                              //looping: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 17, right: 17, bottom: 24.5),
                      height: 1,
                      decoration: BoxDecoration(
                        color: ColorConstant.blackBorder,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 17, right: 17, bottom: 50),
                      child: MyButton(
                        title: "reminders_label_add".tr(),
                        height: 46,
                        titleSize: 14,
                        fontWeight: FontWeight.w600,
                        titleColor: ColorConstant.primaryColor,
                        cornerRadius: 5.0,
                        btnBgColor: ColorConstant.boxColor,
                        onPressed: () {
                          setState(() {
                            print(amPm);
                            print(_selectTime(
                                    int.parse(hour[selectedHour - 1]), amPm)
                                .toString());

                            reminder.reminderDate = reminder.reminderDate
                                .replaceRange(
                                    17,
                                    19,
                                    hour[selectedHour - 1] == 12.toString()
                                        ? "00"
                                        : _selectTime(
                                                        int.parse(hour[
                                                            selectedHour - 1]),
                                                        amPm)
                                                    .toString()
                                                    .length ==
                                                1
                                            ? '0' +
                                                _selectTime(
                                                        int.parse(hour[
                                                            selectedHour - 1]),
                                                        amPm)
                                                    .toString()
                                            : _selectTime(
                                                    int.parse(
                                                        hour[selectedHour - 1]),
                                                    amPm)
                                                .toString());

                            print(_selectTime(
                                    int.parse(hour[selectedHour - 1]), 0)
                                .toString());
                            print(reminder.reminderDate);

                            reminderList.add(reminder);
                            print(profile);
                          });

                          Navigator.of(context).pop(() {
                            setState(() {});
                          });

                          //--------------------Error Checking------------------------
                          //Had to do error checking in UI
                          //Due to unoptimized BLoC value-grabbing architecture
                          //   if (nameController.text == "") {
                          // //    _newEntryBloc.submitError(EntryError.NameNull);
                          //     return;
                          //   }
                          //   if (nameController.text != "") {
                          //     description = nameController.text;
                          //   }

                          //   if (_newEntryBloc.selectedTimeOfDay$.value ==
                          //       "None") {
                          //   //  _newEntryBloc.submitError(EntryError.StartTime);
                          //     return;
                          //   }
                          //   if (_newEntryBloc.selectedDate$.value == "None") {
                          //  //   _newEntryBloc.submitError(EntryError.StartDate);
                          //     return;
                          //   }
                          //   //---------------------------------------------------------

                          //   String startTime =
                          //       _newEntryBloc.selectedTimeOfDay$.value;
                          //   String startDate =
                          //       _newEntryBloc.selectedDate$.value;
                          //   List<int> intIDs = makeIDs(24);

                          //   List<String> notificationIDs = intIDs
                          //       .map((i) => i.toString())
                          //       .toList(); //for Shared preference

                          // Medicine newEntryMedicine = Medicine(
                          //   notificationIDs: notificationIDs,
                          //   description: description,
                          //   startDate: startDate,
                          //   startTime: startTime,
                          // );

                          // _globalBloc.updateMedicineList(newEntryMedicine);
                          // scheduleNotification(newEntryMedicine);

                          // Navigator.pushReplacement(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (BuildContext context) {
                          //       return SuccessScreen();
                          //     },
                          //   ),
                          // );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("Assets/Images/close.png"))),
                  ),
                ),
              )
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
