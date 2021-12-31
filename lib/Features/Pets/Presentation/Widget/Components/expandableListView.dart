import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/alert_reminder.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popup_menu.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Features/Pets/Presentation/bloc/pets_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:neopolis/Features/Pets/Presentation/Widget/Components/alert_Update_Reminder.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpandableListView extends StatefulWidget {
  final Profile profile;
  final Vaccins vaccinPets;
  final String type;
  final int index;
  final int indexPet;
  String title;
  final String desc;
  final bool attachment;
  final List<Documents> documents;
  final bool alarm;
  final List<Reminders> reminders;
  final TextEditingController text;
  final bool switchValue;
  final bool dropdownValue;
  final bool visibile;
  List<bool> addBlockVaccin;
  bool updated;
  ExpandableListView(
      {Key key,
      this.profile,
      this.vaccinPets,
      this.indexPet,
      this.type,
      this.index,
      this.title,
      this.desc,
      this.attachment,
      this.documents,
      this.alarm,
      this.reminders,
      this.text,
      this.switchValue,
      this.addBlockVaccin,
      this.dropdownValue,
      this.updated,
      this.visibile});

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState();
}

//
class _ExpandableListViewState extends State<ExpandableListView> {
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  bool _visiAttachments = false;
  bool _visiRiminders = false;

  List<String> docPaths;
  String fileName;
  String path;
  Map<String, String> paths;
  List<String> extensions;
  bool isLoadingPath = false;
  bool isMultiPick = false;
  FileType fileType;
  File docFile;
  String url;
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
    } on PlatformException catch (e) {}
    if (!mounted) return;
    setState(() {
      isLoadingPath = false;
      fileName = path != null
          ? path.split('/').last
          : paths != null
              ? paths.keys.toString()
              : '...';
      widget.profile.parameters.location = 'vaccine';
      widget.profile.parameters.locationIndex = widget.index;
      widget.profile.parameters.file = docFile;

      dispatchUploadFile(widget.profile);

      Documents document = Documents(public: 0, active: 1);

      setState(() {
        document.data = widget.profile.parameters.fileUrl;

        document.documentName = fileName;
        widget.vaccinPets.documents.add(document);
      });

      widget.profile.parameters.fileUrl !=
              'https://pbs.twimg.com/profile_images/774273386134532096/yNOyEVgS_400x400.jpg'
          ? setState(() {})
          : Timer(Duration(seconds: 2), () {
              setState(() {});
            });
    });
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  Documents document;
  File imageFile;
  void onClickMenu(MenuItemProvider item) async {
    if (item.type == "camera") {
      PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera,
        imageQuality: 20,
        maxWidth: 400,
        maxHeight: 400,
      );
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        widget.profile.parameters.location = 'vaccine';
        widget.profile.parameters.locationIndex = widget.index;
        widget.profile.parameters.file = imageFile;
        dispatchUploadFile(widget.profile);
        Documents document = Documents(public: 0, active: 1);
        setState(() {
          document.data = widget.profile.parameters.fileUrl;
          widget.vaccinPets.documents.add(document);
        });
      }
      widget.profile.parameters.fileUrl !=
              'https://pbs.twimg.com/profile_images/774273386134532096/yNOyEVgS_400x400.jpg'
          ? setState(() {})
          : Timer(Duration(seconds: 4), () {
              setState(() {});
            });
    } else if (item.type == "gallery") {
      PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        imageQuality: 20,
        maxWidth: 400,
        maxHeight: 400,
      );
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        widget.profile.parameters.location = 'vaccine';
        widget.profile.parameters.locationIndex = widget.index;
        widget.profile.parameters.file = imageFile;
        dispatchUploadFile(widget.profile);
        Documents document = Documents(public: 0, active: 1);
        setState(() {
          document.data = widget.profile.parameters.fileUrl;
          widget.vaccinPets.documents.add(document);
        });
      }
      widget.profile.parameters.fileUrl !=
              'https://pbs.twimg.com/profile_images/774273386134532096/yNOyEVgS_400x400.jpg'
          ? setState(() {})
          : Timer(Duration(seconds: 4), () {
              setState(() {});
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

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.switchValue
              ? widget.addBlockVaccin[widget.index] =
                  !widget.addBlockVaccin[widget.index]
              : Container();
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 12.5, bottom: 12.5),
        child: Column(
          children: [
            Row(
              children: [
                widget.vaccinPets.label != ""
                    ? Expanded(
                        child: MyText(
                            value: widget.vaccinPets.label,
                            maxLines: 1,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorConstant.textColor),
                      )
                    : Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child:  MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                        textScaleFactor: MediaQuery.of(context)
                                            .textScaleFactor
                                            .clamp(1.0, 1.0),
                                      ),
                                      child:MyTextField(
                              initialValue: widget.vaccinPets.label,
                              
                              inputType: TextInputType.multiline,
                              editTextBgColor: ColorConstant.textfieldColor,
                              hintTextColor: Colors.white54,
                              title: 'Description',
                              maxline: 1,
                              onChanged: (value) {
                                widget.updated = true;
                                widget.vaccinPets.label = value;
                              },
                            ))),
                      ),
                widget.switchValue
                    ? widget.attachment
                        ? Padding(
                            padding: const EdgeInsets.only(right: 25.7),
                            child: Image.asset(
                              "Assets/Images/attachment-green.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container()
                    : Container(),
                widget.switchValue
                    ? widget.alarm
                        ? Padding(
                            padding: const EdgeInsets.only(right: 11.6),
                            child: Image.asset(
                              "Assets/Images/alarm.png",
                              height: 16,
                              width: 16,
                            ),
                          )
                        : Container()
                    : Container(),
                widget.visibile != null
                    ? Visibility(
                        visible: !widget.visibile,
                        child: CustomSwitch(
                          activeColor: Color(0xff34C759),
                          value: widget.vaccinPets.active == 1 ? true : false,
                          onChanged: (value) {
                            setState(() {
                              widget.updated = true;
                              widget.vaccinPets.active = value == true ? 1 : 0;
                            });
                          },
                        ),
                      )
                    : Container(),
                SizedBox(
                  width: 12,
                ),
                widget.visibile
                    ? SizedBox(
                        width: 30,
                      )
                    : SizedBox(
                        width: 1,
                      ),
                widget.visibile != null
                    ? Visibility(
                        visible: !widget.visibile,
                        child: widget.switchValue
                            ? Image.asset(
                                widget.addBlockVaccin[widget.index]
                                    ? "Assets/Images/arrow-up-gray.png"
                                    : "Assets/Images/arrow-down-gray.png",
                                height: 8,
                                width: 13.18,
                              )
                            : Container(),
                      )
                    : Container()
              ],
            ),
            widget.switchValue
                ? widget.addBlockVaccin[widget.index]
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
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                        textScaleFactor: MediaQuery.of(context)
                                            .textScaleFactor
                                            .clamp(1.0, 1.0),
                                      ),
                                      child: MyTextField(
                                initialValue: widget.vaccinPets.description,
                                inputType: TextInputType.multiline,
                                editTextBgColor: ColorConstant.textfieldColor,
                                hintTextColor: Colors.white54,
                                title: 'Notes',
                                onChanged: (value) {
                                  widget.updated = true;
                                  widget.vaccinPets.description = value;
                                }),
                          )),
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
                            height: 11,
                          ),
                          widget.vaccinPets.documents != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.vaccinPets.documents.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return new Container(
                                      height: 48,
                                      padding:
                                          const EdgeInsets.only(bottom: 6.0),
                                      // padding: EdgeInsets.zero,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          widget.vaccinPets.documents[index]
                                                      .data !=
                                                  null
                                              ? widget.vaccinPets
                                                          .documents[index].data
                                                          .contains(
                                                        '.pdf',
                                                      ) ==
                                                      false
                                                  ? InkWell(
                                                      onTap: () async {
                                                        // url = widget
                                                        //     .diseace
                                                        //     .documents[index]
                                                        //     .data;
                                                        // if (await canLaunch(
                                                        //     url)) {
                                                        //   await launch(url);
                                                        // } else {
                                                        //   throw 'Could not launch $url';
                                                        // }
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
                                                                image: NetworkImage(widget
                                                                    .vaccinPets
                                                                    .documents[
                                                                        index]
                                                                    .data),
                                                                fit: BoxFit
                                                                    .cover)),
                                                      ),
                                                    )
                                                  : InkWell(
                                                      onTap: () async {
                                                        // url = widget
                                                        //     .diseace
                                                        //     .documents[index]
                                                        //     .data;
                                                        // if (await canLaunch(
                                                        //     url)) {
                                                        //   await launch(url);
                                                        // } else {
                                                        //   throw 'Could not launch $url';
                                                        // }
                                                      },
                                                      child: Container(
                                                        height: 42,
                                                        width: 42,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: ColorConstant
                                                              .imgBackgroundColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5)),
                                                          image: DecorationImage(
                                                              image: NetworkImage(
                                                                  'https://nlmt.fr/wp-content/uploads/2016/11/fichier.png'),
                                                              fit:
                                                                  BoxFit.cover),
                                                        ),
                                                      ),
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
                                                                .vaccinPets
                                                                .documents[
                                                                    index]
                                                                .documentName !=
                                                            null
                                                        ? MyText(
                                                            value: widget
                                                                .vaccinPets
                                                                .documents[
                                                                    index]
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
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )
                                                        : MediaQuery(
                                      data: MediaQuery.of(context).copyWith(
                                        textScaleFactor: MediaQuery.of(context)
                                            .textScaleFactor
                                            .clamp(1.0, 1.0),
                                      ),
                                      child: MyTextField(
                                                            initialValue: ' ',
                                                            inputType:
                                                                TextInputType
                                                                    .multiline,
                                                            maxline: 1,
                                                            editTextBgColor:
                                                                ColorConstant
                                                                    .textfieldColor,
                                                            hintTextColor:
                                                                Colors.white54,
                                                            title: '',
                                                            onChanged: (value) {
                                                              widget.updated =
                                                                  true;
                                                              widget
                                                                      .vaccinPets
                                                                      .documents[
                                                                          index]
                                                                      .documentName =
                                                                  value;
                                                            }),
                                                  )),
                                                  widget.switchValue
                                                      ? _visiAttachments != null
                                                          ? widget
                                                                      .vaccinPets
                                                                      .documents[
                                                                          index]
                                                                      .public ==
                                                                  1
                                                              ? Visibility(
                                                                  child: Image
                                                                      .asset(
                                                                  "Assets/Images/eye-green.png",
                                                                  height: 12,
                                                                  width: 17.85,
                                                                ))
                                                              : Visibility(
                                                                  child: Image
                                                                      .asset(
                                                                  "Assets/Images/eye-close.png",
                                                                  height: 16,
                                                                  width: 20,
                                                                ))
                                                          : Container()
                                                      : Container(),
                                                  SizedBox(
                                                    width: 13,
                                                  ),
                                                  _visiAttachments != null
                                                      ? Visibility(
                                                          visible:
                                                              !_visiAttachments,
                                                          child: CustomSwitch(
                                                            activeColor: Color(
                                                                0xff34C759),
                                                            value: widget
                                                                        .vaccinPets
                                                                        .documents[
                                                                            index]
                                                                        .public ==
                                                                    1
                                                                ? true
                                                                : false,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                widget.updated =
                                                                    true;
                                                                widget
                                                                    .vaccinPets
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
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            color: Colors.red,
                                                            child: InkWell(
                                                              splashColor:
                                                                  Colors.red,
                                                              child: SizedBox(
                                                                width: 24,
                                                                height: 24,
                                                                child: Center(
                                                                  child: FaIcon(
                                                                    FontAwesomeIcons
                                                                        .minus,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 16,
                                                                  ),
                                                                ),
                                                              ),
                                                              onTap: () {
                                                                setState(() {
                                                                  widget
                                                                      .vaccinPets
                                                                      .documents
                                                                      .removeAt(
                                                                          index);
                                                                });
                                                              },
                                                            ),
                                                          ),
                                                        )
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
                                                  _visiAttachments != null
                                                      ? Visibility(
                                                          visible:
                                                              !_visiAttachments,
                                                          child: MyText(
                                                            value: widget.switchValue
                                                                ? "objecttag_label_public"
                                                                    .tr()
                                                                : "objecttag_label_private"
                                                                    .tr(),
                                                            fontSize: 7,
                                                            color: ColorConstant
                                                                .switchTextColor,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
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
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.5),
                            child: Container(
                              height: 0.45,
                              color:
                                  ColorConstant.dividerColor.withOpacity(.30),
                            ),
                          ),
                          widget.vaccinPets.documents.length == 0
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
                                            value: "+ " +
                                                "pets_label_addattachments"
                                                    .tr(),
                                            color: ColorConstant.pinkColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          onPressed: maxColumn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ])
                              : Row(
                                  children: <Widget>[
                                    Visibility(
                                      visible: !_visiAttachments,
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
                                                  "editprofil_general_btn_addnew"
                                                      .tr(),
                                              color: ColorConstant.pinkColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            onPressed: maxColumn,
                                          ),
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
                                                  ColorConstant.pinkColor,
                                              miniWidth: 133.5,
                                              btnBgColor: Colors.white,
                                              onPressed: () {
                                                setState(() {
                                                  _visiAttachments =
                                                      !_visiAttachments;
                                                });
                                              },
                                            ),
                                          )),
                                    ),
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
                                                  textColor: Color(0xffEC1C40),
                                                  child: MyText(
                                                    value:
                                                        "editprofil_general_btn_done"
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
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorConstant.textColor),
                          SizedBox(
                            height: 11,
                          ),
                          widget.reminders != null
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  padding: EdgeInsets.zero,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: widget.reminders.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        await showOverlayUpdate(
                                            context,
                                            widget.profile,
                                            widget.index,
                                            widget.reminders[index]);
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
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                                                          .vaccinPets
                                                          .reminders[index]
                                                          .reminderLabel,
                                                      fontSize: 9,
                                                      color: ColorConstant
                                                          .boldTextColor,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      maxLines: 1,
                                                      textAlign:
                                                          TextAlign.start,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  widget
                                                              .vaccinPets
                                                              .reminders[index]
                                                              .reminderDate !=
                                                          null
                                                      ? MyText(
                                                          value: widget.vaccinPets.reminders[index].reminderDate.substring(8, 12) +
                                                              " " +
                                                              widget.vaccinPets.reminders[index].reminderDate
                                                                  .substring(
                                                                      5, 7) +
                                                              " " +
                                                              widget
                                                                  .vaccinPets
                                                                  .reminders[
                                                                      index]
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
                                                                  .vaccinPets
                                                                  .reminders[
                                                                      index]
                                                                  .reminderDate !=
                                                              null
                                                          ? MyText(
                                                              value:
                                                                  convertTime(
                                                                int.parse(widget
                                                                    .vaccinPets
                                                                    .reminders[
                                                                        index]
                                                                    .reminderDate
                                                                    .substring(
                                                                        17,
                                                                        19)),
                                                                widget
                                                                    .vaccinPets
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
                                                                  FontWeight
                                                                      .w500)
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
                                                                .vaccinPets
                                                                .reminders[
                                                                    index]
                                                                .reminderDescription,
                                                            fontSize: 12,
                                                            color: ColorConstant
                                                                .boldSmallTextColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
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
                                                            .vaccinPets
                                                            .reminders[index]
                                                            .active ==
                                                        1
                                                    ? true
                                                    : false,
                                                onChanged: (value) {
                                                  setState(() {
                                                    widget.updated = true;
                                                    widget
                                                            .vaccinPets
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
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.red,
                                                child: InkWell(
                                                  splashColor: Colors.red,
                                                  child: SizedBox(
                                                      width: 24,
                                                      height: 24,
                                                      child: Center(
                                                          child: FaIcon(
                                                        FontAwesomeIcons.minus,
                                                        color: Colors.white,
                                                        size: 16,
                                                      ))),
                                                  onTap: () {
                                                    setState(() {
                                                      nbrReminder--;
                                                      widget
                                                          .vaccinPets.reminders
                                                          .removeAt(index);
                                                    });
                                                    if (widget.vaccinPets
                                                            .reminders.length ==
                                                        0) {
                                                      _visiRiminders =
                                                          !_visiRiminders;
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(),
                          widget.vaccinPets.reminders.length == 0
                              ? Row(
                                  children: <Widget>[
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
                                              value: "+" +
                                                  "pets_label_addreminders"
                                                      .tr(),
                                              color: ColorConstant.pinkColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            onPressed: () async {
                                              await showOverlay(
                                                  context,
                                                  widget.profile,
                                                  widget.index,
                                                  widget.indexPet,
                                                  widget.vaccinPets.reminders);
                                              setState(() {
                                                nbrReminder = widget.vaccinPets
                                                    .reminders.length;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
                                                  disabledTextColor:
                                                      Colors.white,
                                                  color: Colors.white,
                                                  textColor: Color(0xffEC1C40),
                                                  child: MyText(
                                                    value:
                                                        "editprofil_general_btn_addnew"
                                                            .tr(),
                                                    color:
                                                        ColorConstant.pinkColor,
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
                                                              widget.index,
                                                              widget.vaccinPets
                                                                  .reminders);
                                                          setState(() {
                                                            nbrReminder = widget
                                                                .vaccinPets
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
                                                    ColorConstant.pinkColor,
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
                                                    "editprofil_general_btn_done"
                                                        .tr(),
                                                color: ColorConstant.pinkColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              onPressed: () {
                                                setState(() {
                                                  _visiRiminders =
                                                      !_visiRiminders;
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          SizedBox(
                            height: 28,
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

  void dispatchUploadFile(Profile profile) {
    BlocProvider.of<PetsBloc>(context).dispatch(
      UploadFilePetEvent(profile: profile, index: widget.indexPet),
    );
  }

  static showOverlay(BuildContext context, Profile profile, int index,
      int indexSubUser, List reminderList) async {
    await Navigator.of(context).push(
        AlertDialogueReminder(profile, index, indexSubUser, reminderList));
  }
}
