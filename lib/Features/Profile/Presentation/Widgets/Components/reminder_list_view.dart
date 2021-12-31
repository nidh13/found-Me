import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/custom_switch.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';

class ReminderView extends StatefulWidget {
  final Reminders reminder;
  final String title;
  final String date;
  final String time;
  final String type;
  bool switchVal;
  final visibileRimenders;

  ReminderView(
      {this.reminder,
      this.title,
      this.date,
      this.time,
      this.type,
      this.switchVal,
      this.visibileRimenders});

  @override
  ReminderViewState createState() => new ReminderViewState();
}

class ReminderViewState extends State<ReminderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 67,
      padding: EdgeInsets.fromLTRB(12, 6, 10, 0),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 0), // changes position of shadow
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                    widget.reminder.reminderLabel,
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
                widget.reminder.reminderDate != null
                    ? Text(
                        widget.reminder.reminderDate.substring(8, 12) +
                            " " +
                            widget.reminder.reminderDate.substring(5, 7) +
                            " " +
                            widget.reminder.reminderDate.substring(12, 16),
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
                    widget.reminder.reminderDate != null
                        ? Text(
                            widget.reminder.reminderDate.substring(17, 29),
                      textScaleFactor: 1.0,
                            style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 12,
                                color: ColorConstant.boldSmallTextColor,
                                fontWeight: FontWeight.w500),
                          )
                        : Text(
                            '--:--',
                      textScaleFactor: 1.0,
                            style: TextStyle(
                                fontFamily: 'SourceSansPro',
                                fontSize: 12,
                                color: ColorConstant.boldSmallTextColor,
                                fontWeight: FontWeight.w500),
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
                        widget.reminder.rappelReminder,
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 12,
                            color: ColorConstant.boldSmallTextColor,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Visibility(
            visible: !widget.visibileRimenders,
            child: CustomSwitch(
              activeColor: Color(0xff34C759),
              value: widget.reminder.active == 1 ? true : false,
              onChanged: (value) {
                print("VALUE : $value");
                setState(() {
                  widget.reminder.active = value == true ? 1 : 0;
                });
              },
            ),
          ),
          // Visibility(
          //   visible: widget.visibileRimenders,
          //   child: Material(
          //     // pause button (round)
          //     borderRadius: BorderRadius.circular(50), // change radius size
          //     color: Colors.red, //button colour
          //     child: InkWell(
          //       splashColor: Colors.red, // inkwell onPress colour
          //       child: SizedBox(
          //           width: 24,
          //           height: 24, //customisable size of 'button'
          //           child: Center(
          //               child: FaIcon(
          //             FontAwesomeIcons.minus,
          //             color: Colors.white,
          //             size: 16,
          //           ))
          //           /*Icon(Icons.delete, )*/
          //           ),
          //       onTap: () {
          //         setState(
          //           () {
          //             print("value of visible ");
          //           },
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
