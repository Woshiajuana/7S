
import 'package:flutter/material.dart';
import 'package:qimiao/common/utils/date.util.dart';

typedef DayBuilder(BuildContext context, DateTime day, bool isSelected);

class WowCalendar extends StatefulWidget {

  final DateTime selectedDate;
  final Function dayBuilder;
  final Function onSelected;

  WowCalendar({
    Key key,
    this.selectedDate,
    @required this.dayBuilder,
    this.onSelected,
  }) : super(key: key);

  @override
  WowCalendarState createState() => WowCalendarState();
}

class WowCalendarState extends State<WowCalendar> {

  DateTime _selectedDate;
  List<DateTime> _arrMonthsDays;
  List<String> _arrWeeksTitleDays;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _arrWeeksTitleDays = [ '日', '一', '二', '三', '四', '五', '六' ];
    _selectedDate = widget?.selectedDate ?? new DateTime.now();
    _arrMonthsDays = DateUtil.daysInMonth(_selectedDate);
    if (widget.onSelected != null) {
      widget.onSelected(null, _arrMonthsDays);
    }
  }

  @override
  Widget build(BuildContext context) {
    _arrMonthsDays = DateUtil.daysInMonth(_selectedDate);
    // TODO: implement build
    return new Container(
      child: _widgetDaysSection(),
    );
  }

  // day
  Widget _widgetDaysSection () {

    List<Widget> arrDayWidgets = [];
    List<DateTime> calendarDays = _arrMonthsDays;

    arrDayWidgets.addAll(_arrWeeksTitleDays.map((week) => new WowCalendarItem(
      isDayOfWeek: true,
      dayOfWeek: week,
    )).toList());

    arrDayWidgets.addAll(calendarDays.map((DateTime day) {
      bool isSelected = DateUtil.isSameDay(_selectedDate, day) ;
      return new WowCalendarItem(
        onDateSelected: () => _handleSelected(day),
        child: this.widget.dayBuilder(context, day, isSelected),
        date: day,
        isSelected: isSelected,
      );
    }).toList());

    return new Container(
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: new GridView.count(
        shrinkWrap: true,
        crossAxisCount: 7,
        physics: const NeverScrollableScrollPhysics(),
        padding: new EdgeInsets.only(bottom: 0.0),
        children: arrDayWidgets,
      ),
    );

  }

  void _handleSelected (DateTime day) {
    if (day.isAfter(new DateTime.now()))
      return null;
    setState(() {
      _selectedDate = day;
      _arrMonthsDays = DateUtil.daysInMonth(day);
    });
    if (widget.onSelected != null) {
      widget.onSelected(_selectedDate, _arrMonthsDays);
    }
  }

  // 下一个月
  void nextMonth () {
    setState(() {
      _selectedDate = DateUtil.nextMonth(_selectedDate);
      _arrMonthsDays = DateUtil.daysInMonth(_selectedDate);
    });
    if (widget.onSelected != null) {
      widget.onSelected(_selectedDate, _arrMonthsDays);
    }
  }

  // 上一个月
  void previousMonth () {
    setState(() {
      _selectedDate = DateUtil.previousMonth(_selectedDate);
      _arrMonthsDays = DateUtil.daysInMonth(_selectedDate);
    });
    if (widget.onSelected != null) {
      widget.onSelected(_selectedDate, _arrMonthsDays);
    }
  }

}

class WowCalendarItem extends StatelessWidget {

  final VoidCallback onDateSelected;
  final DateTime date;
  final String dayOfWeek;
  final bool isDayOfWeek;
  final bool isSelected;
  final TextStyle dayOfWeekStyles;
  final TextStyle dateStyles;
  final Widget child;

  WowCalendarItem({
    this.onDateSelected,
    this.date,
    this.child,
    this.dateStyles,
    this.dayOfWeek,
    this.dayOfWeekStyles,
    this.isDayOfWeek: false,
    this.isSelected: false,
  });

  Widget renderDateOrDayOfWeek(BuildContext context) {
    if (isDayOfWeek) {
      return new InkWell(
        child: new Container(
          alignment: Alignment.center,
          child: new Text(
            dayOfWeek,
            style: dayOfWeekStyles,
          ),
        ),
      );
    } else {
      return new InkWell(
        onTap: onDateSelected,
        child: new Container(
          decoration: isSelected
              ? new BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).primaryColor,
          )
              : new BoxDecoration(),
          alignment: Alignment.center,
          child: new Text(
            DateUtil.formatDay(date).toString(),
            style: isSelected ? new TextStyle(color: Colors.white) : dateStyles,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return new InkWell(
        child: child,
        onTap: onDateSelected,
      );
    }
    return new Container(
      child: renderDateOrDayOfWeek(context),
    );
  }

}
