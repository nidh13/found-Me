import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:jiffy/jiffy.dart';
import 'package:neopolis/Features/Messages/Domain/Entities/message.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neopolis/Features/Messages/Presentation/bloc/messages_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class Item extends StatefulWidget {
  final Profile profile;
  final DiscussionsMessage discussionsMessage;
  final List<String> discussionMails;
  String objet;

  Item({
    Key key,
    @required this.profile,
    @required this.discussionsMessage,
    @required this.discussionMails,
  }) : super(key: key);

  @override
  _ItemState createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    Profile profile = widget.profile;
    DiscussionsMessage discussionsMessage = widget.discussionsMessage;
    double screenWidth = MediaQuery.of(context).size.width * 0.04 / 14.5;
    double screenHeight = MediaQuery.of(context).size.height * 0.02 / 14;

    return Dismissible(
        key: Key(widget.objet),
        onDismissed: (direction) {},
        background: Container(
          width: 123.0 * screenWidth,
          height: 88.0 * screenHeight,
          color: const Color(0xffec1c40),
          padding: EdgeInsets.symmetric(horizontal: 20),
          alignment: AlignmentDirectional.centerEnd,
          child: SizedBox(
            width: 62.0 * screenWidth,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "editprofil_general_btn_delete".tr(),
                textScaleFactor: 1.0,
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
        child: new ListTile(
          contentPadding:
              EdgeInsets.fromLTRB(0, 10 * screenHeight, 0, 10 * screenWidth),
          leading: Container(
            width: 72.0,
            height: 72.0,
            /*decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: const Color(0xff999999),
            ),*/
            child: Padding(
              padding: EdgeInsets.all(12.0 * screenHeight),
              child: Image.asset('Assets/Images/Groupe5816.png'),
            ),
          ),
          title: Container(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Text(
              discussionsMessage.tagLabel == '' ||
                      discussionsMessage.tagLabel == null
                  ? 'Tag'
                  : discussionsMessage.tagLabel,
              textScaleFactor: 1.0,
              style: TextStyle(
                fontFamily: 'SF Pro Text',
                fontSize: 16,
                color: const Color(0xff231f20),
                letterSpacing: 0.16,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "objecttag_label_objecttype".tr(),
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 12,
                  color: const Color(0xff999999),
                  letterSpacing: 0.12,
                ),
                textAlign: TextAlign.left,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.45,
                child: Text(
                  discussionsMessage.messageOwner +
                      ': ' +
                      discussionsMessage.message,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 12,
                    color: const Color(0xff505050),
                    letterSpacing: 0.12,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                Jiffy(
                  DateTime.parse(discussionsMessage.sendTimeMessage).toLocal(),
                  "yyyy-MM-dd hh:mm:ss",
                ).fromNow(),
                textScaleFactor: 1.0,
                style: TextStyle(
                  fontFamily: 'SF Pro Text',
                  fontSize: 12,
                  color: const Color(0xffec1c40),
                  letterSpacing: 0.12,
                ),
                textAlign: TextAlign.right,
              ),
              if (discussionsMessage.nbUnread != 0)
                Container(
                  width: 20.0,
                  height: 20.0,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    color: const Color(0xffec1c40),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    discussionsMessage.nbUnread.toString(),
                    textScaleFactor: 1.0,
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 10,
                      color: const Color(0xffffffff),
                      letterSpacing: 0.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
            ],
          ),
        ),
        confirmDismiss: (direction) => promptUser(direction));
  }

  Future<bool> promptUser(DismissDirection direction) async {
    return await showCupertinoDialog<bool>(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            content: Text(
              "messages_label_confirmation".tr(),
              textScaleFactor: 1.0,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  "messages_label_ok".tr(),
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 12,
                    color: const Color(0xffec1c40),
                    letterSpacing: 0.12,
                  ),
                ),
                onPressed: () {
                  widget.profile.parameters.discussionMails =
                      widget.discussionMails;
                  dispatchDeteleDiscussion(widget.profile);
                  Navigator.of(context).pop(true);
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  "messages_label_cancel".tr(),
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 12,
                    color: const Color(0xffec1c40),
                    letterSpacing: 0.12,
                  ),
                ),
                onPressed: () {
                  return Navigator.of(context).pop(false);
                },
              )
            ],
          ),
        ) ??
        false; // In case the user dismisses the dialog by clicking away from it
  }

  dispatchDeteleDiscussion(Profile profile) {
    BlocProvider.of<MessagesBloc>(context).dispatch(
      DeleteDiscussionEvent(
        profile: profile,
      ),
    );
  }
}
