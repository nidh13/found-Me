import 'package:flutter/material.dart';

import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Tags/Presentation/Widgets/Components/PopupTagsDisplay.Dart';
import 'package:neopolis/Core/Utils/text.dart';

const Duration _kExpand = Duration(milliseconds: 200);
String localImage = "";
double screenWidth;
double screenHeight;

class MyTagItemPet extends StatefulWidget {
  const MyTagItemPet({
    Key key,
    @required this.headerTitle,
    this.headerImage,
    this.children = const <dynamic>[],
    this.idPet,
    this.type,
    this.onExpansionChanged,
    this.profil,
    this.switchPet,
    this.usertags,
    this.indexu,
    this.initiallyExpanded = false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final String headerTitle;
  final String switchPet;
  final String headerImage;

  final List<dynamic> children;

  final int idPet;

  final String type;

  final Profile profil;

  final usertags;

  final bool initiallyExpanded;
  final ValueChanged<bool> onExpansionChanged;

  final int indexu;
  @override
  _MyTagItemPetState createState() => _MyTagItemPetState();
}

class _MyTagItemPetState extends State<MyTagItemPet>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;

  bool _isExpanded = false;
  bool attachmentPets = false;
  bool remindersPets = false;
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

  bool iconAttachmentPetsTag(int index) {
    widget.profil.userGeneralInfo.tagsList.petTag[widget.indexu].tags[index]
                .otherInfo !=
            null
        ? widget.profil.userGeneralInfo.tagsList.petTag[widget.indexu]
            .tags[index].otherInfo
            .forEach((element) {
            if (element.documents.length != null) {
              attachmentPets = true;
            }
          })
        : Container();
    return attachmentPets;
  }

  bool iconReminiderPetsTag(int index) {
    widget.profil.userGeneralInfo.tagsList.petTag[widget.indexu].tags[index]
                .otherInfo !=
            null
        ? widget.profil.userGeneralInfo.tagsList.petTag[widget.indexu]
            .tags[index].otherInfo
            .forEach((element) {
            if (element.reminders.length != null) {
              remindersPets = true;
            }
          })
        : Container();
    return remindersPets;
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Container(
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
                      bottomRight: Radius.circular(_isExpanded ? 0.0 : 9.0)),
                ),
                padding: EdgeInsets.only(right: 10.0),
                child: Theme(
                  data: ThemeData(
                    iconTheme: IconThemeData(color: ColorConstant.pinkColor),
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
                            border: Border.all(color: Colors.white, width: 3.0),
                            boxShadow: [
                              new BoxShadow(
                                color: Colors.black,
                                blurRadius: 2.0,
                                spreadRadius: 0.01,
                              ),
                            ],
                            image: DecorationImage(
                                image: NetworkImage(widget
                                        .profil
                                        .userGeneralInfo
                                        .tagsList
                                        .petTag[widget.indexu]
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
    );
  }
/* 
  void _showWelcomeOverlay(BuildContext context) {
    Navigator.of(context).push(tagspictureOverlay());
  } */

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(9.0))),
              height: widget.profil.userGeneralInfo.tagsList
                          .petTag[widget.indexu].tags.length >
                      4
                  ? 300
                  : widget.profil.userGeneralInfo.tagsList.petTag[widget.indexu]
                          .tags.length *
                      90.0,
              child: Scrollbar(
                // isAlwaysShown: true,
                child: ListView.builder(
                    itemCount: widget.profil.userGeneralInfo.tagsList
                        .petTag[widget.indexu].tags.length,
                    itemBuilder: (BuildContext context, int index) {
                      return widget.idPet ==
                              widget
                                  .profil
                                  .userGeneralInfo
                                  .tagsList
                                  .petTag[widget.indexu]
                                  .tags[index]
                                  .tagInfo
                                  .idPet
                          ? Container(
                              height: 75,
                              alignment: Alignment.bottomCenter,
                              child: GestureDetector(
                                child: ListTile(
                                  leading: widget
                                                  .profil
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .petTag[widget.indexu]
                                                  .tags[index]
                                                  .tagInfo
                                                  .pictureUrl !=
                                              null &&
                                          widget
                                                  .profil
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .petTag[widget.indexu]
                                                  .tags[index]
                                                  .tagInfo
                                                  .pictureUrl
                                                  .length >
                                              0
                                      ? Container(
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
                                              color: ColorConstant
                                                  .imgBackgroundColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(6.0)),
                                              image: DecorationImage(
                                                  image: NetworkImage(widget
                                                      .profil
                                                      .userGeneralInfo
                                                      .tagsList
                                                      .petTag[widget.indexu]
                                                      .tags[index]
                                                      .tagInfo
                                                      .pictureUrl),
                                                  fit: BoxFit.cover)))
                                      : Container(
                                          height: 48.0,
                                          width: 48.0,
                                          decoration: BoxDecoration(
                                            color: Color(0xffE8E5E5),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(6.0)),
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "Assets/Images/iconPetTag.png"),
                                                fit: BoxFit.cover),
                                          )),
                                  title: InkWell(
                                      child: MyText(
                                          value: widget
                                                  .profil
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .petTag[widget.indexu]
                                                  .tags[index]
                                                  .tagInfo
                                                  .tagLabel ??
                                              " ",
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
                                          color: ColorConstant.textColor),
                                      onTap: () {}),
                                  subtitle: MyText(
                                      value: widget
                                              .profil
                                              .userGeneralInfo
                                              .tagsList
                                              .petTag[widget.indexu]
                                              .tags[index]
                                              .tagInfo
                                              .serialNumber ??
                                          " ",
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w400,
                                      color: ColorConstant.switchTextColor),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      widget
                                                  .profil
                                                  .userGeneralInfo
                                                  .tagsList
                                                  .petTag[widget.indexu]
                                                  .tags[index]
                                                  .tagInfo
                                                  .emergency ==
                                              1
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(right: 6.0),
                                              child: ImageIcon(
                                                AssetImage(
                                                    "Assets/Images/Medical.png"),
                                                color: ColorConstant.pinkColor,
                                                size: 19,
                                              ),
                                            )
                                          : Container(),
                                      iconAttachmentPetsTag(index)
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(right: 6.0),
                                              child: ImageIcon(
                                                AssetImage(
                                                    "Assets/Images/attachment.png"),
                                                color: ColorConstant
                                                    .iconGreenColor,
                                                size: 19,
                                              ),
                                            )
                                          : Container(),
                                      iconReminiderPetsTag(index)
                                          ? Padding(
                                              padding:
                                                  EdgeInsets.only(right: 6.0),
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
                                onTap: () {
                                  if (widget.switchPet == 'switch') {
                                    dispatchgettoSwitchObjectTag(widget.profil,
                                        widget.type, widget.indexu, index);
                                  } else {
                                    int indexpet = widget
                                        .profil.userGeneralInfo.petsInfos
                                        .indexWhere((element) =>
                                            element.generalInfo.idPet ==
                                            widget
                                                .profil
                                                .userGeneralInfo
                                                .tagsList
                                                .petTag[widget.indexu]
                                                .tags[index]
                                                .tagInfo
                                                .idPet);
                                    dispatchViewTag(widget.children[index],
                                        widget.profil, indexpet);
                                  }
                                },
                              ),
                            )
                          : Container();
                    }),
              ) /*ListView(children: widget.children)*/),
    );
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

  void dispatchViewTag(dynamic usertags, Profile profile, int index) {
    Navigator.of(context).pushReplacementNamed(
      '/petsProvider',
      arguments: {
        'profile': profile,
        'index': index,
        'route': 'GoToViewPetProfile',
      },
    );
    // BlocProvider.of<TagsBloc>(context).dispatch(
    //   GoToViewPetsEvent(
    //     profile: profile,
    //     index: index,
    //   ),
    // );
  }
}
