import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/PopupTagsDisplay.Dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

const Duration _kExpand = Duration(milliseconds: 200);
String localImage = "";
double screenWidth;
double screenHeight;

class MyTagItemSwitch extends StatefulWidget {
  const MyTagItemSwitch({
    Key key,
    @required this.headerTitle,
    this.headerImage,
    this.children = const <Tags>[],
    this.idMembers,
    this.type,
    this.profil,
    this.usertags,
    this.indexu,
    this.onExpansionChanged,
    this.initiallyExpanded = false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final String headerTitle;

  final String headerImage;

  final List<Tags> children;

  final String idMembers;

  final String type;
  final ValueChanged<bool> onExpansionChanged;

  final Profile profil;

  final usertags;

  final bool initiallyExpanded;

  final int indexu;

  @override
  _MyTagItemState createState() => _MyTagItemState();
}

class _MyTagItemState extends State<MyTagItemSwitch>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;

  bool _isExpanded = false;
  bool attachmentMedical = false;
  bool remindersMedical = false;
  bool remindersobject = false;
  bool attachmentobject = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));

    _isExpanded = PageStorage.of(context)?.readState(context) as bool ??
        widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  bool iconAttachmentMedicalTag(int index) {
    widget.profil.userGeneralInfo.tagsList.medicalTag[widget.indexu].tags[index]
                .otherInfo !=
            null
        ? widget.profil.userGeneralInfo.tagsList.medicalTag[widget.indexu]
            .tags[index].otherInfo
            .forEach((element) {
            if (element.documents.length != null) {
              attachmentMedical = true;
            }
          })
        : Container();
    return attachmentMedical;
  }

  bool iconReminidermedicalTag(int index) {
    widget.profil.userGeneralInfo.tagsList.medicalTag[widget.indexu].tags[index]
                .otherInfo !=
            null
        ? widget.profil.userGeneralInfo.tagsList.medicalTag[widget.indexu]
            .tags[index].otherInfo
            .forEach((element) {
            if (element.reminders.length != null) {
              remindersMedical = true;
            }
          })
        : Container();
    return remindersMedical;
  }

  bool iconAttachmentObjectTag(int index) {
    widget.profil.userGeneralInfo.tagsList.objectTag[widget.indexu].tags[index]
                .otherInfo !=
            null
        ? widget.profil.userGeneralInfo.tagsList.objectTag[widget.indexu]
            .tags[index].otherInfo
            .forEach((element) {
            if (element.documents.length != null) {
              attachmentobject = true;
            }
          })
        : Container();
    return attachmentobject;
  }

  bool iconReminidertObjectTag(int index) {
    widget.profil.userGeneralInfo.tagsList.objectTag[widget.indexu].tags[index]
                .otherInfo !=
            null
        ? widget.profil.userGeneralInfo.tagsList.objectTag[widget.indexu]
            .tags[index].otherInfo
            .forEach((element) {
            if (element.reminders.length != null) {
              remindersobject = true;
            }
          })
        : Container();
    return remindersobject;
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    Profile profile = widget.profil;
    return widget.type == 'object'
        ? Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(9.0)),
              color: ColorConstant.pinkColor,
              boxShadow: [
                new BoxShadow(
                  color: Colors.grey,
                  blurRadius: 2.0,
                  spreadRadius: 0.01,
                ),
              ],
            ),
            padding: EdgeInsets.only(left: 10.0),
            margin: EdgeInsets.only(bottom: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  onTap: _handleTap,
                  child: Container(
                      constraints: BoxConstraints(minHeight: 55.0),
                      height: 65,
                      decoration: BoxDecoration(
                        color: ColorConstant.filterTextColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(9.0),
                            bottomRight:
                                Radius.circular(_isExpanded ? 0.0 : 9.0)),
                      ),
                      padding: EdgeInsets.only(right: 10.0),
                      child: Theme(
                        data: ThemeData(
                          iconTheme:
                              IconThemeData(color: ColorConstant.pinkColor),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              height: 49,
                              width: 49,
                              margin: EdgeInsets.only(left: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.white, width: 3.0),
                                  boxShadow: [
                                    new BoxShadow(
                                      color: Colors.black,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.01,
                                    ),
                                  ],
                                  image: DecorationImage(
                                      image: NetworkImage(profile
                                              .userGeneralInfo
                                              .tagsList
                                              .objectTag[widget.indexu]
                                              .pictureProfileUrl ??
                                          " "),
                                      fit: BoxFit.cover)),
                            ),
                            Expanded(
                              child: Container(
                                  height: double.maxFinite,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.only(left: 10),
                                  child: MyText(
                                      value: widget.headerTitle,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: ColorConstant.textColor)),
                            ),
                            RotationTransition(
                              turns: _iconTurns,
                              child: const Icon(Icons.expand_more),
                            ),
                          ],
                        ),
                      )),
                ),
                _isExpanded
                    ? Container(
                        height: 1.0,
                        color: ColorConstant.greyTextColor,
                      )
                    : Container(),
                ClipRect(
                  child: Align(
                    heightFactor: _heightFactor.value,
                    child: child,
                  ),
                ),
              ],
            ),
          )
        : widget.type == "medical"
            ? Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9.0)),
                  color: ColorConstant.pinkColor,
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2.0,
                      spreadRadius: 0.01,
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: 10.0),
                margin: EdgeInsets.only(bottom: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    InkWell(
                      onTap: _handleTap,
                      child: Container(
                          constraints: BoxConstraints(minHeight: 55.0),
                          height: 65,
                          decoration: BoxDecoration(
                            color: ColorConstant.filterTextColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(9.0),
                                bottomRight:
                                    Radius.circular(_isExpanded ? 0.0 : 9.0)),
                          ),
                          padding: EdgeInsets.only(right: 10.0),
                          child: Theme(
                            data: ThemeData(
                              iconTheme:
                                  IconThemeData(color: ColorConstant.pinkColor),
                            ),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 49,
                                  width: 49,
                                  margin: EdgeInsets.only(left: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 3.0),
                                      boxShadow: [
                                        new BoxShadow(
                                          color: Colors.black,
                                          blurRadius: 2.0,
                                          spreadRadius: 0.01,
                                        ),
                                      ],
                                      image: DecorationImage(
                                          image: NetworkImage(profile
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .medicalTag[widget.indexu]
                                                  .pictureProfileUrl ??
                                              " "),
                                          fit: BoxFit.cover)),
                                ),
                                Expanded(
                                  child: Container(
                                      height: double.maxFinite,
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 10),
                                      child: MyText(
                                          value: widget.headerTitle,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: ColorConstant.textColor)),
                                ),
                                RotationTransition(
                                  turns: _iconTurns,
                                  child: const Icon(Icons.expand_more),
                                ),
                              ],
                            ),
                          )),
                    ),
                    _isExpanded
                        ? Container(
                            height: 1.0,
                            color: ColorConstant.greyTextColor,
                          )
                        : Container(),
                    ClipRect(
                      child: Align(
                        heightFactor: _heightFactor.value,
                        child: child,
                      ),
                    ),
                  ],
                ),
              )
            : Container();
  }
/* 
  void _showWelcomeOverlay(BuildContext context) {
    Navigator.of(context).push(tagspictureOverlay());
  } */

  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profil;
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: closed
            ? null
            : widget.type == "object"
                ? Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(9.0))),
                    height: profile.userGeneralInfo.tagsList
                                .objectTag[widget.indexu].tags.length >
                            4
                        ? 300
                        : profile.userGeneralInfo.tagsList
                                .objectTag[widget.indexu].tags.length *
                            90.0,
                    child: Scrollbar(
                      // isAlwaysShown: true,
                      child: ListView.builder(
                          itemCount: profile.userGeneralInfo.tagsList
                              .objectTag[widget.indexu].tags.length,
                          itemBuilder: (BuildContext context, int index) {
                            return widget.idMembers ==
                                    profile
                                        .userGeneralInfo
                                        .tagsList
                                        .objectTag[widget.indexu]
                                        .tags[index]
                                        .tagInfo
                                        .idMember
                                ? Container(
                                    height: 75,
                                    alignment: Alignment.bottomCenter,
                                    child: GestureDetector(
                                      child: ListTile(
                                        leading: profile
                                                        .userGeneralInfo
                                                        .tagsList
                                                        .objectTag[
                                                            widget.indexu]
                                                        .tags[index]
                                                        .tagInfo
                                                        .pictureUrl !=
                                                    null &&
                                                profile
                                                        .userGeneralInfo
                                                        .tagsList
                                                        .objectTag[
                                                            widget.indexu]
                                                        .tags[index]
                                                        .tagInfo
                                                        .pictureUrl
                                                        .length >
                                                    0
                                            ? InkWell(
                                                child: Container(
                                                    height: 48.0,
                                                    width: 48.0,
                                                    decoration: BoxDecoration(
                                                        boxShadow: [
                                                          new BoxShadow(
                                                            color: Colors.black,
                                                            blurRadius: 2.0,
                                                            spreadRadius: 0.01,
                                                          ),
                                                        ],
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    6.0)),
                                                        image: DecorationImage(
                                                            image: NetworkImage(profile
                                                                .userGeneralInfo
                                                                .tagsList
                                                                .objectTag[
                                                                    widget
                                                                        .indexu]
                                                                .tags[index]
                                                                .tagInfo
                                                                .pictureUrl),
                                                            fit:
                                                                BoxFit.cover))),
                                                onTap: () {
                                                  Navigator.of(context).push(
                                                      PopUpTagsDisplay(
                                                          widget
                                                              .children[index],
                                                          widget
                                                              .children[index]
                                                              .tagInfo
                                                              .pictureUrl,
                                                          widget.type));
                                                },
                                              )
                                            : widget.type == "object"
                                                ? Container(
                                                    height: 48.0,
                                                    width: 48.0,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6.0)),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://ws.interface-crm.com:445/documents/found_me_doc/3b712de48137572f3849aabd5666a4e3/732a6fc77c7d4da42dd255f730783856de52d1a92ffca9461b5a3322e179c780.jpg"),
                                                          fit: BoxFit.cover),
                                                    ))
                                                : Container(),
                                        title: InkWell(
                                            child: MyText(
                                                value: profile
                                                        .userGeneralInfo
                                                        .tagsList
                                                        .objectTag[
                                                            widget.indexu]
                                                        .tags[index]
                                                        .tagInfo
                                                        .tagLabel ??
                                                    " ",
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.w600,
                                                color: ColorConstant.textColor),
                                            onTap: () {
                                              print(widget.children[index]
                                                  .tagInfo.tagDescription);

                                              print(widget.children[index]);

                                              dispatchgettoSwitchObjectTag(
                                                  profile,
                                                  widget.type,
                                                  widget.indexu,
                                                  index);
                                            }),
                                        subtitle: MyText(
                                            value: profile
                                                    .userGeneralInfo
                                                    .tagsList
                                                    .objectTag[widget.indexu]
                                                    .tags[index]
                                                    .tagInfo
                                                    .serialNumber ??
                                                " ",
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w400,
                                            color:
                                                ColorConstant.switchTextColor),
                                        trailing: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            profile
                                                        .userGeneralInfo
                                                        .tagsList
                                                        .objectTag[
                                                            widget.indexu]
                                                        .tags[index]
                                                        .tagInfo
                                                        .emergency ==
                                                    1
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 6.0),
                                                    child: ImageIcon(
                                                      AssetImage(
                                                          "Assets/Images/Medical.png"),
                                                      color: ColorConstant
                                                          .redColor,
                                                      size: 19,
                                                    ),
                                                  )
                                                : Container(),
                                            iconAttachmentObjectTag(index)
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 6.0),
                                                    child: ImageIcon(
                                                      AssetImage(
                                                          "Assets/Images/attachment.png"),
                                                      color: ColorConstant
                                                          .iconGreenColor,
                                                      size: 19,
                                                    ),
                                                  )
                                                : Container(),
                                            iconReminidertObjectTag(index)
                                                ? Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 6.0),
                                                    child: ImageIcon(
                                                      AssetImage(
                                                          "Assets/Images/alarm.png"),
                                                      color: ColorConstant
                                                          .iconGreenColor,
                                                      size: 19,
                                                    ),
                                                  )
                                                : Container(),
                                          ],
                                        ),
                                      ),
                                      onTap: () {},
                                    ),
                                  )
                                : Container();
                          }),
                    ))
                : widget.type == "medical"
                    ? Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(9.0))),
                        height: profile.userGeneralInfo.tagsList
                                    .medicalTag[widget.indexu].tags.length >
                                4
                            ? 300
                            : profile.userGeneralInfo.tagsList
                                    .medicalTag[widget.indexu].tags.length *
                                90.0,
                        child: Scrollbar(
                          // isAlwaysShown: true,
                          child: ListView.builder(
                              itemCount: profile.userGeneralInfo.tagsList
                                  .medicalTag[widget.indexu].tags.length,
                              itemBuilder: (BuildContext context, int index) {
                                return widget.idMembers ==
                                        profile
                                            .userGeneralInfo
                                            .tagsList
                                            .medicalTag[widget.indexu]
                                            .tags[index]
                                            .tagInfo
                                            .idMember
                                    ? Container(
                                        height: 75,
                                        alignment: Alignment.bottomCenter,
                                        child: GestureDetector(
                                          child: ListTile(
                                            leading: profile
                                                            .userGeneralInfo
                                                            .tagsList
                                                            .medicalTag[
                                                                widget.indexu]
                                                            .tags[index]
                                                            .tagInfo
                                                            .pictureUrl !=
                                                        null &&
                                                    profile
                                                            .userGeneralInfo
                                                            .tagsList
                                                            .medicalTag[
                                                                widget.indexu]
                                                            .tags[index]
                                                            .tagInfo
                                                            .pictureUrl
                                                            .length >
                                                        0
                                                ? InkWell(
                                                    child: Container(
                                                        height: 48.0,
                                                        width: 48.0,
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              new BoxShadow(
                                                                color: Colors
                                                                    .black,
                                                                blurRadius: 2.0,
                                                                spreadRadius:
                                                                    0.01,
                                                              ),
                                                            ],
                                                            color: ColorConstant
                                                                .imgBackgroundColor,
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        6.0)),
                                                            image: DecorationImage(
                                                                image: NetworkImage(widget
                                                                    .profil
                                                                    .userGeneralInfo
                                                                    .tagsList
                                                                    .medicalTag[
                                                                        widget
                                                                            .indexu]
                                                                    .tags[index]
                                                                    .tagInfo
                                                                    .pictureUrl),
                                                                fit: BoxFit
                                                                    .cover))),
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          PopUpTagsDisplay(
                                                              widget.children[
                                                                  index],
                                                              widget
                                                                  .children[
                                                                      index]
                                                                  .tagInfo
                                                                  .pictureUrl,
                                                              widget.type));
                                                    },
                                                  )
                                                : Container(
                                                    height: 48.0,
                                                    width: 48.0,
                                                    decoration: BoxDecoration(
                                                      color: ColorConstant
                                                          .imgBackgroundColor,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  6.0)),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "https://ws.interface-crm.com:445/documents/found_me_doc/3b712de48137572f3849aabd5666a4e3/de20e7222dadb5e8b9e8c06ef9cf3c99b1a55c369d10f213384a9c32e3589833.jpg"),
                                                          fit: BoxFit.cover),
                                                    )),
                                            title: InkWell(
                                                child: MyText(
                                                    value: profile
                                                            .userGeneralInfo
                                                            .tagsList
                                                            .medicalTag[
                                                                widget.indexu]
                                                            .tags[index]
                                                            .tagInfo
                                                            .tagLabel ??
                                                        " ",
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.w600,
                                                    color: ColorConstant
                                                        .textColor),
                                                onTap: () {
/*                                                   print("hello");
             b,nb 
                                                  print(widget.children[index]
                                                      .tagInfo.tagDescription);

                                                  print(widget.children[index]);

                                                  dispatchgettoSwitchObjectTag(
                                                      profile,
                                                      widget.type,
                                                      widget.indexu,
                                                      index); */

                                                  dispatchgettoSwitchObjectTag(
                                                      profile,
                                                      widget.type,
                                                      widget.indexu,
                                                      index);
                                                }),
                                            subtitle: MyText(
                                                value: widget.children[index]
                                                        .tagInfo.serialNumber ??
                                                    " ",
                                                fontSize: 10.0,
                                                fontWeight: FontWeight.w400,
                                                color: ColorConstant
                                                    .switchTextColor),
                                            trailing: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                profile
                                                            .userGeneralInfo
                                                            .tagsList
                                                            .medicalTag[
                                                                widget.indexu]
                                                            .tags[index]
                                                            .tagInfo
                                                            .emergency ==
                                                        1
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 6.0),
                                                        child: ImageIcon(
                                                          AssetImage(
                                                              "Assets/Images/Medical.png"),
                                                          color: ColorConstant
                                                              .redColor,
                                                          size: 19,
                                                        ),
                                                      )
                                                    : Container(),
                                                iconAttachmentMedicalTag(index)
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 6.0),
                                                        child: ImageIcon(
                                                          AssetImage(
                                                              "Assets/Images/attachment.png"),
                                                          color: ColorConstant
                                                              .iconGreenColor,
                                                          size: 19,
                                                        ),
                                                      )
                                                    : Container(),
                                                iconReminidermedicalTag(index)
                                                    ? Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                right: 6.0),
                                                        child: ImageIcon(
                                                          AssetImage(
                                                              "Assets/Images/alarm.png"),
                                                          color: ColorConstant
                                                              .iconGreenColor,
                                                          size: 19,
                                                        ),
                                                      )
                                                    : Container(),
                                              ],
                                            ),
                                          ),
                                          onTap: () {},
                                        ),
                                      )
                                    : Container();
                              }),
                        ))
                    : Container());
  }

  void dispatchGoToEditPetsEvent(Profile profile, int index) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      GoToViewPetsEvent(profile: profile, index: index),
    );
  }

  dispatchgettoSwitchObjectTag(
      Profile profile, String type, int indexu, int index) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      GoTogetSwitchObjectTagEvent(
        profile: profile,
        type: type,
        indexu: indexu,
        index: index,
      ),
    );
  }

  /* 
  void dispatchViewTag(Profile profile, int index) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      GoToViewObjectTagEvent(
        profile: profile,
        index: index,
      ),
    );
  } */
}
