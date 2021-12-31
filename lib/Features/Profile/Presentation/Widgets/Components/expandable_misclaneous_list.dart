import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/alert_reminder.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popup_menu.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/bloc/profile_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/alert_Update_Reminder.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpandableMisclaneousList extends StatefulWidget {
  final Profile profile;
  final int index;
  final Miscilanious miscilanious;
  final bool attachment;
  final bool alarm;
  final TextEditingController text;
  bool switchValue;
  final bool dropdownValue;
  bool visibilite;
  bool update;
  List<bool> addblockMisc;
  ExpandableMisclaneousList(
      {Key key,
      this.profile,
      this.index,
      this.miscilanious,
      this.attachment,
      this.alarm,
      this.text,
      this.update,
      this.switchValue,
      this.addblockMisc,
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

      dispatchUploadFile(widget.profile);

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
        dispatchUploadFile(widget.profile);
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
        dispatchUploadFile(widget.profile);
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
    PopupMenu.context = context;
    bool public = widget.miscilanious.allow == 1 ? true : false;
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.switchValue
              ? widget.addblockMisc[widget.index] =
                  !widget.addblockMisc[widget.index]
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
                  child: widget.addblockMisc[widget.index]
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
                              widget.update = true;
                              widget.miscilanious.label = value;
                            },
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: MyText(
                              value: widget.miscilanious.label,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
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
                                widget.update = true;

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
                              fontWeight: FontWeight.w400),
                        ],
                      )
                    : Container(),
                widget.visibilite
                    ? public
                        ? Container(
                            padding: EdgeInsets.only(left: 11),
                            child: Image.asset(
                              widget.addblockMisc[widget.index]
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
                ? widget.addblockMisc[widget.index]
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
                                widget.update = true;

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
                                                          widget.update = true;

                                                          widget
                                                              .miscilanious
                                                              .documents[index]
                                                              .documentName = value;
                                                        },
                                                      ),
                                                    ),
                                            ),
                                           widget
                                                              .miscilanious
                                                              .documents[index]
                                                              .public ==1?
                                                    Image.asset(
                                                          "Assets/Images/eye-green.png",
                                                          height: 12,
                                                          width: 17.85,
                                                        )
                                                  :
                                                   Image.asset(
                                                          "Assets/Images/eye-close.png",
                                                          height: 16,
                                                          width: 20,
                                                        )
                                                   ,
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
                                                        widget.update = true;

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
                                                                widget.update =
                                                                    true;

                                                                widget
                                                                    .miscilanious
                                                                    .documents
                                                                    .removeAt(
                                                                        index);
                                                                print(
                                                                    "value of visible ");
                                                                widget
                                                                    .miscilanious
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
                                                textColor:
                                                    ColorConstant.primaryColor,
                                                child: MyText(
                                                    value:
                                                        "editprofil_general_btn_addnew"
                                                            .tr(),
                                                    color: ColorConstant
                                                        .primaryColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                                titleColor:
                                                    ColorConstant.primaryColor,
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
                                                  textColor: ColorConstant
                                                      .primaryColor,
                                                  child: MyText(
                                                      value:
                                                          'editprofil_general_btn_done'
                                                              .tr(),
                                                      fontSize: 14,
                                                      color: ColorConstant
                                                          .primaryColor,
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
                            titleColor: ColorConstant.primaryColor,,
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
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.miscilanious.reminders.length,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () async {
                                  await showOverlayUpdate(
                                      context,
                                      widget.profile,
                                      widget.index,
                                      widget.miscilanious.reminders[index]);
                                  setState(() {});
                                },
                                child: new Container(
                                  height: 67,
                                  padding: EdgeInsets.fromLTRB(12, 6, 10, 0),
                                  margin: EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: Offset(
                                            0, 0), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8.0)),
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
                                                fontSize: 9,
                                                color:
                                                    ColorConstant.boldTextColor,
                                                fontWeight: FontWeight.w600,
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            widget.miscilanious.reminders[index]
                                                        .reminderDate !=
                                                    null
                                                ? MyText(
                                                    value: widget
                                                            .miscilanious
                                                            .reminders[index]
                                                            .reminderDate
                                                            .substring(8, 12) +
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
                                                            .substring(12, 16),
                                                    fontSize: 18,
                                                    color:
                                                        ColorConstant.pinkColor,
                                                    fontWeight: FontWeight.w600)
                                                : MyText(
                                                    value: "--- -- ----",
                                                    fontSize: 18,
                                                    color:
                                                        ColorConstant.pinkColor,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                              .reminders[index]
                                                              .reminderDate
                                                              .substring(
                                                                  17, 19)),
                                                          widget
                                                              .miscilanious
                                                              .reminders[index]
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
                                            widget.update = true;

                                            setState(() {
                                              widget.miscilanious
                                                      .reminders[index].active =
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
                                              color: Colors.red, //button colour
                                              child: InkWell(
                                                  splashColor: Colors
                                                      .red, // inkwell onPress colour
                                                  child: SizedBox(
                                                      width: 24,
                                                      height:
                                                          24, //customisable size of 'button'
                                                      child: Center(
                                                          child: FaIcon(
                                                        FontAwesomeIcons.minus,
                                                        color: Colors.white,
                                                        size: 16,
                                                      ))
                                                      /*Icon(Icons.delete, )*/
                                                      ),
                                                  onTap: () {
                                                    setState(() {
                                                      widget.update = true;

                                                      widget.miscilanious
                                                          .reminders
                                                          .removeAt(index);
                                                      if (widget
                                                              .miscilanious
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
                          ),
                          widget.miscilanious.reminders.length == 0
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
                                            textColor:
                                                ColorConstant.primaryColor,
                                            child: MyText(
                                                value: "+ " +
                                                    "pets_label_addreminders"
                                                        .tr(),
                                                color:
                                                    ColorConstant.primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500),
                                            onPressed: () async {
                                              await showOverlay(
                                                  context,
                                                  widget.profile,
                                                  widget.index,
                                                  widget.index,
                                                  widget
                                                      .miscilanious.reminders);
                                              setState(() {
                                                nbrReminder = widget
                                                    .miscilanious
                                                    .reminders
                                                    .length;
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
                                                  disabledTextColor:
                                                      Colors.white,
                                                  color: Colors.white,
                                                  textColor: ColorConstant
                                                      .primaryColor,
                                                  child: MyText(
                                                      value:
                                                          "editprofil_general_btn_addnew"
                                                              .tr(),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                  onPressed: nbrReminder <
                                                          nbReminderFixe
                                                      ? () async {
                                                          await showOverlay(
                                                              context,
                                                              widget.profile,
                                                              widget.index,
                                                              widget.index,
                                                              widget
                                                                  .miscilanious
                                                                  .reminders);
                                                          setState(() {
                                                            nbrReminder = widget
                                                                .miscilanious
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
                                                    "editprofil_general_btn_delete"
                                                        .tr(),
                                                height: 36.0,
                                                titleSize: 14,
                                                fontWeight: FontWeight.w500,
                                                titleColor:
                                                    ColorConstant.primaryColor,
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
                                                  textColor: ColorConstant
                                                      .primaryColor,
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

  void dispatchUploadFile(Profile profile) {
    BlocProvider.of<ProfileBloc>(context).dispatch(
      UploadFileEvent(
        profile: profile,
      ),
    );
  }
}
