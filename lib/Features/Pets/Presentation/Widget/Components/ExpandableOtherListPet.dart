import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/attachmentSelection.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/popup_menu.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Core/Utils/text.dart';

class ExpandableOtherViewDes extends StatefulWidget {
  final Profile profile;
  final OtherInfo otherInfo;
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

  ExpandableOtherViewDes(
      {Key key,
      this.profile,
      this.otherInfo,
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
  _ExpandableOtherViewDesState createState() =>
      new _ExpandableOtherViewDesState();
}

//
class _ExpandableOtherViewDesState extends State<ExpandableOtherViewDes> {
  bool expandFlag = false;

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
        padding: EdgeInsets.only(top: 2.5, bottom: 2.5),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                Expanded(
                    child: widget.otherInfo.label != ""
                        ? MyText(
                            value: widget.otherInfo.label,
                            maxLines: 1,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorConstant.textColor)
                        : Container()),
                widget.switchValue
                    ? widget.attachment
                        ? Padding(
                            padding: const EdgeInsets.only(),
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
                        ? Image.asset(
                            "Assets/Images/alarm.png",
                            height: 16,
                            width: 16,
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
                            widget.otherInfo.documents != null
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        widget.otherInfo.documents.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      bool _isXRay = widget.otherInfo
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
                                            child: Row(
                                              children: [
                                                AttachmentSelection(
                                                  title: widget
                                                      .otherInfo
                                                      .documents[index]
                                                      .
documentName,
                                                  isSelected: _isXRay,
                                                  onPressed: () {
                                                    setState(() {
                                                      _isXRay = !_isXRay;
                                                    });
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 0,
                                                ),
                                             
                                              ],
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
}
