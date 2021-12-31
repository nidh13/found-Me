import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/semantics.dart';

import 'dart:math' as math;
import 'package:neopolis/Features/Users/Presentation/Widgets/Components/customDate_utils.dart' as customDateUtils;
import 'package:neopolis/Core/Utils/colorsConstant.dart';


const double _dayPickerRowHeight = 48.0;
const int _maxDayPickerRowCount = 6; // A 31 day month that starts on Saturday.
const double _maxDayPickerHeight = _dayPickerRowHeight * (_maxDayPickerRowCount + 1);
const double _monthPickerHorizontalPadding = 8.0;

const int _yearPickerColumnCount = 3;
const double _yearPickerPadding = 16.0;
const double _yearPickerRowHeight = 52.0;
const double _yearPickerRowSpacing = 8.0;

const int _monthPickerColumnCount = 3;
const double _monthPickerPadding = 16.0;
const double _monthPickerRowHeight = 52.0;
const double _monthPickerRowSpacing = 8.0;

const double _subHeaderHeight = 52.0;
const double _monthNavButtonsWidth = 108.0;

enum Mt_DatePickerMode {
  /// Choosing a day.
  day,

  /// Choosing a month.
  month,

  /// Choosing a year.
  year,
}

class CustomCalendar extends StatefulWidget {

  CustomCalendar({
    Key key,
    @required DateTime initialDate,
    @required DateTime firstDate,
    @required DateTime lastDate,
    this.initialCalendarMode = Mt_DatePickerMode.day,
    this.selectableDayPredicate,
    @required this.onDateChanged,
  }) : assert(initialDate != null),
        assert(firstDate != null),
        assert(lastDate != null),
        initialDate = customDateUtils.dateOnly(initialDate),
        firstDate = customDateUtils.dateOnly(firstDate),
        lastDate = customDateUtils.dateOnly(lastDate),
        assert(onDateChanged != null),
        assert(initialCalendarMode != null),
        super(key: key){
    assert(
    !this.lastDate.isBefore(this.firstDate),
    'lastDate ${this.lastDate} must be on or after firstDate ${this.firstDate}.'
    );
    assert(
    !this.initialDate.isBefore(this.firstDate),
    'initialDate ${this.initialDate} must be on or after firstDate ${this.firstDate}.'
    );
    assert(
    !this.initialDate.isAfter(this.lastDate),
    'initialDate ${this.initialDate} must be on or before lastDate ${this.lastDate}.'
    );
    assert(
    selectableDayPredicate == null || selectableDayPredicate(this.initialDate),
    'Provided initialDate ${this.initialDate} must satisfy provided selectableDayPredicate.'
    );
  }


  /// The initially selected [DateTime] that the picker should display.
  final DateTime initialDate;

  /// The earliest allowable [DateTime] that the user can select.
  final DateTime firstDate;

  /// The latest allowable [DateTime] that the user can select.
  final DateTime lastDate;

  /// The initial display of the calendar picker.
  final Mt_DatePickerMode initialCalendarMode;

  /// Called when the user selects a date in the picker.
  final ValueChanged<DateTime> onDateChanged;


  /// Function to provide full control over which dates in the calendar can be selected.
  final SelectableDayPredicate selectableDayPredicate;

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  bool _announcedInitialDate = false;
  DateTime _currentDisplayedMonthDate;
  DateTime _selectedDate;
  Mt_DatePickerMode _mode;
  final GlobalKey _monthPickerKey = GlobalKey();
  final GlobalKey _yearPickerKey = GlobalKey();
  MaterialLocalizations _localizations;
  TextDirection _textDirection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mode = widget.initialCalendarMode;
    _currentDisplayedMonthDate = DateTime(widget.initialDate.year, widget.initialDate.month);
    _selectedDate = widget.initialDate;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = MaterialLocalizations.of(context);
    _textDirection = Directionality.of(context);
    if (!_announcedInitialDate) {
      _announcedInitialDate = true;
      SemanticsService.announce(
        _localizations.formatFullDate(_selectedDate),
        _textDirection,
      );
    }
  }

  void _handleModeChanged(Mt_DatePickerMode mode) {
    setState(() {
      _mode = mode;
      if (_mode == Mt_DatePickerMode.day) {
        SemanticsService.announce(
          _localizations.formatMonthYear(_selectedDate),
          _textDirection,
        );
      } else {
        SemanticsService.announce(
          _localizations.formatYear(_selectedDate),
          _textDirection,
        );
      }
    });
  }

  void _handleMonthChanged(DateTime date) {
    setState(() {
      _mode = Mt_DatePickerMode.day;
      if (_currentDisplayedMonthDate.year != date.year || _currentDisplayedMonthDate.month != date.month) {
        _currentDisplayedMonthDate = DateTime(date.year, date.month);
        _selectedDate = DateTime(date.year, date.month, _selectedDate.day);
//        widget.onDisplayedMonthChanged?.call(_currentDisplayedMonthDate);
      }
    });
  }

  void _handleYearChanged(DateTime value) {

    if (value.isBefore(widget.firstDate)) {
      value = widget.firstDate;
    } else if (value.isAfter(widget.lastDate)) {
      value = widget.lastDate;
    }

    setState(() {
      _handleMonthChanged(value);
    });
  }

  void _handleDayChanged(DateTime value) {
    setState(() {
      _selectedDate = value;
      widget.onDateChanged?.call(_selectedDate);
    });
  }

  Widget _buildPicker() {
    assert(_mode != null);
    switch (_mode) {
      case Mt_DatePickerMode.day:
        return Padding(
            padding: const EdgeInsets.only(top: 21),
            child: _MtDayPicker(
              key: _monthPickerKey,
              initialMonth: _currentDisplayedMonthDate,
              currentDate: DateTime.now(),
              firstDate: widget.firstDate,
              lastDate: widget.lastDate,
              selectedDate: _selectedDate.isAfter(widget.lastDate) ? widget.lastDate : _selectedDate.isBefore(widget.firstDate) ? widget.firstDate : _selectedDate,
              onChanged: _handleDayChanged,
              onDisplayedMonthChanged: _handleMonthChanged,
              selectableDayPredicate: widget.selectableDayPredicate,
            ),
        );
      case Mt_DatePickerMode.month:
        return Padding(
            padding: const EdgeInsets.only(top: _subHeaderHeight),
            child: _MtMonthPicker(
              key: _monthPickerKey,
              currentDate: DateTime.now(),
              firstDate: widget.firstDate,
              lastDate: widget.lastDate,
              initialDate: _currentDisplayedMonthDate,
              selectedDate: _selectedDate,
              onChanged: _handleMonthChanged,
            )
        );
      case Mt_DatePickerMode.year:
        return Padding(
          padding: const EdgeInsets.only(top: _subHeaderHeight),
          child: _MtYearPicker(
            key: _yearPickerKey,
            currentDate: DateTime.now(),
            firstDate: widget.firstDate,
            lastDate: widget.lastDate,
            initialDate: _currentDisplayedMonthDate,
            selectedDate: _selectedDate,
            onChanged: _handleYearChanged,
          )
        );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SizedBox(
          height: _maxDayPickerHeight,
          child: _buildPicker()
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                color: ColorConstant.textfieldColor
              ),
              child: _MonthDropDown(
                  mode: _mode,
                  title: customDateUtils.formatMonth(_currentDisplayedMonthDate),
                  onTitlePressed: (){
                    // Toggle the day/year mode.
                    _handleModeChanged(_mode == Mt_DatePickerMode.day ? Mt_DatePickerMode.month : _mode == Mt_DatePickerMode.year ? Mt_DatePickerMode.month : Mt_DatePickerMode.day);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Container(
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  color: ColorConstant.textfieldColor
                ),
                child: _YearDropDown(
                    mode: _mode,
                    title: _localizations.formatYear(_currentDisplayedMonthDate),
                    onTitlePressed: (){
                      // Toggle the day/year mode.
                      _handleModeChanged(_mode == Mt_DatePickerMode.day ? Mt_DatePickerMode.year : _mode == Mt_DatePickerMode.month ? Mt_DatePickerMode.year : Mt_DatePickerMode.day);
                    }),
              ),
            ),

          ],
        ),
      ],
    );
  }
}

//    Month DropDown
class _MonthDropDown extends StatefulWidget {
  const _MonthDropDown({
    @required this.mode,
    @required this.title,
    @required this.onTitlePressed});

  /// The current display of the calendar picker.
  final Mt_DatePickerMode mode;

  /// The text that displays the current month/year being viewed.
  final String title;

  /// The callback when the title is pressed.
  final VoidCallback onTitlePressed;

  @override
  __MonthDropDownState createState() => __MonthDropDownState();
}

class __MonthDropDownState extends State<_MonthDropDown> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      value: widget.mode == Mt_DatePickerMode.month ? 0.5 : 0,
      upperBound: 0.5,
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(_MonthDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mode == widget.mode) {
      return;
    }

    if (widget.mode == Mt_DatePickerMode.month) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }


  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color controlColor = colorScheme.onSurface.withOpacity(0.60);

    return Container(
      height: _subHeaderHeight,
      child:Semantics(
        // TODO(darrenaustin): localize 'Select year'
        label: 'Select month',
        excludeSemantics: true,
        button: true,
        child: Container(
          height: _subHeaderHeight,
          child: InkWell(
            onTap: widget.onTitlePressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      widget.title,
                        textScaleFactor: 1.0,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w600, color: ColorConstant.textColor)
                      /*textTheme.subtitle2?.copyWith(
                        color: controlColor,
                      ),*/
                    ),
                  ),
                  RotationTransition(
                    turns: _controller,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: controlColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

//    Year DropDown
class _YearDropDown extends StatefulWidget {
  const _YearDropDown({
    @required this.mode,
    @required this.title,
    @required this.onTitlePressed});
  
  /// The current display of the calendar picker.
  final Mt_DatePickerMode mode;

  /// The text that displays the current month/year being viewed.
  final String title;

  /// The callback when the title is pressed.
  final VoidCallback onTitlePressed;
  
  @override
  _YearDropDownState createState() => _YearDropDownState();
}

class _YearDropDownState extends State<_YearDropDown> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      value: widget.mode == Mt_DatePickerMode.year ? 0.5 : 0,
      upperBound: 0.5,
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }


  @override
  void didUpdateWidget(_YearDropDown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mode == widget.mode) {
      return;
    }

    if (widget.mode == Mt_DatePickerMode.year) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Color controlColor = colorScheme.onSurface.withOpacity(0.60);

    return Container(
      height: _subHeaderHeight,
      child: Semantics(
        // TODO(darrenaustin): localize 'Select year'
        label: 'Select year',
        excludeSemantics: true,
        button: true,
        child: Container(
          height: _subHeaderHeight,
          child: InkWell(
            onTap: widget.onTitlePressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Text(
                      widget.title,
                        textScaleFactor: 1.0,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w600, color: ColorConstant.textColor)
                      /*textTheme.subtitle2?.copyWith(
                        color: controlColor,
                      ),*/
                    ),
                  ),
                  RotationTransition(
                    turns: _controller,
                    child: Icon(
                      Icons.arrow_drop_down,
                      color: controlColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}


//    Month Picker
class _MtMonthPicker extends StatefulWidget {

  _MtMonthPicker({
    Key key,
    @required this.currentDate,
    @required this.firstDate,
    @required this.lastDate,
    @required this.initialDate,
    @required this.selectedDate,
    @required this.onChanged,
  }) : assert(currentDate != null),
        assert(firstDate != null),
        assert(lastDate != null),
        assert(initialDate != null),
        assert(selectedDate != null),
        assert(onChanged != null),
        assert(!firstDate.isAfter(lastDate)),
        super(key: key);

  /// The current date.
  ///
  /// This date is subtly highlighted in the picker.
  final DateTime currentDate;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// The initial date to center the year display around.
  final DateTime initialDate;

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a year.
  final ValueChanged<DateTime> onChanged;

  @override
  __MtMonthPickerState createState() => __MtMonthPickerState();
}

class __MtMonthPickerState extends State<_MtMonthPicker> {
  static const int _itemCount = 12;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  Widget _buildMonthItem(BuildContext context, int index) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    final int month = index + 1;
    final bool isSelected = month == widget.selectedDate.month;
    final bool isCurrentYear = month == widget.currentDate.month && widget.currentDate.year == widget.selectedDate.year;
    final bool isDisabled = false/*year < widget.currentDate.month*/;
    const double decorationHeight = 36.0;
    const double decorationWidth = 100.0;

    Color textColor;
    if (isSelected) {
      textColor = colorScheme.onPrimary;
    } else if (isDisabled) {
      textColor = colorScheme.onSurface.withOpacity(0.38);
    } else if (isCurrentYear) {
      textColor = colorScheme.primary;
    } else {
      textColor = ColorConstant.calendarTextColor;
    }
    final TextStyle itemStyle = TextStyle(fontSize: 16.0, color: textColor);

    BoxDecoration decoration;
    if (isSelected) {
      decoration = BoxDecoration(
        color: ColorConstant.pinkColor,
        borderRadius: BorderRadius.circular(decorationHeight / 2),
        shape: BoxShape.rectangle,
      );
    } else if (isCurrentYear && !isDisabled) {
      decoration = BoxDecoration(
        border: Border.all(
          color: ColorConstant.pinkColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(decorationHeight / 2),
        shape: BoxShape.rectangle,
      );
    }

    Widget monthItem = Center(
      child: Container(
        decoration: decoration,
        height: decorationHeight,
        width: decorationWidth,
        child: Center(
          child: Semantics(
            selected: isSelected,
            child: Text(customDateUtils.formatMonth(DateTime(0, month)),textScaleFactor: 1.0, style: itemStyle),
          ),
        ),
      ),
    );

    if (isDisabled) {
      monthItem = ExcludeSemantics(
        child: monthItem,
      );
    } else {
      monthItem = InkWell(
        key: ValueKey<int>(month),
        onTap: () {
          widget.onChanged(
            DateTime(
              widget.initialDate.year,
              month,
              widget.initialDate.day,
            ),
          );
        },
        child: monthItem,
      );
    }

    return monthItem;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(),
        Expanded(
          child: GridView.builder(
            gridDelegate: _monthPickerGridDelegate,
            itemBuilder: _buildMonthItem,
            itemCount: _itemCount,
            padding: const EdgeInsets.symmetric(horizontal: _yearPickerPadding),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class _MonthPickerGridDelegate extends SliverGridDelegate {
  const _MonthPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double tileWidth =
        (constraints.crossAxisExtent - (_yearPickerColumnCount - 1) * _yearPickerRowSpacing) / _yearPickerColumnCount;
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: _yearPickerRowHeight,
      crossAxisCount: _yearPickerColumnCount,
      crossAxisStride: tileWidth + _yearPickerRowSpacing,
      mainAxisStride: _yearPickerRowHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_YearPickerGridDelegate oldDelegate) => false;
}

const _MonthPickerGridDelegate _monthPickerGridDelegate = _MonthPickerGridDelegate();


//  Year Picker
class _MtYearPicker extends StatefulWidget {

  _MtYearPicker({
    Key key,
    @required this.currentDate,
    @required this.firstDate,
    @required this.lastDate,
    @required this.initialDate,
    @required this.selectedDate,
    @required this.onChanged,
  }) : assert(currentDate != null),
        assert(firstDate != null),
        assert(lastDate != null),
        assert(initialDate != null),
        assert(selectedDate != null),
        assert(onChanged != null),
        assert(!firstDate.isAfter(lastDate)),
        super(key: key);

  /// The current date.
  ///
  /// This date is subtly highlighted in the picker.
  final DateTime currentDate;

  /// The earliest date the user is permitted to pick.
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  final DateTime lastDate;

  /// The initial date to center the year display around.
  final DateTime initialDate;

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a year.
  final ValueChanged<DateTime> onChanged;

  @override
  _MtYearPickerState createState() => _MtYearPickerState();
}

class _MtYearPickerState extends State<_MtYearPicker> {
  ScrollController scrollController;

  // The approximate number of years necessary to fill the available space.
  static const int minYears = 18;

  @override
  void initState() {
    super.initState();

    // Set the scroll position to approximately center the initial year.
    final int initialYearIndex = widget.selectedDate.year - widget.firstDate.year;
    final int initialYearRow = initialYearIndex ~/ _yearPickerColumnCount;
    // Move the offset down by 2 rows to approximately center it.
    final int centeredYearRow = initialYearRow - 2;
    final double scrollOffset = _itemCount < minYears ? 0 : centeredYearRow * _yearPickerRowHeight;
    scrollController = ScrollController(initialScrollOffset: scrollOffset);
  }

  Widget _buildYearItem(BuildContext context, int index) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextTheme textTheme = Theme.of(context).textTheme;

    // Backfill the _YearPicker with disabled years if necessary.
    final int offset = _itemCount < minYears ? (minYears - _itemCount) ~/ 2 : 0;
    final int year = widget.firstDate.year + index - offset;
    final bool isSelected = year == widget.selectedDate.year;
    final bool isCurrentYear = year == widget.currentDate.year;
    final bool isDisabled = year < widget.firstDate.year || year > widget.lastDate.year;
    const double decorationHeight = 36.0;
    const double decorationWidth = 72.0;

    Color textColor;
    if (isSelected) {
      textColor = colorScheme.onPrimary;
    } else if (isDisabled) {
      textColor = colorScheme.onSurface.withOpacity(0.38);
    } else if (isCurrentYear) {
      textColor = colorScheme.primary;
    } else {
      textColor = ColorConstant.calendarTextColor;
    }
    final TextStyle itemStyle = TextStyle(fontSize: 16.0, color: textColor);

    BoxDecoration decoration;
    if (isSelected) {
      decoration = BoxDecoration(
        color: ColorConstant.pinkColor,
        borderRadius: BorderRadius.circular(decorationHeight / 2),
        shape: BoxShape.rectangle,
      );
    } else if (isCurrentYear && !isDisabled) {
      decoration = BoxDecoration(
        border: Border.all(
          color: ColorConstant.pinkColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(decorationHeight / 2),
        shape: BoxShape.rectangle,
      );
    }

    Widget yearItem = Center(
      child: Container(
        decoration: decoration,
        height: decorationHeight,
        width: decorationWidth,
        child: Center(
          child: Semantics(
            selected: isSelected,
            child: Text(year.toString(),textScaleFactor: 1.0, style: itemStyle),
          ),
        ),
      ),
    );

    if (isDisabled) {
      yearItem = ExcludeSemantics(
        child: yearItem,
      );
    } else {
      yearItem = InkWell(
        key: ValueKey<int>(year),
        onTap: () {
          widget.onChanged(
            DateTime(
              year,
              widget.initialDate.month,
              widget.initialDate.day,
            ),
          );
        },
        child: yearItem,
      );
    }

    return yearItem;
  }

  int get _itemCount {
    return widget.lastDate.year - widget.firstDate.year + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(),
        Expanded(
          child: GridView.builder(
            controller: scrollController,
            gridDelegate: _yearPickerGridDelegate,
            itemBuilder: _buildYearItem,
            itemCount: math.max(_itemCount, minYears),
            padding: const EdgeInsets.symmetric(horizontal: _yearPickerPadding),
          ),
        ),
        const Divider(),
      ],
    );
  }
}

class _YearPickerGridDelegate extends SliverGridDelegate {
  const _YearPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    final double tileWidth =
        (constraints.crossAxisExtent - (_yearPickerColumnCount - 1) * _yearPickerRowSpacing) / _yearPickerColumnCount;
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: _yearPickerRowHeight,
      crossAxisCount: _yearPickerColumnCount,
      crossAxisStride: tileWidth + _yearPickerRowSpacing,
      mainAxisStride: _yearPickerRowHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_YearPickerGridDelegate oldDelegate) => false;
}

const _YearPickerGridDelegate _yearPickerGridDelegate = _YearPickerGridDelegate();

//  Date Picker
class _MtDayPicker extends StatefulWidget {
  /// Creates a month picker.
  _MtDayPicker({
    Key key,
    @required this.initialMonth,
    @required this.currentDate,
    @required this.firstDate,
    @required this.lastDate,
    @required this.selectedDate,
    @required this.onChanged,
    @required this.onDisplayedMonthChanged,
    this.selectableDayPredicate,
  }) : assert(selectedDate != null),
        assert(currentDate != null),
        assert(onChanged != null),
        assert(firstDate != null),
        assert(lastDate != null),
        assert(!firstDate.isAfter(lastDate)),
        assert(!selectedDate.isBefore(firstDate)),
        assert(!selectedDate.isAfter(lastDate)),
        super(key: key);

  /// The initial month to display
  final DateTime initialMonth;

  /// The current date.
  ///
  /// This date is subtly highlighted in the picker.
  final DateTime currentDate;

  /// The earliest date the user is permitted to pick.
  ///
  /// This date must be on or before the [lastDate].
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  ///
  /// This date must be on or after the [firstDate].
  final DateTime lastDate;

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// Called when the user navigates to a new month
  final ValueChanged<DateTime> onDisplayedMonthChanged;

  /// Optional user supplied predicate function to customize selectable days.
  final SelectableDayPredicate selectableDayPredicate;


  @override
  __MtDayPickerState createState() => __MtDayPickerState();
}

class __MtDayPickerState extends State<_MtDayPicker> {
  DateTime _currentMonth;
  PageController _pageController;
  MaterialLocalizations _localizations;
  TextDirection _textDirection;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentMonth = widget.initialMonth;
    _pageController = PageController(initialPage: customDateUtils.monthDelta(widget.firstDate, _currentMonth));

  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _localizations = MaterialLocalizations.of(context);
    _textDirection = Directionality.of(context);
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }


  void _handleMonthPageChanged(int monthPage) {
    final DateTime monthDate = customDateUtils.addMonthsToMonthDate(widget.firstDate, monthPage);
    if (_currentMonth.year != monthDate.year || _currentMonth.month != monthDate.month) {
      _currentMonth = DateTime(monthDate.year, monthDate.month);
      widget.onDisplayedMonthChanged?.call(_currentMonth);
    }
  }

  Widget _buildItems(BuildContext context, int index) {
    final DateTime month = customDateUtils.addMonthsToMonthDate(widget.firstDate, index);
    return _MtDatePicker(
      key: ValueKey<DateTime>(month),
      selectedDate: widget.selectedDate,
      currentDate: widget.currentDate,
      onChanged: widget.onChanged,
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      displayedMonth: month,
      selectableDayPredicate: widget.selectableDayPredicate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      child: Column(
        children: <Widget>[
          _DayHeaders(),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: _buildItems,
              itemCount: customDateUtils.monthDelta(widget.firstDate, widget.lastDate) + 1,
              scrollDirection: Axis.horizontal,
              onPageChanged:  _handleMonthPageChanged,
            ),
          ),
        ],
      ),
    );
  }
}

class _MtDatePicker extends StatelessWidget {
  /// Creates a day picker.
  _MtDatePicker({
    Key key,
    @required this.currentDate,
    @required this.displayedMonth,
    @required this.firstDate,
    @required this.lastDate,
    @required this.selectedDate,
    @required this.onChanged,
    this.selectableDayPredicate,
  }) : assert(currentDate != null),
        assert(displayedMonth != null),
        assert(firstDate != null),
        assert(lastDate != null),
        assert(selectedDate != null),
        assert(onChanged != null),
        assert(!firstDate.isAfter(lastDate)),
        assert(!selectedDate.isBefore(firstDate)),
        assert(!selectedDate.isAfter(lastDate)),
        super(key: key);

  /// The currently selected date.
  ///
  /// This date is highlighted in the picker.
  final DateTime selectedDate;

  /// The current date at the time the picker is displayed.
  final DateTime currentDate;

  /// Called when the user picks a day.
  final ValueChanged<DateTime> onChanged;

  /// The earliest date the user is permitted to pick.
  ///
  /// This date must be on or before the [lastDate].
  final DateTime firstDate;

  /// The latest date the user is permitted to pick.
  ///
  /// This date must be on or after the [firstDate].
  final DateTime lastDate;

  /// The month whose days are displayed by this picker.
  final DateTime displayedMonth;

  /// Optional user supplied predicate function to customize selectable days.
  final SelectableDayPredicate selectableDayPredicate;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    final TextStyle dayStyle = textTheme.caption;
    final Color enabledDayColor = ColorConstant.calendarTextColor;
    final Color disabledDayColor = colorScheme.onSurface.withOpacity(0.38);
    final Color selectedDayColor = colorScheme.onPrimary;
    final Color selectedDayBackground = ColorConstant.pinkColor;
    final Color todayColor = colorScheme.primary;

    final int year = displayedMonth.year;
    final int month = displayedMonth.month;

    final int daysInMonth = customDateUtils.getDaysInMonth(year, month);
    final int dayOffset = customDateUtils.firstDayOffset(year, month, localizations);

    final List<Widget> dayItems = <Widget>[];
    // 1-based day of month, e.g. 1-31 for January, and 1-29 for February on
    // a leap year.
    int day = -dayOffset;
    while (day < daysInMonth) {
      day++;
      if (day < 1) {
        dayItems.add(Container());
      } else {
        final DateTime dayToBuild = DateTime(year, month, day);
        final bool isDisabled = dayToBuild.isAfter(lastDate) ||
            dayToBuild.isBefore(firstDate) ||
            (selectableDayPredicate != null && !selectableDayPredicate(dayToBuild));

        BoxDecoration decoration;
        Color dayColor = enabledDayColor;
        final bool isSelectedDay = customDateUtils.isSameDay(selectedDate, dayToBuild);

        if (isSelectedDay) {
          // The selected day gets a circle background highlight, and a
          // contrasting text color.
          dayColor = selectedDayColor;
          decoration = BoxDecoration(
            color: selectedDayBackground,
            shape: BoxShape.circle,
          );
        } else if (isDisabled) {
          dayColor = disabledDayColor;
        } else if (customDateUtils.isSameDay(currentDate, dayToBuild)) {
          // The current day gets a different text color and a circle stroke
          // border.
          dayColor = todayColor;
          decoration = BoxDecoration(
            border: Border.all(color: todayColor, width: 1),
            shape: BoxShape.circle,
          );
        }

        Widget dayWidget = Container(
          decoration: decoration,
          child: Center(
            child: Text(localizations.formatDecimal(day),textScaleFactor: 1.0, style: TextStyle(fontSize: 16.0, color: dayColor)),
          ),
        );

        if (isDisabled) {
          dayWidget = ExcludeSemantics(
            child: dayWidget,
          );
        } else {
          dayWidget = GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onChanged(dayToBuild),
            child: Semantics(
              // We want the day of month to be spoken first irrespective of the
              // locale-specific preferences or TextDirection. This is because
              // an accessibility user is more likely to be interested in the
              // day of month before the rest of the date, as they are looking
              // for the day of month. To do that we prepend day of month to the
              // formatted full date.
              label: '${localizations.formatDecimal(day)}, ${localizations.formatFullDate(dayToBuild)}',
              selected: isSelectedDay,
              excludeSemantics: true,
              child: dayWidget,
            ),
          );
        }

        dayItems.add(dayWidget);
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _monthPickerHorizontalPadding,
      ),
      child: GridView.custom(
        padding: EdgeInsets.only(top: 10),
        physics: const ClampingScrollPhysics(),
        gridDelegate: _dayPickerGridDelegate,
        childrenDelegate: SliverChildListDelegate(
          dayItems,
          addRepaintBoundaries: false,
        ),
      ),
    );
  }
}

class _DayPickerGridDelegate extends SliverGridDelegate {
  const _DayPickerGridDelegate();

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    const int columnCount = DateTime.daysPerWeek;
    final double tileWidth = constraints.crossAxisExtent / columnCount;
    final double tileHeight = math.min(_dayPickerRowHeight, constraints.viewportMainAxisExtent / _maxDayPickerRowCount);
    return SliverGridRegularTileLayout(
      childCrossAxisExtent: tileWidth,
      childMainAxisExtent: tileHeight,
      crossAxisCount: columnCount,
      crossAxisStride: tileWidth,
      mainAxisStride: tileHeight,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(_DayPickerGridDelegate oldDelegate) => false;
}

const _DayPickerGridDelegate _dayPickerGridDelegate = _DayPickerGridDelegate();

class _DayHeaders extends StatelessWidget {
  List<String> _dayLst = [ "Sun","Mon", "Tue", "Wed", "Thu", "Fri", "Sat",];
  /// Builds widgets showing abbreviated days of week. The first widget in the
  /// returned list corresponds to the first day of week for the current locale.
  ///
  /// Examples:
  ///
  /// ```
  /// ┌ Sunday is the first day of week in the US (en_US)
  /// |
  /// S M T W T F S  <-- the returned list contains these widgets
  /// _ _ _ _ _ 1 2
  /// 3 4 5 6 7 8 9
  ///
  /// ┌ But it's Monday in the UK (en_GB)
  /// |
  /// M T W T F S S  <-- the returned list contains these widgets
  /// _ _ _ _ 1 2 3
  /// 4 5 6 7 8 9 10
  /// ```
  int get firstDayOfWeekIndex => 1; 
  List<Widget> _getDayHeaders(TextStyle headerStyle, MaterialLocalizations localizations) {
    
    final List<Widget> result = <Widget>[];
    for (int i =firstDayOfWeekIndex; true; i = (i + 1) % 7) {
      final String weekday = _dayLst[i];
      result.add(ExcludeSemantics(
        child: Center(child: Text(weekday.toUpperCase(),textScaleFactor: 1.0, style: headerStyle)),
      ));
      if (i == (firstDayOfWeekIndex - 1) % 7)
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final TextStyle dayHeaderStyle = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: ColorConstant.pinkColor)/*theme.textTheme.caption?.apply(
      color: colorScheme.onSurface.withOpacity(0.60),
    )*/;
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);
    final List<Widget> labels = _getDayHeaders(dayHeaderStyle, localizations);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: _monthPickerHorizontalPadding,
      ),
      child: GridView.custom(
        shrinkWrap: true,
        gridDelegate: _dayPickerGridDelegate,
        childrenDelegate: SliverChildListDelegate(
          labels,
          addRepaintBoundaries: false,
        ),
      ),
    );
  }
}


