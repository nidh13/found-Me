import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:jiffy/jiffy.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({this.notif, this.index, this.type});

  final AdminNotification notif;

  final int index;

  final String type;

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  var jiffy =
      Jiffy("Mon, 11 Aug 2014 12:53 pm PDT", "EEE, dd MMM yyyy hh:mm a zzz");
  var screenWidth, screenHeight;
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width * 0.05 / 14.5;
    screenHeight = MediaQuery.of(context).size.height * 0.040 / 13;

    //print(notification.length.toString());

    print(widget.notif.toString());
    //Si l'etat de notification est active

    return Dismissible(
        key: Key(
          widget.notif.toString(),
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
                      child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.22,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.asset("Assets/Images/noti.png"),
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                children: [
                                  widget.notif.content.length != 0
                                      ? Container(
                                          child: RichText(
                                              textAlign: TextAlign.left,
                                              text: TextSpan(
                                                text: widget.notif.content.last
                                                    .notificationType,
                                                style: TextStyle(
                                                  fontFamily: 'SF Pro Text',
                                                  fontSize: 16,
                                                  color:
                                                      const Color(0xff231f20),
                                                  letterSpacing: 0.16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )))
                                      : Container(
                                          child: Text(" "),
                                        ),
                                ],
                              ),
                              SizedBox(
                                width: screenWidth * 35,
                              ),
                              Column(
                                children: [
                                  widget.notif.content.length != 0
                                      ? Text(
                                          Jiffy(
                                                  widget.notif.content.last
                                                      .dateNotification
                                                      .substring(5, 16),
                                                  "dd MMM yyyy")
                                              .fromNow(),
                                          style: TextStyle(
                                            fontFamily: 'SF Pro Text',
                                            fontSize: 11,
                                            color: widget.notif.content.last
                                                        .status ==
                                                    0
                                                ? Color(0xff999999)
                                                : const Color(0xffec1c40),
                                            letterSpacing: 0.12,
                                          ),
                                          textAlign: TextAlign.right,
                                        )
                                      : Container(),
                                ],
                              ),
                            ],
                          ),
                          widget.notif.content.length != 0
                              ? new Text(
                                  widget.notif.content.last.title,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontFamily: 'SFProText',
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff999999),
                                    letterSpacing: 0.12,
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              : Text(""),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widget.notif.content.length != 0
                                  ? RichText(
                                      textAlign: TextAlign.left,
                                      text: TextSpan(
                                        text: widget.notif.content.last.text,
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Text',
                                          fontSize: 12,
                                          color: const Color(0xff999999),
                                          letterSpacing: 0.12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ))
                                  : Container(),
                              SizedBox(
                                width: 80,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: widget.notif.content.length != 0
                                    ? widget.notif.content.last.status == 1
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
                                                  color:
                                                      const Color(0xffffffff),
                                                  letterSpacing: 0.1,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        : Container()
                                    : Container(),
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
        confirmDismiss: (direction) => promptUser(direction));
  }

  Future<bool> promptUser(DismissDirection direction) async {
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
                  //      print(widget.notif.content.last.idNotifcation);

                  //service.setArchive(  lstNotf["Admin notification"]['content'][index]['id_notifcation'] );

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
