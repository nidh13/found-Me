import 'package:flutter/material.dart';

import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Tags/Presentation/bloc/tags_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Reminders/Presentation/Widgets/reminder_Display.dart';
import 'package:easy_localization/easy_localization.dart';

const Duration _kExpand = Duration(milliseconds: 200);
String localImage = "";
double screenWidth;
double screenHeight;

class MyTagItem extends StatefulWidget {
  const MyTagItem({
    Key key,
    @required this.headerTitle,
    this.headerImage,
    this.children = const <dynamic>[],
    this.idMembers,
    this.type,
    this.profil,
    this.usertags,
    this.initiallyExpanded = false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final String headerTitle;

  final String headerImage;

  final List<dynamic> children;

  final String idMembers;

  final String type;

  final Profile profil;

  final usertags;

  final bool initiallyExpanded;

  @override
  _MyTagItemState createState() => _MyTagItemState();
}

class _MyTagItemState extends State<MyTagItem>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  AnimationController _controller;
  Animation<double> _iconTurns;
  Animation<double> _heightFactor;

  bool _isExpanded = false;

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
  }

  static showOverlayUpdate(BuildContext context, Profile profile, int index,
      Reminders reminders) async {
    await Navigator.of(context)
        .push(UpdateDialogueReminder(profile, index, reminders));
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(9.0)),
        color: widget.type == "pets" || widget.type == "medical"
            ? ColorConstant.pinkColor
            : ColorConstant.blueColor,
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
                                image: NetworkImage(widget.headerImage),
                                fit: BoxFit.cover)),
                      ),
                      Expanded(
                        child: Container(
                            height: double.maxFinite,
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              widget.headerTitle,
                              textScaleFactor: 1.0,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstant.textColor),
                            )),
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

  @override
  Widget build(BuildContext context) {
    String convertTime(int time, String mn) {
      if (time > 12) {
        time = time - 12;
        return time.toString() +
            mn.toString() +
            " " +
            "reminders_label_pm".tr();
      } else if (time == 00) {
        time = time + 12;
        return time.toString() +
            mn.toString() +
            " " +
            "reminders_label_am".tr();
      } else if (time == 12) {
        return time.toString() +
            mn.toString() +
            " " +
            "reminders_label_pm".tr();
      } else {
        return time.toString() +
            mn.toString() +
            " " +
            "reminders_label_am".tr();
      }
    }

    final bool closed = !_isExpanded && _controller.isDismissed;
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed
          ? null
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(9.0),
                ),
              ),
              height: 150,
              child: Scrollbar(
                // isAlwaysShown: true,
                child: ListView.builder(
                    itemCount: widget.children.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          showOverlayUpdate(
                            context,
                            widget.profil,
                            index,
                            widget.children[index],
                          );
                        },
                        child: Container(
                          height: 67,
                          padding: EdgeInsets.fromLTRB(12, 6, 10, 0),
                          margin: EdgeInsets.only(
                              left: 20, top: 11, right: 20, bottom: 0),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(0, 0),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        widget.children[index].reminderLabel,
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                            fontFamily: 'SourceSansPro',
                                            fontSize: 9,
                                            color: ColorConstant.boldTextColor,
                                            fontWeight: FontWeight.w600),
                                        softWrap: true,
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    widget.children[index].reminderDate != null
                                        ? Text(
                                            widget.children[index].reminderDate
                                                    .substring(8, 12) +
                                                " " +
                                                widget.children[index]
                                                    .reminderDate
                                                    .substring(5, 7) +
                                                " " +
                                                widget.children[index]
                                                    .reminderDate
                                                    .substring(12, 16),
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontFamily: 'SourceSansPro',
                                                fontSize: 18,
                                                color: ColorConstant.pinkColor,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            "--- -- ----",
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontFamily: 'SourceSansPro',
                                                fontSize: 18,
                                                color: ColorConstant.pinkColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Row(
                                      children: [
                                        widget.children[index].reminderDate !=
                                                null
                                            ? Text(
                                                convertTime(
                                                  int.parse(widget
                                                      .children[index]
                                                      .reminderDate
                                                      .substring(17, 19)),
                                                  widget.children[index]
                                                      .reminderDate
                                                      .substring(19, 22),
                                                ),
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontFamily: 'SourceSansPro',
                                                    fontSize: 12,
                                                    color: ColorConstant
                                                        .boldSmallTextColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )
                                            : Text(
                                                '--:--',
                                                textScaleFactor: 1.0,
                                                style: TextStyle(
                                                    fontFamily: 'SourceSansPro',
                                                    fontSize: 12,
                                                    color: ColorConstant
                                                        .boldSmallTextColor,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
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
                                          child: Text(
                                            widget.children[index]
                                                .reminderDescription,
                                            textScaleFactor: 1.0,
                                            style: TextStyle(
                                                fontFamily: 'SourceSansPro',
                                                fontSize: 12,
                                                color: ColorConstant
                                                    .boldSmallTextColor,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Visibility(
                                visible: true,
                                child: CustomSwitch(
                                  activeColor: Color(0xff34C759),
                                  value: widget.children[index].active == 1
                                      ? true
                                      : false,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.children[index].active =
                                          value == true ? 1 : 0;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }

  void dispatchGoToEditPetsEvent(Profile profile, int index) {
    BlocProvider.of<TagsBloc>(context).dispatch(
      GoToViewPetsEvent(profile: profile, index: index),
    );
  }
}
