import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Features/Profile/Presentation/Widgets/Components/button.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/cupertino_Time.dart';
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/customCalendar.dart';
import 'package:neopolis/Core/Utils/text.dart';
import 'package:easy_localization/easy_localization.dart';

class AlertDialogueReminder extends ModalRoute {
  @override
  Duration get transitionDuration => Duration(milliseconds: 300);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  double screenWidth;
  double screenHeight;
  Reminders reminders;
  int index;
  int indexSubUser;
  Profile profile;
  List reminderList;
  AlertDialogueReminder(
      Profile profile, int index, int indexSubUser, List reminderList) {
    this.reminders = reminders;
    this.profile = profile;
    this.index = index;
    this.indexSubUser = indexSubUser;
    this.reminderList = reminderList;
  }

  DateTime _time = DateTime.now();
  bool _clicked = false;
  int _selectTime(int hr, int ampm) {
    if (ampm == 1) {
      if (hr != 12) {
        hr = hr + 12;
      }
      return hr;
    } else if (hr == 12) {
      hr = 00;
      return hr;
    } else {
      return 0 + hr;
    }
  }

  TextEditingController nameController;
  TextEditingController dosageController;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  //NewEntryBloc _newEntryBloc;
  FixedExtentScrollController scrollRecurringController;
  int _hourColorIndex = 0;
  int selectedHour = 1;
  int selectedYear;
  int selectedMonth;
  int selectedDay;

  double itemExtent = 45.0;
  FixedExtentScrollController scrollHourController;
  FixedExtentScrollController scrollMinuteController;
  FixedExtentScrollController scrollAmPmController;

  int _minuteColorIndex = 10;
  int selectedMinute = 00;

  int _amPmColorIndex = 1;
  int amPm = 0;

  int _recurringColorIndex = 2;
  double height = 230;
// List<String> date =["1","2","3"];
  static List<String> hour = [
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12"
  ];
  static List<String> minute = [
    "00",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
    "24",
    "25",
    "26",
    "27",
    "28",
    "29",
    "30",
    "31",
    "32",
    "33",
    "34",
    "35",
    "36",
    "37",
    "38",
    "39",
    "40",
    "41",
    "42",
    "43",
    "44",
    "45",
    "46",
    "47",
    "48",
    "49",
    "50",
    "51",
    "52",
    "53",
    "54",
    "55",
    "56",
    "57",
    "58",
    "59"
  ];

  var _newEntryBloc;

  int recurring = 0;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Reminders reminder = new Reminders(
      status: 1,
      active: 1,
      id: null,
      reminderDate: "Fri, " +
          DateTime.now().day.toString() +
          ' ' +
          DateFormat.MMMM().format(DateTime.now()).toString().substring(0, 3) +
          ' ' +
          DateTime.now().year.toString() +
          " 00:00:00 GMT",
      reminderDescription: "reminders_label_houly".tr(),
      reminderLabel: '',
      rappelId: 1,
      rappelReminder: "reminders_label_houly".tr());
  Widget _buildOverlayContent(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      if (Orientation.portrait == orientation) {
        screenWidth = MediaQuery.of(context).size.width;
        screenHeight = MediaQuery.of(context).size.height;
      } else {
        screenWidth = MediaQuery.of(context).size.height;
        screenHeight = MediaQuery.of(context).size.width;
      }
      return Container(
        height: screenHeight * 1.0,
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                width: screenWidth * 0.99,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Column(
                  children: <Widget>[
                    Container(
                        height: 128,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                          color: ColorConstant.pinkColor,
                        ),
                        child: Row(children: <Widget>[
                          // IconButton(
                          //   icon: Image.asset(
                          //     "assets/image/arrow-white-back.png",
                          //     height: 13.5,
                          //     width: 21,
                          //   ),
                          //   onPressed: () {
                          //     Navigator.pop(context, true);
                          //   },
                          // ),
                          Expanded(
                            child: MyText(
                                value: "drawer_label_remindersalarms".tr(),
                                textAlign: TextAlign.center,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                        ])),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 17, right: 17, top: 14.5),
                        child: MyText(
                          value: "reminders_label_setdesc".tr(),
                          color: ColorConstant.pinkColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: MediaQuery(
                        data: MediaQuery.of(context).copyWith(
                          textScaleFactor: MediaQuery.of(context)
                              .textScaleFactor
                              .clamp(1.0, 1.0),
                        ),
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          controller: nameController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                          onChanged: (value) {
                            reminder.reminderLabel = value;
                          },
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 17, right: 17, top: 14.5),
                        child: MyText(
                          value: "reminders_label_setdatetime".tr(),
                          color: ColorConstant.pinkColor,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 34.0),
                      child: CustomCalendar(
                        initialCalendarMode: Mt_DatePickerMode.day,
                        firstDate: new DateTime(DateTime.now().year),
                        lastDate: new DateTime(DateTime.now().year + 5),
                        initialDate: DateTime.now(),
                        onDateChanged: (date) {
                          setState(() {
                            selectedYear = date.year;
                            selectedMonth = date.month;
                            selectedDay = date.day;
                          });

                          DateFormat.MMMM().format(date);
                          reminder.reminderDate = reminder.reminderDate
                              .replaceRange(
                                  8,
                                  11,
                                  DateFormat.MMMM()
                                      .format(date)
                                      .substring(0, 3));

                          reminder.reminderDate = reminder.reminderDate
                              .replaceRange(
                                  5,
                                  7,
                                  date.day.toString().length == 1
                                      ? ' ' + date.day.toString()
                                      : date.day.toString());
                          print(reminder.reminderDate.substring(13, 16));
                          print(date.year.toString());
                          reminder.reminderDate = reminder.reminderDate
                              .replaceRange(12, 16, date.year.toString());

                          print(date.day);
                          print(reminder.reminderDate);
                        },
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: height,
                            width: 50,
                            child: CupertinoPicker(
                              scrollController: scrollHourController,
                              itemExtent: itemExtent,
                              borderSize: 1.0,
                              borderWidth: 40,
                              borderColor: ColorConstant.blackBorder,
                              children: <Widget>[
                                for (var i = 0; i < hour.length; i++)
                                  Center(
                                    child: MyText(
                                        value: hour[i].toString(),
                                        fontSize: selectedHour.compareTo(
                                                    int.parse(hour[i])) ==
                                                0
                                            ? 22
                                            : 18,
                                        color: selectedHour.compareTo(
                                                    int.parse(hour[i])) ==
                                                0
                                            ? ColorConstant.pinkColor
                                            : Colors.black),
                                  ),
                              ],
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  print(selectedHour);
                                  selectedHour = index + 1;
                                });
                              },
                              looping: true,
                            ),
                          ),
                          SizedBox(
                            width: 19,
                          ),
                          MyText(
                              value: ":",
                              color: ColorConstant.greyTextColor,
                              fontSize: 23,
                              fontWeight: FontWeight.w500),
                          SizedBox(
                            width: 19,
                          ),
                          Container(
                            width: 50,
                            height: height,
                            child: CupertinoPicker(
                              scrollController: scrollMinuteController,
                              itemExtent: itemExtent,
                              borderSize: 1.0,
                              borderWidth: 40,
                              borderColor: ColorConstant.blackBorder,
                              children: <Widget>[
                                for (var i = 0; i < minute.length; i++)
                                  Center(
                                    child: MyText(
                                        value: minute[i].toString(),
                                        fontSize: selectedMinute.compareTo(
                                                    int.parse(minute[i])) ==
                                                0
                                            ? 22
                                            : 18,
                                        color: selectedMinute.compareTo(
                                                    int.parse(minute[i])) ==
                                                0
                                            ? ColorConstant.pinkColor
                                            : Colors.black),
                                  ),
                              ],
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  selectedMinute = index;
                                  print(minute[selectedMinute].toString());

                                  reminder.reminderDate = reminder.reminderDate
                                      .replaceRange(20, 22,
                                          minute[selectedMinute].toString());
                                });
                              },
                              looping: true,
                            ),
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Container(
                            width: 50,
                            child: CupertinoPicker(
                              scrollController: scrollAmPmController,
                              itemExtent: itemExtent,
                              borderSize: 1.0,
                              borderWidth: 40,
                              borderColor: ColorConstant.blackBorder,
                              children: <Widget>[
                                Center(
                                  child: MyText(
                                      value: "reminders_label_am".tr(),
                                      fontSize: amPm == 0 ? 22 : 17,
                                      color: amPm == 0
                                          ? ColorConstant.pinkColor
                                          : Colors.black),
                                ),
                                Center(
                                  child: MyText(
                                      value: "reminders_label_pm".tr(),
                                      fontSize: amPm == 1 ? 22 : 17,
                                      color: amPm == 1
                                          ? ColorConstant.pinkColor
                                          : Colors.black),
                                ),
                              ],
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  amPm = index;

                                  // ss=index==Colors.green;
                                });

                                //   ss=Colors.green;//:Colors.yellow;
                              },
                              //looping: true,
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 17, right: 17, top: 15),
                      height: 1,
                      decoration: BoxDecoration(
                        color: ColorConstant.blackBorder,
                      ),
                    ),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 17, right: 17, top: 14.5),
                            child: MyText(
                              value: "reminders_label_recurring".tr(),
                              color: ColorConstant.pinkColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 178,
                            width: 80,
                            child: CupertinoPicker(
                              scrollController: scrollRecurringController,
                              itemExtent: 50,

                              children: <Widget>[
                                Center(
                                  child: MyText(
                                      value: "reminders_label_houly".tr(),
                                      fontSize: recurring == 0 ? 22 : 17,
                                      color: recurring == 0
                                          ? Colors.pink
                                          : Colors.black),
                                ),
                                Center(
                                  child: MyText(
                                      value: "reminders_label_weekly".tr(),
                                      fontSize: recurring == 1 ? 22 : 17,
                                      color: recurring == 1
                                          ? ColorConstant.pinkColor
                                          : Colors.black),
                                ),
                                Center(
                                  child: MyText(
                                      value: "reminders_label_monthly".tr(),
                                      fontSize: recurring == 2 ? 22 : 17,
                                      color: recurring == 2
                                          ? ColorConstant.pinkColor
                                          : Colors.black),
                                ),
                                Center(
                                  child: MyText(
                                      value: "reminders_label_yearly".tr(),
                                      fontSize: recurring == 3 ? 22 : 17,
                                      color: recurring == 3
                                          ? ColorConstant.pinkColor
                                          : Colors.black),
                                ),
                              ],
                              onSelectedItemChanged: (int index) {
                                setState(() {
                                  recurring = index;
                                  if (recurring == 0) {
                                    reminder.reminderDescription =
                                        "reminders_label_houly".tr();
                                    reminder.rappelReminder =
                                        "reminders_label_houly".tr();
                                    reminder.rappelId = 1;
                                  }
                                  if (recurring == 1) {
                                    reminder.reminderDescription =
                                        "reminders_label_weekly".tr();
                                    reminder.rappelId = 2;
                                    reminder.rappelReminder =
                                        "reminders_label_weekly".tr();
                                  } else if (recurring == 2) {
                                    reminder.reminderDescription =
                                        "reminders_label_monthly".tr();
                                    reminder.rappelReminder =
                                        "reminders_label_monthly".tr();

                                    reminder.rappelId = 3;
                                  } else if (recurring == 3) {
                                    reminder.reminderDescription =
                                        "reminders_label_yearly".tr();
                                    reminder.rappelReminder =
                                        "reminders_label_yearly".tr();

                                    reminder.rappelId = 4;
                                  }
                                  // ss=index==Colors.green;
                                });
                                //   ss=Colors.green;//:Colors.yellow;
                              },
                              //looping: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                          left: 17, right: 17, bottom: 24.5),
                      height: 1,
                      decoration: BoxDecoration(
                        color: ColorConstant.blackBorder,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 17, right: 17, bottom: 50),
                      child: MyButton(
                        title: "reminders_label_savereminder".tr(),
                        height: 46,
                        titleSize: 14,
                        fontWeight: FontWeight.w600,
                        titleColor: ColorConstant.pinkColor,
                        cornerRadius: 5.0,
                        btnBgColor: ColorConstant.boxColor,
                        onPressed: () {
                          setState(() {
                            print(amPm);
                            print(_selectTime(
                                    int.parse(hour[selectedHour - 1]), amPm)
                                .toString());

                            reminder.reminderDate = reminder.reminderDate
                                .replaceRange(
                                    17,
                                    19,
                                    hour[selectedHour - 1] == 12.toString()
                                        ? "00"
                                        : _selectTime(
                                                        int.parse(hour[
                                                            selectedHour - 1]),
                                                        amPm)
                                                    .toString()
                                                    .length ==
                                                1
                                            ? '0' +
                                                _selectTime(
                                                        int.parse(hour[
                                                            selectedHour - 1]),
                                                        amPm)
                                                    .toString()
                                            : _selectTime(
                                                    int.parse(
                                                        hour[selectedHour - 1]),
                                                    amPm)
                                                .toString());

                            reminderList.add(reminder);
                          });

                          Navigator.of(context).pop(() {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("Assets/Images/close.png"),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
