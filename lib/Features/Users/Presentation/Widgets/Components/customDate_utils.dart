


import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Returns a [DateTime] with just the date of the original, but no time set.
DateTime dateOnly(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

/// Returns a [DateTime] with just the date of the original, but no time set.
String formatMonth(DateTime date) {
  return DateFormat("MMMM").format(date);
}


int getDaysInMonth(int year, int month) {
  if (month == DateTime.february) {
    final bool isLeapYear = (year % 4 == 0) && (year % 100 != 0) ||
        (year % 400 == 0);
    if (isLeapYear)
      return 29;
    return 28;
  }
  const List<int> daysInMonth = <int>[31, -1, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  return daysInMonth[month - 1];
}

DateTime addMonthsToMonthDate(DateTime monthDate, int monthsToAdd) {
  return DateTime(monthDate.year, monthDate.month + monthsToAdd);
}

/// Returns true if the two [DateTime] objects have the same day, month, and
/// year.
bool isSameDay(DateTime dateA, DateTime dateB) {

  return
    dateA.year == dateB.year &&
        dateA.month == dateB.month &&
        dateA.day == dateB.day;
}

int monthDelta(DateTime startDate, DateTime endDate) {
  return (endDate.year - startDate.year) * 12 + endDate.month - startDate.month;
}

int firstDayOffset(int year, int month, MaterialLocalizations localizations) {
  // 0-based day of week for the month and year, with 0 representing Monday.
  final int weekdayFromMonday = DateTime(year, month).weekday - 1;

  // 0-based start of week depending on the locale, with 0 representing Sunday.
  int firstDayOfWeekIndex = localizations.firstDayOfWeekIndex;

  // firstDayOfWeekIndex recomputed to be Monday-based, in order to compare with
  // weekdayFromMonday.
  firstDayOfWeekIndex = (firstDayOfWeekIndex - 1) % 7;

  // Number of days between the first day of week appearing on the calendar,
  // and the day corresponding to the first of the month.
  return (weekdayFromMonday - firstDayOfWeekIndex) % 7;
}