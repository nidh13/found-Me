import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popup_menu.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/text_field.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:neopolis/Features/Users/Presentation/bloc/users_bloc.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class ExpandableDnrView extends StatefulWidget {
  final Profile profile;
  final int indexSubUser;
  final List<Documents> documents;

  final Resuscitate resuscitateInfo;
  final String type;
  final int index;
  String title;
  final String desc;
  final bool attachment;
  final bool alarm;
  final List<Reminders> reminders;
  final TextEditingController text;
  final bool switchValue;
  final bool dropdownValue;
  final bool visibile;

  ExpandableDnrView(
      {Key key,
      this.profile,
      this.documents,
      this.indexSubUser,
      this.resuscitateInfo,
      this.type,
      this.index,
      this.title,
      this.desc,
      this.attachment,
      this.alarm,
      this.reminders,
      this.text,
      this.switchValue,
      this.dropdownValue,
      this.visibile});

  @override
  _ExpandableDnrViewState createState() => new _ExpandableDnrViewState();
}

//
class _ExpandableDnrViewState extends State<ExpandableDnrView> {
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

      widget.profile.parameters.location = "Dnr";
      widget.profile.parameters.locationIndex = widget.index;
      widget.profile.parameters.file = docFile;

      dispatchUploadFile(widget.profile, widget.indexSubUser);
      Documents document = Documents(public: 0, active: 1);

      setState(() {
        document.data = widget.profile.parameters.fileUrl;

        document.documentName = fileName;
        widget.resuscitateInfo.documents.add(document);
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
        widget.profile.parameters.location = "Dnr";
        widget.profile.parameters.locationIndex = widget.index;
        widget.profile.parameters.file = imageFile;
        dispatchUploadFile(widget.profile, widget.indexSubUser);
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
        maxWidth: 400,
        maxHeight: 400,
      );
      if (pickedFile != null) {
        imageFile = File(pickedFile.path);
        widget.profile.parameters.location = "Dnr";
        widget.profile.parameters.locationIndex = widget.index;
        widget.profile.parameters.file = imageFile;
        dispatchUploadFile(widget.profile, widget.indexSubUser);
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
        padding: EdgeInsets.only(top: 12.5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: MyText(
                      value: "editprofil_label_donotrecusitatetext".tr(),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: ColorConstant.textColor),
                ),
                widget.switchValue
                    ? widget.documents.length != 0
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
                CustomSwitch(
                  activeColor: Color(0xff34C759),
                  value: widget.resuscitateInfo.active == 1 ? true : false,
                  onChanged: (value) {
                    setState(() {
                      widget.resuscitateInfo.allow = value == true ? 1 : 0;
                    });
                  },
                ),
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
                Visibility(
                  visible: !widget.visibile,
                  child: widget.switchValue
                      ? Image.asset(
                          expandFlag
                              ? "Assets/Images/arrow-up-gray.png"
                              : "Assets/Images/arrow-down-gray.png",
                          height: 8,
                          width: 13.18,
                        )
                      : Container(),
                )
              ],
            ),
            widget.switchValue
                ? expandFlag
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
                            child: MyText(
                              value: "editprofil_label_donotrecusitatemsg".tr(),
                            ),
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Container(
                              height: 30,
                              child: InkWell(
                                child: MyText(
                                  value: "https://eforms.com/dnr",
                                ),
                                onTap: () async {
                                  if (await canLaunch(
                                      "https://eforms.com/dnr")) {
                                    await launch("https://eforms.com/dnr");
                                  }
                                },
                              )),
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
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: widget.documents != null
                                ? widget.documents.length
                                : 1,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context, int index) {
                              return new Container(
                                height: 48,
                                padding: const EdgeInsets.only(bottom: 6.0),
                                // padding: EdgeInsets.zero,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    widget.documents[index].data != null
                                        ? widget.documents[index].data.contains(
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
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  5)),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              widget
                                                                  .documents[
                                                                      index]
                                                                  .data),
                                                          fit: BoxFit.cover)),
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
                                              child: widget.documents[index]
                                                          .documentName !=
                                                      null
                                                  ? MyText(
                                                      value: widget
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
                                                  : MyTextField(
                                                      initialValue: ' ',
                                                      inputType: TextInputType
                                                          .multiline,
                                                      maxline: 1,
                                                      editTextBgColor:
                                                          ColorConstant
                                                              .textfieldColor,
                                                      hintTextColor:
                                                          Colors.white54,
                                                      title: '',
                                                      onChanged: (value) {
                                                        widget.documents[index]
                                                                .documentName =
                                                            value;
                                                      }),
                                            ),
                                            widget.switchValue
                                                ? _visiAttachments != null
                                                    ? widget.documents[index]
                                                                .public ==
                                                            1
                                                        ? Visibility(
                                                            child: Image.asset(
                                                            "Assets/Images/eye-green.png",
                                                            height: 12,
                                                            width: 17.85,
                                                          ))
                                                        : Visibility(
                                                            child: Image.asset(
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
                                                    visible: !_visiAttachments,
                                                    child: CustomSwitch(
                                                      activeColor:
                                                          Color(0xff34C759),
                                                      value: widget
                                                                  .documents[
                                                                      index]
                                                                  .public ==
                                                              1
                                                          ? true
                                                          : false,
                                                      onChanged: (value) {
                                                        setState(() {
                                                          widget
                                                              .documents[index]
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
                                                                widget.documents
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
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12.5),
                            child: Container(
                                height: 0.45,
                                color: ColorConstant.dividerColor
                                    .withOpacity(.30)),
                          ),
                          widget.documents == null
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
                                              color: ColorConstant.primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            onPressed: maxColumn,
                                          )),
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
                                                color:
                                                    ColorConstant.primaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              onPressed: maxColumn,
                                            )),
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
                                                        'editprofil_general_btn_done'
                                                            .tr(),
                                                    fontSize: 14,
                                                    color: ColorConstant
                                                        .primaryColor,
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
                        ],
                      )
                    : Container()
                : Container(),
          ],
        ),
      ),
    );
  }

  void dispatchUploadFile(Profile profile, int index) {
    BlocProvider.of<UsersBloc>(context).dispatch(
      UploadFileEvent(profile: profile, index: index),
    );
  }
}
