import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/attachmentSelection.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popup_menu.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Features/Profile/Presentation/bloc/profile_bloc.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpandableListViewDes extends StatefulWidget {
  final Profile profile;
  final Blocks diseace;
  final String type;
  final int index;
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

  ExpandableListViewDes(
      {Key key,
      this.profile,
      this.diseace,
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
      this.dropdownValue,
      this.visibile});

  @override
  _ExpandableListViewDesState createState() =>
      new _ExpandableListViewDesState();
}

//
class _ExpandableListViewDesState extends State<ExpandableListViewDes> {
  bool expandFlag = false;
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  bool _visiAttachments = false;
  bool _visiRimindersDeseace = false;

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
  
  @override
  Widget build(BuildContext context) {


    return GestureDetector(
      onTap: () {
        setState(() {
          widget.switchValue ? expandFlag = !expandFlag : Container();
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Expanded(
                    child: widget.diseace.label != ""
                        ? MyText(
                            value: widget.diseace.label,
                            maxLines: 1,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorConstant.textColor)
                        : Container()),
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
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 24.0),
              child: widget.switchValue
                  ? expandFlag
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 3,
                            ),
                            widget.diseace.documents != null
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: widget.diseace.documents.length,
                          physics: NeverScrollableScrollPhysics(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      bool _isXRay = widget.diseace
                                                  .documents[index].public ==
                                              1
                                          ? true
                                          : false;
                                      return Column(
                                        children: [
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            child: AttachmentSelection(
                                              title: widget.diseace
                                                  .documents[index].documentName,
                                              isSelected: _isXRay,
                                              onPressed: () {
                                                setState(() {
                                                  _isXRay = !_isXRay;
                                                });
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  )
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        )
                      : Container()
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }

  void dispatchUploadFile(Profile profile) {
    BlocProvider.of<ProfileBloc>(context).dispatch(
      UploadFileEvent(
        profile: profile,
      ),
    );
  }
}

class ExpandableListViewBlood extends StatefulWidget {
  final Diabates diseace;
  final Profile profile;
  final int index;
  final String title;
  final String desc;
  final bool attachment;
  final List<Documents> documents;
  final bool alarm;
  final List<Reminders> reminders;
  final TextEditingController text;
  bool switchValue;
  final bool dropdownValue;
  bool visible;

  ExpandableListViewBlood(
      {Key key,
      this.diseace,
      this.profile,
      this.index,
      this.title,
      this.desc,
      this.attachment,
      this.documents,
      this.alarm,
      this.reminders,
      this.text,
      this.switchValue,
      this.dropdownValue,
      this.visible});

  @override
  _ExpandableListViewBloodState createState() =>
      new _ExpandableListViewBloodState();
}

class _ExpandableListViewBloodState extends State<ExpandableListViewBlood> {
  bool expandFlag = false;
  PopupMenu menu;
  GlobalKey btnKey = GlobalKey();
  bool _visiRimindersBlood = false;
  bool _visiAttachmentBlood = false;

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
      widget.profile.parameters.location = 'bloodInfo';
      widget.profile.parameters.locationIndex = widget.index;
      widget.profile.parameters.file = docFile;

      dispatchUploadFile(widget.profile);

      Documents document = Documents(public: 0, active: 1);

      setState(() {
        document.data = widget.profile.parameters.fileUrl;

        document.documentName = fileName;
        widget.diseace.documents.add(document);
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
        maxWidth: 400,
        maxHeight: 400,
      );
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        widget.profile.parameters.location = 'bloodInfo';
        widget.profile.parameters.locationIndex = widget.index;
        widget.profile.parameters.file = imageFile;
        dispatchUploadFile(widget.profile);
        Documents document = Documents(public: 0, active: 1);
        setState(() {
          document.data = widget.profile.parameters.fileUrl;
          widget.diseace.documents.add(document);
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
        maxWidth: 400,
        maxHeight: 400,
      );
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        widget.profile.parameters.location = 'bloodInfo';
        widget.profile.parameters.locationIndex = widget.index;
        widget.profile.parameters.file = imageFile;
        dispatchUploadFile(widget.profile);
        Documents document = Documents(public: 0, active: 1);
        setState(() {
          document.data = widget.profile.parameters.fileUrl;
          widget.diseace.documents.add(document);
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
      // _openFileExplorer();
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

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;

    return GestureDetector(
      onTap: () {
        setState(() {
          widget.switchValue ? expandFlag = !expandFlag : Container();
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 12.5, bottom: 12.5),
        child: Column(
          children: [
            Row(
              children: [
                widget.diseace.diabeteLabel != null
                    ? Expanded(
                        child: Padding(
                        padding: const EdgeInsets.only(right: 25),
                        child: MyText(
                            value: widget.diseace.diabeteLabel,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorConstant.textColor),
                      ))
                    : Expanded(
                        child: Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: MyTextField(
                              initialValue: widget.diseace.diabeteLabel,
                              inputType: TextInputType.multiline,
                              //                                  textAlign: TextAlign.start,
                              maxline: 1,
                              focusNode: null,
                              editTextBgColor: ColorConstant.textfieldColor,
                              hintTextColor: Colors.white54,
                              title: '',
                              // maxline: 5,
                              textController: null,
                              onChanged: (value) {
                                widget.diseace.diabeteLabel = value;
                              },
                            ))),
                widget.diseace.documents.isNotEmpty
                    ? Visibility(
                        visible: widget.visible,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 6.7),
                          child: Image.asset(
                            "Assets/Images/attachment-green.png",
                            height: 16,
                            width: 16,
                          ),
                        ),
                      )
                    : Container(),
                widget.diseace.reminder.isNotEmpty
                    ? Visibility(
                        visible: widget.visible,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 11.6),
                          child: Image.asset(
                            "Assets/Images/alarm.png",
                            height: 16,
                            width: 16,
                          ),
                        ),
                      )
                    : Container(),
                Visibility(
                    visible: widget.visible,
                    child: CustomSwitch(
                      activeColor: Color(0xff34C759),
                      value: widget.diseace.active == 1 ? true : false,
                      onChanged: (value) {
                        setState(() {
                          widget.diseace.active = value == true ? 1 : 0;
                          widget.switchValue = value;
                        });
                      },
                    )),
                SizedBox(
                  width: 12,
                ),
                widget.switchValue
                    ? Visibility(
                        visible: widget.visible,
                        child: Container(
                          height: 25,
                          width: 25.18,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(top: 8, bottom: 8, left: 6),
                          child: Image.asset(
                            expandFlag
                                ? "Assets/Images/arrow-up-gray.png"
                                : "Assets/Images/arrow-down-gray.png",
                            height: 8,
                            width: 13.18,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
            expandFlag
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
                            initialValue: widget.diseace.diabeteDescription,
                            inputType: TextInputType.multiline,
                            editTextBgColor: ColorConstant.textfieldColor,
                            hintTextColor: Colors.white54,
                            title: '',
                            onChanged: (value) {
                              widget.diseace.diabeteDescription = value;
                            }),
                      ),
                      SizedBox(
                        height: 22,
                      ),
                      Row(
                        children: [
                          MyText(
                              value: "editprofil_medical_label_attachment".tr(),
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
                      widget.diseace.documents != null
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.diseace.documents.length,
                              padding: EdgeInsets.zero,
                              itemBuilder: (BuildContext context, int index) {
                                return new Container(
                                  height: 48,
                                  padding: const EdgeInsets.only(bottom: 6.0),
                                  // padding: EdgeInsets.zero,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      widget.diseace.documents[index].data !=
                                              null
                                          ? widget.diseace.documents[index].data
                                                      .contains(
                                                    '.pdf',
                                                  ) ==
                                                  false
                                              ? InkWell(
                                                  onTap: () async {
                                                    url = widget.diseace
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
                                                                    .diseace
                                                                    .documents[
                                                                        index]
                                                                    .data),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                )
                                              : InkWell(
                                                  onTap: () async {
                                                    url = widget.diseace
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
                                                                  Radius
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
                                                            .diseace
                                                            .documents[index]
                                                            .documentName !=
                                                        null
                                                    ? MyText(
                                                        value: widget
                                                            .diseace
                                                            .documents[index]
                                                            .labelDoc,
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
                                                    : MyTextField(
                                                        initialValue: '',
                                                        inputType: TextInputType
                                                            .multiline,
                                                        editTextBgColor:
                                                            ColorConstant
                                                                .textfieldColor,
                                                        hintTextColor:
                                                            Colors.white54,
                                                        title: '',
                                                        onChanged: (value) {
                                                          widget
                                                              .diseace
                                                              .documents[index]
                                                              .documentName = value;
                                                        }),
                                              ),
                                              widget.switchValue
                                                  ? _visiAttachmentBlood != null
                                                      ? Visibility(
                                                          visible:
                                                              _visiAttachmentBlood,
                                                          child: Image.asset(
                                                            "Assets/Images/eye-green.png",
                                                            height: 12,
                                                            width: 17.85,
                                                          ))
                                                      : Container()
                                                  : _visiAttachmentBlood != null
                                                      ? Visibility(
                                                          visible:
                                                              _visiAttachmentBlood,
                                                          child: Image.asset(
                                                            "Assets/Images/eye-close.png",
                                                            height: 16,
                                                            width: 20,
                                                          ))
                                                      : Container(),
                                              SizedBox(
                                                width: 13,
                                              ),
                                              _visiAttachmentBlood != null
                                                  ? Visibility(
                                                      visible:
                                                          !_visiAttachmentBlood,
                                                      child: CustomSwitch(
                                                        activeColor:
                                                            Color(0xff34C759),
                                                        value: widget
                                                                    .diseace
                                                                    .documents[
                                                                        index]
                                                                    .public ==
                                                                1
                                                            ? true
                                                            : false,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            widget
                                                                    .diseace
                                                                    .documents[
                                                                        index]
                                                                    .public =
                                                                value == true
                                                                    ? 1
                                                                    : 0;
                                                          });
                                                        },
                                                      ),
                                                    )
                                                  : Container(),
                                              _visiAttachmentBlood != null
                                                  ? Visibility(
                                                      visible:
                                                          _visiAttachmentBlood,
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
                                                                  widget.diseace
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
                                              _visiAttachmentBlood != null
                                                  ? Visibility(
                                                      visible:
                                                          !_visiAttachmentBlood,
                                                      child: MyText(
                                                          value: widget
                                                                  .switchValue
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
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.5),
                        child: Container(
                            height: 0.45,
                            color: ColorConstant.dividerColor.withOpacity(.30)),
                      ),
                      Row(
                        children: <Widget>[
                          Visibility(
                            visible: !_visiAttachmentBlood,
                            child: Expanded(
                              key: btnKey,
                              flex: 5,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: MyButton(
                                  title: "editprofil_general_btn_addnew".tr(),
                                  height: 36.0,
                                  titleSize: 14,
                                  fontWeight: FontWeight.w500,
                                  titleColor: ColorConstant.primaryColor,
                                  miniWidth: 133.5,
                                  btnBgColor: Colors.white,
                                  onPressed: maxColumn,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Visibility(
                            visible: !_visiAttachmentBlood,
                            child: Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: MyButton(
                                    title: "editprofil_general_btn_delete".tr(),
                                    height: 36.0,
                                    titleSize: 14,
                                    fontWeight: FontWeight.w500,
                                    titleColor: ColorConstant.primaryColor,
                                    miniWidth: 133.5,
                                    btnBgColor: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        _visiAttachmentBlood =
                                            !_visiAttachmentBlood;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          Visibility(
                            visible: _visiAttachmentBlood,
                            child: Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ButtonTheme(
                                    height: 36.0,
                                    minWidth: 280.5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: RaisedButton(
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.white,
                                        color: Colors.white,
                                        textColor: ColorConstant.primaryColor,
                                        child: MyText(
                                          value: 'editprofil_general_btn_done'
                                              .tr(),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _visiAttachmentBlood =
                                                !_visiAttachmentBlood;
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
                      widget.diseace.reminder != null
                          ? ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: widget.diseace.reminder.length,
                              itemBuilder: (BuildContext context, int index) {
                                return new Container(
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
                                                    .diseace
                                                    .reminder[index]
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
                                            widget.diseace.reminder[index]
                                                        .reminderDate !=
                                                    null
                                                ? MyText(
                                                    value: widget
                                                            .diseace
                                                            .reminder[index]
                                                            .reminderDate
                                                            .substring(8, 12) +
                                                        " " +
                                                        widget
                                                            .diseace
                                                            .reminder[index]
                                                            .reminderDate
                                                            .substring(5, 7) +
                                                        " " +
                                                        widget
                                                            .diseace
                                                            .reminder[index]
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
                                                widget.diseace.reminder[index]
                                                            .reminderDate !=
                                                        null
                                                    ? MyText(
                                                        value: widget
                                                            .diseace
                                                            .reminder[index]
                                                            .reminderDate
                                                            .substring(17, 29),
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
                                                          .diseace
                                                          .reminder[index]
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
                                        visible: !_visiRimindersBlood,
                                        child: CustomSwitch(
                                          activeColor: Color(0xff34C759),
                                          value: widget.diseace.reminder[index]
                                                      .active ==
                                                  1
                                              ? true
                                              : false,
                                          onChanged: (value) {
                                            setState(() {
                                              widget.diseace.reminder[index]
                                                      .active =
                                                  value == true ? 1 : 0;
                                            });
                                          },
                                        ),
                                      ),
                                      Visibility(
                                          visible: _visiRimindersBlood,
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
                                                      ))),
                                                  onTap: () {
                                                    setState(() {
                                                      widget.diseace.reminder
                                                          .removeAt(index);
                                                    });
                                                  }))),
                                    ],
                                  ),
                                );
                              },
                            )
                          : Container(),
                      Row(
                        children: <Widget>[
                          Visibility(
                            visible: !_visiRimindersBlood,
                            child: Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: MyButton(
                                  title: "editprofil_general_btn_addnew".tr(),
                                  height: 36.0,
                                  titleSize: 14,
                                  fontWeight: FontWeight.w500,
                                  titleColor: ColorConstant.primaryColor,
                                  miniWidth: 133.5,
                                  btnBgColor: Colors.white,
                                  onPressed: () => {},
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Visibility(
                            visible: !_visiRimindersBlood,
                            child: Expanded(
                                flex: 5,
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: MyButton(
                                    title: "editprofil_general_btn_delete".tr(),
                                    height: 36.0,
                                    titleSize: 14,
                                    fontWeight: FontWeight.w500,
                                    titleColor: ColorConstant.primaryColor,
                                    miniWidth: 133.5,
                                    btnBgColor: Colors.white,
                                    onPressed: () {
                                      setState(() {
                                        _visiRimindersBlood =
                                            !_visiRimindersBlood;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          Visibility(
                            visible: _visiRimindersBlood,
                            child: Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: ButtonTheme(
                                    height: 36.0,
                                    minWidth: 280.5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: RaisedButton(
                                        disabledColor: Colors.grey,
                                        disabledTextColor: Colors.white,
                                        color: Colors.white,
                                        textColor: ColorConstant.primaryColor,
                                        child: MyText(
                                          value: 'editprofil_general_btn_done'
                                              .tr(),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _visiRimindersBlood =
                                                !_visiRimindersBlood;
                                          });
                                        })),
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
          ],
        ),
      ),
    );
  }

  void dispatchUploadFile(Profile profile) {
    BlocProvider.of<ProfileBloc>(context).dispatch(
      UploadFileEvent(
        profile: profile,
      ),
    );
  }
}
