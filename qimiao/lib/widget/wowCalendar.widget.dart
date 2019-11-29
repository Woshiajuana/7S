
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'package:date_utils/date_utils.dart';
import 'package:qimiao/widget/wowCalendarTile.widget.dart';

typedef DayBuilder(BuildContext context, DateTime day, bool isSelected);

class WowCalendar extends StatefulWidget {

  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<Tuple2<DateTime, DateTime>> onSelectedRangeChange;
  final bool isExpandable;
  final DayBuilder dayBuilder;
  final bool showChevronsToChangeRange;
  final bool showTodayAction;
  final bool showCalendarPickerIcon;
  final DateTime initialCalendarDateOverride;

  WowCalendar({
    this.onDateSelected,
    this.onSelectedRangeChange,
    this.isExpandable: false,
    this.dayBuilder,
    this.showTodayAction: true,
    this.showChevronsToChangeRange: true,
    this.showCalendarPickerIcon: true,
    this.initialCalendarDateOverride
  });

  @override
  _WowCalendarState createState() => _WowCalendarState();
}

class _WowCalendarState extends State<WowCalendar> {

  final calendarUtils = new Utils();
  List<DateTime> selectedMonthsDays;
  Iterable<DateTime> selectedWeeksDays;
  DateTime _selectedDate = new DateTime.now();
  String currentMonth;
  bool isExpanded = false;
  String displayMonth;
  DateTime get selectedDate => _selectedDate;

  final List<String> weekdays = const [ '日', '一', '二', '三', '四', '五', '六' ];

  void initState() {
    super.initState();
    if (widget.initialCalendarDateOverride != null)
      _selectedDate = widget.initialCalendarDateOverride;
    selectedMonthsDays = Utils.daysInMonth(_selectedDate);
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
    selectedWeeksDays =
        Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
            .toList()
            .sublist(0, 7);
    displayMonth = Utils.formatMonth(_selectedDate);
  }

  Widget get calendarGridView {
    return new Container(
      child: new GestureDetector(
        onHorizontalDragStart: (gestureDetails) => beginSwipe(gestureDetails),
        onHorizontalDragUpdate: (gestureDetails) =>
            getDirection(gestureDetails),
        onHorizontalDragEnd: (gestureDetails) => endSwipe(gestureDetails),
        child: new GridView.count(
          shrinkWrap: true,
          crossAxisCount: 7,
          padding: new EdgeInsets.only(bottom: 0.0),
          children: calendarBuilder(),
        ),
      ),
    );
  }

  List<Widget> calendarBuilder() {
    List<Widget> dayWidgets = [];
    List<DateTime> calendarDays =
    isExpanded ? selectedMonthsDays : selectedWeeksDays;

    weekdays.forEach((day) {
      dayWidgets.add(
        new CalendarTile(
          isDayOfWeek: true,
          dayOfWeek: day,
        ),
      );
    });

    bool monthStarted = false;
    bool monthEnded = false;

    calendarDays.forEach((day) {
      if (monthStarted && day.day == 01) {
        monthEnded = true;
      }
      if (Utils.isFirstDayOfMonth(day)) {
        monthStarted = true;
      }
      bool isSelected = Utils.isSameDay(selectedDate, day);
      if (this.widget.dayBuilder != null) {
        dayWidgets.add(
          new CalendarTile(
            child: this.widget.dayBuilder(context, day, isSelected),
            date: day,
            onDateSelected: () => handleSelectedDateAndUserCallback(day),
          ),
        );
      } else {
        dayWidgets.add(
          new CalendarTile(
            onDateSelected: () => handleSelectedDateAndUserCallback(day),
            date: day,
            dateStyles: configureDateStyle(monthStarted, monthEnded),
            isSelected: isSelected,
          ),
        );
      }
    });

    return dayWidgets;
  }

  TextStyle configureDateStyle(monthStarted, monthEnded) {
    TextStyle dateStyles;
    if (isExpanded) {
      dateStyles = monthStarted && !monthEnded
          ? new TextStyle(color: Colors.black)
          : new TextStyle(color: Colors.black38);
    } else {
      dateStyles = new TextStyle(color: Colors.black);
    }
    return dateStyles;
  }

  Widget get _widgetExpansionButtonRow {
    if (widget.isExpandable) {
      return new Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          border: new Border(
            top: new BorderSide(
              color: Color(0xffdddddd),
              width: 0.5,
            ),
          ),
        ),
        child: new Container(
          width: 100.0,
          height: 16.0,
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              bottomLeft: new Radius.circular(6.0),
              bottomRight: new Radius.circular(6.0),
            ),
            boxShadow: [
              new BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.1),
                offset: Offset(0.0, 1.0), //阴影xy轴偏移量
              ),
            ],
          ),
          child: new FlatButton(
            onPressed: toggleExpanded,
            padding: const EdgeInsets.all(0),
            child: new Icon(
              isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              color: Color(0xff999999),
              size: 16.0,
            ),
          ),
        ),
      );
    } else {
      return new Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new WowExpansionCrossFade(
            collapsed: calendarGridView,
            expanded: calendarGridView,
            isExpanded: isExpanded,
          ),
          _widgetExpansionButtonRow,
        ],
      ),
    );
  }

  void resetToToday() {
    _selectedDate = new DateTime.now();
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);

    setState(() {
      selectedWeeksDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      displayMonth = Utils.formatMonth(_selectedDate);
    });

    _launchDateSelectionCallback(_selectedDate);
  }

  void nextMonth() {
    setState(() {
      _selectedDate = Utils.nextMonth(_selectedDate);
      var firstDateOfNewMonth = Utils.firstDayOfMonth(_selectedDate);
      var lastDateOfNewMonth = Utils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
      selectedMonthsDays = Utils.daysInMonth(_selectedDate);
      displayMonth = Utils.formatMonth(_selectedDate);
    });
  }

  void previousMonth() {
    setState(() {
      _selectedDate = Utils.previousMonth(_selectedDate);
      var firstDateOfNewMonth = Utils.firstDayOfMonth(_selectedDate);
      var lastDateOfNewMonth = Utils.lastDayOfMonth(_selectedDate);
      updateSelectedRange(firstDateOfNewMonth, lastDateOfNewMonth);
      selectedMonthsDays = Utils.daysInMonth(_selectedDate);
      displayMonth = Utils.formatMonth(_selectedDate);
    });
  }

  void nextWeek() {
    setState(() {
      _selectedDate = Utils.nextWeek(_selectedDate);
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeeksDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList()
              .sublist(0, 7);
      displayMonth = Utils.formatMonth(_selectedDate);
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void previousWeek() {
    setState(() {
      _selectedDate = Utils.previousWeek(_selectedDate);
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(_selectedDate);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(_selectedDate);
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      selectedWeeksDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList()
              .sublist(0, 7);
      displayMonth = Utils.formatMonth(_selectedDate);
    });
    _launchDateSelectionCallback(_selectedDate);
  }

  void updateSelectedRange(DateTime start, DateTime end) {
    var selectedRange = new Tuple2<DateTime, DateTime>(start, end);
    if (widget.onSelectedRangeChange != null) {
      widget.onSelectedRangeChange(selectedRange);
    }
  }

  Future<Null> selectDateFromPicker() async {
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? new DateTime.now(),
      firstDate: new DateTime(1960),
      lastDate: new DateTime(2050),
    );

    if (selected != null) {
      var firstDayOfCurrentWeek = Utils.firstDayOfWeek(selected);
      var lastDayOfCurrentWeek = Utils.lastDayOfWeek(selected);

      setState(() {
        _selectedDate = selected;
        selectedWeeksDays =
            Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
                .toList();
        selectedMonthsDays = Utils.daysInMonth(selected);
        displayMonth = Utils.formatMonth(selected);
      });
      // updating selected date range based on selected week
      updateSelectedRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek);
      _launchDateSelectionCallback(selected);
    }
  }

  var gestureStart;
  var gestureDirection;

  void beginSwipe(DragStartDetails gestureDetails) {
    gestureStart = gestureDetails.globalPosition.dx;
  }

  void getDirection(DragUpdateDetails gestureDetails) {
    if (gestureDetails.globalPosition.dx < gestureStart) {
      gestureDirection = 'rightToLeft';
    } else {
      gestureDirection = 'leftToRight';
    }
  }

  void endSwipe(DragEndDetails gestureDetails) {
    if (gestureDirection == 'rightToLeft') {
      if (isExpanded) {
        nextMonth();
      } else {
        nextWeek();
      }
    } else {
      if (isExpanded) {
        previousMonth();
      } else {
        previousWeek();
      }
    }
  }

  void toggleExpanded() {
    if (widget.isExpandable) {
      setState(() => isExpanded = !isExpanded);
    }
  }

  void handleSelectedDateAndUserCallback(DateTime day) {
    var firstDayOfCurrentWeek = Utils.firstDayOfWeek(day);
    var lastDayOfCurrentWeek = Utils.lastDayOfWeek(day);
    setState(() {
      _selectedDate = day;
      selectedWeeksDays =
          Utils.daysInRange(firstDayOfCurrentWeek, lastDayOfCurrentWeek)
              .toList();
      selectedMonthsDays = Utils.daysInMonth(day);
    });
    _launchDateSelectionCallback(day);
  }

  void _launchDateSelectionCallback(DateTime day) {
    if (widget.onDateSelected != null) {
      widget.onDateSelected(day);
    }
  }

}

class WowExpansionCrossFade extends StatelessWidget {
  final Widget collapsed;
  final Widget expanded;
  final bool isExpanded;

  WowExpansionCrossFade({this.collapsed, this.expanded, this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return new Flexible(
      flex: 1,
      child: new AnimatedCrossFade(
        firstChild: collapsed,
        secondChild: expanded,
        firstCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.decelerate,
        crossFadeState:
        isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 300),
      ),
    );
  }
}
