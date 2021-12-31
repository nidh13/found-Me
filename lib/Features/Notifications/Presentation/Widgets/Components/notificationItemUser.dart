import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:jiffy/jiffy.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Notifications/Presentation/bloc/notifications_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationItemUser extends StatefulWidget {
  const NotificationItemUser({this.notif, this.index, this.profile});

  final AdminNotification notif;

  final int index;

  final Profile profile;
  @override
  _NotificationItemUserState createState() => _NotificationItemUserState();
}

class _NotificationItemUserState extends State<NotificationItemUser> {
  var jiffy =
      Jiffy("Mon, 11 Aug 2014 12:53 pm PDT", "EEE, dd MMM yyyy hh:mm a zzz");
  var screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width * 0.05 / 14.5;
    screenHeight = MediaQuery.of(context).size.height * 0.040 / 13;

    //print(notification.length.toString());

    //  print(widget.notif.toString());
    //Si l'etat de notification est active

    return Dismissible(
        key: Key(
          widget.notif.content
              .elementAt(widget.notif.content.length - 1)
              .notificationType,
        ),
        onDismissed: (direction) {},
        background: Container(
          width: 123.0 * screenWidth,
          height: 108.0 * screenHeight,
          color: const Color(0xffec1c40),
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: AlignmentDirectional.centerEnd,
          child: SizedBox(
            width: 62.0 * screenWidth,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "editprofil_general_btn_delete".tr(),
                style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 18,
                  color: const Color(0xffffffff),
                  letterSpacing: 0.18,
                ),
              ),
            ),
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 5, right: 5),
              child: Card(
                elevation: 0.0,
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      // color: Colors.black,
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.20,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: widget.notif.content[widget.index].url !=
                                        null &&
                                    widget.notif.content[widget.index].url != ''
                                ? Image.network(
                                    widget.notif.content[widget.index].url,
                                  )
                                : Image.asset(
                                    "Assets/Images/noti.png",
                                  ),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: widget.notif.content[widget.index]
                                                .tagLabel ??
                                            ' ',
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Text',
                                          fontSize: 16,
                                          color: const Color(0xff231f20),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ))),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.20,
                                child: Container(
                                  margin: EdgeInsets.only(top: 1),
                                  child: Text(
                                    Jiffy(
                                            widget.notif.content[widget.index]
                                                .dateNotification
                                                .substring(5, 16),
                                            "dd MMM yyyy")
                                        .fromNow(),
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Text',
                                      fontSize: 11,
                                      color:
                                          widget.notif.content.last.status == 0
                                              ? Color(0xff999999)
                                              : const Color(0xffec1c40),
                                      letterSpacing: 0.12,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                /*    margin: EdgeInsets.only(left: 10), */
                                child: Text(
                                  widget.notif.content[widget.index]
                                              .idTagType !=
                                          null
                                      ? widget.profile.parameters.tagTypesList[
                                          widget.notif.content[widget.index]
                                                  .idTagType -
                                              2]['type_label']
                                      : '',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff999999),
                                    letterSpacing: 0.12,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: RichText(
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                        text: TextSpan(
                                          text: widget
                                              .notif
                                              .content[widget.index]
                                              .serialNumber,
                                          style: TextStyle(
                                            fontFamily: 'SF Pro Text',
                                            fontSize: 12,
                                            color: const Color(0xff999999),
                                            letterSpacing: 0.12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 60),
                                child: widget.notif.content[widget.index]
                                            .status ==
                                        1
                                    ? SizedBox(
                                        child: Container(
                                          width: 20.0,
                                          height: 20.0,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.elliptical(
                                                    9999.0, 9999.0)),
                                            color: const Color(0xffec1c40),
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '1',
                                            style: TextStyle(
                                              fontFamily: 'SF Pro Text',
                                              fontSize: 10,
                                              color: const Color(0xffffffff),
                                              letterSpacing: 0.1,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Text(
                                  widget.notif.content[widget.index].content,
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff999999),
                                    letterSpacing: 0.12,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: ColorConstant.darkGray, height: 0.45, indent: 100),
          ],
        ),
        confirmDismiss: (direction) =>
            promptUser(direction, widget.profile, widget.index, context));
  }

  Future<bool> promptUser(DismissDirection direction, Profile profile,
      int index, BuildContext contect) async {
    String action;

    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text("messages_label_confirmation".tr()),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  "messages_label_ok".tr(),
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 12,
                    color: const Color(0xffec1c40),
                    letterSpacing: 0.12,
                  ),
                ),
                onPressed: () {
                  // Dismiss the dialog and
                  // also dismiss the swiped item
                  BlocProvider.of<NotificationsBloc>(contect).dispatch(
                    GoToDeleteNotifEvent(
                      profile: profile,
                      index: index,
                    ),
                  );
                  Navigator.of(context).pop(true);
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  "messages_label_cancel".tr(),
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 12,
                    color: const Color(0xffec1c40),
                    letterSpacing: 0.12,
                  ),
                ),
                onPressed: () {
                  // Dismiss the dialog but don't
                  // dismiss the swiped item
                  return Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        ) ??
        false; // In case the user dismisses the dialog by clicking away from it
  }
}
