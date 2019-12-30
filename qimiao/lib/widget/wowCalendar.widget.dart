
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:date_utils/date_utils.dart';
//import 'package:qimiao/common/utils/date_utils.dart';
import "package:intl/intl.dart";

typedef DayBuilder(BuildContext context, DateTime day, bool isSelected);

class WowCalendar extends StatefulWidget {

  final DateTime initSelectedDate;
  final Function dayBuilder;
  WowCalendar({
    this.initSelectedDate,
    this.dayBuilder,
  });

  @override
  _WowCalendarState createState() => _WowCalendarState();
}

class _WowCalendarState extends State<WowCalendar> {

  final calendarUtils = new Utils();
  DateTime _selectedDate;
  List<DateTime> _arrMonthsDays;
  Iterable<DateTime> _arrWeeksDays;
  List<String> _arrWeeksTitleDays;
  String _strSelectedMonth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  void init () {
    _arrWeeksTitleDays = [ '日', '一', '二', '三', '四', '五', '六' ];
    _selectedDate = widget?.initSelectedDate ?? new DateTime.now();
    _arrMonthsDays = Utils.daysInMonth(_selectedDate);

    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
    _arrWeeksDays = Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
        .toList()
        .sublist(0, 7);

    print('firstDayOfCurrentWeek => $firstDayOfCurrentWeek');
    print('lastDayOfCurrentWeek => $lastDayOfCurrentWeek');
    print('_arrWeeksDays => $_arrWeeksDays');
    print('_arrMonthsDays => $_arrMonthsDays');
    _strSelectedMonth = new DateFormat('yyyy/MM').format(_selectedDate);
    print('_strSelectedMonth => $_strSelectedMonth');
  }

  @override
  Widget build(BuildContext context) {
    this.init();
    // TODO: implement build
    return new Container(
      child: new Column(
        children: <Widget>[
          _widgetTitleSection(),
          _widgetDaysSection(),
        ],
      ),
    );
  }

  // 标题
  Widget _widgetTitleSection () {
    return new Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: new Text(
        _strSelectedMonth,
        style: new TextStyle(
          color: Theme.of(context).accentColor,
          fontSize: 18.0,
        ),
      ),
    );
  }

  // day
  Widget _widgetDaysSection () {

    List<Widget> arrDayWidgets = [];
    List<DateTime> calendarDays = _arrMonthsDays;

    // 周几
    Widget _widgetDayItem ({
      String strWeek,
      DateTime dateTime,

    }) {
      String text = strWeek == null
          ? new DateFormat('dd').format(dateTime)
          : strWeek;
      return new Container(
        alignment: Alignment.center,
        child: new Text(
          text,
        ),
      );
    }

    arrDayWidgets.addAll(_arrWeeksTitleDays.map((week) => _widgetDayItem(
      strWeek: week,
    )).toList());

    arrDayWidgets.addAll(calendarDays.map((DateTime day) => _widgetDayItem(
      dateTime: day,
    )).toList());

    return new GridView.count(
      shrinkWrap: true,
      crossAxisCount: 7,
      physics: const NeverScrollableScrollPhysics(),
      padding: new EdgeInsets.only(bottom: 0.0),
      children: arrDayWidgets,
    );

  }


}

