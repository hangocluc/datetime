import 'dart:developer';

import 'package:date_time_picker/test_bloc/drop_down_button/bloc/drop_down_button_state.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../../base_cubit.dart';

class DropDownCubit extends BaseCubit<DropDownState> {
  DropDownCubit() : super(DropDownStateInitial());
  DateTime now = DateTime.now();
  String nows = '';
  String changeOption = 'Ngày';
  BehaviorSubject<String> textDateTimeSubJect = BehaviorSubject();

  Stream<String> get textDateTimeStream => textDateTimeSubJect.stream;

  void getState() {
    nows = getDateToString(now);
    textDateTimeSubJect.sink.add(nows);
  }

  void onNextDay() {
    int a = now.millisecondsSinceEpoch;
    a = a + (24 * 60 * 60 * 1000);
    now = DateTime.fromMillisecondsSinceEpoch(a);
    nows = getDateToString(now);
    textDateTimeSubJect.sink.add(nows);
  }

  String getDateToString(DateTime time, [DateTime? endDate]) {
    String day, month;
    if (time.day < 10) {
      day = '0${time.day}';
    } else {
      day = '${time.day}';
    }
    if (time.month < 10) {
      month = '0${time.month}';
    } else {
      month = '${time.month}';
    }

    // endDate
    String dayEnd, monthEnd;
    if (time.day < 10) {
      dayEnd = '0${time.day}';
    } else {
      dayEnd = '${time.day}';
    }
    if (time.month < 10) {
      monthEnd = '0${time.month}';
    } else {
      monthEnd = '${time.month}';
    }
    //
    if (endDate != null) {
      if (changeOption == 'Tuần') {
        return "$day,$month - $dayEnd Tháng $monthEnd, ${endDate.year}";
      } else {
        return "$day - $dayEnd Tháng $monthEnd, ${endDate.year}";
      }
      // return "${time.day} , ${time.month} - ${endDate.day} , ${endDate.month}, ${endDate.year}";
      //return "${time.day} - ${endDate.day}  tháng ${endDate.month}, ${endDate.year}";
    }
    return "$day Tháng $month,${time.year}";
    //
  }

  void onBackDay() {
    int a = now.millisecondsSinceEpoch;
    a = a - (24 * 60 * 60 * 1000);
    now = DateTime.fromMillisecondsSinceEpoch(a);
    nows = getDateToString(now);
    textDateTimeSubJect.sink.add(nows);
  }

  void ontoDay() {
    DateTime today = DateTime.now();
    nows = getDateToString(today);
    textDateTimeSubJect.sink.add(nows);
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  void onNextWeek() {
    int b = now.millisecondsSinceEpoch;
    b = b + (7 * 24 * 60 * 60 * 1000);
    now = DateTime.fromMillisecondsSinceEpoch(b);
    String a = DateFormat(DateFormat.WEEKDAY).format(now); // Tues
    final weekDay = now.weekday == 7 ? 0 : now.weekday;
    if (a == 'Sunday') {
      nows = getDateToString(
          DateTime.fromMillisecondsSinceEpoch(getDate(now
                  .subtract(Duration(days: DateTime.daysPerWeek - weekDay - 1)))
              .millisecondsSinceEpoch),
          DateTime.fromMillisecondsSinceEpoch(
              getDate(now.subtract(Duration(days: weekDay)))
                  .millisecondsSinceEpoch));
      textDateTimeSubJect.sink.add(nows);
    } else {
      nows = getDateToString(
          DateTime.fromMillisecondsSinceEpoch(
              getDate(now.subtract(Duration(days: weekDay)))
                      .millisecondsSinceEpoch +
                  (24 * 60 * 60 * 1000)),
          DateTime.fromMillisecondsSinceEpoch(getDate(now
                      .add(Duration(days: DateTime.daysPerWeek - weekDay - 1)))
                  .millisecondsSinceEpoch +
              (24 * 60 * 60 * 1000)));
      textDateTimeSubJect.sink.add(nows);
    }
  }

  void onBackWeek() {
    int b = now.millisecondsSinceEpoch;
    b = b - (7 * 24 * 60 * 60 * 1000);
    now = DateTime.fromMillisecondsSinceEpoch(b);
    String a = DateFormat(DateFormat.WEEKDAY).format(now); // Tues
    final weekDay = now.weekday == 7 ? 0 : now.weekday;
    if (a == 'Sunday') {
      nows = getDateToString(
          DateTime.fromMillisecondsSinceEpoch(getDate(now
                  .subtract(Duration(days: DateTime.daysPerWeek - weekDay - 1)))
              .millisecondsSinceEpoch),
          DateTime.fromMillisecondsSinceEpoch(
              getDate(now.subtract(Duration(days: weekDay)))
                  .millisecondsSinceEpoch));
      textDateTimeSubJect.sink.add(nows);
    } else {
      nows = getDateToString(
          DateTime.fromMillisecondsSinceEpoch(
              getDate(now.subtract(Duration(days: weekDay)))
                      .millisecondsSinceEpoch +
                  (24 * 60 * 60 * 1000)),
          DateTime.fromMillisecondsSinceEpoch(getDate(now
                      .add(Duration(days: DateTime.daysPerWeek - weekDay - 1)))
                  .millisecondsSinceEpoch +
              (24 * 60 * 60 * 1000)));
      textDateTimeSubJect.sink.add(nows);
    }
  }

  void onNextMonth() {
    final firstDayThisMonth = DateTime(now.year, now.month, now.day);
    final firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    int c = firstDayNextMonth.difference(firstDayThisMonth).inDays;
    int b = now.millisecondsSinceEpoch;
    b = b + (c * 24 * 60 * 60 * 1000);
    now = DateTime.fromMillisecondsSinceEpoch(b);
    nows = getDateToString(
        DateTime.fromMillisecondsSinceEpoch(
            DateTime.utc(now.year, now.month, 1).millisecondsSinceEpoch),
        DateTime.fromMillisecondsSinceEpoch(DateTime.utc(
          now.year,
          now.month + 1,
        ).subtract(const Duration(days: 1)).millisecondsSinceEpoch));
    textDateTimeSubJect.sink.add(nows);
  }

  void onBackMonth() {
    final firstDayThisMonth = DateTime(now.year, now.month, now.day);
    final firstDayNextMonth = DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    int c = firstDayNextMonth.difference(firstDayThisMonth).inDays;
    int b = now.millisecondsSinceEpoch;
    b = b - (c * 24 * 60 * 60 * 1000);
    now = DateTime.fromMillisecondsSinceEpoch(b);
    nows = getDateToString(
        DateTime.fromMillisecondsSinceEpoch(
            DateTime.utc(now.year, now.month, 1).millisecondsSinceEpoch),
        DateTime.fromMillisecondsSinceEpoch(DateTime.utc(
          now.year,
          now.month + 1,
        ).subtract(const Duration(days: 1)).millisecondsSinceEpoch));
    textDateTimeSubJect.sink.add(nows);
  }

  void checkToOption(String a) {
    switch (a) {
      case 'Ngày':
        onNextDay();
        break;
      case 'Tuần':
        onNextWeek();
        break;
      case 'Tháng':
        onNextMonth();
        break;
    }
  }

  void checkToOptionBackDay(String a) {
    switch (a) {
      case 'Ngày':
        onBackDay();
        break;
      case 'Tuần':
        onBackWeek();
        break;
      case 'Tháng':
        onBackMonth();
        break;
    }
  }

  void dispose() {
    textDateTimeSubJect.close();
  }
}
