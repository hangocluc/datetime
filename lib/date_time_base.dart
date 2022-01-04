import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'base_string.dart';

class DateTimeBase extends StatefulWidget {
  const DateTimeBase({Key? key}) : super(key: key);

  @override
  _DateTimeBaseState createState() => _DateTimeBaseState();
}

class _DateTimeBaseState extends State<DateTimeBase> {
  DateTime now = DateTime.now();
  String nows = '';
  String changeOption = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nows = getDateToString(now);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffE2E8F0).withOpacity(0.2),
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 16,
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xff7966FF).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: GestureDetector(
                onTap: () {
                  _ontoDay();
                },
                child: const Text(
                  "Hôm nay",
                  style: TextStyle(
                      color: Color(0xff7966FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Container(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      //  _onBackDay();
                      // _onBackWeek();
                      _onBackMonth();
                    },
                    child: SvgPicture.asset('asset/image/ic_back.svg'),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(nows),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      _checkToOption(changeOption);
                    },
                    child: SvgPicture.asset('asset/image/ic_next.svg'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: HomePage(
                onChanged: (value) {
                  log(">>>>" + value);
                  changeOption = value;
                },
              )),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }

  void _onNextDay() {
    int a = now.millisecondsSinceEpoch;
    a = a + (24 * 60 * 60 * 1000);
    now = DateTime.fromMillisecondsSinceEpoch(a);
    nows = getDateToString(now);
    setState(() {});
  }

  String getDateToString(DateTime time, [DateTime? endDate]) {
    if (endDate != null) {
      if (endDate.month < 10) {
        return "0${time.day} - ${endDate.day}  tháng 0${endDate.month}, ${endDate.year}";
      } else {
        return "0${time.day} - ${endDate.day}  tháng ${endDate.month}, ${endDate.year}";
      }
      // return "${time.day} , ${time.month} - ${endDate.day} , ${endDate.month}, ${endDate.year}";
      //return "${time.day} - ${endDate.day}  tháng ${endDate.month}, ${endDate.year}";
    }
    // if (changeOption == 'Ngày') {
    //   return "${time.day} Tháng ${time.month},${time.year}";
    // } else if (changeOption == 'Tuần') {
    //   return "${time.day} , ${time.month} - ${endDate.day} , ${endDate.month}, ${endDate.year}";
    // }
    return "${time.day} Tháng ${time.month},${time.year}";
  }

  void _onBackDay() {
    int a = now.millisecondsSinceEpoch;
    a = a - (24 * 60 * 60 * 1000);
    now = DateTime.fromMillisecondsSinceEpoch(a);
    nows = getDateToString(now);
    setState(() {});
  }

  void _ontoDay() {
    DateTime today = DateTime.now();
    nows = getDateToString(today);
    setState(() {});
  }

  DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

  void _onNextWeek() {
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
    }
    setState(() {});
  }

  void _onBackWeek() {
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
    }
    setState(() {});
  }

  void _onNextMonth() {
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
    setState(() {});
  }

  void _onBackMonth() {
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
    setState(() {});
  }

  void _checkToOption(String a) {
    switch (a) {
      case 'Ngày':
        _onNextDay();
        break;
      case 'Tuần':
        _onNextWeek();
        break;
      case 'Tháng':
        _onNextMonth();
        break;
    }
  }
}

enum Options { Ngay, Tuan, Thang }
