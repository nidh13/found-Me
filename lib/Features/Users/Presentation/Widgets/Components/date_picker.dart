import 'package:flutter/material.dart';
import 'package:neopolis/Core/Utils/colorsConstant.dart';
import 'package:neopolis/Core/Utils/date.dart';
import 'package:neopolis/Core/Utils/date_format.dart';
import 'package:neopolis/Core/Utils/date_hint.dart';
import 'package:neopolis/Core/Utils/date_util.dart';
import 'package:neopolis/Core/Utils/nullable_valid_date.dart';
import 'package:neopolis/Core/Utils/validDate.dart';
import 'package:neopolis/Features/Signin/Domain/Entities/profileEntity.dart';
import 'package:easy_localization/easy_localization.dart';

/// Creates a [DropdownDatePicker] widget instance
///
/// Displays year, month and day [DropdownButton] widgets in a [Row]
// ignore: must_be_immutable
class DropdownDatePicker extends StatefulWidget {
  /// Stores the date format how [DropdownButton] widgets should be build.
  final Date_Format dateFormat;
  Profile profile;
  int index;

  /// Mimimum date value that [DropdownButton] widgets can have.
  final ValidDate firstDate;

  /// Maximum date value that [DropdownButton] widgets can have.
  final ValidDate lastDate;

  /// Text style of the dropdown button and it's menu items
  final TextStyle textStyle;

  /// The widget to use for drawing the drop-down button's underline.
  ///
  /// Defaults to a 2.0 height bottom container with Theme.of(context).primaryColor
  final Widget underLine;

  /// The background color of the dropdown.
  ///
  /// If it is not provided, the theme's [ThemeData.canvasColor] will be used instead.
  final Color dropdownColor;

  /// If true [DropdownMenuItem]s will be built in ascending order
  final bool ascending;

  /// Contains year, month and day DropdownButton's hint texts
  ///
  /// Default is: 'yyyy', 'mm', 'dd'
  final DateHint dateHint;

  Date _currentDate;

  /// Holds the currently selected date
  Date get currentDate => _currentDate;

  /// Returns currently selected day
  int get day {
    return _currentDate?.day;
  }

  /// Returns currently selected month
  int get month {
    return _currentDate?.month;
  }

  /// Returns currently selected year
  int get year {
    return _currentDate?.year;
  }

  /// Returns date as String by a [separator]
  /// based on [dateFormat]
  String getDate([String separator = '-']) {
    String date;
    var year = _currentDate?.year;

    var month = Date.toStringWithLeadingZeroIfLengthIsTwo(_currentDate?.month);

    var day = Date.toStringWithLeadingZeroIfLengthIsOne(_currentDate?.day);

    switch (dateFormat) {
      case Date_Format.ymd:
        date = '$year$separator$month$separator$day';
        break;
      case Date_Format.dmy:
        date = '$day$separator$month$separator$year';
        break;
      case Date_Format.mdy:
        date = '$month$separator$day$separator$year';
        break;
    }
    return date;
  }

  /// Creates an instance of [DropdownDatePicker].
  ///
  /// [firstDate] must be before [lastDate]
  /// and [initialDate] must be between their range
  ///
  /// [initialDate] is optional, if not provided a hintText
  /// will be shown in their [DropDownButton]'s
  ///
  /// By default [dateFormat] is [DateFormat.ymd].
  DropdownDatePicker({
    this.profile,
    this.index,
    @required this.firstDate,
    @required this.lastDate,
    Date initialDate = const NullableValidDate.nullDate(),
    this.dateFormat = Date_Format.ymd,
    this.dateHint = const DateHint(),
    this.dropdownColor,
    this.textStyle,
    this.underLine,
    this.ascending = true,
    final Key key,
  })  : assert(firstDate < lastDate, 'First date must be before last date.'),
        assert(_isValidInitialDate(initialDate, firstDate, lastDate),
            'Initial date must be null or between first and last date.'),
        _currentDate = initialDate,
        super(key: key);

  static bool _isValidInitialDate(Date date, Date firstDate, Date lastDate) {
    if (date?.year == null) return true;
    if (date.year < firstDate.year) return true;
    if (date.year > lastDate.year) return true;
    if (date?.month == null) return true;
    if (date.month < firstDate.month) return true;
    if (date.month > lastDate.month) return true;
    if (date?.day == null) return true;
    if (date.day < firstDate.day) return true;
    if (date.day > lastDate.day) return true;

    return true;
  }

  @override
  _DropdownDatePickerState createState() => _DropdownDatePickerState();
}

class _DropdownDatePickerState extends State<DropdownDatePicker> {
  List<DropdownMenuItem<int>> _buildDropdownMenuItemList(int min, int max) {
    return _intGenerator(min, max, widget.ascending)
        .map(
          (i) => DropdownMenuItem<int>(
            value: i,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                Date.toStringWithLeadingZeroIfLengthIsOne(i),
                textScaleFactor: 1.0,
                textAlign: TextAlign.center,
                style: widget.textStyle,
              ),
            ),
          ),
        )
        .toList();
  }

  List<DropdownMenuItem<int>> _buildDropdownMenuItemListMonth(
      int min, int max) {
    return _intGenerator(min, max, widget.ascending)
        .map(
          (i) => DropdownMenuItem<int>(
            value: i,
            child: Container(
              alignment: Alignment.center,
              child: Text(
                Date.toStringWithLeadingZeroIfLengthIsTwo(i).substring(0, 3),
                textScaleFactor: 1.0,
                // textAlign: TextAlign.center,
                style: widget.textStyle,
              ),
            ),
          ),
        )
        .toList();
  }

  Widget _buildDropdownButton({
    @required final int initialValue,
    @required final String hint,
    @required final Function onChanged,
    @required final List<DropdownMenuItem<int>> items,
  }) {
    return Container(
        height: 100,
        child: DropdownButton<int>(
          underline: SizedBox(),
          isExpanded: true,
          dropdownColor: widget.dropdownColor,
          focusColor: Colors.white,
          value: initialValue,
          hint: Text(
            hint,
            textScaleFactor: 1.0, // dd, mm, yyyy
            style: TextStyle(
                fontFamily: 'SourceSansPro',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorConstant.textColor),
          ),
          onChanged: (val) => Function.apply(onChanged, [val]),
          items: items,
        ));
  }

  Widget _buildDropdownButtonMonth({
    @required final int initialValue,
    @required final String hint,
    @required final Function onChanged,
    @required final List<DropdownMenuItem<int>> items,
  }) {
    return Container(
        height: 100,
        child: DropdownButton<int>(
          underline: SizedBox(),
          isExpanded: true,
          dropdownColor: widget.dropdownColor,
          focusColor: Colors.white,
          value: initialValue,
          hint: Text(
            hint,
            textScaleFactor: 1.0, // dd, mm, yyyy
            style: TextStyle(
                fontFamily: 'SourceSansPro',
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorConstant.textColor),
          ),
          onChanged: (val) => Function.apply(onChanged, [val]),
          items: items,
        ));
  }

  Iterable<int> _intGenerator(int start, int end, bool ascending) sync* {
    if (ascending) {
      for (var i = start; i <= end; i++) {
        yield i;
      }
    } else {
      for (var i = end; i >= start; i--) {
        yield i;
      }
    }
  }

  Widget _buildYearDropdownButton() {
    return Container(
        height: 24,
        width: 80,
        padding: EdgeInsets.only(left: 5, right: 1),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        // border: Border.all(style: BorderStyle.solid, width: 0.70),
        child: _buildDropdownButton(
          items: _buildDropdownMenuItemList(
            widget.firstDate.year,
            widget.lastDate.year,
          ),
          initialValue: widget._currentDate?.year,
          hint: widget.dateHint.year,
          onChanged: (final year) => setState(() {
            widget.profile.userGeneralInfo.update = true;

            widget._currentDate = widget._currentDate.copyWith(year: year);
          }),
        ));
  }

  Widget _buildMonthDropdownButton() {
    var minMonth = 1;
    var maxMonth = 12;

    if (widget._currentDate?.year != null) {
      if (widget.firstDate.year == widget._currentDate?.year) {
        minMonth = widget.firstDate.month;
        if (widget._currentDate?.month != null &&
            widget._currentDate.month < widget.firstDate.month) {
          widget._currentDate = widget._currentDate.copyWith(month: minMonth);
        }
      }
      if (widget.lastDate.year == widget._currentDate?.year) {
        maxMonth = widget.lastDate.month;
        if (widget._currentDate?.month != null &&
            widget._currentDate.month > widget.lastDate.month) {
          widget._currentDate = widget._currentDate.copyWith(month: maxMonth);
        }
      }
    } else {
      widget._currentDate =
          widget._currentDate.copyWith(month: widget._currentDate?.month);
    }
    return Container(
        height: 24,
        width: 70,
        padding: EdgeInsets.only(left: 5, right: 1),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        // border: Border.all(style: BorderStyle.solid, width: 0.70),
        child: _buildDropdownButtonMonth(
          items: _buildDropdownMenuItemListMonth(
            minMonth,
            maxMonth,
          ),
          initialValue: widget._currentDate?.month,
          hint: widget.dateHint.month,
          onChanged: (final month) => setState(() {
            widget.profile.userGeneralInfo.update = true;

            widget._currentDate = widget._currentDate.copyWith(month: month);
          }),
        ));
  }

  Widget _buildDayDropdownButton() {
    var minDay = 1;
    var maxDay = DateUtil.daysInDate(
      month: widget._currentDate?.month,
      year: widget._currentDate?.year,
    );

    if (widget._currentDate?.month != null) {
      if (widget._currentDate?.year != null) {
        if (widget.firstDate.year == widget._currentDate?.year &&
            widget.firstDate.month >= widget._currentDate?.month) {
          minDay = widget.firstDate.day;
          if (widget._currentDate.day != null &&
              widget.firstDate.day >= widget._currentDate?.day) {
            widget._currentDate = widget._currentDate.copyWith(day: minDay);
          }
        }
        if (widget.lastDate.year == widget._currentDate?.year &&
            widget.lastDate.month <= widget._currentDate?.month) {
          maxDay = widget.lastDate.day;
          if (widget._currentDate.day != null &&
              widget.lastDate.day <= widget._currentDate?.day) {
            widget._currentDate = widget._currentDate.copyWith(day: maxDay);
          }
        }
      }
    }

    return Container(
        height: 24,
        width: 62,
        padding: EdgeInsets.only(left: 5, right: 1),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        // border: Border.all(style: BorderStyle.solid, width: 0.70),
        child: _buildDropdownButton(
          items: _buildDropdownMenuItemList(minDay, maxDay),
          initialValue: widget._currentDate?.day,
          hint: widget.dateHint.day,
          onChanged: (final day) => setState(() {
            widget.profile.userGeneralInfo.update = true;
            widget._currentDate = widget._currentDate.copyWith(day: day);
          }),
        ));
  }

  List<Widget> _buildDropdownButtonsByDateFormat() {
    final dropdownButtonList = <Widget>[];

    switch (widget.dateFormat) {
      case Date_Format.dmy:
        dropdownButtonList
          ..add(
            Text("editprofil_medical_label_day".tr(),
                textScaleFactor: 1.0,
                style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: ColorConstant.textColor)),
          )
          ..add(_buildDayDropdownButton())
          ..add(
            Text('editprofil_medical_label_month'.tr(),
                textScaleFactor: 1.0,
                style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: ColorConstant.textColor)),
          )
          ..add(_buildMonthDropdownButton());
        break;
      case Date_Format.ymd:
        dropdownButtonList
          ..add(_buildYearDropdownButton())
          ..add(_buildMonthDropdownButton())
          ..add(_buildDayDropdownButton());
        break;
      case Date_Format.mdy:
        dropdownButtonList
          ..add(_buildMonthDropdownButton())
          ..add(_buildDayDropdownButton())
          ..add(_buildYearDropdownButton());
        break;
    }
    return dropdownButtonList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
            .birthInfo.day =
        Date.toStringWithLeadingZeroIfLengthIsOne(widget._currentDate.day);
    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
        .birthInfo.month = widget._currentDate.month ==
            null
        ? widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
            .birthInfo.month
        : Date.toStringWithLeadingZeroIfLengthIsOne(widget._currentDate.month)
            .toString();
    widget.profile.userGeneralInfo.subUsers[widget.index].userGeneralInfo
        .birthInfo.year = widget._currentDate.year;
    return Column(
      children: [
        Row(children: [
          Expanded(
              flex: 2,
              child: Row(
                children: [
                  Text("editprofil_medical_label_day".tr(),
                      textScaleFactor: 1.0,
                      style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorConstant.textColor)),
                  SizedBox(
                    width: 22,
                  ),
                  _buildDayDropdownButton(),
                ],
              )),
          Expanded(
              flex: 3,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Text("editprofil_medical_label_month".tr(),
                        textScaleFactor: 1.0,
                        style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorConstant.textColor)),
                  ),
                  SizedBox(
                    width: 22,
                  ),
                  _buildMonthDropdownButton()
                ],
              ))
        ]),
        Padding(
            padding: const EdgeInsets.only(top: 12.5, bottom: 12.5),
            child: Container(
              height: 0.40,
              color: ColorConstant.dividerColor.withOpacity(.30),
            )),
        Row(
          children: [
            Text("editprofil_medical_label_year".tr(),
                textScaleFactor: 1.0,
                style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: ColorConstant.textColor)),
            SizedBox(
              width: 22,
            ),
            _buildYearDropdownButton()
          ],
        ),
      ],
    );
  }
}
